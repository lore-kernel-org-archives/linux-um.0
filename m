Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4Bf-0006u7-RC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:35 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4Bf-0005NX-4t
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:35 -0700
Message-Id: <200606292136.k5TLaefd010832@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 29 Jun 2006 17:36:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 9/9] UML - add __raw_writeq definition
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

The x86_64 build requires a definition for __raw_writeq.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/include/asm-um/io.h
===================================================================
--- linux-2.6.16.orig/include/asm-um/io.h	2006-03-23 16:40:24.000000000 -0500
+++ linux-2.6.16/include/asm-um/io.h	2006-06-21 17:39:40.000000000 -0400
@@ -45,8 +45,13 @@ static inline void writel(unsigned int b
 {
 	*(volatile unsigned int __force *) addr = b;
 }
+static inline void writeq(unsigned int b, volatile void __iomem *addr)
+{
+	*(volatile unsigned long long __force *) addr = b;
+}
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
+#define __raw_writeq writeq
 
 #endif


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
