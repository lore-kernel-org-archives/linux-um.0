Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88089CA0EC0
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 05:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ghp4aqIfWYjIth+RE2bWuQf8QfvJiCJcNtaoJe6JOCE=; b=4VWdZgxj2iZ+ccMf6eGJBtwMcC
	KFXav011owm8GbIYfCgj8dZ4il8G4HSEdcJZRfmWuQTDVF3uLF911DrdaA0vHJSWCAENWITDjHbix
	+0yL1HqQrjI8qo0fz2YUUJEGlFbuDuTHfUOuuIePTpKdJqyXVs/TIDDd9KFGY8NHrr2dcT3836UfO
	TzGuSzSZ5js/ZFNjCT1FeMqtEWILEa7MfoNT90XrNgQp27/5kpNJi2Fl1HCj9FZWmEXyrMWfibyIv
	eGvMl5h9Ffs2+aduejr/YtDOxDelOP0rsusr2dwOarkFyG3asvap+NsGRLuBYW4sz15cJGs5KktS8
	lznghofA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyyY-00000005IK4-0NGE;
	Sun, 10 Aug 2025 05:52:10 +0000
Received: from out-179.mta0.migadu.com ([2001:41d0:1004:224b::b3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyyU-00000005IJ2-45XO
	for linux-um@lists.infradead.org;
	Sun, 10 Aug 2025 05:52:08 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghp4aqIfWYjIth+RE2bWuQf8QfvJiCJcNtaoJe6JOCE=;
	b=VZyFXx3zupTOWZFhm7f7Ztw0M3GBICeCgkaCEf2FXpxoLcV3795eT3GMj7pB4aIDmOdJ59
	POsAg7j+kuFi7Z5z+lnEhkKzT9mrKtPCIbFc4brf8+rAOYEIVfJRvUPs9DnR2YqbamZAKk
	eJdceAQWUaEtLCN3tQNzGv2ysJNVtjg=
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
Subject: [PATCH v2 02/10] um: Remove unused cpu_data and current_cpu_data macros
Date: Sun, 10 Aug 2025 13:51:28 +0800
Message-Id: <20250810055136.897712-3-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250809_225207_158819_3677262B 
X-CRM114-Status: UNSURE (   6.21  )
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


