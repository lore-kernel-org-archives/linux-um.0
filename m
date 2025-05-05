Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6BEC3ABB0
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 08:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mH54UZ2XgdTbH/mJDFAclr0Gkcxe9PqEGsY/iPZaH+s=; b=b4YeuJE1HOet2uMtoDqGI8cpnC
	V3iy5Y/NfDt+d8zw06Fsx/5pLZulVOYc4ILMGjRgTN2WJPNOnree+aidy9rHMtWlmoacqaTW6lbx+
	sl9/duZbFu7Pr5q0JiYvKzo/nHYiLewk0Nu42VfHHYhZIZ4gx1l++y0JTHJU26kUkzxV8fgi7WfQu
	IxdmxaeHDkO9Cs2Bmdr//eO8JX83t8/vdZ/lnYtVkenvihg+iU+VyNjCnKUuMyiuBsjQ7PR0j4jmm
	M7kfcfqpf0IVfcNy30S5onOIitkTHzhEMD/vNpjBjHK5NENJFkcS8FRRm4dkpec8t0oxPX4Uk9Fn/
	++PdJKfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrPN-00000006oIU-3Bc9;
	Mon, 05 May 2025 08:42:41 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrH2-00000006nLy-3bSw
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 08:34:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=mH54UZ2XgdTbH/mJDFAclr0Gkcxe9PqEGsY/iPZaH+s=; t=1746434044; x=1747643644; 
	b=J9GtqztUTkc2CE44XKTimRnaSGqzLY4gAjfmCosLHHptDtLRUcLIv238fuULF/YIdNgdAXwRwmm
	3qG6sidXW9NOIbEZ8xjjmGEKH2yAQP4LW5I414h3qe9FRaNQaq68jLoLn7PwleY9gZ9hSazHsyPRQ
	0P7xk8FchEiZ0PWBGYscMaDj3lMFwXcfYN+A5jYm7UrMJlMStqTW94+SKDZxKRyjQ6v85ltBmTVOp
	68gxVBiBQq4hqjK1zPwNLPuRIiBZ2YcwZArs99ngn5WTLoc2IFXtXbQvpi4opCQJch4hYu1kixjrj
	B8PB9aDBC8VkGbX1m/Cakhv2+juvziaPjGfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uBrGy-000000044ea-2vwd;
	Mon, 05 May 2025 10:34:01 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: chan_kern: use raw spinlock for irqs_to_free_lock
Date: Mon,  5 May 2025 10:33:59 +0200
Message-ID: <20250505103358.ae7dc659f8b4.I64ca7aece30e0b4b0b5b35ad89cdd63db197c0ce@changeid>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_013404_899596_B64D0CED 
X-CRM114-Status: GOOD (  10.54  )
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

From: Johannes Berg <johannes.berg@intel.com>

Since this is called deep in the ARCH=um IRQ infrastructure
it must use a raw spinlock. It's not really part of the
driver, but rather the core UML IRQ code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/chan_kern.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index e78a99816c86..26442db7d608 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -212,7 +212,7 @@ int enable_chan(struct line *line)
  * be permanently disabled.  This is discovered in IRQ context, but
  * the freeing of the IRQ must be done later.
  */
-static DEFINE_SPINLOCK(irqs_to_free_lock);
+static DEFINE_RAW_SPINLOCK(irqs_to_free_lock);
 static LIST_HEAD(irqs_to_free);
 
 void free_irqs(void)
@@ -222,9 +222,9 @@ void free_irqs(void)
 	struct list_head *ele;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irqs_to_free_lock, flags);
+	raw_spin_lock_irqsave(&irqs_to_free_lock, flags);
 	list_splice_init(&irqs_to_free, &list);
-	spin_unlock_irqrestore(&irqs_to_free_lock, flags);
+	raw_spin_unlock_irqrestore(&irqs_to_free_lock, flags);
 
 	list_for_each(ele, &list) {
 		chan = list_entry(ele, struct chan, free_list);
@@ -246,9 +246,9 @@ static void close_one_chan(struct chan *chan, int delay_free_irq)
 		return;
 
 	if (delay_free_irq) {
-		spin_lock_irqsave(&irqs_to_free_lock, flags);
+		raw_spin_lock_irqsave(&irqs_to_free_lock, flags);
 		list_add(&chan->free_list, &irqs_to_free);
-		spin_unlock_irqrestore(&irqs_to_free_lock, flags);
+		raw_spin_unlock_irqrestore(&irqs_to_free_lock, flags);
 	} else {
 		if (chan->input && chan->enabled)
 			um_free_irq(chan->line->read_irq, chan);
-- 
2.49.0


