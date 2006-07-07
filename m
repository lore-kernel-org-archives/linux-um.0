Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHw-0006bM-Pi for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:44 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHv-0000kY-Ah
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:44 -0700
Message-Id: <200607070033.k670XrGr008742@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 17/19] UML - Add some EINTR protection
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Add some more uses of the CATCH_EINTR wrapper.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/net_user.c	2006-07-05 20:54:02.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/net_user.c	2006-07-05 21:04:12.000000000 -0400
@@ -105,9 +105,7 @@ int net_recvfrom(int fd, void *buf, int 
 {
 	int n;
 
-	while(((n = recvfrom(fd,  buf,  len, 0, NULL, NULL)) < 0) && 
-	      (errno == EINTR)) ;
-
+	CATCH_EINTR(n = recvfrom(fd,  buf,  len, 0, NULL, NULL));
 	if(n < 0){
 		if(errno == EAGAIN)
 			return 0;
@@ -135,7 +133,7 @@ int net_send(int fd, void *buf, int len)
 {
 	int n;
 
-	while(((n = send(fd, buf, len, 0)) < 0) && (errno == EINTR)) ;
+	CATCH_EINTR(n = send(fd, buf, len, 0));
 	if(n < 0){
 		if(errno == EAGAIN)
 			return 0;
@@ -150,8 +148,8 @@ int net_sendto(int fd, void *buf, int le
 {
 	int n;
 
-	while(((n = sendto(fd, buf, len, 0, (struct sockaddr *) to,
-			   sock_len)) < 0) && (errno == EINTR)) ;
+	CATCH_EINTR(n = sendto(fd, buf, len, 0, (struct sockaddr *) to,
+			       sock_len));
 	if(n < 0){
 		if(errno == EAGAIN)
 			return 0;
Index: linux-2.6.17/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/file.c	2006-07-05 21:04:02.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/file.c	2006-07-05 21:04:12.000000000 -0400
@@ -18,6 +18,7 @@
 #include "os.h"
 #include "user.h"
 #include "kern_util.h"
+#include "user_util.h"
 
 static void copy_stat(struct uml_stat *dst, struct stat64 *src)
 {
@@ -42,10 +43,7 @@ int os_stat_fd(const int fd, struct uml_
 	struct stat64 sbuf;
 	int err;
 
-	do {
-		err = fstat64(fd, &sbuf);
-	} while((err < 0) && (errno == EINTR)) ;
-
+	CATCH_EINTR(err = fstat64(fd, &sbuf));
 	if(err < 0)
 		return -errno;
 


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
