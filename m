Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <f.fainelli@gmail.com>) id 1QVid0-0000cx-RJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 11:14:50 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QVid0-0003Iu-0F
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 11:14:50 +0000
Received: by wye20 with SMTP id 20so3911566wye.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 Jun 2011 04:14:43 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
Date: Sun, 12 Jun 2011 13:14:41 +0200
MIME-Version: 1.0
Message-Id: <201106121314.41348.florian@openwrt.org>
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
Subject: [uml-devel] [PATCH 2/2] um: disable compile-time buffer checks
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

From: Nicolas Thill <nico@openwrt.org>

Ubuntu 8.10 and newer enable compile-time buffer checks by default,
which can sometime cause build failures like this:

  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  LINK linux
  Building modules, stage 2.
  MODPOST 51 modules
ERROR: "__sprintf_chk" [arch/um/drivers/harddog.ko] undefined!

disable compile-time buffer checks to avoid such errors.

Signed-off-by: Nicolas Thill <nico@openwrt.org>
---
diff --git a/arch/um/Makefile-os-Linux b/arch/um/Makefile-os-Linux
index 2c8a598..2968e0d 100644
--- a/arch/um/Makefile-os-Linux
+++ b/arch/um/Makefile-os-Linux
@@ -6,4 +6,7 @@
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE -D_LARGEFILE64_SOURCE
 KBUILD_CFLAGS += -D_LARGEFILE64_SOURCE
+# disable compile-time buffer checks, enabled by default on Ubuntu 8.10
+# and later
+KBUILD_CFLAGS += $(call cc-option,-U_FORTIFY_SOURCE)
 DEV_NULL_PATH = \"/dev/null\"
-- 
1.7.4.1


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

