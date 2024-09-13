Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0123BFC6175
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 20:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XUqiFFfQjZmNU5v/lHC3KhzgJNDg25CuFMNulDtI9FM=; b=gyL9t0Pe+uRRdcmT4mqe9mFl5/
	X4wWvU0uIxiaHZGqqepaesYQR0MqkZ/BqHRnpNwaUxO5gmQl+GW6t5Pz34qYqsjYCx3mrJ5kYindD
	LREeDSPoQBDfUfYBSOXLtmryarLEJV2Hn0dj0W209mazTcqSa4ihoPYhbRDJ+puSPS20pjfaEY4Fv
	cRZ0nbn/iUl7+8FXjfqmxRv+Ol+xxAq4W9IKy922hYXdVG+nvsYtLN72KndPm3Rksi+zevXIwAh1o
	KW9hD1MNLvCjZ+nLMQJEY8XSSuKTSCD5tcs1Bow4y6uvc7Vm273CCS1DVdaBXFTbaKbb7FkZL+SeC
	r4wjrV5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spCln-0000000H3YY-0dvb;
	Fri, 13 Sep 2024 20:19:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spClk-0000000H3Xk-2DDs
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 20:19:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XUqiFFfQjZmNU5v/lHC3KhzgJNDg25CuFMNulDtI9FM=; t=1726258791; x=1727468391; 
	b=C2y2SJ69drApmcFfcd+aKIF/OhW13Jxe+HtibM3D7X6ymQvInZYecWuv0Jh4E/v9ubOUefKzlR0
	mh+1ukZvFybXL0aQnfLsy0iWnZWYXLp7wExXD+7KkxvS+zJ6NYxNJUM6qWlkSb7y19SDRuWGZFgyV
	DfC120VQs4Y7fJpAPxo6Vk8URIU5+fdB9iAFD9hrHbV0Gjwl+m0slvIvjVi4vLXRsVfuv0o0n7QDw
	EQc68hiGa/dTWRXskIxANqUJP/v/HTsWWyc+oEOgWt5iMb6LeRBzOKvCn06dtXmS28zV2rxTUNcfU
	AB2fTrVbzHvm/VF2MokpHHR1PulqC+2X0s0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1spClg-0000000HUm3-0VVy;
	Fri, 13 Sep 2024 22:19:48 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] um: insert scheduler ticks when userspace does not yield
Date: Fri, 13 Sep 2024 22:17:56 +0200
Message-ID: <20240913201756.1223327-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_131952_608594_64D9599B 
X-CRM114-Status: GOOD (  16.46  )
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

In time-travel mode userspace can do a lot of work without any time
passing. Unfortunately, this can result in OOM situations as the RCU
core code will never be run.

Work around this by keeping track of userspace processes that do not
yield for a lot of operations. When this happens, insert a jiffie into
the sched_clock clock to account time against the process and cause the
bookkeeping to run.

As sched_clock is used for tracing, it is useful to keep it in sync
between the different VMs. As such, try to remove added ticks again when
the actual clock ticks.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/time.c           | 20 ++++++++++++++++++++
 arch/um/os-Linux/skas/process.c | 25 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 29b27b90581f..e7da5e6cd4ce 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -25,6 +25,8 @@
 #include <shared/init.h>
 
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+#include <linux/sched/clock.h>
+
 enum time_travel_mode time_travel_mode;
 EXPORT_SYMBOL_GPL(time_travel_mode);
 
@@ -47,6 +49,15 @@ static u16 time_travel_shm_id;
 static struct um_timetravel_schedshm *time_travel_shm;
 static union um_timetravel_schedshm_client *time_travel_shm_client;
 
+unsigned long tt_extra_sched_jiffies;
+
+notrace unsigned long long sched_clock(void)
+{
+	return (unsigned long long)(jiffies - INITIAL_JIFFIES +
+				    tt_extra_sched_jiffies)
+					* (NSEC_PER_SEC / HZ);
+}
+
 static void time_travel_set_time(unsigned long long ns)
 {
 	if (unlikely(ns < time_travel_time))
@@ -443,6 +454,11 @@ static void time_travel_periodic_timer(struct time_travel_event *e)
 {
 	time_travel_add_event(&time_travel_timer_event,
 			      time_travel_time + time_travel_timer_interval);
+
+	/* Remove inserted sched_clock ticks again to avoid timestamp drift */
+	if (tt_extra_sched_jiffies > 0)
+		tt_extra_sched_jiffies -= 1;
+
 	deliver_alarm();
 }
 
@@ -594,6 +610,10 @@ EXPORT_SYMBOL_GPL(time_travel_add_irq_event);
 
 static void time_travel_oneshot_timer(struct time_travel_event *e)
 {
+	/* Remove inserted sched_clock ticks again to avoid timestamp drift */
+	if (tt_extra_sched_jiffies > 0)
+		tt_extra_sched_jiffies -= 1;
+
 	deliver_alarm();
 }
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index b6f656bcffb1..e1a6f97a000b 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -336,6 +336,9 @@ int start_userspace(unsigned long stub_stack)
 	return err;
 }
 
+int unscheduled_userspace_iterations;
+extern unsigned long tt_extra_sched_jiffies;
+
 void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 {
 	int err, status, op, pid = userspace_pid[0];
@@ -345,6 +348,26 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	interrupt_end();
 
 	while (1) {
+		/*
+		 * When we are in time-travel mode, userspace can theoretically
+		 * do a *lot* of work without being scheduled. The problem with
+		 * this is that it will prevent kernel bookkeeping (primarily
+		 * the RCU) from running and this can for example cause OOM
+		 * situations.
+		 *
+		 * This code accounts a jiffie against the scheduling clock
+		 * after 10000 userspace iterations (syscall or pagefault) in
+		 * the same thread. By doing so the situation is effectively
+		 * prevented.
+		 */
+		if (time_travel_mode == TT_MODE_INFCPU ||
+		    time_travel_mode == TT_MODE_EXTERNAL) {
+			if (unscheduled_userspace_iterations++ > 10000) {
+				tt_extra_sched_jiffies += 1;
+				unscheduled_userspace_iterations = 0;
+			}
+		}
+
 		time_travel_print_bc_msg();
 
 		current_mm_sync();
@@ -487,6 +510,8 @@ void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 
 void switch_threads(jmp_buf *me, jmp_buf *you)
 {
+	unscheduled_userspace_iterations = 0;
+
 	if (UML_SETJMP(me) == 0)
 		UML_LONGJMP(you, 1);
 }
-- 
2.46.0


