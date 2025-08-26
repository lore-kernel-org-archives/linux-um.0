Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D617BCA0EE4
	for <linux-um@archiver.kernel.org>; Tue, 26 Aug 2025 05:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=65ayLE+QQynk9aQmcYEngRqdHtxeY4HUGz5dhtcY1F0=; b=it7W78XxxP8C3rS55Wuh1jCtD0
	XZVw4etHhIk6dwv0sgOiD1dx11OEXIpuaqFJHB95GsDxWxKu9SvcyoZDcmLQlI7U70/wnYXjoARDn
	q/xSGBsJPkZ6D9kNtym8P7LkNkeEiWQchG2PwweiqdUS7L9aECBO+5mur8g4MXi2gZOHMwu/Sf58T
	/rflPN5VGwQY3DrGohn379Ej6FDu9A/RPL9BXi0i4N//UNo8q0l4pQHF9B0iwhnzUQK+RuBDJ6+Rd
	rcL5Cu8YV6pDd0G7kqoqm9/aQPI9DAaQEUC4bSCSQqvsYsfoYaeZ6KUPqKElF4mmlTM83lrUtNzXU
	yo+dS6Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqmFK-0000000AalB-1ffW;
	Tue, 26 Aug 2025 05:29:26 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqmFI-0000000Aaki-22Ks
	for linux-um@lists.infradead.org;
	Tue, 26 Aug 2025 05:29:25 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756186159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=65ayLE+QQynk9aQmcYEngRqdHtxeY4HUGz5dhtcY1F0=;
	b=Wq6Ux+WC2gIff/jZ/isyQz+BbCWLrcjOr4FQaQf29+xxJllaVC2St0w7reMOMbwCf0ucpg
	wMHNDP6oXt85ysteE3C15+xukHVemOZGaY/xYcgwf1ueeMfvan+cO7iHdI1hnvasFLMVKA
	wIAtvnoJcQSfPrg80ljFFzoJ5dxD4sHJtTHMbgzvoK11ywq67dzS57viFFMo4nEgU8URaw
	bO5LlyBGRQY5QRW0z/PfZzxaUodPaMCfOmz0JSuWlI04RKILD8IFxF+IlVeDTQ3ncL1LY5
	sSe7w1h62t377FLJPMimvuWZtf6i7zY1EscHlJCgbxSJbBMJS+vE72xsTYZpGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756186159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=65ayLE+QQynk9aQmcYEngRqdHtxeY4HUGz5dhtcY1F0=;
	b=sKuNjYhfjcMqtbi/xJ6keKKcRYn6EZO9jbKAcc5QJRj9FYL4OA5rbvIG5YsuMAshlGQr/W
	An4saYE4LMRJs5Bw==
Date: Tue, 26 Aug 2025 07:29:11 +0200
Subject: [PATCH] vdso: Remove struct getcpu_cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-getcpu_cache-v1-1-8748318f6141@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACZGrWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNT3fTUkuSC0vjkxOSMVF3jxKTkFKNUM1MTY3MloJaCotS0zAqwcdG
 xtbUAwJ29uV4AAAA=
X-Change-ID: 20250825-getcpu_cache-3abcd2e65437
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756186155; l=9757;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zAA65t+biCTL2Eftd5Vt0eFjHTRHEoaWFGOLEH6aG4w=;
 b=oCH06dxxdjmFh7WWuVm9nzzFq2kCgh1Ogw3db72JXYeGBbeG8IW+QjHv1UcScE5HMJWzhJ0V8
 RIFNkDMcDqBDhl6Nfn7WDqgAyYQep8GaP8LuLJF9TlYHxgP3yYaCx0i
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_222924_678487_E416EC57 
X-CRM114-Status: GOOD (  18.42  )
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

The cache parameter of getcpu() is not used by the kernel and no user ever
passes it in anyways.

Remove the struct and its header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
We could also completely remove the parameter, but I am not sure if
that is a good idea for syscalls and vDSO entrypoints.
---
 arch/loongarch/vdso/vgetcpu.c                   |  5 ++---
 arch/s390/kernel/vdso64/getcpu.c                |  3 +--
 arch/s390/kernel/vdso64/vdso.h                  |  4 +---
 arch/x86/entry/vdso/vgetcpu.c                   |  5 ++---
 arch/x86/include/asm/vdso/processor.h           |  4 +---
 arch/x86/um/vdso/um_vdso.c                      |  7 +++----
 include/linux/getcpu.h                          | 19 -------------------
 include/linux/syscalls.h                        |  3 +--
 kernel/sys.c                                    |  4 +---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c |  4 +---
 10 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 5301cd9d0f839eb0fd7b73a1d36e80aaa75d5e76..aefba899873ed035d70766a95b0b6fea881e94df 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -4,7 +4,6 @@
  */
 
 #include <asm/vdso.h>
-#include <linux/getcpu.h>
 
 static __always_inline int read_cpu_id(void)
 {
@@ -20,8 +19,8 @@ static __always_inline int read_cpu_id(void)
 }
 
 extern
-int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
-int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused);
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
 {
 	int cpu_id;
 
diff --git a/arch/s390/kernel/vdso64/getcpu.c b/arch/s390/kernel/vdso64/getcpu.c
index 5c5d4a848b7669436e73df8e3b711e5b876eb3db..1e17665616c5fa766ca66c8de276b212528934bd 100644
--- a/arch/s390/kernel/vdso64/getcpu.c
+++ b/arch/s390/kernel/vdso64/getcpu.c
@@ -2,11 +2,10 @@
 /* Copyright IBM Corp. 2020 */
 
 #include <linux/compiler.h>
-#include <linux/getcpu.h>
 #include <asm/timex.h>
 #include "vdso.h"
 
-int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
+int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, void *unused)
 {
 	union tod_clock clk;
 
diff --git a/arch/s390/kernel/vdso64/vdso.h b/arch/s390/kernel/vdso64/vdso.h
index 9e5397e7b590a23c149ccc6043d0c0b0d5ea8457..cadd307d7a365cabf53f5c8d313be3718625533d 100644
--- a/arch/s390/kernel/vdso64/vdso.h
+++ b/arch/s390/kernel/vdso64/vdso.h
@@ -4,9 +4,7 @@
 
 #include <vdso/datapage.h>
 
-struct getcpu_cache;
-
-int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);
+int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, void *unused);
 int __s390_vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 int __s390_vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 int __s390_vdso_clock_getres(clockid_t clock, struct __kernel_timespec *ts);
diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index e4640306b2e3c95d74d73037ab6b09294b8e1d6c..6381b472b7c52487bccf3cbf0664c3d7a0e59699 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -6,17 +6,16 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/getcpu.h>
 #include <asm/segment.h>
 #include <vdso/processor.h>
 
 notrace long
-__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned *cpu, unsigned *node, void *unused)
 {
 	vdso_read_cpunode(cpu, node);
 
 	return 0;
 }
 
-long getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+long getcpu(unsigned *cpu, unsigned *node, void *tcache)
 	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vdso/processor.h
index 7000aeb59aa287e2119c3d43ab3eaf82befb59c4..93e0e24e5cb47f7b0056c13f2a7f2304ed4a0595 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -18,9 +18,7 @@ static __always_inline void cpu_relax(void)
 	native_pause();
 }
 
-struct getcpu_cache;
-
-notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);
+notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused);
 
 #endif /* __ASSEMBLER__ */
 
diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124fd0ff0f9d240c33fefb8d213c84cd..9aa2c62cce6b7a07bbaf8441014d347162d1950d 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -10,14 +10,13 @@
 #define DISABLE_BRANCH_PROFILING
 
 #include <linux/time.h>
-#include <linux/getcpu.h>
 #include <asm/unistd.h>
 
 /* workaround for -Wmissing-prototypes warnings */
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
-long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
+long __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
@@ -60,7 +59,7 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
-__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
 {
 	/*
 	 * UML does not support SMP, we can cheat here. :)
@@ -74,5 +73,5 @@ __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused
 	return 0;
 }
 
-long getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
+long getcpu(unsigned int *cpu, unsigned int *node, void *tcache)
 	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/include/linux/getcpu.h b/include/linux/getcpu.h
deleted file mode 100644
index c304dcdb4eac2a9117080e6a14f4e3f28d07fd56..0000000000000000000000000000000000000000
--- a/include/linux/getcpu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_GETCPU_H
-#define _LINUX_GETCPU_H 1
-
-/* Cache for getcpu() to speed it up. Results might be a short time
-   out of date, but will be faster.
-
-   User programs should not refer to the contents of this structure.
-   I repeat they should not refer to it. If they do they will break
-   in future kernels.
-
-   It is only a private cache for vgetcpu(). It will change in future kernels.
-   The user program must store this information per thread (__thread)
-   If you want 100% accurate information pass NULL instead. */
-struct getcpu_cache {
-	unsigned long blob[128 / sizeof(long)];
-};
-
-#endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77f45e5d44139da36a5dacbf9db7b65261d13398..81822d203eac5d8d91488a18ff7fcdc65670df54 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -59,7 +59,6 @@ struct compat_stat;
 struct old_timeval32;
 struct robust_list_head;
 struct futex_waitv;
-struct getcpu_cache;
 struct old_linux_dirent;
 struct perf_event_attr;
 struct file_handle;
@@ -714,7 +713,7 @@ asmlinkage long sys_getrusage(int who, struct rusage __user *ru);
 asmlinkage long sys_umask(int mask);
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
-asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
+asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, void __user *cache);
 asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce206d7d0ed27e8a4fce8b616c3565..a830d78c1e1eb1d6cef31294feeb6a88dc0f83f3 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -31,7 +31,6 @@
 #include <linux/tty.h>
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
-#include <linux/getcpu.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/seccomp.h>
 #include <linux/cpu.h>
@@ -2813,8 +2812,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	return error;
 }
 
-SYSCALL_DEFINE3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep,
-		struct getcpu_cache __user *, unused)
+SYSCALL_DEFINE3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep, void __user *, unused)
 {
 	int err = 0;
 	int cpu = raw_smp_processor_id();
diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
index cdeaed45fb26c61f6314c58fe1b71fa0be3c0108..994ce569dc37c6689b1a3c79156e3dfc8bf27f22 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -16,9 +16,7 @@
 #include "vdso_config.h"
 #include "vdso_call.h"
 
-struct getcpu_cache;
-typedef long (*getcpu_t)(unsigned int *, unsigned int *,
-			 struct getcpu_cache *);
+typedef long (*getcpu_t)(unsigned int *, unsigned int *, void *);
 
 int main(int argc, char **argv)
 {

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250825-getcpu_cache-3abcd2e65437

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


