Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFFCC87FCE
	for <linux-um@archiver.kernel.org>; Sun, 27 Jul 2025 06:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LrFS7N8p/JHZD+0Aak4dVrLUX8Ckh4/iyF2T8Dum6MY=; b=FyehcmkTG2DB+wIzLBEvPH+Ab9
	1XxB7VdPjxNGkpVLZXvONnWQYyi3SRwcyi14PGjQCox3Bvza5rQDxg+QrzRVIL+OxXnMpHiKFyqr5
	xDDlMRrRUcp2FKENyNRikfL64UeQEFwD2HdNvH22CfkgII7RT0J7lETCl/hvubQv/Wxd4fRUEvl0R
	9qVH+9YIHn4f99fHIzsE6fRWRrmlRbXqewykgMDl3YfVtD5rWyMmC6y+yZelYS5ie/+iN7d6EwF9o
	+LftssTQhob90oAFby5p4l7ZEO1ifSyd1k/kzQmJY81X5WnlAh5yW40QL5u6fEbfOUTqaneA6XwyH
	05jac1HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutv-0000000CNwv-2ipr;
	Sun, 27 Jul 2025 06:30:27 +0000
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutt-0000000CNuM-2xk1
	for linux-um@lists.infradead.org;
	Sun, 27 Jul 2025 06:30:27 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753597824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrFS7N8p/JHZD+0Aak4dVrLUX8Ckh4/iyF2T8Dum6MY=;
	b=pgSUJ+QQHFW0/kt0bqy6nCk348GTTxJyjelmNCBPy35nVreWeg4QYhjsZO0wbeZq03FS9Z
	KUh7gZQum6qogE5tRjysNk1CnpHViT8KHa/JlN3Gvpqe6OZznutKs96qs6xgUVC9uTHq6u
	6JWm6p4dmB5GWTjfXrBLwxZ7sTf7Vf8=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 6/9] um: Determine sleep based on need_resched()
Date: Sun, 27 Jul 2025 14:29:34 +0800
Message-Id: <20250727062937.1369050-7-tiwei.bie@linux.dev>
In-Reply-To: <20250727062937.1369050-1-tiwei.bie@linux.dev>
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_233025_911357_FEE10677 
X-CRM114-Status: GOOD (  13.35  )
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
on pending resched. This is a preparation for adding SMP support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/kern_util.h |  1 +
 arch/um/kernel/process.c           | 12 ++++++++++--
 arch/um/os-Linux/time.c            | 11 +++++------
 3 files changed, 16 insertions(+), 8 deletions(-)

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
index 1be644de9e41..01b935c00454 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -209,10 +209,13 @@ int arch_dup_task_struct(struct task_struct *dst,
 
 void um_idle_sleep(void)
 {
-	if (time_travel_mode != TT_MODE_OFF)
+	if (time_travel_mode != TT_MODE_OFF) {
 		time_travel_sleep();
-	else
+	} else {
+		raw_local_irq_enable();
 		os_idle_sleep();
+		raw_local_irq_disable();
+	}
 }
 
 void arch_cpu_idle(void)
@@ -225,6 +228,11 @@ int __uml_cant_sleep(void) {
 	/* Is in_interrupt() really needed? */
 }
 
+int uml_need_resched(void)
+{
+	return need_resched();
+}
+
 extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
 
 void do_uml_exitcalls(void)
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 4d5591d96d8c..f25a4196bab7 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -98,18 +98,17 @@ long long os_nsecs(void)
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
+	/* Sleep if no resched is pending. */
+	if (!uml_need_resched())
 		sigsuspend(&old);
-	/* either way, restore the signal mask */
+
+	/* Restore the signal mask. */
 	sigprocmask(SIG_UNBLOCK, &set, NULL);
 }
-- 
2.34.1


