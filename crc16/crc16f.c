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
	  CRCtbl[data] = calcCRC(data, genPoly);
	  printf("%02x %04x\n", data, CRCtbl[data]);
    }
}

int mirror (int n) {
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
	  b = mirror(b);
	  crc = (crc << 8) ^ CRCtbl[((crc >> 8) & 0xFF)] ^ b;
    }                                /* Loop until num=0 */
  return(crc);                     /* Return updated CRC */
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
  crc = 0;
  while( (nr = read( fd, buf, MAXBUF )) > 0 ) {
	crc = crc16( buf, nr , crc);
  }
  if( nr != 0 ) {
	perror( "reading" );
  }
  printf( "%04x\n", crc );
}
