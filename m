Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1yB3-0006vY-7y for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 17:43:01 -0800
Received: from newsread1.arcor-online.net ([151.189.0.146]
	helo=postman.arcor.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B1yAy-0001bI-DG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 17:42:56 -0800
Received: from server.schwinge.homeip.net (dialin-212-144-133-107.arcor-ip.net
	[212.144.133.107]) (authenticated bits=0)
	by postman.arcor.de (8.13.0.PreAlpha4/8.13.0.PreAlpha4) with ESMTP id
	i2D1gocj024168 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 Mar 2004 02:42:54 +0100 (MET)
From: Thomas Schwinge
	<schwinge-lists-sourceforge.net-user-mode-linux-devel@nic-nac-project.de>
Message-ID: <20040313014957.GB13419@speedy.schwinge.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Subject: [uml-devel] /dev/random oddity
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 13 Mar 2004 02:49:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello again!

Could you please try to compile and execute the attached file?
It's part of skalibs <URL:http://www.skarnet.org/software/skalibs/> and
is used to check if /dev/random is working correctly.

On a native Linux system this is no problem:
#v+
thomas@speedy:~/tmp > gcc -o trydevr trydevr.c 
thomas@speedy:~/tmp > strace ./trydevr
execve("./trydevr", ["./trydevr"], [/* 59 vars */]) = 0
[...]
open("/dev/random", O_RDONLY)           = 3
read(3, "\26\3239Q^\327\246\373\f\250c\5\333W\311\266\237m\\\231"..., 64) = 64
close(3)                                = 0
open("/dev/random", O_RDONLY)           = 3
read(3, "\276Hj=W\311\237:\200F\1\262Z\266c\313\346k\202_\3348\317"..., 64) = 64
close(3)                                = 0
exit_group(0)                           = ?
#v-

Whereas on UML it is:
#v+
thomas@uml:~/tmp > gcc -o trydevr trydevr.c 
thomas@uml:~/tmp > strace ./trydevr
execve("./trydevr", ["./trydevr"], [/* 55 vars */]) = 0
[...]
open("/dev/random", O_RDONLY)           = 3
read(3, "\274\202\216\375\350\"\207W\221Y4Q\345QW\250\345\361 \305"..., 64) = 21
read(3, [hangs here]
#v-

The program is only able to read 21 bytes from /dev/random; sometimes
it's not even able to read anything at all.


#v+
thomas@uml:~ > cat /dev/random | sed 's|.|*|g'
#v-
does not return anything.

#v+
thomas@speedy:~ > cat /dev/random | sed 's|.|*|g'
#v-
returns a lot of '*' and then stops to refill until the kernel has
refilled it's entropy pool (see drivers/char/random.c) - refilling
happens by gathering random events e.g. interrupts - moving the mouse
or keeping a key pressed as examples.
/dev/random only returns random numbers from the entropy pool whereas
/dev/urandom also returns 'weak' (calculated) random numbers.
On UML the entropy pool seems never to be refilled - not matter how long
I keep a key pressed; I don't have a mouse there - so AFAICT /dev/random
stops working at the time the pool gets empty.

Might this be the problem?


UML is linux-2.6.4 with uml-patch-2.6.4-1 and
<URL:http://www.metaparadigm.com/~mclark/uml/uml-2.6.3-skas-1.patch>.


Regards,
 Thomas

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trydevr.c"

/* Public domain. */

#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <errno.h>

static int fd_read (int fd, char *buf, unsigned int len)
{
  register int r ;
  do r = read(fd, buf, len) ;
  while ((r == -1) && (errno == EINTR)) ;
  return r ;
}

static unsigned int allread (int fd, register char *buf, register unsigned int len)
{
  register unsigned int written = 0 ;
  while (len)
  {
    register int w = fd_read(fd, buf, len) ;
    if (!w) errno = EPIPE ;
    if (w <= 0) break ;
    written += w ;
    buf += w ;
    len -= w ;
  }
  return written ;
}

static int byte_diff (char *s, unsigned int n, char *t)
{
  for (;;)
  {
    if (!n) return 0 ;
    if (*s != *t) break ;
    ++s ; ++t ; --n ;
  }
  return ((int)(unsigned int)(unsigned char) *s)
       - ((int)(unsigned int)(unsigned char) *t);
}

int main ()
{
  char a[64] ;
  char b[64] ;
  int fd ;
  fd = open("/dev/random", O_RDONLY) ;
  if ((fd == -1) || (allread(fd, a, 64) < 64) ) return 111 ;
  close(fd) ;
  fd = open("/dev/random", O_RDONLY) ;
  if ((fd == -1) || (allread(fd, b, 64) < 64) ) return 111 ;
  close(fd) ;
  return !byte_diff(a, 64, b) ;
}

--mYCpIKhGyMATD0i+--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
