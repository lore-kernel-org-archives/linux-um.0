Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950C0CAC594
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hH26aYIp7wW0Rx8k/qri2ElN7BBI2gkazkXuHwYeotg=; b=CeJnvZVS23xLEukguEpdtqzyC9
	9zKzur8XdQ64m+/qV17C4Ph/xiHIdhdOucsg8y0f+jKqH4qC0+r684cXx2LVcJObWNh895m8JkxKS
	yiO4Phbf1RnCfFXb0lCXh1G0g33nGyPRMG7BPfAahcLzXaksNFUYKd0XkLWhIWwQ9JuVFe9HiPHhO
	HUUi+CO1E+2Z5etnJHiERnIs7PZL5QB8lJzTD0iGZfGxBwiTcJ1AFMobPgoJpYuINjJDtCBFyvbZx
	fUMTtqUm1miokuR73CWCyRQMB/o+rjY7+4yurAL2+EJazYgMgItM6dIhymP4Nx+dtcUZM0VTCl+To
	+Bwo8CGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XM-000000031k5-1RZi;
	Mon, 15 Sep 2025 07:22:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XJ-000000031hl-0M1x
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hH26aYIp7wW0Rx8k/qri2ElN7BBI2gkazkXuHwYeotg=;
	t=1757920924; x=1759130524; b=SH2Lx7FF72ioBeDcPLzDoOme41xttebPrSck5MsbruwO2df
	jKc5zk2QZC4TypxNunyVgtHu3pUnD9yzawsh0nW4CVIK0GC4H/QGzWPWxYmdNcivVQWKHQUBcDX7c
	yS+XsnVFA2c77tpvkMLEmWvKifjOmRHZmFC9RImCw6cVroRc3QCzTYDgpbhQP/qr0unF9g64IkHvn
	RHTinpo88Hq4lIaElPl1OF2XQfCwRE/xHYR81on8n0nwM0RVfw/vHD/0dil4OxAcsYkBqazE68+tg
	ezeXrf8BwP+RtPJwGoxvyq0elWXOdSizhenisQNOIrnXaNeA+hSao9dFWJWi5hmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XF-00000005w6o-0LYc;
	Mon, 15 Sep 2025 09:22:01 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/9] um: use tools/include for user files
Date: Mon, 15 Sep 2025 09:11:08 +0200
Message-ID: <20250915071115.1429196-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002205_274164_C4C8D102 
X-CRM114-Status: GOOD (  19.06  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

Using the kernel headers directly from the userspace parts of UML is
problematic. Switch to use the headers from the tools/include
subdirectory instead. These contain stripped down versions that work
well for UML and only relatively small adjustments are needed to make it
work.

This adds two symlinks so that the userspace code can still find
asm-offsets.h and user_constants.h. Other than that, some includes are
moved into USER_CFLAGS instead of handling them in Makefile.rules.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Makefile                                  | 11 +++++++----
 arch/um/include/shared/generated/asm-offsets.h    |  1 +
 arch/um/include/shared/generated/user_constants.h |  1 +
 arch/um/include/shared/init.h                     |  2 +-
 arch/um/include/shared/user.h                     |  5 -----
 arch/um/kernel/skas/stub.c                        |  1 +
 arch/um/kernel/skas/stub_exe.c                    |  4 ++--
 arch/um/os-Linux/skas/process.c                   |  6 ++----
 arch/um/os-Linux/start_up.c                       |  4 ++--
 arch/um/scripts/Makefile.rules                    |  2 +-
 arch/x86/um/Makefile                              |  6 ++++--
 arch/x86/um/user-offsets.c                        |  1 -
 12 files changed, 22 insertions(+), 22 deletions(-)
 create mode 120000 arch/um/include/shared/generated/asm-offsets.h
 create mode 120000 arch/um/include/shared/generated/user_constants.h

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 7be0143b5ba3..a3f27d791cc0 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -70,10 +70,13 @@ KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
-		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
-		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__ \
-		-include $(srctree)/include/linux/compiler-version.h \
-		-include $(srctree)/include/linux/kconfig.h
+		-idirafter $(srctree)/tools/include \
+		-D__UM_HOST__ \
+		-include $(srctree)/tools/include/linux/compiler.h \
+		-include $(srctree)/tools/include/linux/kconfig.h \
+		-include $(srctree)/include/generated/autoconf.h \
+		-include $(srctree)/include/linux/kern_levels.h \
+		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
 
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
diff --git a/arch/um/include/shared/generated/asm-offsets.h b/arch/um/include/shared/generated/asm-offsets.h
new file mode 120000
index 000000000000..22fd929dbac7
--- /dev/null
+++ b/arch/um/include/shared/generated/asm-offsets.h
@@ -0,0 +1 @@
+../../../../../include/generated/asm-offsets.h
\ No newline at end of file
diff --git a/arch/um/include/shared/generated/user_constants.h b/arch/um/include/shared/generated/user_constants.h
new file mode 120000
index 000000000000..5f67c190ec09
--- /dev/null
+++ b/arch/um/include/shared/generated/user_constants.h
@@ -0,0 +1 @@
+../../../../../include/generated/user_constants.h
\ No newline at end of file
diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index 1a659e2e8cc3..d201705bedb3 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -41,7 +41,7 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#include <linux/compiler_types.h>
+#define __section(section)	__attribute__((__section__(section)))
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index 139eb78a4767..c9b853e1282f 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -16,13 +16,8 @@
  */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-/* This is to get size_t and NULL */
-#ifndef __UM_HOST__
 #include <linux/types.h>
-#else
 #include <stddef.h>
-#include <sys/types.h>
-#endif
 
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index 67cab46a602c..6c9bb1511ea2 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -5,6 +5,7 @@
 
 #include <sysdep/stub.h>
 
+#include <linux/init.h>
 #include <linux/futex.h>
 #include <sys/socket.h>
 #include <errno.h>
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index cbafaa684e66..0563838c01d1 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -4,8 +4,8 @@
 #include <asm/unistd.h>
 #include <sysdep/stub.h>
 #include <stub-data.h>
-#include <linux/filter.h>
-#include <linux/seccomp.h>
+#include <uapi/linux/filter.h>
+#include <uapi/linux/seccomp.h>
 #include <generated/asm-offsets.h>
 
 void _start(void);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 78f48fa9db8b..8ad7e863af97 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -29,9 +29,7 @@
 #include <sysdep/stub.h>
 #include <sysdep/mcontext.h>
 #include <linux/futex.h>
-#include <linux/threads.h>
 #include <timetravel.h>
-#include <asm-generic/rwonce.h>
 #include "../internal.h"
 
 int is_skas_winch(int pid, int fd, void *data)
@@ -204,7 +202,7 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 			 * Either way, if PID is negative, then we have no
 			 * choice but to kill the task.
 			 */
-			if (__READ_ONCE(mm_idp->pid) < 0)
+			if (READ_ONCE(mm_idp->pid) < 0)
 				goto out_kill;
 
 			ret = syscall(__NR_futex, &data->futex,
@@ -217,7 +215,7 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 			}
 		} while (data->futex == FUTEX_IN_CHILD);
 
-		if (__READ_ONCE(mm_idp->pid) < 0)
+		if (READ_ONCE(mm_idp->pid) < 0)
 			goto out_kill;
 
 		running = 0;
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index a827c2e01aa5..8971f4fdddab 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -28,8 +28,8 @@
 #include <stdbool.h>
 #include <stub-data.h>
 #include <sys/prctl.h>
-#include <linux/seccomp.h>
-#include <linux/filter.h>
+#include <uapi/linux/seccomp.h>
+#include <uapi/linux/filter.h>
 #include <sysdep/mcontext.h>
 #include <sysdep/stub.h>
 #include <registers.h>
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index a8b7d9dab0a6..b4a2e0058503 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -9,7 +9,7 @@ USER_OBJS += $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS:.o=.%): \
-	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
+	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(basetarget).o)
 
 # These are like USER_OBJS but filter USER_CFLAGS through unprofile instead of
 # using it directly.
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index b42c31cd2390..e5f1658a8f9d 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -38,8 +38,10 @@ subarch-$(CONFIG_MODULES) += ../kernel/module.o
 
 USER_OBJS := bugs_$(BITS).o ptrace_user.o fault.o
 
-$(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
-	-Iarch/x86/include/generated
+$(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS)	\
+	-Iarch/x86/include/generated					\
+	-include include/linux/kbuild.h
+
 targets += user-offsets.s
 
 include/generated/user_constants.h: $(obj)/user-offsets.s FORCE
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index d6e1cd9956bf..74fc9763b76e 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -8,7 +8,6 @@
 #define __FRAME_OFFSETS
 #include <linux/ptrace.h>
 #include <asm/types.h>
-#include <linux/kbuild.h>
 
 #define DEFINE_LONGS(sym, val)	\
 	COMMENT(#val " / sizeof(unsigned long)");	\
-- 
2.51.0


