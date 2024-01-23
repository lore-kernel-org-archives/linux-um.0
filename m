Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529C0C48285
	for <linux-um@archiver.kernel.org>; Tue, 23 Jan 2024 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gr7z/SlPhRJd7tsl4kQkoTMn2fox0E9luuadMesY+gA=; b=cIWSaNthYOn5crA70suh3SkBxy
	v/u+chr9MnJmNBkmvv+zND39ZG7WL0Lmpu+4cGRaaPvE/Q1kdqi9L8wfSYox8YUaCevv2CV9sxiVv
	lcNknH/xNZVIAP22Ga0i4fRFpmsFbS77Q1Iw7jbF8DJOCz9a8J1ah2A3yDi4dYE6u5Ts6lf/5GtMX
	gRIGopBgGdn4gFvJzwARAVmGIUtmrlr/dI+QIWvKUmMgoauHQ5ldEo66cH4GahHN92QGqxDwkAL6x
	lufnlm+VdZuJSXzINo/I2B8UiKRyeltJWVLgKIY1Dhn50um6hec/+jnOhE3NKAh0Ixfa03k90UKe0
	D2cSNa2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEZa-00G3pA-2e;
	Tue, 23 Jan 2024 11:04:06 +0000
Received: from out0-210.mail.aliyun.com ([140.205.0.210])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEZU-00G3ja-1H
	for linux-um@lists.infradead.org;
	Tue, 23 Jan 2024 11:04:04 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WDCKTk8_1706007836;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WDCKTk8_1706007836)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:03:57 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/5] um: Fix the return type of __switch_to
Date: Tue, 23 Jan 2024 19:03:46 +0800
Message-Id: <20240123110347.1274217-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
References: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_030400_736554_56811EF5 
X-CRM114-Status: UNSURE (   8.77  )
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


