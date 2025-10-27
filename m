Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AC3CCF9E5
	for <linux-um@archiver.kernel.org>; Mon, 27 Oct 2025 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qv8GrhWWLvpi+yXjcVXvopwH0zWKk+Fo+xAzYv1qf0M=; b=TzCbj8EVPltC2VF3/seYRlQsl1
	mXhuUnYOjkN5KBCJLxzI5Yox+adjB6Wq8jFKGfIQFsdGDetWB+l0WrQwv65cZJkpRt/grFeijDqtP
	UI+Lc+0u7x7IW6pe2F0XzUzU15lMELoXHaIGmNFeO6OJiYE17FtSunQvPWjUMUnYxA3qtMxvr2ugv
	d4HwHCibI3/trlqDaZ6RpgnD4BMildY44kqi1j7qk//DCylj88gYH4/qkmzqingb/AiLWDPjaaxqg
	949yamwTVztN6bGpZr4/91MNt305wVmxcPZErSJEMA8R5z+x6fLwv495j+VTt/bq/CpUhkJ1YoRWa
	IrlsgxGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAwq-0000000CtTs-1fqb;
	Mon, 27 Oct 2025 00:18:56 +0000
Received: from out-184.mta0.migadu.com ([91.218.175.184])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAwo-0000000CtRQ-0Zty
	for linux-um@lists.infradead.org;
	Mon, 27 Oct 2025 00:18:55 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qv8GrhWWLvpi+yXjcVXvopwH0zWKk+Fo+xAzYv1qf0M=;
	b=T4PKl5X+6V424JgZsHbjgohHFQmgP76ww0hRCuAU8l0OHdP80gOU4h5zkGhwT54VMt6IiR
	g/0xY78vvtuBWUgD/WDWefBPq53HQnlB1K8Xq7XZZgmL5nsY2iJjmGFPmkGGV8PZPjd2t3
	CQmBS+q7pZDeiog2t+/nDV+DmIglumA=
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
	linux-arch@vger.kernel.org
Subject: [PATCH v4 7/8] asm-generic: percpu: Add assembly guard
Date: Mon, 27 Oct 2025 08:18:14 +0800
Message-Id: <20251027001815.1666872-8-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_171854_343177_ABDA3FD9 
X-CRM114-Status: UNSURE (   8.09  )
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

Currently, asm/percpu.h is directly or indirectly included by
some assembly files on x86. Some of them (e.g., checksum_32.S)
are also used on um. But x86 and um provide different versions
of asm/percpu.h -- um uses asm-generic/percpu.h directly.

When SMP is enabled, asm-generic/percpu.h will introduce C code
that cannot be assembled. Since asm-generic/percpu.h currently
is not designed for use in assembly, and these assembly files
do not actually need asm/percpu.h on um, let's add the assembly
guard in asm-generic/percpu.h to fix this issue.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/percpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 02aeca21479a..6628670bcb90 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_PERCPU_H_
 #define _ASM_GENERIC_PERCPU_H_
 
+#ifndef __ASSEMBLER__
+
 #include <linux/compiler.h>
 #include <linux/threads.h>
 #include <linux/percpu-defs.h>
@@ -557,4 +559,5 @@ do {									\
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_GENERIC_PERCPU_H_ */
-- 
2.34.1


