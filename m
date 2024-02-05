Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE488C48291
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gr7z/SlPhRJd7tsl4kQkoTMn2fox0E9luuadMesY+gA=; b=H1DscaIe7R9WjV5BYbDCh7Ve2R
	J8zl4ClwtpjuuV6I8O6L62r/oeIXA1il4HSljECRPqhQcTc6/bYjyN7S2xLvLHm7HrcWsWSvabxtZ
	5Dv2vIWKNxFK+PPdJoOS9cWIUyOA6ghLOYmrTzjxl49i3jz2Cfpt+uGjwLS6dkXp1f3w8fMpLAzY1
	mr2bUHtlZuqUFb5m0wpbXSm7o/SmOCL0hjE57AJ+678gNrtsgcduRBeoBvlWlMU6dOig4cHI2nid+
	QUkFDduSKHRsXDuAHQg99BX26bTj/rr83bEpRZo0bYNwvXTXtj4fBZ7GMiVLGbjRjUoZfn37s2JPJ
	7MyY10gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxRn-000000032t6-253z;
	Mon, 05 Feb 2024 11:47:35 +0000
Received: from out0-204.mail.aliyun.com ([140.205.0.204])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxRh-000000032pc-2FFR
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 11:47:32 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047193;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WNt.HmC_1707133639;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WNt.HmC_1707133639)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 19:47:19 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 4/6] um: Fix the return type of __switch_to
Date: Mon, 05 Feb 2024 19:47:06 +0800
Message-Id: <20240205114708.25235-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205114708.25235-1-tiwei.btw@antgroup.com>
References: <20240205114708.25235-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_034729_902384_D055F391 
X-CRM114-Status: UNSURE (   8.80  )
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

Make it match the declaration in asm-generic/switch_to.h. And
also include the header to allow the compiler to check it.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 292c8014aaa6..a7607ef1b02f 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/resume_user_mode.h>
 #include <asm/current.h>
 #include <asm/mmu_context.h>
+#include <asm/switch_to.h>
 #include <linux/uaccess.h>
 #include <as-layout.h>
 #include <kern_util.h>
@@ -73,7 +74,7 @@ static inline void set_current(struct task_struct *task)
 
 extern void arch_switch_to(struct task_struct *to);
 
-void *__switch_to(struct task_struct *from, struct task_struct *to)
+struct task_struct *__switch_to(struct task_struct *from, struct task_struct *to)
 {
 	to->thread.prev_sched = from;
 	set_current(to);
-- 
2.34.1


