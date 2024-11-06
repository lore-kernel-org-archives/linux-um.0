Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00560D44D51
	for <linux-um@archiver.kernel.org>; Wed,  6 Nov 2024 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PVxLB4ynQexwBLLLCslCsw+YDn8W8UTgxWZ/DVEd+W4=; b=QbkPXaupFa9RMS9sybcJoStx0l
	SL5o4jI7DPS0qxZWnBK0ZWt8h+Dl62m42uBAurpc+8diVR9ggqPo8rjZeKwraF/iMVIgsohtP+7k9
	BWjj7qN1KNMzN9+5iulTGTzAFkDvhj0hr1lkQ550Nd5z8zc9cs0YPL9rMtqR/ES1MdiXWBR2LRWfv
	DDh7ZLR48mA/RGGAYb85cEPkGu8AwhKInwTWC+h8jVZ0nVimpHI0CX0KhsxsJxuA3h7KPJntLBlpA
	3Rh62MjuC5YcVVwGaRhqAQSVt0gfcbuiLQcImPQrr6xAc3jNfEpMZkqd6gBu8LmrKNAYpqQCDZSHp
	p9jM4TOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8eKc-00000002wRl-2M8g;
	Wed, 06 Nov 2024 11:36:14 +0000
Received: from out0-212.mail.aliyun.com ([140.205.0.212])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8dRz-00000002m1C-17QH
	for linux-um@lists.infradead.org;
	Wed, 06 Nov 2024 10:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730889582; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PVxLB4ynQexwBLLLCslCsw+YDn8W8UTgxWZ/DVEd+W4=;
	b=FMKSS4CUp6TiZyTXksd3Z87iETLcIqPhpucjkjGwEnnhBT0qGcZ2cFs+0kSZvtwQ39rjv/GRjdPk49cL0oP0mah/oV1HVDA/CPV9RG2GzoSbfiZ4xaFdKbMbQUDzrg3ieLOMptLDxL60c3HOzPSH2qRwpxzmUkY6nhr5p7Y/YKA=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a2sg25o_1730889575 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 18:39:39 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Always dump trace for specified task in show_stack
Date: Wed, 06 Nov 2024 18:39:33 +0800
Message-Id: <20241106103933.1132365-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_023947_831489_964287BC 
X-CRM114-Status: UNSURE (   8.25  )
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

Currently, show_stack() always dumps the trace of the current task.
However, it should dump the trace of the specified task if one is
provided. Otherwise, things like running "echo t > sysrq-trigger"
won't work as expected.

Fixes: 970e51feaddb ("um: Add support for CONFIG_STACKTRACE")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/sysrq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 4bb8622dc512..e3b6a2fd75d9 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -52,5 +52,5 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 	}
 
 	printk("%sCall Trace:\n", loglvl);
-	dump_trace(current, &stackops, (void *)loglvl);
+	dump_trace(task ?: current, &stackops, (void *)loglvl);
 }
-- 
2.34.1


