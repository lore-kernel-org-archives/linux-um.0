Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5474C87FCF
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uC/Em+drc44+RiAYfSg4CRc+O+H2NViY9r1XJ+GqBZE=; b=iK5cCMRBKh60AOckkpzvg5MeXG
	CLYKG+PTPjGL11eM8RDOHfiYHZo308l2vo1s7rxBpHSWTgGXpS8ayqZE3MEWo1DMJ4cF/xqMt9gTF
	0i9+pJYX9U4mePU86FqEYct5K1YqLV2GqALvIueLUJ59dFCmb3n6fiLr4PhYMpWxYt2ZG9TbRay5H
	OjfLmzWsv1GvTutxxf5Ccika6LSU9I7QeBo8W52ISC0PIZQHzX8Be3f3jnZ96326a7QRbo/FBQoul
	T4b4i+9fAObfUOZKnF3wiMI7FvyO8yyDHGmn5NNNos2dvk+21lTciC7Zmg+ZOUhB/QF0KJX4MTl++
	P4ij04sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyym-00000005IUb-23Us;
	Sun, 10 Aug 2025 05:52:24 +0000
Received: from out-180.mta0.migadu.com ([2001:41d0:1004:224b::b4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyyk-00000005ISz-36A3
	for linux-um@lists.infradead.org;
	Sun, 10 Aug 2025 05:52:23 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uC/Em+drc44+RiAYfSg4CRc+O+H2NViY9r1XJ+GqBZE=;
	b=LlMZFI0ZvE6sSNtQjC92itwyk9TD/Qv+YhRp0iYn93pIZMnEz3cyTjWAOJfSLXpuNl3ENE
	eL5rbJSbMstBqdsrAU3hNNwW2n2AjfOs2GzMHUznFOB0vwdFBFZ44Hue9eFTT7zaWfIuHJ
	rarJrIoIz/eFGCGhL7mywg7D6rRtzDo=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 07/10] um: Remove unused ipi_pipe field from cpuinfo_um
Date: Sun, 10 Aug 2025 13:51:33 +0800
Message-Id: <20250810055136.897712-8-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250809_225222_921283_0839BEF4 
X-CRM114-Status: UNSURE (   9.68  )
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

It's no longer used after the removal of the SMP implementation in
TT mode by commit 28fa468f5316 ("um: Remove broken SMP support").

While at it, remove the outdated comment.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 1 -
 arch/um/kernel/um_arch.c                | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 236fdfd7cdbe..7854d51b6639 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -71,7 +71,6 @@ extern void start_thread(struct pt_regs *regs, unsigned long entry,
 
 struct cpuinfo_um {
 	unsigned long loops_per_jiffy;
-	int ipi_pipe[2];
 	int cache_alignment;
 	union {
 		__u32		x86_capability[NCAPINTS + NBUGINTS];
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 2f5ee045bc7a..e46718b3c711 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -54,12 +54,9 @@ static void __init add_arg(char *arg)
 
 /*
  * These fields are initialized at boot time and not changed.
- * XXX This structure is used only in the non-SMP case.  Maybe this
- * should be moved to smp.c.
  */
 struct cpuinfo_um boot_cpu_data = {
 	.loops_per_jiffy	= 0,
-	.ipi_pipe		= { -1, -1 },
 	.cache_alignment	= L1_CACHE_BYTES,
 	.x86_capability		= { 0 }
 };
-- 
2.34.1


