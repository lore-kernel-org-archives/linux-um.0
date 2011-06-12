Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <f.fainelli@gmail.com>) id 1QVicz-0000cl-LF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 11:14:49 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QVicy-00021W-Ok
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 11:14:49 +0000
Received: by wwj40 with SMTP id 40so3621542wwj.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 Jun 2011 04:14:42 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
Date: Sun, 12 Jun 2011 13:14:39 +0200
MIME-Version: 1.0
Message-Id: <201106121314.39884.florian@openwrt.org>
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
Subject: [uml-devel] [PATCH 1/2] um: disable funit-at-a-time for gcc < 4.3
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

From: Nicolas Thill <nico@openwrt.org>

Building UML with gcc < 4.3 with -funit-at-a-time for i386 causes startup
crashes, disabling funit-at-a-time works around it.

Signed-off-by: Nicolas Thill <nico@openwrt.org>
---
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index 302cbe5..8251030 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -35,7 +35,7 @@ cflags-y += -ffreestanding
 # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
 # a lot more stack due to the lack of sharing of stacklots.  Also, gcc
 # 4.3.0 needs -funit-at-a-time for extern inline functions.
-KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0400 ] ; then \
+KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0403 ] ; then \
 			echo $(call cc-option,-fno-unit-at-a-time); \
 			else echo $(call cc-option,-funit-at-a-time); fi ;)
 
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

