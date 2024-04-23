Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D538AC4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gIvw0W9jwz4ek3Tvi63O6eytV7zW5ZlAtrTwF4fjS0o=; b=471NnGHvMV8cz2FkzAmP9Mvqzr
	72DpQbNILJ1nGj4qCEMUZSONkZZaSXpfcg3OEDfNCpA0esPCeOojSdXw8Q80PuNeV92MOrSxlkC+L
	3O4KnnLm6g3Cd/2eplfSnYM26BaKPxth8G1B3+2fks/t1h//Q0az82dKkZgaP1PeOkV80JtbD9VY1
	mamjgs5S1S2Zg3H3fklbJMxl+7/fzolPmB88LqsUNgbgiKXQXQ+xqSe+Q8mRtwWBEcW9EeuTwxzzB
	Y3ESUz64JB99ib7wesCakx3+Bp3liNF+4hFiylXY1AG44P+188YaKy6eMZlG3bId/QOmaangylWZ7
	CdxxwoSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEHG-0000000H5K1-1iKq;
	Tue, 23 Apr 2024 11:25:34 +0000
Received: from out0-202.mail.aliyun.com ([140.205.0.202])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEH1-0000000H5C8-1yW0
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 11:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871515; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=gIvw0W9jwz4ek3Tvi63O6eytV7zW5ZlAtrTwF4fjS0o=;
	b=sX846VBh91wzkgBlxFgAHjsDwkVIeOvnK81+YvAyg4Sgcfkl51yh9gSDLc6cQroHqnFbuLonTnfX1Y7kPoeHkkl/b4cLYHwXAN4w5MPNM5iEl+/+E1Pzw1pIt7fmd7qsak8DQHwqXIIbMlBBAf+TJx0Be6ttA9qJDdpKx8pW3zE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047193;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYiD_1713871513;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYiD_1713871513)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:13 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 6/7] um: Fix -Wmissing-prototypes warnings for __vdso_*
Date: Tue, 23 Apr 2024 19:24:56 +0800
Message-Id: <20240423112457.2409319-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_042520_477285_75474F43 
X-CRM114-Status: UNSURE (   7.85  )
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

The VDSO functions are defined as globals and intended to be called
from userspace. Let's just workaround the -Wmissing-prototypes warnings
by declaring them locally.

This will address below -Wmissing-prototypes warnings:

arch/x86/um/vdso/um_vdso.c:16:5: warning: no previous prototype for ‘__vdso_clock_gettime’ [-Wmissing-prototypes]
arch/x86/um/vdso/um_vdso.c:30:5: warning: no previous prototype for ‘__vdso_gettimeofday’ [-Wmissing-prototypes]
arch/x86/um/vdso/um_vdso.c:44:21: warning: no previous prototype for ‘__vdso_time’ [-Wmissing-prototypes]
arch/x86/um/vdso/um_vdso.c:57:1: warning: no previous prototype for ‘__vdso_getcpu’ [-Wmissing-prototypes]

Meanwhile, also fix the "WARNING: Prefer 'unsigned int *' to bare use
of 'unsigned *'" checkpatch warning.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/vdso/um_vdso.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index ff0f3b4b6c45..cbae2584124f 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -13,6 +13,12 @@
 #include <linux/getcpu.h>
 #include <asm/unistd.h>
 
+/* workaround for -Wmissing-prototypes warnings */
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
+long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
+
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
 	long ret;
@@ -54,7 +60,7 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
-__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
 {
 	/*
 	 * UML does not support SMP, we can cheat here. :)
@@ -68,5 +74,5 @@ __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 	return 0;
 }
 
-long getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+long getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
 	__attribute__((weak, alias("__vdso_getcpu")));
-- 
2.34.1


