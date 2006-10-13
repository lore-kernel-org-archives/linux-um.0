Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYTNO-0000tH-Ae for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 13:11:26 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GYTNN-0001EQ-Ne
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 13:11:26 -0700
Date: Fri, 13 Oct 2006 16:10:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061013201010.GC5517@ccure.user-mode-linux.org>
References: <20061009163208.GA4931@ccure.user-mode-linux.org>
	<20061011110828.43576.qmail@web25221.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061011110828.43576.qmail@web25221.mail.ukl.yahoo.com>
Subject: Re: [uml-devel] [PATCH 01/14] uml: fix compilation options for
	USER_OBJS
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
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Oct 11, 2006 at 01:08:27PM +0200, Paolo Giarrusso wrote:
> Ok, at a first glance this alternative solution is ok. Make sure (run
> gdb on an userspace object file and saying list <function>) that it
> works and we'll be ok.

After discovering that the original patch broke UML/i386 and broke the
UML/x86_64 build, I now have the patch below.

Listing userspace functions is fine.

				Jeff


Index: linux-2.6.18-mm/arch/um/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Makefile	2006-10-13 10:20:51.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Makefile	2006-10-13 10:21:50.000000000 -0400
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
@@ -74,15 +79,11 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
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
 
Index: linux-2.6.18-mm/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Makefile-x86_64	2006-10-13 10:20:51.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Makefile-x86_64	2006-10-13 10:21:50.000000000 -0400
@@ -8,8 +8,8 @@ _extra_flags_ = -fno-builtin -m64
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ $(_extra_flags_)
-USER_CFLAGS += $(_extra_flags_)
+ARCH_KERNEL_DEFINES = -U__$(SUBARCH)__
+CFLAGS += $(_extra_flags_)
 
 CHECKFLAGS  += -m64
 AFLAGS += -m64
Index: linux-2.6.18-mm/arch/um/Makefile-i386
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Makefile-i386	2006-10-10 09:10:21.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Makefile-i386	2006-10-13 10:28:43.000000000 -0400
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
@@ -38,4 +37,3 @@ cflags-y += $(call cc-option,-mpreferred
 cflags-y += -ffreestanding
 
 CFLAGS += $(cflags-y)
-USER_CFLAGS += $(cflags-y)

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
