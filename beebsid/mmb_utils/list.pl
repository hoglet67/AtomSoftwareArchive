#!/usr/bin/perl -w
use strict;

# Beeb Utilities to manipulate MMB and SSD files
# Copyright (C) 2012 Stephen Harris
# 
# See file "COPYING" for GPLv2 licensing

use FindBin;
use lib "$FindBin::Bin";
use BeebUtils;

@ARGV=BeebUtils::init_ssd(@ARGV);
my $filename=$BeebUtils::BBC_FILE;
die "Syntax: $BeebUtils::PROG filename [-o #]\n" unless $filename;
my $listo=0;
if (@ARGV == 2 && $ARGV[0] eq "-o") { $listo=$ARGV[1]; shift @ARGV;shift @ARGV;}
if (@ARGV == 1 && $ARGV[0] =~ /-o(\d+)$/) { $listo=$1; shift @ARGV;}
die "Unexpected arguments\n" if @ARGV;

my %indent = ( 'FOR' => 0, 'REPEAT' => 0);

open(F,"<$filename") or die "$filename: $!\n";
while (!eof(F))
{
  my %nextindent = ( 'FOR' => 0, 'REPEAT' => 0);
  my $ch;
  # First char of each line should be ^M
  read F,$ch,1; die "Bad program (expected ^M)\n" unless defined($ch) && $ch eq "\015";

  # next two bytes are line number or end of program
  read F,$ch,1; die "Bad program (line number high)\n" unless defined($ch);
  last if $ch eq "\xff";  # end of program 
  my $line=ord($ch)*256;

  read F,$ch,1; die "Bad program (line number low)\n" unless defined($ch);
  $line+=ord($ch);

  # next byte is length of line
  read F,$ch,1; die "Bad program (length)\n" unless defined($ch);
  my $len=ord($ch)-4; die "Bad program (bad length)\n" if $len <0; # Already got 4 bytes

  # rest of line
  my $raw=0;  # Set to 1 if in quotes
  my $decode="";
  my $skip=0;
  foreach my $pos (1..$len)
  {
    if ($skip) { $skip--; next;}
    read F,$ch,1; die "Bad program (reading line)\n" unless defined($ch);
  
    my $d;
    if ($raw) { $d = $ch; }
    elsif ($ch eq "\x8D")
    { # Line token
      my $lno;
      read F,$lno,3; die "Bad program (line token)\n" unless length($lno) == 3;
      $skip = 3;
      # This comes from page 41 of "The BASIC ROM User Guide"
      my ($n1,$n2,$n3)=map { ord($_) } split(//,$lno);
      $n1=($n1*4)&255;
      my $low=($n1 & 192) ^ $n2;
      $n1=($n1*4)&255;
      my $high=$n1 ^ $n3;
      $lno=$high*256+$low;
      $d=$lno;
    }
    else
    {
      $d=$BeebUtils::basic_tokens{ord($ch)};
      if ($d)
      {
        $d=(@$d)[0];
        $d .= " " if $listo & 8;
      }
      else
      {
        $d=$ch;
      }
    }
    $raw=1-$raw if $ch eq '"';
    die "trap" unless defined($d);
    $decode .= $d;
       if ($d eq 'REPEAT' && $listo & 4) { $nextindent{REPEAT}++; }
    elsif ($d eq 'UNTIL' && $listo & 4) { $nextindent{REPEAT}--; }
    elsif ($d eq 'FOR' && $listo & 2) { $nextindent{FOR}++; }
    elsif ($d eq 'NEXT' && $listo & 2) { $nextindent{FOR}--; }
  }

  my $i=substr(" "x255,1,$indent{FOR}*2+$indent{REPEAT}*2+($listo&1));
  printf("%5d%s%s\n",$line,$i,$decode);
  $indent{FOR}+=$nextindent{FOR}; $indent{FOR}=0 if $indent{FOR}<0;
  $indent{REPEAT}+=$nextindent{REPEAT}; $indent{REPEAT}=0 if $indent{REPEAT}<0;
} 
