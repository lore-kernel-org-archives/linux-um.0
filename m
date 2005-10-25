Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUX0q-00051n-Qn	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:11:20 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUX0o-0000Yp-Vb
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:11:20 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051025221327.21106.79685.stgit@zion.home.lan>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 5/6] i386: use -mcpu, not -mtune, for GCCs older
	than 3.4
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
Date: Wed, 26 Oct 2005 00:13:27 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I just noted that -mtune is used, which is only supported on recent GCCs; by
reading http://gcc.gnu.org/gcc-3.4/changes.html, you see "-mcpu has been renamed
to -mtune.", so for GCC < 3.4 we're not using any specific tuning in the
appropriate cases. However -mcpu is deprecated, so use -mtune when possible.

This was introduced by commit e9d4dce954a60dc23dd1d967766ca2347b780e54 of the
old tree (between 2.6.10-rc3 and 2.6.10) by Linus Torvalds, to remove the use of
 -march, since that could trigger gcc using SSE on its own. But no attention was
used about using -mcpu vs. -mtune.

And btw, the old 2.6.4 code (for instance) was:
cflags-$(CONFIG_MPENTIUMII)     += $(call check_gcc,-march=pentium2,-march=i686)
cflags-$(CONFIG_MPENTIUMIII)    += $(call check_gcc,-march=pentium3,-march=i686)
cflags-$(CONFIG_MPENTIUMM)      += $(call check_gcc,-march=pentium3,-march=i686)
cflags-$(CONFIG_MPENTIUM4)      += $(call check_gcc,-march=pentium4,-march=i686)

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/i386/Makefile.cpu |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/i386/Makefile.cpu b/arch/i386/Makefile.cpu
--- a/arch/i386/Makefile.cpu
+++ b/arch/i386/Makefile.cpu
@@ -1,6 +1,14 @@
 # CPU tuning section - shared with UML.
 # Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.
 
+#-mtune exists since gcc 3.4, and some -mcpu flavors didn't exist in gcc 2.95.
+HAS_MTUNE	:= $(call cc-option-yn, -mtune=i386)
+ifeq ($(HAS_MTUNE),y)
+tune		= $(call cc-option,-mtune=$(1),)
+else
+tune		= $(call cc-option,-mcpu=$(1),)
+endif
+
 align := $(cc-option-align)
 cflags-$(CONFIG_M386)		+= -march=i386
 cflags-$(CONFIG_M486)		+= -march=i486
@@ -8,17 +16,17 @@ cflags-$(CONFIG_M586)		+= -march=i586
 cflags-$(CONFIG_M586TSC)	+= -march=i586
 cflags-$(CONFIG_M586MMX)	+= $(call cc-option,-march=pentium-mmx,-march=i586)
 cflags-$(CONFIG_M686)		+= -march=i686
-cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call cc-option,-mtune=pentium2)
-cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call cc-option,-mtune=pentium3)
-cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call cc-option,-mtune=pentium4)
+cflags-$(CONFIG_MPENTIUMII)	+= -march=i686 $(call tune,pentium2)
+cflags-$(CONFIG_MPENTIUMIII)	+= -march=i686 $(call tune,pentium3)
+cflags-$(CONFIG_MPENTIUMM)	+= -march=i686 $(call tune,pentium3)
+cflags-$(CONFIG_MPENTIUM4)	+= -march=i686 $(call tune,pentium4)
 cflags-$(CONFIG_MK6)		+= -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
 cflags-$(CONFIG_MK7)		+= $(call cc-option,-march=athlon,-march=i686 $(align)-functions=4)
 cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,$(call cc-option,-march=athlon,-march=i686 $(align)-functions=4))
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
-cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call cc-option,-mtune=pentium3) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call tune,pentium3) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call cc-option,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= $(call cc-option,-march=winchip2,-march=i586)



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
