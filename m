Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53518CE7A88
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rCMaQVSp2NOfqyCY65GXz9pEyZfvROyfIlmngC+gcX0=; b=hTJEbAjECNbeye
	W3RCKAuvM1cehhdZmHRLRUwO51Bv7cPDuZKOCSDF828qv20yBodLY2zJXu9ffTYAiO+sWovCgmOc4
	sIy/7rzhJN9MWaNP3Rtxf2k8QxfS7XemuAA3Bv8NRp1dxud2EZqIzjzMu7rs71UxlymZVWHsMk5zF
	cGcb0LW3yLaofzumNpDtkWJybUboAEInyKDisbtKctskvQu1UtllameoImzbDsM7N2qKOhH7Zkalf
	JYijA9do1BJs+1XEy+Kqwt2QGroNc0CNS+64FJopQ48q3jC6RP5hgQJ9sZEPtx4w9cJl2gnbWW5Ej
	RdOKBa6BS6QDVwOiL9MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjoo8-009vYP-34;
	Fri, 22 Sep 2023 22:39:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjoo2-009vWJ-2Z
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 22:39:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3Ewb8X8qwzdej/Dyi2h0QcVlpfouhJGR7F+AnRSf4Wo=;
	t=1695422364; x=1696631964; b=HMlU3VlBhVvGXxtELUzw5ILKSH4H8NlCFxSrUl7C2HGHu9y
	5rpVwDp5inc7RINErnxJl29BgtqHlKPvwJeAHC7uaJ88oBUg5IrctVpXBfZaY9WT75d3ZHW0oevmj
	K5AIT3iBOPpEPA1GxVKLfcSOnprGaaX65PLiXEjnIrXcLuUSGdorW084REIbAIvoHve4Ab1ASnxo+
	8QmDqkBlu9cFEam/B+k/vHWCdfrtocrBbl9noc3YTVNSSOQExzQj6rawakzazSocf4Soj3/FOmyFa
	HrEjekFaJlhQ96ZpLxZtfCs/s5ZZi4hMUd5SACDLkRiL1ZjAuI11l3GiSdMl+Taw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjonx-00FtWi-2l;
	Sat, 23 Sep 2023 00:39:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 2/3] um: clean up init_new_context()
Date: Sat, 23 Sep 2023 00:37:40 +0200
Message-ID: <20230923003737.c4494349a21a.I909ad341512baae41901f4e5b8ccb57ce9fd0d6a@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922223737.1206223-4-johannes@sipsolutions.net>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_153926_882536_F001F69F 
X-CRM114-Status: GOOD (  15.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

This function gets a context that's already copied from
the old context if making a copy, or memset to 0 if not.
This means we don't need to play games with current,
even if those games are OK now since dup_mm() is only
ever called with current->mm as the source.

Also memset() our context to 0 since we don't have in
there anything that we need to keep - except the LDT but
we have to copy that separately, so make a temporary
local copy.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/mmu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 656fe16c9b63..ea0c37b92581 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -16,6 +16,7 @@
 
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
+	struct mm_context _from_mm;
  	struct mm_context *from_mm = NULL;
 	struct mm_context *to_mm = &mm->context;
 	unsigned long stack = 0;
@@ -25,15 +26,26 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	if (stack == 0)
 		goto out;
 
+	/*
+	 * If the kernel wants a copy, it already copied the entire context.
+	 * If not, it's all memset to 0.
+	 * So we can detect here whether or not we should copy, and have the
+	 * pid we should copy _from_ in our own context struct of the new mm.
+	 */
+	if (to_mm->id.u.pid) {
+		_from_mm = *to_mm;
+		from_mm = &_from_mm;
+	}
+
+	memset(to_mm, 0, sizeof(*to_mm));
 	to_mm->id.stack = stack;
-	if (current->mm != NULL && current->mm != &init_mm)
-		from_mm = &current->mm->context;
 
 	block_signals_trace();
 	if (from_mm)
 		to_mm->id.u.pid = copy_context_skas0(stack,
 						     from_mm->id.u.pid);
-	else to_mm->id.u.pid = start_userspace(stack);
+	else
+		to_mm->id.u.pid = start_userspace(stack);
 	unblock_signals_trace();
 
 	if (to_mm->id.u.pid < 0) {
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
