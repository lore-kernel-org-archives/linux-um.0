Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7qm-0007WZ-SY
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:01:56 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7qm-0004kf-3b
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:01:56 +0000
Date: Thu, 18 Aug 2011 20:01:49 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7qf-0007Xq-8a@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 17/91] um: get rid of kern_constants.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/Makefile                   |   11 +----------
 arch/um/include/shared/as-layout.h |    2 +-
 arch/um/include/shared/task.h      |    2 +-
 arch/um/include/shared/um_malloc.h |    2 +-
 arch/um/include/shared/user.h      |    2 +-
 5 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 3aded4e..649aebc 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -25,9 +25,6 @@ include $(srctree)/$(ARCH_DIR)/Makefile-skas
 SHARED_HEADERS	:= $(ARCH_DIR)/include/shared
 ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
 ARCH_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/sys-$(SUBARCH)/shared
-ifneq ($(KBUILD_SRC),)
-ARCH_INCLUDE	+= -I$(SHARED_HEADERS)
-endif
 KBUILD_CPPFLAGS += -I$(srctree)/$(ARCH_DIR)/sys-$(SUBARCH)
 
 # -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
@@ -87,7 +84,6 @@ endef
 KBUILD_KCONFIG := arch/um/Kconfig.$(HEADER_ARCH)
 
 archprepare: include/generated/user_constants.h
-archprepare: $(SHARED_HEADERS)/kern_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
@@ -118,8 +114,7 @@ endef
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
-CLEAN_FILES += linux x.i gmon.out \
-	$(SHARED_HEADERS)/kern_constants.h
+CLEAN_FILES += linux x.i gmon.out
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
@@ -146,8 +141,4 @@ endef
 include/generated/user_constants.h: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.s
 	$(call filechk,gen-asm-offsets)
 
-$(SHARED_HEADERS)/kern_constants.h:
-	$(Q)mkdir -p $(dir $@)
-	$(Q)echo '#include <generated/asm-offsets.h>' >$@
-
 export SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS HEADER_ARCH DEV_NULL_PATH
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index a92b678..896e166 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -6,7 +6,7 @@
 #ifndef __START_H__
 #define __START_H__
 
-#include "kern_constants.h"
+#include <generated/asm-offsets.h>
 
 /*
  * Stolen from linux/const.h, which can't be directly included since
diff --git a/arch/um/include/shared/task.h b/arch/um/include/shared/task.h
index 3fe726b..3db6b58 100644
--- a/arch/um/include/shared/task.h
+++ b/arch/um/include/shared/task.h
@@ -1,7 +1,7 @@
 #ifndef __TASK_H
 #define __TASK_H
 
-#include <kern_constants.h>
+#include <generated/asm-offsets.h>
 
 #define TASK_REGS(task) ((struct uml_pt_regs *) &(((char *) (task))[HOST_TASK_REGS]))
 #define TASK_PID(task) *((int *) &(((char *) (task))[HOST_TASK_PID]))
diff --git a/arch/um/include/shared/um_malloc.h b/arch/um/include/shared/um_malloc.h
index c554d70..6395fef 100644
--- a/arch/um/include/shared/um_malloc.h
+++ b/arch/um/include/shared/um_malloc.h
@@ -6,7 +6,7 @@
 #ifndef __UM_MALLOC_H__
 #define __UM_MALLOC_H__
 
-#include "kern_constants.h"
+#include <generated/asm-offsets.h>
 
 extern void *uml_kmalloc(int size, int flags);
 extern void kfree(const void *ptr);
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index 293f7c7..2d46f63 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -6,7 +6,7 @@
 #ifndef __USER_H__
 #define __USER_H__
 
-#include "kern_constants.h"
+#include <generated/asm-offsets.h>
 
 /*
  * The usual definition - copied here because the kernel provides its own,
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

