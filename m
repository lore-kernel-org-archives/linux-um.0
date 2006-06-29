Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4Bd-0006tw-QU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:33 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4Bd-0005My-2Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:33 -0700
Message-Id: <200606292136.k5TLacIh010827@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 29 Jun 2006 17:36:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/9] UML - Fix biarch gcc build on x86_64
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

I run an x86_64 kernel with i386 userspace (Ubuntu Dapper) and decided
to try out UML today. I found that UML wasn't quite aware of biarch
compilers (which Ubuntu i386 ships). A fix similar to what was done for
x86_64 should probably be committed (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=113425940204010&w=2).
Without the FLAGS changes, the build will fail at a number of places and
without the LINK change, the final link will fail.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Index: linux-2.6.17/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.17.orig/arch/um/Makefile-x86_64	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/Makefile-x86_64	2006-06-29 10:36:18.000000000 -0400
@@ -6,9 +6,11 @@ START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ -fno-builtin
-USER_CFLAGS += -fno-builtin
+CFLAGS += -U__$(SUBARCH)__ -fno-builtin -m64
+USER_CFLAGS += -fno-builtin -m64
 CHECKFLAGS  += -m64
+AFLAGS += -m64
+LDFLAGS += -m elf_x86_64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
@@ -16,3 +18,4 @@ ELF_FORMAT := elf64-x86-64
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
+LINK-y += -m64
Index: linux-2.6.17/arch/um/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/vmlinux.lds.S	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/vmlinux.lds.S	2006-06-29 10:36:18.000000000 -0400
@@ -1,4 +1,6 @@
 #include <linux/config.h>
+/* in case the preprocessor is a 32bit one */
+#undef i386
 #ifdef CONFIG_LD_SCRIPT_STATIC
 #include "uml.lds.S"
 #else


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
