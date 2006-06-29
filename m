Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4BS-0006sv-8J for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:22 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4BR-0005KC-Nq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:22 -0700
Message-Id: <200606292136.k5TLaR27010797@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 29 Jun 2006 17:36:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/9] UML - Fix off-by-one bug in VM file creation
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

Fix an off-by-one bug in temp file creation.  Seeking to the desired
length and writing a byte resulted in the file being one byte longer
than expected.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/mem.c	2006-06-29 10:42:11.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/mem.c	2006-06-29 11:42:23.000000000 -0400
@@ -210,8 +210,11 @@ int create_tmp_file(unsigned long long l
 		exit(1);
 	}
 
-        if (lseek64(fd, len, SEEK_SET) < 0) {
- 		perror("os_seek_file");
+	/* Seek to len - 1 because writing a character there will
+	 * increase the file size by one byte, to the desired length.
+	 */
+	if (lseek64(fd, len - 1, SEEK_SET) < 0) {
+		perror("os_seek_file");
 		exit(1);
 	}
 


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
