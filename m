Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3B8C83F20
	for <linux-um@archiver.kernel.org>; Sun, 13 Jul 2025 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hkA9J0yJ6LYuwj61ZyOGv+Xl/BzsgcrZZJOuPyYgKM=; b=ejKzqL0v90WkmsyeUpuPaHywXx
	BB/EwYfguo3nan0FXZe8CAkmnXr9+5eb56tAED9uWCINhi014vzyEONrmp6FaCW+Y1qbigk4g/rGt
	VBbI8rz9Hn3WHCNjYpcIdTzyTia/tst0S4y6fxwtAQ8lqAWUvWBnvRWkL5rUjQleSfDg9SPVNnwlL
	NMDnkh6QdmWX3kIpvb6V828UuoQ4O1YitHm5MI18y58jOvnfGnGGwJDy+wMCQy5dgkHoXn4NCfzUz
	BlQU4BKYJ6WhKtc8NGj4/Tfnn3qwpOZhsMFRMSKfIpTL8Uc2wxQB3biaz3oDF7jrQ3sFN1ivZkPZH
	FA4O+Gjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0So-00000000RLm-01LJ;
	Sun, 13 Jul 2025 17:26:10 +0000
Received: from out-174.mta1.migadu.com ([2001:41d0:203:375::ae])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Sk-00000000RKz-185E
	for linux-um@lists.infradead.org;
	Sun, 13 Jul 2025 17:26:08 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752427563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hkA9J0yJ6LYuwj61ZyOGv+Xl/BzsgcrZZJOuPyYgKM=;
	b=WlS6Y2KYGcwzm99kCwEmxlwIZx5EnvAOpjDQQbo0PshypRNdCX4PdjnS2Yf5pXjh7xWsjj
	CNzUZvDtKHp2B1Lpoq6h+js0kqwSDcbWzDIDiU12gL83MuQyQ2MjJ+QKFumMHcaNTHbo8I
	hSolDv4GF3nqA3Ic9Ydwu+SMniDeI68=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [RFC PATCH 3/4] um: vdso: Implement __vdso_getcpu() via syscall
Date: Mon, 14 Jul 2025 01:25:35 +0800
Message-Id: <20250713172536.404809-4-tiwei.bie@linux.dev>
In-Reply-To: <20250713172536.404809-1-tiwei.bie@linux.dev>
References: <20250713172536.404809-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250713_102606_756830_D7E9D263 
X-CRM114-Status: UNSURE (   8.75  )
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


