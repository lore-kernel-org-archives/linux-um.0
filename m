Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0hke-0000WY-QN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 09:39:53 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G0hke-0005qF-3m
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 09:39:52 -0700
Message-Id: <200607121640.k6CGe1Nf021231@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 12 Jul 2006 12:40:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/5] UML - Tidy biarch gcc support
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
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On top of the previous biarch changes for UML, this makes the
preprocessor changes a bit cleaner. Specify the 64-bit build in CPPFLAGS
on the x86_64 SUBARCH, rather than #undef'ing i386. Compile-tested with
i386 and x86_64 SUBARCHs.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.17.orig/arch/um/Makefile-x86_64	2006-07-12 11:26:41.000000000 -0400
+++ linux-2.6.17/arch/um/Makefile-x86_64	2006-07-12 11:32:52.000000000 -0400
@@ -11,6 +11,7 @@ USER_CFLAGS += -fno-builtin -m64
 CHECKFLAGS  += -m64
 AFLAGS += -m64
 LDFLAGS += -m elf_x86_64
+CPPFLAGS += -m64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
Index: linux-2.6.17/arch/um/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/vmlinux.lds.S	2006-07-12 11:26:41.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/vmlinux.lds.S	2006-07-12 11:32:52.000000000 -0400
@@ -1,5 +1,3 @@
-/* in case the preprocessor is a 32bit one */
-#undef i386
 #ifdef CONFIG_LD_SCRIPT_STATIC
 #include "uml.lds.S"
 #else



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
