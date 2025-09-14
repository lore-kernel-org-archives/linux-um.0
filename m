Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B195CAC598
	for <linux-um@archiver.kernel.org>; Sun, 14 Sep 2025 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bl37ymUxPOSh0uADw//c0j6dKMZwyMMccmkvzyDx4iM=; b=xZ4mfIzJnunMD9dDoJokGxhBMr
	kNypaj0Vyhzcab0p6MERBWhiuaAbbl6Nm2gLKJpoIreFAmFkQ41yBpRqfCBAaG/ISZhKWX+cc/7su
	8ZvjWZ+q6MRqDqwpeueB2EZPhQHVePIQxxU9qnj3jnjHWiJEaM3CqFkl/S0UPYE7e8bHRlae0CWDJ
	g9lyuqdQ+lOs6HJlf958HxvfuJj0iiZ9RXOPA8nJS1Yarnuvf7o2JoMyWRegraJU2rCpLgp516YrS
	2vyGSoqbd2yBUjjY+RVel5oSe/sDvCC4idfALIILn5bVMwfZ0OS+bnULLsw+GwKSbw63KwSZdp4DZ
	xJ2c6keQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxp73-00000001loT-3SzJ;
	Sun, 14 Sep 2025 15:58:01 +0000
Received: from out-174.mta0.migadu.com ([91.218.175.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxp70-00000001lkE-02tp
	for linux-um@lists.infradead.org;
	Sun, 14 Sep 2025 15:57:59 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bl37ymUxPOSh0uADw//c0j6dKMZwyMMccmkvzyDx4iM=;
	b=lK2a0T27ImIAd64YS6JxypBOEQfNoimxQualhdSIiev7c+rytN7wkxz3/5Fmpq73iYLLqr
	QW9051fiWMumZdp3pAYd3PQ61ZoHKpTvymxppol7TfnArpz1OYNwtGadmPxUmXBo+auODG
	P/BawdH0x9b1hRtuZR1U8oIJoQcvfdw=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 5/7] um: vdso: Remove getcpu support on x86
Date: Sun, 14 Sep 2025 23:56:56 +0800
Message-Id: <20250914155658.1028790-6-tiwei.bie@linux.dev>
In-Reply-To: <20250914155658.1028790-1-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250914_085758_193424_D397B236 
X-CRM114-Status: UNSURE (   8.56  )
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

We are going to support SMP on UML/x86, so we can't hard code
the CPU and NUMA node in __vdso_getcpu() anymore. Let's just
remove it and let applications fall back to the syscall.

Suggested-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/vdso/um_vdso.c  | 20 --------------------
 arch/x86/um/vdso/vdso.lds.S |  2 --
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..43a5ffcc7158 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -10,14 +10,12 @@
 #define DISABLE_BRANCH_PROFILING
 
 #include <linux/time.h>
-#include <linux/getcpu.h>
 #include <asm/unistd.h>
 
 /* workaround for -Wmissing-prototypes warnings */
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
-long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
@@ -58,21 +56,3 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 	return secs;
 }
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
-
-long
-__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
-{
-	/*
-	 * UML does not support SMP, we can cheat here. :)
-	 */
-
-	if (cpu)
-		*cpu = 0;
-	if (node)
-		*node = 0;
-
-	return 0;
-}
-
-long getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
-	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/arch/x86/um/vdso/vdso.lds.S b/arch/x86/um/vdso/vdso.lds.S
index 73c508587a98..401600effc0a 100644
--- a/arch/x86/um/vdso/vdso.lds.S
+++ b/arch/x86/um/vdso/vdso.lds.S
@@ -22,8 +22,6 @@ VERSION {
 		__vdso_clock_gettime;
 		gettimeofday;
 		__vdso_gettimeofday;
-		getcpu;
-		__vdso_getcpu;
 		time;
 		__vdso_time;
 	local: *;
-- 
2.34.1


