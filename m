Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C719C87FCE
	for <linux-um@archiver.kernel.org>; Sun, 27 Jul 2025 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hkA9J0yJ6LYuwj61ZyOGv+Xl/BzsgcrZZJOuPyYgKM=; b=K422yAlLarFMyywWZaZgMTgNSC
	CofgoMtBPRGqn5+Ad+1hrLGs89qnuQ2mSFMDXq4kPT42/MWeI3PAYscaGAvJ3KEnxau1EUtgoAMK4
	EWUXSxutXYyzitsrFGg3vudtGn9L2V7Br6UTTROFCQQ3YECPm2oUpy5lVf+UryxDBxHvPk/kYXP9S
	HxnmIRR1s3dXYefS7Fa5JpJduXRoKU22/eeQ4T1u76i02q7dS2UhU65/K3YDqohIu593x3GFLyB36
	FAltdPFi80xlzAIQ/KAFs+rySms4mXUiKPdlWZ0kVxzb5AJEtiu2A9JPQGNsJNIf61Rraer6EBQdr
	nKSRngfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutj-0000000CNqN-3YIi;
	Sun, 27 Jul 2025 06:30:15 +0000
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufuth-0000000CNpM-1uc4
	for linux-um@lists.infradead.org;
	Sun, 27 Jul 2025 06:30:14 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753597811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hkA9J0yJ6LYuwj61ZyOGv+Xl/BzsgcrZZJOuPyYgKM=;
	b=D5R6kguiZPEbWSn8su0VB0j7zvM1CYnijPKreYEGF72kjEPDvRBXyAQEZ0SdRKq/i+MNBv
	55Ba9RIUPwz9kqLWbzmfiogXuAIynw9HEsQaXTsiyJ1dqMcrxymlbOSfSFHaadKgwE3/u/
	IWeuTfsb8vj0jO903JWBvQjL+inj+jY=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 3/9] um: vdso: Implement __vdso_getcpu() via syscall
Date: Sun, 27 Jul 2025 14:29:31 +0800
Message-Id: <20250727062937.1369050-4-tiwei.bie@linux.dev>
In-Reply-To: <20250727062937.1369050-1-tiwei.bie@linux.dev>
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_233013_638818_3E7E4F03 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
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

We are going to support SMP in UML, so we can not hard code
the CPU and NUMA node in __vdso_getcpu() anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/vdso/um_vdso.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..ee40ac446c1c 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -17,7 +17,7 @@
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
-long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
+long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
@@ -60,18 +60,16 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
-__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
 {
-	/*
-	 * UML does not support SMP, we can cheat here. :)
-	 */
+	long ret;
 
-	if (cpu)
-		*cpu = 0;
-	if (node)
-		*node = 0;
+	asm volatile("syscall"
+		: "=a" (ret)
+		: "0" (__NR_getcpu), "D" (cpu), "S" (node), "d" (tcache)
+		: "rcx", "r11", "memory");
 
-	return 0;
+	return ret;
 }
 
 long getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
-- 
2.34.1


