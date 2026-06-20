Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D2CCDB471
	for <linux-um@archiver.kernel.org>; Sat, 20 Jun 2026 03:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lEUg6D+GFM56fnHVOgGa2ieTPH08FZYZa7bjmqpjtO4=; b=BvNWjSYo2WYXi2PzgvIic125f7
	sRO/+uOeOpnA/+DS6SUov0pvX71ayiNh6OOM6o1NK0Nfihk+iEI+tQ254RqqbSmOMlis0nCXf7tjW
	xpdVNsJ/gYKHhKx/+iSyvByP5nBZxSk2I/jbpSZD2yWZRlO6uh5Gpox4VXY9wl+Kjo60Vod+sRPvb
	RpJTuy40W5S9J/fM/RtFvsV+piKwl3AVbtLsE874oAcfufkKJAP3l2arprO7ZnSgJlaYmzPRR+Iqx
	uBbkqBmWg5Wt4R4Dvdq4XwD/j1WzLcqYMbI5Q3nlcsSxHc3gco/7ZBJPwJ8T4gt19ez5BiCS8HQPe
	EvMHNImw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIS-000000038wi-0DPs;
	Sat, 20 Jun 2026 03:23:04 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIP-000000038uI-2oBt
	for linux-um@lists.infradead.org;
	Sat, 20 Jun 2026 03:23:03 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-30bcdf8232fso5991726eec.0
        for <linux-um@lists.infradead.org>; Fri, 19 Jun 2026 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925781; x=1782530581; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEUg6D+GFM56fnHVOgGa2ieTPH08FZYZa7bjmqpjtO4=;
        b=Asc2gy6HjnDiZBI1xqhZYQjNRMt8vFaGzsnUfp0L1QZPUDTNG5hUFYWMiO890CpQfQ
         Q9Cd237P+nF6trK9/gwa9/r4UAAY0o6SSUj6LKXCMBOAfH6IBXQU6/tnzYjcUQJA1D7X
         XBrgtyRKedymEBZ8eQmibPCjk0NkGIObN2naOF+Qs1++SfRHpw/7PTwG0u5jd92MD/jY
         5AfZ+eUJwePAiNL4MstqpitmHK0WX9cp1s1W9NrrLUKPnRkBN2A4qJeBBsEQ2R1NI3Wl
         oXLzjtRFJ2EjDwq5vwcqvGDbtCOO1J5bldFTBnDlFvTcFOo1Zxw1+V0BEYhWpOqNWNho
         z5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925781; x=1782530581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lEUg6D+GFM56fnHVOgGa2ieTPH08FZYZa7bjmqpjtO4=;
        b=UNTdcJ0k+19RkVyJ6ew5jFke15QCHdZKv6BofuZOYGYH/z1qyXmW9uhXqGuVWR2wPU
         zagb6etMCJVlKzQvNIFAepJ89xfr3bZHY8/Uguj+h+NkKBn7AlWGfb5swkuIWE+UGIRf
         ndduK2eYmw+CSuARL7HMOdtk7yMbwJx85/8Wbbl5yyk8W3W3D/KgrTmm1J9X56h/d/eM
         RnRzcc43acQfWsNsvPgOVJc6x/T+lBa1tqvd3OsoT36FfbbaDkUb/wdcRgKTDxTRmTOM
         gQzBPBUwejq1JCFpz+dxXA7X7K9JbIuR7FsnGvuFlP7iiOK7F2LE3zPycbu4PI6RNpO+
         SQaA==
X-Forwarded-Encrypted: i=1; AFNElJ+PSt4eqc1+Ck59bynqAngxwYDkZbjymbB94OU/ASBJWEjMyWlQKZSa9xpJpmKUCv81vY2O8JcreQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCGFXQC8wcHR1azvUFrNJjdyLcG4djaZF83Ei0CB005gkVu7OJ
	6jBKgxkgh8vL/Ceb1rl6VJ48IM0ox/M6WB3Lhzp1/KlUFQghbeBJmbnQ
X-Gm-Gg: AfdE7cm53aMuV9Pyzsf3TzJTQkPHxTdQ8FJ35ndHaK5LSwsUYoqrmcOxKqw+69V3Cyw
	pfP6Bv3b3Lp7vuEJw1r1N9nk5NnqovVspYpotTMu74/3f0BdrECLfQM/a88W+1R/JRr+fmfoU/r
	AgjZCWxdRtM8RqAe8GeiYAx8Q12DGXIIbNt6LRIAxeLYJrqxdN0X5BP/7z5tjZrTWbhtVN7qnag
	HGiSrDtrOv+WxAaOX8MuUeGqcAZwa451hv1WmpmX6h+NsC+pDktCpqb6ht+qvN6GRbbxjWTlOCc
	pi6m/q50DbZwqBQITCthjTRnYijoZW1XIbTzmamNhUNXN4sPFrHf3R8Otq/X1oGJn1kKTCxitOV
	1wS/z27cv3H5fjV12FrUnoyFNjUydhBiRJBd9hXLJLQI8j/7+Wh/TmiOG+jV3YBII+4qPD9XnrN
	+N9f6NVetqqNguw7Tcqye9aQSgQuw7PVwlqelA0UShriRo1OQzPg==
X-Received: by 2002:a05:693c:63d3:b0:30c:1275:9509 with SMTP id 5a478bee46e88-30c1275997emr1573462eec.14.1781925780761;
        Fri, 19 Jun 2026 20:23:00 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:ce45:b713:5d9f:6abd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm1902019eec.5.2026.06.19.20.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:23:00 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 6/7] um: skas: kill stubs that block SIGALRM via a watchdog thread
Date: Fri, 19 Jun 2026 20:22:23 -0700
Message-ID: <7c7c19f9f70e874f071c3ea66957d56e0ea2648d.1781925126.git.xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781925126.git.xiyou.wangcong@gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_202302_200835_395F9BB7 
X-CRM114-Status: GOOD (  23.40  )
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

From: Cong Wang <cwang@multikernel.io>

A hijacked stub can block SIGALRM with a crafted rt_sigreturn (the mask is
restored from the stack it controls), so it is never preempted and never
reports back. SIGALRM goes to the stub, not the monitor, so the monitor
then blocks indefinitely in wait_stub_done_seccomp(). This is the one item
("blocking e.g. SIGALRM") of the stub.c "Known security issues" list that a
seccomp filter cannot address, since rt_sigreturn is required and its
effect lives on the stack rather than in register arguments.

Detect it out of band. A helper thread blocks on its own timerfd and
watches a per-vCPU (pid, seq) pair the monitor updates around each wait:
pid is the stub being waited on, seq advances every time the stub reports.
A stub that stops reporting leaves pid pinned and seq frozen; after
SECCOMP_WD_STALL_TICKS ticks of no progress the watchdog SIGKILLs it, and
the resulting SIGCHLD unblocks the monitor through the existing "pid < 0"
teardown.

Each monitor writes only its own slot and the watchdog only reads, so the
word-sized state needs just __READ_ONCE()/__WRITE_ONCE(), no lock; the
watchdog scans every slot, covering all CPUs under SMP. A false kill cannot
happen without the same pid and an unchanged seq across many ticks. The
thread runs with all signals blocked (os_run_helper_thread()), uses
write(2) rather than printk() from its non-kernel context, and is started
once via a compare-and-swap guard. It is preferred over a bounded
FUTEX_WAIT timeout: it costs one counter bump on the per-syscall hot path
and catches a stall anywhere on stub input, not just the one futex.

Verified on UML (UP and 2-CPU SMP): heavy mmap/munmap churn and CPU-bound
loops on every vCPU run with zero false kills; a stub with SIGALRM blocked
is killed in ~5s and the monitor recovers, while syscall-making processes
are untouched.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/os-Linux/skas/process.c | 129 ++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 2010b4529c41..7ffde2b00b61 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -21,6 +21,7 @@
 #include <as-layout.h>
 #include <init.h>
 #include <kern_util.h>
+#include <smp.h>
 #include <mem.h>
 #include <os.h>
 #include <ptrace_user.h>
@@ -33,6 +34,8 @@
 #include <linux/threads.h>
 #include <sys/ioctl.h>
 #include <poll.h>
+#include <signal.h>
+#include <sys/timerfd.h>
 #include <timetravel.h>
 #include <asm-generic/rwonce.h>
 #include "../internal.h"
@@ -254,11 +257,131 @@ static void seccomp_serve_stub_syscalls(struct mm_id *mm_idp)
 		seccomp_notify_serve(mm_idp);
 }
 
+#define SECCOMP_WD_TICK_SECS	1
+#define SECCOMP_WD_STALL_TICKS	5	/* ~5s of no progress before killing */
+
+static int seccomp_wd_pid[CONFIG_NR_CPUS] = { [0 ... CONFIG_NR_CPUS - 1] = -1 };
+static unsigned long seccomp_wd_seq[CONFIG_NR_CPUS];
+
+static inline void seccomp_wd_enter(int pid)
+{
+	int cpu = uml_curr_cpu();
+
+	__WRITE_ONCE(seccomp_wd_seq[cpu], seccomp_wd_seq[cpu] + 1);
+	__WRITE_ONCE(seccomp_wd_pid[cpu], pid);
+}
+
+static inline void seccomp_wd_progress(void)
+{
+	int cpu = uml_curr_cpu();
+
+	__WRITE_ONCE(seccomp_wd_seq[cpu], seccomp_wd_seq[cpu] + 1);
+}
+
+static inline void seccomp_wd_exit(void)
+{
+	__WRITE_ONCE(seccomp_wd_pid[uml_curr_cpu()], -1);
+}
+
+/* Per-CPU snapshot the watchdog compares against the next tick. */
+struct seccomp_wd_cpu {
+	int prev_pid;
+	unsigned long prev_seq;
+	int stall;
+};
+
+static void seccomp_wd_check_cpu(int cpu, struct seccomp_wd_cpu *st)
+{
+	static const char kill_msg[] =
+		"seccomp watchdog: killing unresponsive stub (SIGALRM blocked?)\n";
+	int pid = __READ_ONCE(seccomp_wd_pid[cpu]);
+	unsigned long seq = __READ_ONCE(seccomp_wd_seq[cpu]);
+
+	if (pid >= 0 && pid == st->prev_pid && seq == st->prev_seq) {
+		if (++st->stall >= SECCOMP_WD_STALL_TICKS) {
+			/* printk() is unsafe from this thread. */
+			(void)!write(2, kill_msg, sizeof(kill_msg) - 1);
+			kill(pid, SIGKILL);
+			st->stall = 0;
+		}
+	} else {
+		st->stall = 0;
+	}
+
+	st->prev_pid = pid;
+	st->prev_seq = seq;
+}
+
+static void *seccomp_watchdog(void *arg)
+{
+	int tfd = (int)(long)arg;
+	struct seccomp_wd_cpu st[CONFIG_NR_CPUS];
+	int cpu;
+
+	for (cpu = 0; cpu < CONFIG_NR_CPUS; cpu++)
+		st[cpu] = (struct seccomp_wd_cpu){ .prev_pid = -1 };
+
+	for (;;) {
+		unsigned long long expirations;
+
+		/*
+		 * One check per wakeup; ignore the expiration count so a
+		 * descheduled watchdog accrues stalls more slowly, never faster.
+		 */
+		if (read(tfd, &expirations, sizeof(expirations)) !=
+		    sizeof(expirations))
+			continue;
+
+		for (cpu = 0; cpu < CONFIG_NR_CPUS; cpu++)
+			seccomp_wd_check_cpu(cpu, &st[cpu]);
+	}
+
+	return NULL;
+}
+
+static void start_seccomp_watchdog(void)
+{
+	static int started;
+	static struct os_helper_thread *wd_td;
+	struct itimerspec its = {
+		.it_value    = { .tv_sec = SECCOMP_WD_TICK_SECS },
+		.it_interval = { .tv_sec = SECCOMP_WD_TICK_SECS },
+	};
+	int tfd;
+
+	/* Several vCPU monitors may race here; only the first starts the thread. */
+	if (!__sync_bool_compare_and_swap(&started, 0, 1))
+		return;
+
+	tfd = timerfd_create(CLOCK_MONOTONIC, 0);
+	if (tfd < 0) {
+		printk(UM_KERN_ERR "%s : timerfd_create failed, errno = %d\n",
+		       __func__, errno);
+		return;
+	}
+
+	if (timerfd_settime(tfd, 0, &its, NULL) < 0) {
+		printk(UM_KERN_ERR "%s : timerfd_settime failed, errno = %d\n",
+		       __func__, errno);
+		close(tfd);
+		return;
+	}
+
+	if (os_run_helper_thread(&wd_td, seccomp_watchdog, (void *)(long)tfd) < 0) {
+		printk(UM_KERN_ERR "%s : failed to start watchdog thread\n",
+		       __func__);
+		close(tfd);
+		wd_td = NULL;
+	}
+}
+
 void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 {
 	struct stub_data *data = (void *)mm_idp->stack;
 	int ret;
 
+	seccomp_wd_enter(mm_idp->pid);
+
 	do {
 		if (!running) {
 			wake_seccomp_stub(mm_idp);
@@ -296,6 +419,9 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 		if (__READ_ONCE(mm_idp->pid) < 0)
 			goto out_kill;
 
+		/* The stub reported back: record progress for the watchdog. */
+		seccomp_wd_progress();
+
 		running = 0;
 
 		/* We may receive a SIGALRM before SIGSYS, iterate again. */
@@ -312,9 +438,11 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 		goto out_kill;
 	}
 
+	seccomp_wd_exit();
 	return;
 
 out_kill:
+	seccomp_wd_exit();
 	printk(UM_KERN_ERR "%s : failed to wait for stub, pid = %d, errno = %d\n",
 	       __func__, mm_idp->pid, errno);
 	/* This is not true inside start_userspace */
@@ -633,6 +761,7 @@ int start_userspace(struct mm_id *mm_id)
 		err = get_stub_listener(mm_id);
 		if (err)
 			goto out_kill;
+		start_seccomp_watchdog();
 	} else {
 		close(tramp_data.sockpair[1]);
 	}
-- 
2.43.0


