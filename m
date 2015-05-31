Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YzAwK-0008W2-Nk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:40 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YzAwJ-0006WH-Dm for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 31 May 2015 23:38:22 +0200
Message-Id: <1433108305-9255-2-git-send-email-richard@nod.at>
In-Reply-To: <1433108305-9255-1-git-send-email-richard@nod.at>
References: <1433108305-9255-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 2/5] um: Stop abusing __KERNEL__
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

Currently UML is abusing __KERNEL__ to distinguish between
kernel and host code (os-Linux). It is better to use a custom
define such that existing users of __KERNEL__ don't get confused.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Makefile                | 7 ++++---
 arch/um/drivers/mconsole.h      | 2 +-
 arch/um/include/shared/init.h   | 4 ++--
 arch/um/include/shared/user.h   | 2 +-
 arch/x86/um/shared/sysdep/tls.h | 6 +++---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 17d4460..098ab33 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -68,9 +68,10 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
-USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -D__KERNEL__,,\
-	$(patsubst -I%,,$(KBUILD_CFLAGS)))) $(ARCH_INCLUDE) $(MODE_INCLUDE) \
-	$(filter -I%,$(CFLAGS)) -D_FILE_OFFSET_BITS=64 -idirafter include
+USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
+		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
+		-D_FILE_OFFSET_BITS=64 -idirafter include \
+		-D__KERNEL__ -D__UM_HOST__
 
 #This will adjust *FLAGS accordingly to the platform.
 include $(ARCH_DIR)/Makefile-os-$(OS)
diff --git a/arch/um/drivers/mconsole.h b/arch/um/drivers/mconsole.h
index 8b22535..44af737 100644
--- a/arch/um/drivers/mconsole.h
+++ b/arch/um/drivers/mconsole.h
@@ -7,7 +7,7 @@
 #ifndef __MCONSOLE_H__
 #define __MCONSOLE_H__
 
-#ifndef __KERNEL__
+#ifdef __UM_HOST__
 #include <stdint.h>
 #define u32 uint32_t
 #endif
diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index b3906f8..031ad1d 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -40,7 +40,7 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#ifndef __KERNEL__
+#ifdef __UM_HOST__
 #ifndef __section
 # define __section(S) __attribute__ ((__section__(#S)))
 #endif
@@ -131,7 +131,7 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
 #define __uml_postsetup_call	__used __section(.uml.postsetup.init)
 #define __uml_exit_call		__used __section(.uml.exitcall.exit)
 
-#ifndef __KERNEL__
+#ifdef __UM_HOST__
 
 #define __define_initcall(level,fn) \
 	static initcall_t __initcall_##fn __used \
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index cef0685..4cff19f 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -17,7 +17,7 @@
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /* This is to get size_t */
-#ifdef __KERNEL__
+#ifndef __UM_HOST__
 #include <linux/types.h>
 #else
 #include <stddef.h>
diff --git a/arch/x86/um/shared/sysdep/tls.h b/arch/x86/um/shared/sysdep/tls.h
index 27cce00..a682db1 100644
--- a/arch/x86/um/shared/sysdep/tls.h
+++ b/arch/x86/um/shared/sysdep/tls.h
@@ -1,7 +1,7 @@
 #ifndef _SYSDEP_TLS_H
 #define _SYSDEP_TLS_H
 
-# ifndef __KERNEL__
+#ifdef __UM_HOST__
 
 /* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
  * may be named user_desc (but in 2.4 and in header matching its API was named
@@ -22,11 +22,11 @@ typedef struct um_dup_user_desc {
 #endif
 } user_desc_t;
 
-# else /* __KERNEL__ */
+#else /* __UM_HOST__ */
 
 typedef struct user_desc user_desc_t;
 
-# endif /* __KERNEL__ */
+#endif /* __UM_HOST__ */
 
 extern int os_set_thread_area(user_desc_t *info, int pid);
 extern int os_get_thread_area(user_desc_t *info, int pid);
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

