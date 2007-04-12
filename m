Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hc2EY-0002Ai-Oh for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 09:33:18 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hc2EX-0000fm-P1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 09:33:18 -0700
Date: Thu, 12 Apr 2007 12:28:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070412162802.GA7230@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 1/6 ] UML - Change remaining callers of
	os_{read_write}_file
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Convert all remaining os_{read_write}_file users to use the simple
{read,write} wrappers, os_{read_write}_file_k.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/chan_kern.c |    4 ++--
 arch/um/drivers/cow_sys.h   |    2 +-
 arch/um/drivers/net_user.c  |    6 +++---
 arch/um/drivers/ubd_kern.c  |    2 +-
 arch/um/kernel/initrd.c     |    2 +-
 arch/um/kernel/physmem.c    |    2 +-
 arch/um/sys-i386/bugs.c     |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_kern.c	2007-04-11 17:00:16.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_kern.c	2007-04-12 11:34:41.000000000 -0400
@@ -98,7 +98,7 @@ int generic_read(int fd, char *c_out, vo
 {
 	int n;
 
-	n = os_read_file(fd, c_out, sizeof(*c_out));
+	n = os_read_file_k(fd, c_out, sizeof(*c_out));
 
 	if(n == -EAGAIN)
 		return 0;
@@ -111,7 +111,7 @@ int generic_read(int fd, char *c_out, vo
 
 int generic_write(int fd, const char *buf, int n, void *unused)
 {
-	return os_write_file(fd, buf, n);
+	return os_write_file_k(fd, buf, n);
 }
 
 int generic_window_size(int fd, void *unused, unsigned short *rows_out,
Index: linux-2.6.21-mm/arch/um/drivers/cow_sys.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/cow_sys.h	2007-04-11 17:00:16.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/cow_sys.h	2007-04-12 11:34:41.000000000 -0400
@@ -35,7 +35,7 @@ static inline int cow_file_size(char *fi
 
 static inline int cow_write_file(int fd, void *buf, int size)
 {
-	return(os_write_file(fd, buf, size));
+	return(os_write_file_k(fd, buf, size));
 }
 
 #endif
Index: linux-2.6.21-mm/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/net_user.c	2007-04-11 17:00:36.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/net_user.c	2007-04-12 11:34:41.000000000 -0400
@@ -73,7 +73,7 @@ void read_output(int fd, char *output, i
 
 	while(remain != 0){
 		expected = (remain < len) ? remain : len;
-		ret = os_read_file(fd, output, expected);
+		ret = os_read_file_k(fd, output, expected);
 		if (ret != expected) {
 			str = "data";
 			goto err;
@@ -94,7 +94,7 @@ int net_read(int fd, void *buf, int len)
 {
 	int n;
 
-	n = os_read_file(fd,  buf,  len);
+	n = os_read_file_k(fd,  buf,  len);
 
 	if(n == -EAGAIN)
 		return 0;
@@ -122,7 +122,7 @@ int net_write(int fd, void *buf, int len
 {
 	int n;
 
-	n = os_write_file(fd, buf, len);
+	n = os_write_file_k(fd, buf, len);
 
 	if(n == -EAGAIN)
 		return 0;
Index: linux-2.6.21-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/ubd_kern.c	2007-04-11 17:00:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/ubd_kern.c	2007-04-12 11:34:41.000000000 -0400
@@ -1246,7 +1246,7 @@ int read_cow_bitmap(int fd, void *buf, i
 	if(err < 0)
 		return(err);
 
-	err = os_read_file(fd, buf, len);
+	err = os_read_file_k(fd, buf, len);
 	if(err < 0)
 		return(err);
 
Index: linux-2.6.21-mm/arch/um/kernel/initrd.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/initrd.c	2007-04-11 17:00:16.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/initrd.c	2007-04-12 11:34:41.000000000 -0400
@@ -55,7 +55,7 @@ int load_initrd(char *filename, void *bu
 		printk("Opening '%s' failed - err = %d\n", filename, -fd);
 		return(-1);
 	}
-	n = os_read_file(fd, buf, size);
+	n = os_read_file_k(fd, buf, size);
 	if(n != size){
 		printk("Read of %d bytes from '%s' failed, err = %d\n", size,
 		       filename, -n);
Index: linux-2.6.21-mm/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/physmem.c	2007-04-11 17:00:36.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/physmem.c	2007-04-12 11:34:41.000000000 -0400
@@ -211,7 +211,7 @@ void physmem_forget_descriptor(int fd)
 			panic("physmem_forget_descriptor - failed to seek "
 			      "to %lld in fd %d, error = %d\n",
 			      offset, fd, -err);
-		err = os_read_file(fd, addr, PAGE_SIZE);
+		err = os_read_file_k(fd, addr, PAGE_SIZE);
 		if(err < 0)
 			panic("physmem_forget_descriptor - failed to read "
 			      "from fd %d to 0x%p, error = %d\n",
Index: linux-2.6.21-mm/arch/um/sys-i386/bugs.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/bugs.c	2007-04-11 17:00:36.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/bugs.c	2007-04-12 11:34:41.000000000 -0400
@@ -28,7 +28,7 @@ static char token(int fd, char *buf, int
 	ptr = buf;
 	end = &buf[len];
 	do {
-		n = os_read_file(fd, ptr, sizeof(*ptr));
+		n = os_read_file_k(fd, ptr, sizeof(*ptr));
 		c = *ptr++;
 		if(n != sizeof(*ptr)){
 			if(n == 0)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
