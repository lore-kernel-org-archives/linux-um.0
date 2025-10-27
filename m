Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032FECCF9E9
	for <linux-um@archiver.kernel.org>; Mon, 27 Oct 2025 00:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3yN0Jw1zCGCU2swiMeoJP4VIvF3PJD+YGhgn1SWJiEQ=; b=M1YG1b9WaiYN0SeyqyaJ7TZQYY
	zjyCm5Zmu+wS1eGC4VoyRKCxh9XbGd/ykrTqo23YUQbhwTCxt5jF+Mz2Es5gl32FrYsq9gPW4FHrt
	oTz5pNnxGq9kRRJttAWEkfWg9LritMf5Q4LFAtJ3FdHbq0epre/xLDS/hFE38M1V3ZG6IE1gfLwHs
	ycEVd1/33cUudJ4qyhP9Swn1ko3k2190e2fBVVnfoKlKXGrqnPItQ0f7KJNGab9dCTwOqTSagkTAw
	BlRDHxv8M9iGWgFsdoJuMccn4tyAxsEb7TRtP+/0FL3inCEbrhDAMSW2R26AGd+FApcCbzaDtj6H1
	v9Eo1V0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAwf-0000000CtNz-3CWt;
	Mon, 27 Oct 2025 00:18:45 +0000
Received: from out-180.mta0.migadu.com ([2001:41d0:1004:224b::b4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAwd-0000000CtLP-0WEe
	for linux-um@lists.infradead.org;
	Mon, 27 Oct 2025 00:18:44 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yN0Jw1zCGCU2swiMeoJP4VIvF3PJD+YGhgn1SWJiEQ=;
	b=Q8PZUXJ/EFYmqfsILLrn33GI2LpzoVpOYBn1f/BIYssTfx9gjrppPCCAZ3n5cmcnPPfYdp
	i0BIgEY0kHVfH7XF7b5cbEI41wIZu8fxNgRSzhRlsZXWuo9wwWEMn/MTR1sQukRG0goVGX
	7R/et7Hpnq1H+UkawmRUWBLvKEViJV8=
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
Subject: [PATCH v4 3/8] um: Determine sleep based on need_resched()
Date: Mon, 27 Oct 2025 08:18:10 +0800
Message-Id: <20251027001815.1666872-4-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_171843_306582_FA01EEFC 
X-CRM114-Status: GOOD (  16.71  )
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
index 757e21185a0e..a60230b299da 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -221,6 +221,11 @@ int __uml_cant_sleep(void) {
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


