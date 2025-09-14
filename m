Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C92DCAC587
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWHTAE/9tK2VmYtJYChd0m6RlqKlICrq+eONEttRyNc=; b=xtd0Z/hjkVwrvhqoDf/fKiTE3c
	uoVXsz5TZAC37f1ejTRjkn4KnYuVsg3FfnFelBHMczHWozojVgmdZaTf8fkOfNP31GOSssDB2nDrZ
	VAsHLTnczBc/wqBlUYePxeQaYw9hy7IreLNoof5r6sNXoVYoRI8hRDyD8GiFthf6VY89GCoXi52+J
	0OpsqR2JyWLg8NT3YO/4HRbwbv+pX89xQ057DXN/dKOxPZP29svYhPCw9cDKzPi1ocgMxTGUjXdKT
	10Z7nPXZYVecbkfKYV16OIQq36UC3rzfaFmy7Qmd+usxJSwRvG4Job/HpFqXdqUBsLRKEqBLOIE5C
	VHiCfiPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxp8q-00000001mY7-241r;
	Sun, 14 Sep 2025 15:59:52 +0000
Received: from out-185.mta0.migadu.com ([91.218.175.185])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxp8o-00000001lij-1WnC
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 15:59:51 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWHTAE/9tK2VmYtJYChd0m6RlqKlICrq+eONEttRyNc=;
	b=f/B4PnvK67yJlD9oFLRA2LCJgt2inszhoK2k7stiHdEgjOKdiNpA60Vkrht7OTRZOuu9YW
	Fj+UEwnV8NIyOQ2Nko4WMXveMcdKXpzAkEBYT50TdWEZ0u58lHZnrEGAgfNpSz5Nwk1kWT
	O2a6vteizNXDWeP/HCKPXqEAcSZhTwg=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v3 2/7] um: Determine sleep based on need_resched()
Date: Sun, 14 Sep 2025 23:56:53 +0800
Message-Id: <20250914155658.1028790-3-tiwei.bie@linux.dev>
In-Reply-To: <20250914155658.1028790-1-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_085950_539353_71B474AD 
X-CRM114-Status: GOOD (  16.64  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

With SMP and NO_HZ enabled, the CPU may still need to sleep even
if the timer is disarmed. Switch to deciding whether to sleep based
on pending resched. Additionally, because disabling IRQs does not
block SIGALRM, it is also necessary to check for any pending timer
alarms. This is a preparation for adding SMP support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/kern_util.h |  1 +
 arch/um/kernel/process.c           |  5 +++++
 arch/um/os-Linux/internal.h        |  5 +++++
 arch/um/os-Linux/signal.c          |  6 ++++++
 arch/um/os-Linux/time.c            | 15 +++++++++------
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 00ca3e12fd9a..3daaa5c4b35d 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -55,6 +55,7 @@ extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern char *uml_strdup(const char *string);
+int uml_need_resched(void);
 
 extern unsigned long to_irq_stack(unsigned long *mask_out);
 extern unsigned long from_irq_stack(int nested);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 1be644de9e41..41b3b3bf7309 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -225,6 +225,11 @@ int __uml_cant_sleep(void) {
 	/* Is in_interrupt() really needed? */
 }
 
+int uml_need_resched(void)
+{
+	return need_resched();
+}
+
 extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
 
 void do_uml_exitcalls(void)
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index 5d8d3b0817a9..c2c7a0dc673c 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -15,6 +15,11 @@ void scan_elf_aux(char **envp);
  */
 void check_tmpexec(void);
 
+/*
+ * signal.c
+ */
+int timer_alarm_pending(void);
+
 /*
  * skas/process.c
  */
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 58da8c6ece98..554a87dd32cc 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -20,6 +20,7 @@
 #include <um_malloc.h>
 #include <sys/ucontext.h>
 #include <timetravel.h>
+#include "internal.h"
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) = {
 	[SIGTRAP]	= relay_signal,
@@ -159,6 +160,11 @@ void timer_set_signal_handler(void)
 	set_handler(SIGALRM);
 }
 
+int timer_alarm_pending(void)
+{
+	return !!(signals_pending & SIGALRM_MASK);
+}
+
 void set_sigstack(void *sig_stack, int size)
 {
 	stack_t stack = {
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 4d5591d96d8c..f3d4547e5227 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -15,6 +15,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <string.h>
+#include "internal.h"
 
 static timer_t event_high_res_timer = 0;
 
@@ -98,18 +99,20 @@ long long os_nsecs(void)
  */
 void os_idle_sleep(void)
 {
-	struct itimerspec its;
 	sigset_t set, old;
 
-	/* block SIGALRM while we analyze the timer state */
+	/* Block SIGALRM while performing the need_resched check. */
 	sigemptyset(&set);
 	sigaddset(&set, SIGALRM);
 	sigprocmask(SIG_BLOCK, &set, &old);
 
-	/* check the timer, and if it'll fire then wait for it */
-	timer_gettime(event_high_res_timer, &its);
-	if (its.it_value.tv_sec || its.it_value.tv_nsec)
+	/*
+	 * Because disabling IRQs does not block SIGALRM, it is also
+	 * necessary to check for any pending timer alarms.
+	 */
+	if (!uml_need_resched() && !timer_alarm_pending())
 		sigsuspend(&old);
-	/* either way, restore the signal mask */
+
+	/* Restore the signal mask. */
 	sigprocmask(SIG_UNBLOCK, &set, NULL);
 }
-- 
2.34.1


