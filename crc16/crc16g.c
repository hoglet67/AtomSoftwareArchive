#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>

#define poly 0x002d

static unsigned int CRCtbl[256];

static unsigned int calcCRC(unsigned char  data, unsigned int  genPoly)
{
  int i;
  unsigned int crc = (data << 8);

  for (i = 8; i; i--)
	{
	  crc = crc << 1;
	  if (crc & 0x10000)
	    crc = (crc ^ poly) & 0xFFFF;
	}

  return crc;
}


void initCRCSmmt(unsigned int  genPoly)
{
  unsigned int data;

  for (data = 0; data < 256; data++)
    {
	  CRCtbl[mirror8(data)] = mirror16(calcCRC(data, genPoly));
    }
}
void dumpTable() {
  int i,j;
   for (j = 0; j <= 8; j+= 8) {
	if (j == 0) {
	  printf(";; low byte\n");
	} else {
	  printf(";; high byte\n");
	}
	for (i = 0; i < 256; i++) {
	  if (i % 8 == 0) {
		printf(".byte ");
	  }
	  printf("$%02x", (CRCtbl[i] >> j) & 0xff);	
	  if (i % 8 == 7) {
		printf("\n");
	  } else {
		printf(", ");
	  }
	}
  }
}


int mirror8 (int n) {
  return
	((n&1) << 7) |
	((n&2) << 5) |
	((n&4) << 3) |
	((n&8) << 1) |
	((n&16) >> 1) |
	((n&32) >> 3) |
	((n&64) >> 5) |
	((n&128) >> 7);
}

int mirror16 (int n) {
  return
	((n&0x0001) << 15) |
	((n&0x0002) << 13) |
	((n&0x0004) << 11) |
	((n&0x0008) << 9) |
	((n&0x0010) << 7) |
	((n&0x0020) << 5) |
	((n&0x0040) << 3) |
	((n&0x0080) << 1) |
	((n&0x0100) >> 1) |
	((n&0x0200) >> 3) |
	((n&0x0400) >> 5) |
	((n&0x0800) >> 7) |
	((n&0x1000) >> 9) |
	((n&0x2000) >> 11) |
	((n&0x4000) >> 13) |
	((n&0x8000) >> 15);
}

/* On entry, addr=>start of data
   num = length of data
   crc = incoming CRC     */
int crc16(char *addr, int num, int crc)
{
  int i;
  int b;
  for (; num>0; num--)               /* Step through bytes in memory */
    {
      b = (*addr++);
	  crc = (crc >> 8) ^ CRCtbl[(crc & 0xFF)] ^ ((b & 0xff) << 8);
    }                                /* Loop until num=0 */
  return(mirror16(crc));                     /* Return updated CRC */
}


#define MAXBUF (256*1024)

void main(int argc, char **argv)
{
  int fd = 0;
  int nr;
  char buf[MAXBUF];
  unsigned short crc;

  if( argc > 1 )
	{
	  if( (fd = open( argv[1], O_RDONLY )) < 0 )
		{
		  perror( argv[1] );
		  exit( -1 );
		}
	}
  initCRCSmmt(poly);
  dumpTable();
  crc = 0;
  while( (nr = read( fd, buf, MAXBUF )) > 0 ) {
	crc = crc16( buf, nr , crc);
  }
  if( nr != 0 ) {
	perror( "reading" );
  }
  printf( "%04x\n", crc );
}
