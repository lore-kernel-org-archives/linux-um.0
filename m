Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7v9-00085b-AC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:06:27 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7v8-0002P8-JM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:06:27 +0000
Date: Thu, 18 Aug 2011 20:06:19 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7v1-0007ks-KC@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 44/91] um: trim detritus from
	Makefile-i386
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/Makefile-i386 |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index 7e5f1ba..57acfd6 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -1,13 +1,10 @@
 core-y += arch/um/sys-x86/ arch/x86/crypto/
 
-TOP_ADDR := $(CONFIG_TOP_ADDR)
-
 START := 0x8048000
 
 LDFLAGS			+= -m elf_i386
-ELF_ARCH		:= $(SUBARCH)
-ELF_FORMAT 		:= elf32-$(SUBARCH)
-OBJCOPYFLAGS  		:= -O binary -R .note -R .comment -S
+ELF_ARCH		:= i386
+ELF_FORMAT 		:= elf32-i386
 HEADER_ARCH		:= x86
 CHECKFLAGS	+= -D__i386__
 
@@ -16,9 +13,8 @@ ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
 KBUILD_CFLAGS		+= $(call cc-option,-m32)
 KBUILD_AFLAGS		+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
-UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)
 
-export LDFLAGS HOSTCFLAGS HOSTLDFLAGS UML_OBJCOPYFLAGS
+export LDFLAGS
 endif
 endif
 
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

