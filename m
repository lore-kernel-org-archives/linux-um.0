Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B162C54734
	for <linux-um@archiver.kernel.org>; Tue, 27 Aug 2024 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8BuXbSV50TEt+AgNnhXYJRDEgWiLZU4rzbHMXboIqe0=; b=JTgtNAwhjJooSWGtYvUVGqebDJ
	VZVQ/3VCi3fLRrYp6ORhlmkoDF67qtKD9uyFQemj+nkIs4Oaus2x0y1nEC7jCFfLFOUTSW9nF73ip
	AzNo4qNe3jbQ8iX2ahzcfT6CuMb+0jRoEfZ36SLvQpAiXEPwaX7Vbv4r+9x/RKTgC6DbgGSAlWvYQ
	wHvCzqFOmsr7k8AZAVYhVb/9d/mbh601nzGdSn5WecMXJcXxkAodfEr/5sEhRKs1ysMXUvEEzKt/u
	2ge/9hLmPBuwzOsyB8uF5lRN5HqYwNKr4Pxwt36O6oWOnw3gqifRMU6yFfQUiQ5KTJMPCf7rNBNLK
	7TChubWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siwom-0000000BZXB-37BM;
	Tue, 27 Aug 2024 14:05:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siwok-0000000BZWg-1sYK
	for linux-um@lists.infradead.org;
	Tue, 27 Aug 2024 14:05:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8BuXbSV50TEt+AgNnhXYJRDEgWiLZU4rzbHMXboIqe0=; t=1724767505; x=1725977105; 
	b=nQBEbcJBBbsc5pohlkjh1hZ43qNqaL2qlLmS+q8ofjc6UWEhAn7/VfHAJtjJSACHoTMvVX3Snf/
	nBYYKjWmIRHAxDbrMoqfKUWQvyGPs2kpfftmnSgfByQISt4DeIDMux11ogYDZ8YMHipg7QyKPS2Gf
	565pmmxYlSfEZwHnvM5qgWq6oWDyWS8iRbrDWGHuiiX2mHWjOsrGiSapbwmKeIj5TIBTY4HZ8t1Wo
	ENZvR3qKa1Q0taxpKpUOQVA2QiM1qHGWoxcQyHyjOiGgEi2yisMLTavDL5am/1ny54ddKdvy/kIGE
	YP+wEPFjBIc5KUsJt5/A3vxrdxKDCqc0PUXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1siwog-00000004rzs-2KVL;
	Tue, 27 Aug 2024 16:05:02 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: fix time-travel syscall scheduling hack
Date: Tue, 27 Aug 2024 16:05:01 +0200
Message-ID: <20240827160500.cb3781ab2794.I92a8df925dc029627ed97a8f227f9ea0ac73a2c8@changeid>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_070506_518252_6468D049 
X-CRM114-Status: GOOD (  15.40  )
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

The schedule() call there really never did anything at
least since the introduction of the EEVDF scheduler,
but now I found a case where we permanently hang in a
loop of -ERESTARTNOINTR (due to locking.) Work around
it by making any syscalls with error return take time
(and then schedule after) so we cannot hang in such a
loop forever.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/syscall.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 9ee19e566da3..b09e85279d2b 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -12,23 +12,13 @@
 #include <sysdep/syscalls.h>
 #include <linux/time-internal.h>
 #include <asm/unistd.h>
+#include <asm/delay.h>
 
 void handle_syscall(struct uml_pt_regs *r)
 {
 	struct pt_regs *regs = container_of(r, struct pt_regs, regs);
 	int syscall;
 
-	/*
-	 * If we have infinite CPU resources, then make every syscall also a
-	 * preemption point, since we don't have any other preemption in this
-	 * case, and kernel threads would basically never run until userspace
-	 * went to sleep, even if said userspace interacts with the kernel in
-	 * various ways.
-	 */
-	if (time_travel_mode == TT_MODE_INFCPU ||
-	    time_travel_mode == TT_MODE_EXTERNAL)
-		schedule();
-
 	/* Initialize the syscall number and default return value. */
 	UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
@@ -41,9 +31,25 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
-	if (syscall >= 0 && syscall < __NR_syscalls)
-		PT_REGS_SET_SYSCALL_RETURN(regs,
-				EXECUTE_SYSCALL(syscall, regs));
+	if (syscall >= 0 && syscall < __NR_syscalls) {
+		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
+
+		PT_REGS_SET_SYSCALL_RETURN(regs, ret);
+
+		/*
+		 * An error value here can be some form of -ERESTARTSYS
+		 * and then we'd just loop. Make any error syscalls take
+		 * some time, so that it won't just loop if something is
+		 * not ready, and hopefully other things will make some
+		 * progress.
+		 */
+		if (IS_ERR_VALUE(ret) &&
+		    (time_travel_mode == TT_MODE_INFCPU ||
+		     time_travel_mode == TT_MODE_EXTERNAL)) {
+			um_udelay(1);
+			schedule();
+		}
+	}
 
 out:
 	syscall_trace_leave(regs);
-- 
2.46.0


