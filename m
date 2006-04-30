Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaCkN-0001eY-Lq for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:03 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FaCkN-0001yl-F2 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:03 -0700
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FaCkM-0005Z4-Kc for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 07:18:03 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060430141619.9060.68951.stgit@zion.home.lan>
In-Reply-To: <20060430141512.9060.39338.stgit@zion.home.lan>
References: <20060430141512.9060.39338.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 5/7] uml: fix compilation and execution with
	hardened GCC
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
Date: Sun, 30 Apr 2006 16:16:19 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

To make some half-assembly stubs compile, disable various "hardened" GCC
features:

*) we can't make it build PIC code as we need %ebx to do syscalls and GCC wants it
free for PIC
*) we can't leave stack protection as the stub is moved (not relocated!) in memory
so the RIP-relative access to the canary tries reading from an unmapped address
and causes a segfault, since we move the stub of various megabytes (the exact
amount will be decided at runtime) away from the link-time address.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile             |    6 +++++-
 arch/um/kernel/skas/Makefile |    9 ++++++++-
 arch/um/sys-i386/Makefile    |    2 ++
 arch/um/sys-x86_64/Makefile  |    2 ++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 930e006..bed604a 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -118,6 +118,10 @@ prepare: $(ARCH_DIR)/include/kern_consta
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
 
+CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
+	$(call cc-option, -fno-stack-protector,) \
+	$(call cc-option, -fno-stack-protector-all,)
+
 CPP_MODE-$(CONFIG_MODE_TT) := -DMODE_TT
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
@@ -227,4 +231,4 @@ $(ARCH_DIR)/include/kern_constants.h: $(
 	@echo '  SYMLINK $@'
 	$(Q)ln -sf ../../../include/asm-um/asm-offsets.h $@
 
-export SUBARCH USER_CFLAGS OS
+export SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 57181a9..ad84296 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -11,4 +11,11 @@ USER_OBJS := clone.o
 include arch/um/scripts/Makefile.rules
 
 # clone.o is in the stub, so it can't be built with profiling
-$(obj)/clone.o : c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
+# GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
+# disable it
+
+CFLAGS_clone.o := $(CFLAGS_NO_HARDENING)
+
+# since we're setting c_flags we _must_ add $(CFLAGS_$(*F).o).
+
+$(obj)/clone.o : c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS)) $(CFLAGS_$(*F).o)
diff --git a/arch/um/sys-i386/Makefile b/arch/um/sys-i386/Makefile
index 82121ab..3734c3e 100644
--- a/arch/um/sys-i386/Makefile
+++ b/arch/um/sys-i386/Makefile
@@ -13,6 +13,8 @@ USER_OBJS := bugs.o ptrace_user.o sigcon
 USER_OBJS += user-offsets.s
 extra-y += user-offsets.s
 
+CFLAGS_stub_segv.o := $(CFLAGS_NO_HARDENING)
+
 extra-$(CONFIG_MODE_TT) += unmap.o
 
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/sys-x86_64/Makefile b/arch/um/sys-x86_64/Makefile
index f739bea..6d3b29c 100644
--- a/arch/um/sys-x86_64/Makefile
+++ b/arch/um/sys-x86_64/Makefile
@@ -21,6 +21,8 @@ USER_OBJS := ptrace_user.o sigcontext.o 
 USER_OBJS += user-offsets.s
 extra-y += user-offsets.s
 
+CFLAGS_stub_segv.o := $(CFLAGS_NO_HARDENING)
+
 extra-$(CONFIG_MODE_TT) += unmap.o
 
 include arch/um/scripts/Makefile.rules


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
