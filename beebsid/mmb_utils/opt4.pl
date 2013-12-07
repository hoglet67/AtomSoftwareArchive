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
die "Syntax: $BeebUtils::PROG filename.ssd [0-3]\n" if $BeebUtils::BBC_FILE eq "" || !@ARGV || $ARGV[0] !~ /^[0-3]$/;

my $image=BeebUtils::load_external_ssd(undef,1);

# We mangle byte 0x106
my $b=0x106;

# Existing value
my $v=ord(substr($image,$b,1));

# Mask out old value
$v &= 0xCF;

# Add new value
$v |= ($ARGV[0] << 4);

# Update image
substr($image,$b,1)=chr($v);

# Save it
BeebUtils::write_ssd(\$image,$BeebUtils::BBC_FILE);
