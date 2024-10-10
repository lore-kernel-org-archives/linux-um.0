Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D74CF11F8
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JGuX6Ac2FgXFwpzk6R3/KgzDMXdxVRIIRc/Pq4rsBBI=; b=xgx6FJkq9SM/wVionStJ0f6ilw
	pWaKZFzNuhV1IG1PCe6nNdBcmgKng+suBD4f1tC4nH+utAeviFU4C1Zg0tJScl7eO8RMnfTs8iGuO
	W1wi8MqqPW1vRxy52AGAKHaoNDhHhcxPaU2mZ+svHYkEYuJGTQDi/2WTIfx7qv7ZF0QhOZLaBvfvK
	e3/5viihJ4B2BzyJ4LixowhLDdpywY1WYHgVDWuvawlKHoTI5J/Ibh/o0YR0xm84KtGeJ8fXAIge0
	CIOOKUG12wyIkwgLtFSs3BuKcnWylJ5r8cEm6kLHhtA8oMUhL1xjvY7WPxCb0rVp4V9Yi88e/yFVM
	34zLsyNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syu7l-0000000D5sx-3rxv;
	Thu, 10 Oct 2024 14:26:41 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syu7j-0000000D5re-139e
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 14:26:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=JGuX6Ac2FgXFwpzk6R3/KgzDMXdxVRIIRc/Pq4rsBBI=; t=1728570398; x=1729779998; 
	b=oTU+AEPvDltAAk9XNGpKJtM8UCt0npvTy5R/KemM/5F/GVS0SVa+GMHefVU+0v+WHp95bEb7yKN
	1PkKimtePrh1yI1lx2finIgWb1C8oUtUbNO2j3P8d4/LWmckdv5Jd2lAWqpmEdHEZ4ETWlVspyME8
	YCWsbE8gBdR32Gc/m5G/zrDHTx75uGnqFbstnRNgg1CoTZ71YWGmiJXJuDNhvnT3wLaUAy+ixjLDI
	2QNU6dR99GoGYtwTa3OtzPZOT5OKE5+oCrazLYcQVfv9fmDCMx/Ymp1c6yHlzSa17htSeJS/0M+5a
	gq5OZY4Z1trokK4+q1wkSOx4BPzqlDUX8rew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1syu7g-000000068Vt-3gMB;
	Thu, 10 Oct 2024 16:26:37 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2] um: insert scheduler ticks when userspace does not yield
Date: Thu, 10 Oct 2024 16:25:37 +0200
Message-ID: <20241010142537.1134685-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_072639_321205_90AD3928 
X-CRM114-Status: GOOD (  20.24  )
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
v2:
* Add a kernel configuration option and permit disabling the feature
* Improve comment for tt_extra_sched_jiffies decrement
---
 arch/um/Kconfig                         | 15 ++++++++++++++
 arch/um/include/shared/common-offsets.h |  6 +++++-
 arch/um/kernel/time.c                   | 20 +++++++++++++++++++
 arch/um/os-Linux/skas/process.c         | 26 +++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 448454a3d8b5..5dc702ad9e7a 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -227,6 +227,21 @@ config UML_TIME_TRAVEL_SUPPORT
 
 	  It is safe to say Y, but you probably don't need this.
 
+config UML_MAX_USERSPACE_ITERATIONS
+	int
+	prompt "Maximum number of unscheduled userspace iterations"
+	default 10000
+	depends on UML_TIME_TRAVEL_SUPPORT
+	help
+	  In UML inf-cpu and ext time-travel mode userspace can run without being
+	  interrupted. This will eventually overwhelm the kernel and create OOM
+	  situations (mainly RCU not running). This setting specifies the number
+	  of kernel/userspace switches (minor/major page fault, signal or syscall)
+	  for the same userspace thread before the sched_clock is advanced by a
+	  jiffie to trigger scheduling.
+
+	  Setting it to zero disables the feature.
+
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 579ed946a3a9..86537e20942a 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -28,4 +28,8 @@ DEFINE(UML_CONFIG_64BIT, CONFIG_64BIT);
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 DEFINE(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT, CONFIG_UML_TIME_TRAVEL_SUPPORT);
 #endif
-
+#ifdef CONFIG_UML_MAX_USERSPACE_ITERATIONS
+DEFINE(UML_CONFIG_UML_MAX_USERSPACE_ITERATIONS, CONFIG_UML_MAX_USERSPACE_ITERATIONS);
+#else
+DEFINE(UML_CONFIG_UML_MAX_USERSPACE_ITERATIONS, 0);
+#endif
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 29b27b90581f..1394568c0210 100644
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
+	/* clock tick; decrease extra jiffies by keeping sched_clock constant */
+	if (tt_extra_sched_jiffies > 0)
+		tt_extra_sched_jiffies -= 1;
+
 	deliver_alarm();
 }
 
@@ -594,6 +610,10 @@ EXPORT_SYMBOL_GPL(time_travel_add_irq_event);
 
 static void time_travel_oneshot_timer(struct time_travel_event *e)
 {
+	/* clock tick; decrease extra jiffies by keeping sched_clock constant */
+	if (tt_extra_sched_jiffies > 0)
+		tt_extra_sched_jiffies -= 1;
+
 	deliver_alarm();
 }
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 2286486bb0f3..31d87a4f3e98 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -388,6 +388,9 @@ int start_userspace(unsigned long stub_stack)
 	return err;
 }
 
+int unscheduled_userspace_iterations;
+extern unsigned long tt_extra_sched_jiffies;
+
 void userspace(struct uml_pt_regs *regs)
 {
 	int err, status, op, pid = userspace_pid[0];
@@ -397,6 +400,27 @@ void userspace(struct uml_pt_regs *regs)
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
+		 * after the defined userspace iterations in the same thread.
+		 * By doing so the situation is effectively prevented.
+		 */
+		if (time_travel_mode == TT_MODE_INFCPU ||
+		    time_travel_mode == TT_MODE_EXTERNAL) {
+			if (UML_CONFIG_UML_MAX_USERSPACE_ITERATIONS &&
+			    unscheduled_userspace_iterations++ >
+			    UML_CONFIG_UML_MAX_USERSPACE_ITERATIONS) {
+				tt_extra_sched_jiffies += 1;
+				unscheduled_userspace_iterations = 0;
+			}
+		}
+
 		time_travel_print_bc_msg();
 
 		current_mm_sync();
@@ -539,6 +563,8 @@ void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 
 void switch_threads(jmp_buf *me, jmp_buf *you)
 {
+	unscheduled_userspace_iterations = 0;
+
 	if (UML_SETJMP(me) == 0)
 		UML_LONGJMP(you, 1);
 }
-- 
2.46.2


