Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5C6C83F17
	for <linux-um@archiver.kernel.org>; Sun, 13 Jul 2025 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ghp4aqIfWYjIth+RE2bWuQf8QfvJiCJcNtaoJe6JOCE=; b=eLPrOJtWH9GjyAAYQf63KKg9mR
	m49S1BDfIYumtamkDPuHAZ3OU8haUDQPNnv/by5rugOGdD810YHrVFVwSq8Bnuf7GI6nt8cuvOYib
	4UJd+qYgNs1XDizNWwAR8GJqF1JWAikyBbS0e4SnT0X93VICGL3/TEQSYiCUwYbqRAVTkI1VGasXQ
	OL5h+NcaLYmW7FokhevKuSG6QY4dJxSdRXUo9Zm+IN4P81o02B+Kptbix4yZVYAkUVgI96ikhSPP6
	HkSSafKxxjQhJ6bmzfABgGNGZNc3EeJe/MkvjdyxcKioCFJyGxOQuomgCuaBlckVc6M0i1okU8aN9
	jhgYrOrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Ui-00000000RSf-46Eb;
	Sun, 13 Jul 2025 17:28:08 +0000
Received: from out-179.mta1.migadu.com ([2001:41d0:203:375::b3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Uf-00000000RKv-3vJi
	for linux-um@lists.infradead.org;
	Sun, 13 Jul 2025 17:28:07 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752427561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghp4aqIfWYjIth+RE2bWuQf8QfvJiCJcNtaoJe6JOCE=;
	b=AVNEm8SUqmH/63AIwX9Qf9CcVYhxGcTB4VE1p/hjwvtzfhlZ+q/1tUNvEUFSWf2/kBrAEc
	QFUS2rj/r80czyA8iB5T9XySWl04/0nmFs0CR6Y8HIFhy448QFTaTmc6Vpr8VURk+uFzL/
	OMU5ttKK3exzQqZ7EZAxIR1hq+q6c2Y=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [RFC PATCH 2/4] um: Remove unused cpu_data and current_cpu_data macros
Date: Mon, 14 Jul 2025 01:25:34 +0800
Message-Id: <20250713172536.404809-3-tiwei.bie@linux.dev>
In-Reply-To: <20250713172536.404809-1-tiwei.bie@linux.dev>
References: <20250713172536.404809-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250713_102806_113112_ADD86849 
X-CRM114-Status: UNSURE (   6.18  )
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


