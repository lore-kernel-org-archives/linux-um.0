Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeFU6-0000Xp-7B for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 10:34:14 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GeFU4-0002fK-IM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Oct 2006 10:34:14 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 29 Oct 2006 19:34:09 +0100
Message-Id: <20061029183409.31657.10144.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029183405.31657.44335.stgit@americanbeauty.home.lan>
References: <20061029183405.31657.44335.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 2/2] uml: fix compilation options for USER_OBJS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <blaisorblade@yahoo.it>

Make sure that when compiling USER_OBJS the correct compilation options are
passed; since they are compiled with USER_CFLAGS which is derived from CFLAGS,
make sure it is a recursively evaluated variable, so that changes to CFLAGS done
afterwards the inclusion of arch/$(ARCH)/Makefile are reflected in USER_CFLAGS.

For instance, without this patch userspace objects are never compiled with debug
info active.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile        |   21 +++++++++++----------
 arch/um/Makefile-i386   |    4 +---
 arch/um/Makefile-x86_64 |    4 ++--
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index c8016a9..5d5ed72 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -64,9 +64,14 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 
 AFLAGS += $(ARCH_INCLUDE)
 
-USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
-USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
+USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -D__KERNEL__,,\
+	$(patsubst -I%,,$(CFLAGS)))) $(ARCH_INCLUDE) $(MODE_INCLUDE) \
+	-D_FILE_OFFSET_BITS=64
+
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+
+#This will adjust *FLAGS accordingly to the platform.
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
@@ -74,15 +79,11 @@ # in CFLAGS.  Otherwise, it would cause
 # errnos.
 # These apply to kernelspace only.
 
-CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
-	-Dmktime=kernel_mktime
+KERNEL_DEFINES = -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
+	-Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES)
+CFLAGS += $(KERNEL_DEFINES)
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
-include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
-
-#This will adjust *FLAGS accordingly to the platform.
-include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
-
 # These are needed for clean and mrproper, since in that case .config is not
 # included; the values here are meaningless
 
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index b65ca11..c9f1c5b 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -16,7 +16,6 @@ OBJCOPYFLAGS  		:= -O binary -R .note -R
 ifeq ("$(origin SUBARCH)", "command line")
 ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
 CFLAGS			+= $(call cc-option,-m32)
-USER_CFLAGS		+= $(call cc-option,-m32)
 AFLAGS			+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
 UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)
@@ -25,7 +24,7 @@ export LDFLAGS HOSTCFLAGS HOSTLDFLAGS UM
 endif
 endif
 
-CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
+ARCH_KERNEL_DEFINES += -U__$(SUBARCH)__ -U$(SUBARCH)
 
 # First of all, tune CFLAGS for the specific CPU. This actually sets cflags-y.
 include $(srctree)/arch/i386/Makefile.cpu
@@ -38,4 +37,3 @@ # an unresolved reference.
 cflags-y += -ffreestanding
 
 CFLAGS += $(cflags-y)
-USER_CFLAGS += $(cflags-y)
diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index d278682..69ecea6 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -8,8 +8,8 @@ _extra_flags_ = -fno-builtin -m64
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ $(_extra_flags_)
-USER_CFLAGS += $(_extra_flags_)
+ARCH_KERNEL_DEFINES = -U__$(SUBARCH)__
+CFLAGS += $(_extra_flags_)
 
 CHECKFLAGS  += -m64
 AFLAGS += -m64
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
