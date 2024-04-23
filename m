Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5114C16B13
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64KorjYk0sx2nDSk7hiRZHzNhfBx4ybSJcgKjrQvbD8=; b=3bNbAAuY6ORLyL3wttcqwzWxEr
	SxZ8aC8boJNfproGcNXVmIlVCyKo75EArGWtlqFsYOzN3pHjjVudFJA05Xc6tGthC4xG5OXlZ+Fcg
	XsTKGXc3ZDwD5MfaxexW1IInxGHZqneQ8Ymx4qzBnQhT3Sh7eWM++Qb39TTysiZnUXx6EYA7q4czC
	Cbip0pwuXr84Bt0j+j6p8p4JnHSE38PYPNX7Xsfgyv8v5KFR45l6qKzuBJJ+wlKigLDoDEPp98mYT
	+kOury0yR96l0+41pO6e378RF4XknykHVt+wYiH9LFohsonv55nrwykrLCuDW0pJPOEFq/CJxj7GA
	vM8UioFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFk4-0000000HY1F-10Od;
	Tue, 23 Apr 2024 12:59:24 +0000
Received: from out0-211.mail.aliyun.com ([140.205.0.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFju-0000000HXvH-3GrE
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 12:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877150; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=64KorjYk0sx2nDSk7hiRZHzNhfBx4ybSJcgKjrQvbD8=;
	b=TOQfcjgCAeyXDh2yappDAJka2AMm2ud5T++EXDeuK7KanSTOanpLVNyJ5s1A1bNFx1IlRtlkIYV7DufTJdKXdONEcmcYoTRdzCN/GoLpuusjvXjMKNOmloGqL1s9QIHihAjSZnxI+JI6l3YSkCY4nJPfHTAnyX5WfrIy4wttGbk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjSx_1713877148;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjSx_1713877148)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:08 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 6/7] um: Fix -Wmissing-prototypes warnings for __vdso_*
Date: Tue, 23 Apr 2024 20:58:57 +0800
Message-Id: <20240423125858.137709-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423125858.137709-1-tiwei.btw@antgroup.com>
References: <20240423125858.137709-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_055917_697823_754A86B1 
X-CRM114-Status: UNSURE (   7.87  )
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

While at it, also fix the "WARNING: Prefer 'unsigned int *' to bare
use of 'unsigned *'" checkpatch warning.

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


