Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFAEC87FCF
	for <linux-um@archiver.kernel.org>; Sun, 27 Jul 2025 06:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ghp4aqIfWYjIth+RE2bWuQf8QfvJiCJcNtaoJe6JOCE=; b=Fdz0P0OlHB1wI5xrAHReLGZswU
	Q+ssiYL+tBWVcAqS/aM0RaB6rA6tNWDKee33agVDSLzALEBu4qCkjPUOsUN92vCCnqbuR6b1CYpFR
	Vze67w7+yy+X0GhW/TkeKX+EsasLIUD7GctBLqlcYrkFfSCb0R0UszPkXM5iTIeHthDP+0lxP3ZQs
	rhFB9NzXEhVdPNe2AnRZPuSHsacuyD9YbkADzCS5DcSh7ORmC0RTqOXtGifkySmGO7jWpBvV3QMWP
	0Ki5f8rT+dcVWizQ0CSF1jN3cgC33+fe3SGWWKeRKvyl8omIXKg1x9WmsWofplv37GdKLFy+5vSq3
	jM//5hzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutu-0000000CNvh-1Pxp;
	Sun, 27 Jul 2025 06:30:26 +0000
Received: from out-174.mta0.migadu.com ([91.218.175.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutr-0000000CNox-2UOF
	for linux-um@lists.infradead.org;
	Sun, 27 Jul 2025 06:30:25 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753597808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghp4aqIfWYjIth+RE2bWuQf8QfvJiCJcNtaoJe6JOCE=;
	b=uYRxCrvj/v5PotCaSjaUusA6juaVWKrfifatRpCZX0KfiXLhasF9emAJS1jGdOOzmVsT15
	kSGZwDlSVzl1OKFCj/iE2GzRiFiJ72Tv/aIddZqrL4LI2v9owrJOAy24vgOSMr2x8ow4Kc
	OHn+Hbm/axnAloLDf8FqmE+N0gAJUTI=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 2/9] um: Remove unused cpu_data and current_cpu_data macros
Date: Sun, 27 Jul 2025 14:29:30 +0800
Message-Id: <20250727062937.1369050-3-tiwei.bie@linux.dev>
In-Reply-To: <20250727062937.1369050-1-tiwei.bie@linux.dev>
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_233023_776160_E1F21122 
X-CRM114-Status: UNSURE (   6.38  )
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

These two macros have no users. Remove them.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 8a789c17acd8..236fdfd7cdbe 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -81,8 +81,6 @@ struct cpuinfo_um {
 
 extern struct cpuinfo_um boot_cpu_data;
 
-#define cpu_data(cpu)    boot_cpu_data
-#define current_cpu_data boot_cpu_data
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
-- 
2.34.1


