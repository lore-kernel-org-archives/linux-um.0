Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B40C9833E
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HEWBMLD6x2u3yCWv48dT9RUMzOgGEgx/avI2s60itPU=; b=TMRfDwjuNQLVwG9wVHLn+QRXwN
	IDLTGp3PS1/obBIVos/CIJDJfALly4D6oCv86FZxd5QsR4imiRhWrd5a1Ul5t/WWFadjdNgsPkC80
	JRd+8jRMpnf3eBND2gljiFME8cg3kUF7QiAK7Ig2WT3t0iREYeLYodOsBgx8768JMuOthNHcAsqXT
	RL0d5pd1ed+E4FIPeic5PzMtaiiuYBwAQxqLFpTqo5OVmBsSgAlyniVj/kMjbM5esN3vEASYVUYyF
	5nSEaGxTcuoP4fnTyYXz2F8Iiia7Q7cZyGrFVrJ0Doy1MrZtyjblHuL2SPlF/jZive0uvgmyfdLsm
	NxqpILtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB5xj-0000000HZ4r-1PfR;
	Mon, 28 Sep 2026 07:39:47 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB5xg-0000000HZ2j-08qO
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 07:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=HEWBMLD6x2u3yCWv48dT9RUMzOgGEgx/avI2s60itPU=; t=1790581183; x=1791790783; 
	b=AU/b4OzRyZid3KVT3m3CDe4zuWmrNoQphHxD/AdR8h2zSQWPyU/FIOfhvRuthmoyOiVt1buUE6a
	zzPQj/hxg/HPYvprpgT+Dcn80pg/OqYomP+xL7ur5P3GP4sipqXXSYWjOrtgCkzZdNkDI3dMHa07b
	5SMQ2E9TOL+JCDiVCTA1fYNAwCIYsg1YXXbTDrH29tVVWRhCWIw1SX2YT6GGo+9Cef10m3P/scD/N
	5rsjdB7NFjpQfStx4egvIYrlY/0lpF2OUYXa223zp5v7pVLpi7hIWHCy6E3OKa6maHFdJOorv1+zg
	dwI9PniovTCSTg0+he3F/114UkbN/Ku4bV8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xB5xb-0000000DKy8-1wbM;
	Mon, 28 Sep 2026 09:39:39 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH] um: fix shutdown __inittext access
Date: Mon, 28 Sep 2026 09:39:35 +0200
Message-ID: <20260928093934.ca7af44c59ca.I470ece16d176ea704aa6e5767b755055d106da35@changeid>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_003944_273306_932FA7B0 
X-CRM114-Status: GOOD (  17.66  )
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

From: Johannes Berg <johannes.berg@intel.com>

Since first moving __init text into the right place in commit
8966ed0b2d48 ("um: move init text between __init_begin/end")
and then making all init sections inaccessible, shutdown and
reboot crash instead of working correctly, for the obvious
reason that the functions are __init but run on the way out.

Removing the __init markers would work in some way, but that
would bubble through a lot of functions.

Instead, mark the relevant functions __noreturn (including
longjmp() since that's now needed so start_idle_thread() can
be __noreturn), and split out the part of main() that's done
on the way out into a new os_exit() function that's called
directly.

Reported-by: Hajime Tazaki <thehajime@gmail.com>
Closes: https://lore.kernel.org/linux-um/m24ifc4v6m.wl-thehajime@gmail.com/
Fixes: a418ab8fddea ("um: mprotect() __init memory")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/as-layout.h |  3 ++-
 arch/um/include/shared/kern_util.h |  3 ++-
 arch/um/include/shared/longjmp.h   |  3 ++-
 arch/um/include/shared/os.h        |  6 +++++-
 arch/um/kernel/skas/process.c      |  6 +++---
 arch/um/kernel/um_arch.c           |  4 ++--
 arch/um/os-Linux/main.c            | 17 +++++++++++------
 arch/um/os-Linux/skas/process.c    | 11 +++--------
 8 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 02ef258e3395..7c4ccb6d9d37 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -29,6 +29,7 @@
 
 #ifndef __ASSEMBLER__
 
+#include <linux/compiler_types.h>
 #include <sysdep/ptrace.h>
 
 struct task_struct;
@@ -46,7 +47,7 @@ extern unsigned long brk_start;
 
 extern unsigned long stub_start;
 
-extern int linux_main(int argc, char **argv, char **envp);
+extern void __noreturn linux_main(int argc, char **argv, char **envp);
 extern void uml_finishsetup(void);
 
 struct siginfo;
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 9812efd14ec0..7950d58a4ae8 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -6,6 +6,7 @@
 #ifndef __KERN_UTIL_H__
 #define __KERN_UTIL_H__
 
+#include <linux/compiler_types.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/faultinfo.h>
 
@@ -37,7 +38,7 @@ extern void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs
 
 extern void uml_pm_wake(void);
 
-extern int start_uml(void);
+extern void __noreturn start_uml(void);
 
 extern void uml_cleanup(void);
 extern void do_uml_exitcalls(void);
diff --git a/arch/um/include/shared/longjmp.h b/arch/um/include/shared/longjmp.h
index c53e43d980c8..b35ed756e3e4 100644
--- a/arch/um/include/shared/longjmp.h
+++ b/arch/um/include/shared/longjmp.h
@@ -2,11 +2,12 @@
 #ifndef __UML_LONGJMP_H
 #define __UML_LONGJMP_H
 
+#include <linux/compiler_types.h>
 #include <sysdep/archsetjmp.h>
 #include <os.h>
 
 extern int setjmp(jmp_buf);
-extern void longjmp(jmp_buf, int);
+extern void __noreturn longjmp(jmp_buf, int);
 
 #define UML_LONGJMP(buf, val) do { \
 	longjmp(*buf, val);	\
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b26e94292fc1..0067c5208c4c 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -15,6 +15,7 @@
 #ifndef __UM_HOST__
 #include <linux/types.h>
 #else
+#include <stdbool.h>
 #include <sys/types.h>
 #endif
 
@@ -196,6 +197,9 @@ extern int create_mem_file(unsigned long long len);
 /* tlb.c */
 extern void report_enomem(void);
 
+/* main.c */
+extern void __noreturn os_exit(bool reboot);
+
 /* process.c */
 pid_t os_reap_child(void);
 extern void os_alarm_process(int pid);
@@ -295,7 +299,7 @@ extern int start_userspace(struct mm_id *mm_id);
 extern void userspace(struct uml_pt_regs *regs);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
-extern int start_idle_thread(void *stack, jmp_buf *switch_buf);
+extern void __noreturn start_idle_thread(void *stack, jmp_buf *switch_buf);
 extern void initial_thread_cb_skas(void (*proc)(void *),
 				 void *arg);
 extern void halt_skas(void);
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index dcdce50b4595..f60541df209f 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -27,7 +27,7 @@ static int __init start_kernel_proc(void *unused)
 
 char cpu_irqstacks[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
 
-int __init start_uml(void)
+void __init start_uml(void)
 {
 	stack_protections((unsigned long) &cpu_irqstacks[0]);
 	set_sigstack(cpu_irqstacks[0], THREAD_SIZE);
@@ -36,8 +36,8 @@ int __init start_uml(void)
 
 	init_task.thread.request.thread.proc = start_kernel_proc;
 	init_task.thread.request.thread.arg = NULL;
-	return start_idle_thread(task_stack_page(&init_task),
-				 &init_task.thread.switch_buf);
+	start_idle_thread(task_stack_page(&init_task),
+			  &init_task.thread.switch_buf);
 }
 
 static DEFINE_SPINLOCK(initial_jmpbuf_spinlock);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 13e84e605630..3dbe3acc4833 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -308,7 +308,7 @@ static unsigned long __init get_top_address(char **envp)
 	return PAGE_ALIGN(top_addr + 1);
 }
 
-int __init linux_main(int argc, char **argv, char **envp)
+void __init linux_main(int argc, char **argv, char **envp)
 {
 	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
@@ -401,7 +401,7 @@ int __init linux_main(int argc, char **argv, char **envp)
 
 	os_flush_stdout();
 
-	return start_uml();
+	start_uml();
 }
 
 int __init __weak read_initrd(void)
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 7e114862a723..ea41188ef2d0 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -100,10 +100,11 @@ static void __init setup_env_path(void)
 	}
 }
 
+static char **new_argv;
+
 int __init main(int argc, char **argv, char **envp)
 {
-	char **new_argv;
-	int ret, i, err;
+	int ret, i;
 
 	/* Disable randomization and re-exec if it was changed successfully */
 	ret = personality(PER_LINUX | ADDR_NO_RANDOMIZE);
@@ -150,7 +151,12 @@ int __init main(int argc, char **argv, char **envp)
 	scan_elf_aux(envp);
 
 	change_sig(SIGPIPE, 0);
-	ret = linux_main(argc, argv, envp);
+	linux_main(argc, argv, envp);
+}
+
+void os_exit(bool reboot)
+{
+	int err;
 
 	/*
 	 * Disable SIGPROF - I have no idea why libc doesn't do this or turn
@@ -183,12 +189,11 @@ int __init main(int argc, char **argv, char **envp)
 
 	os_info("\n");
 	/* Reboot */
-	if (ret) {
+	if (reboot) {
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
-		ret = 1;
 	}
-	return uml_exitcode;
+	exit(uml_exitcode);
 }
 
 extern void *__real_malloc(int);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d6c22f8aa06d..bca05a5a7a83 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -816,7 +816,7 @@ static __thread void (*cb_proc)(void *arg);
 static __thread void *cb_arg;
 static __thread jmp_buf *cb_back;
 
-int start_idle_thread(void *stack, jmp_buf *switch_buf)
+void start_idle_thread(void *stack, jmp_buf *switch_buf)
 {
 	int n;
 
@@ -843,21 +843,16 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 		break;
 	case INIT_JMP_HALT:
 		kmalloc_ok = 0;
-		return 0;
+		os_exit(false);
 	case INIT_JMP_REBOOT:
 		kmalloc_ok = 0;
-		return 1;
+		os_exit(true);
 	default:
 		printk(UM_KERN_ERR "Bad sigsetjmp return in %s - %d\n",
 		       __func__, n);
 		fatal_sigsegv();
 	}
 	longjmp(*switch_buf, 1);
-
-	/* unreachable */
-	printk(UM_KERN_ERR "impossible long jump!");
-	fatal_sigsegv();
-	return 0;
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
-- 
2.55.0


