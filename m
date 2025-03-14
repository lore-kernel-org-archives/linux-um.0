Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE69C282EC
	for <linux-um@archiver.kernel.org>; Fri, 14 Mar 2025 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ObRSfbQE/j9BgW67MkKEctDB4103781/jt3UQErYRes=; b=Xxyz66NzvreOAX/RnfLGWJusTV
	GiGD5p+B1rwSPMomgvJ3E0jJPv3vAGbWxHnlv33qn12tGjC+s8AXILfFHzqlGPqIQo3xaSoVanf10
	TddUiodVqZhVq+ThNX4wk9PGF/rvdXofj0jcCp9vI9hZbKvRjn1TufGJcaZ+N90m3xQ1yeOTJNpcn
	6envJapUwGNgVk/rFYHMtUxYDy9dBg93l7LBce8FFe6FjzQpvcqdIvYNUD++Na2CXeYoO+lyt2A22
	uZMKBJhkXTLae73TkNzI4AylI9bP+Sh8W/9BdB9ndPGEi2RZLWgT0ov/9BNlRtkFSoJmqoTP849Fc
	cKSRF+kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt4mJ-0000000EEiO-2Sdm;
	Fri, 14 Mar 2025 13:08:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt4mG-0000000EEhl-3lg0
	for linux-um@lists.infradead.org;
	Fri, 14 Mar 2025 13:08:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ObRSfbQE/j9BgW67MkKEctDB4103781/jt3UQErYRes=; t=1741957719; x=1743167319; 
	b=u6xKLdSKJBlqKxc7f1WqC0kFOUBzx8VSC2jughudEp4i9crcLXVY+3UJmcineL6MgwVGKFBUrJ7
	VErBdn+qUWe5Sq8fEOsN8Je5Y14Z+i2jyG1fAfLzmNaZr2IgaZ854VtmO1LlBpuMHYehgPXsrIiFK
	ll6/EwKScrMDja2ZPtLy68gbgZKhxRoINwkGh/7yqgIQ6oBhYfN+b3K8N6Qw+N9v2eEHfp1Lwk301
	ro4x8tXad/WKAf2gp+BPJHYR2KtZYCGOx/sdSdVzbGD96uWw2tZ4tnetlWv2JoLdP96vPn1HghIbY
	i0T0AYSKPDm4D+xA1cuIieAap1z23Otsdt0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tt4m9-0000000B6Tp-2xyR;
	Fri, 14 Mar 2025 14:08:34 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] um: work around sched_yield not yielding in time-travel mode
Date: Fri, 14 Mar 2025 14:08:15 +0100
Message-ID: <20250314130815.226872-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_060841_210866_705DCDCA 
X-CRM114-Status: GOOD (  14.35  )
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

sched_yield by a userspace may not actually cause scheduling in
time-travel mode as no time has passed. In the case seen it appears to
be a badly implemented userspace spinlock in ASAN. Unfortunately, with
time-travel it causes an extreme slowdown or even deadlock depending on
the kernel configuration (CONFIG_UML_MAX_USERSPACE_ITERATIONS).

Work around it by accounting time to the process whenever it executes a
sched_yield syscall.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

I suspect it is this code in ASAN that uses sched_yield
  https://github.com/llvm/llvm-project/blob/main/compiler-rt/lib/sanitizer_common/sanitizer_mutex.cpp
though there are also some other places that use sched_yield.

I doubt that code is reasonable. At the same time, not sure that
sched_yield is behaving as advertised either as it obviously is not
necessarily relinquishing the CPU.
---
 arch/um/include/linux/time-internal.h |  2 ++
 arch/um/kernel/skas/syscall.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index b22226634ff6..138908b999d7 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -83,6 +83,8 @@ extern void time_travel_not_configured(void);
 #define time_travel_del_event(...) time_travel_not_configured()
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
+extern unsigned long tt_extra_sched_jiffies;
+
 /*
  * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
  * which is intentional since we really shouldn't link it in that case.
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index b09e85279d2b..a5beaea2967e 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -31,6 +31,17 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
+
+	/*
+	 * If no time passes, then sched_yield may not actually yield, causing
+	 * broken spinlock implementations in userspace (ASAN) to hang for long
+	 * periods of time.
+	 */
+	if ((time_travel_mode == TT_MODE_INFCPU ||
+	     time_travel_mode == TT_MODE_EXTERNAL) &&
+	    syscall == __NR_sched_yield)
+		tt_extra_sched_jiffies += 1;
+
 	if (syscall >= 0 && syscall < __NR_syscalls) {
 		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
 
-- 
2.48.1


