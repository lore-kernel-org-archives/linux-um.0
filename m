Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ey0dv-0002kd-VF for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Jan 2006 21:41:31 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ey0dt-0004jL-KW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Jan 2006 21:41:32 -0800
Message-Id: <200601150633.k0F6Xa2I015470@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/3] UML - Add __raw_writel definition
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
Date: Sun, 15 Jan 2006 01:33:36 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bryan O'Sullivan <bos@pathscale.com>

Add implementations of the write* and __raw_write* functions.  __raw_writel
is needed by lib/iocopy.c, which shouldn't be used in UML, but which is 
unconditionally linked in anyway.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/include/asm-um/io.h
===================================================================
--- linux-2.6.15-mm.orig/include/asm-um/io.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15-mm/include/asm-um/io.h	2006-01-14 19:12:17.000000000 -0500
@@ -33,4 +33,20 @@ static inline void * phys_to_virt(unsign
  */
 #define xlate_dev_kmem_ptr(p)	p
 
+static inline void writeb(unsigned char b, volatile void __iomem *addr)
+{
+	*(volatile unsigned char __force *) addr = b;
+}
+static inline void writew(unsigned short b, volatile void __iomem *addr)
+{
+	*(volatile unsigned short __force *) addr = b;
+}
+static inline void writel(unsigned int b, volatile void __iomem *addr)
+{
+	*(volatile unsigned int __force *) addr = b;
+}
+#define __raw_writeb writeb
+#define __raw_writew writew
+#define __raw_writel writel
+
 #endif



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
