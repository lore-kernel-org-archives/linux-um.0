Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6akB-0002rB-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 12:10:07 -0700
Received: from smtp.schwaar.com ([212.31.69.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6ak8-0001xn-OZ
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 12:10:05 -0700
Received: from [10.96.96.13] (mecki.schwaar.com [10.96.96.13])
	by smtp.schwaar.com (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id h96JA0v13005
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 21:10:00 +0200
Mime-Version: 1.0
Message-Id: <p05111b01bba76a1d5321@[10.96.96.13]>
From: Hannes Schulz <schulz@schwaar.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Subject: [uml-devel] [BUG 2.4.22-um5 + hostfs] file not updated upon munmap
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 6 Oct 2003 21:09:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net

summary: The program below does not work when on hostfs

how to reproduce:
	cc mmaptest.c && ./a.out | od -tx1

should give:
0000000 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f 50
*
0001000

but gives:
0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
0001000


how to produce the expected output:
	either the working directory is not on hostfs
	or
	cc -DMAKE_IT_WORK mmaptest.c && ./a.out | od -tx1
	or debug mmaptest ... the file is updated some time
		after the "close" in function "one".

how I found this bug:
	The coda-client (http://coda.cs.cmu.edu) does not work.
	This is why.


Any ideas ?


Hannes

--- mmaptest.c ---
#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>






#define NAME		"testfile"

#define MMAP_SIZE	((size_t) 6656)
#define FILE_SIZE	((off_t)  512)


int one (const char* name) {

	int fd;
	char* p;
	int i;
	size_t size;
	int err;
	off_t off;

	fd = open (name, O_CREAT|O_TRUNC|O_RDWR);
	if (fd < 0)
		return errno;
	size = MMAP_SIZE;
	err = ftruncate (fd, (off_t) size);
	if (err)
		return errno;
	p = mmap (0, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (p == MAP_FAILED)
		return errno;
	memset (p, 0, size);
	for (i = 0; i < size; i++)
		p [i] = 'A'+ (i & 0x0f);
#ifdef MAKE_IT_WORK
	err = msync (p, size, MS_ASYNC /* MS_SYNC works too */ );
	if (err)
		return errno;
#endif
	err = munmap (p, size);
	if (err)
		return errno;
	off = FILE_SIZE;
	err = ftruncate (fd, off);
	if (err)
		return errno;
	err = close (fd);
	if (err)
		return errno;
	return 0;
}

int two (const char* name) {

	int fd;
	char c;
	size_t	r;
	size_t	s = 1;

	fd = open (name, O_RDONLY);
	if (fd < 0)
		return errno;
	while ((r = read (fd, &c, s)) > 0)
		putchar (c);
	if (r != 0)
		return errno;
	close (fd);
	return 0;
}

int main (int argc, char** argv) {

	int err;

	err = one (NAME);
	if (err) {
		fprintf (stderr, "error %d: %s\n", err, strerror (err));
		return 1;
	}
	err = two (NAME);
	if (err) {
		fprintf (stderr, "error %d: %s\n", err, strerror (err));
		return 1;
	}
	return 0;
}






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
