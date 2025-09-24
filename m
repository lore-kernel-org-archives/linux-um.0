Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6AACAC5B3
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 09:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2zU3hWkY+GpCpwaUcqD4x9HJZAaBKvyZT2l+B3W0An8=; b=TVBzIirwLyC33P+sgm1j2Eof82
	xTROb5k6ohAqiVTHEGM7mE3ZX2o0TKUCmw/Ch1Ubyn5/F7m87lpqqUAGsKE28FGyeDs/lIbayJMTI
	jRrPqxyfpMzlNecw9ql1jQu0/o5Ah/S245MbOIVNOuCWNJ5XWKIKXETtJ5sGNC1OW+aGz/ZgKT+Lb
	Hpp5wZilCPkyykirPBxKtUQrHfFRQkg5dOYPlNjgfP6IC3g0YsuE9z8qq3/9gvdgCrQczb/2G/QPM
	AWo8iZvO/ds0gLlS6bxEkNisJMkU6qOT0qx7DdtCbV3nJdDPbLShJbCxaMqPLro/glPEXpH+6+QHM
	RdsmGF8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LrL-0000000G4VA-2kWy;
	Wed, 24 Sep 2025 09:32:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LrI-0000000G4SQ-26Zq
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 09:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2zU3hWkY+GpCpwaUcqD4x9HJZAaBKvyZT2l+B3W0An8=; t=1758706340; x=1759915940; 
	b=DPWy+nfyeqVluWZ7Um2ChP9+ypHK27qHF6VMR65M5OWYiEcfJwQV5kcADCsa2a51URuNFhAGR+U
	gVUK/Uml/RaVZUqtuUVSl0/5JRydWbze+fNlWoJ9CG05HgmLBwg1DTEUZrRYiwTaIrpc2l9et+V0O
	aHu/+vNl7V7qAojQMhKDxWZ/IBDp9haIXe4Ktyv+PO4yBGmAez3x5P7Lb/1KfFlDQ4if2MfClJNTq
	S4g4YKV3rnsLj6rBnBuwFmj9WORsjzLxJede5U1YmZAjeUQuiVcyDTENl4hwz45bodf3Zx0wuQOOC
	0B7lcCO4Ebn74DhC6SaCvQMxJtVN4gYPun3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v1LrF-00000008XZU-21FC;
	Wed, 24 Sep 2025 11:32:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: init cpu_tasks[] earlier
Date: Wed, 24 Sep 2025 11:32:13 +0200
Message-ID: <20250924113214.c76cd74d0583.I974f691ebb1a2b47915bd2b04cc38e5263b9447f@changeid>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_023220_544260_372280FF 
X-CRM114-Status: GOOD (  12.61  )
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

This is currently done in uml_finishsetup(), but e.g. with
KCOV enabled we'll crash because some init code can call
into e.g. memparse(), which has coverage annotations, and
then the checks in check_kcov_mode() crash because current
is NULL.

Simply initialize the cpu_tasks[] array statically, which
fixes the crash. For the later SMP work, it seems to have
not really caused any problems yet, but initialize all of
the entries anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/process.c | 4 +++-
 arch/um/kernel/um_arch.c | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 1be644de9e41..66787619db97 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -43,7 +43,9 @@
  * cares about its entry, so it's OK if another processor is modifying its
  * entry.
  */
-struct task_struct *cpu_tasks[NR_CPUS];
+struct task_struct *cpu_tasks[NR_CPUS] = {
+	[0 ... NR_CPUS - 1] = &init_task,
+};
 EXPORT_SYMBOL(cpu_tasks);
 
 void free_stack(unsigned long stack, int order)
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 2f5ee045bc7a..f2edd95d7663 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -242,8 +242,6 @@ static struct notifier_block panic_exit_notifier = {
 
 void uml_finishsetup(void)
 {
-	cpu_tasks[0] = &init_task;
-
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &panic_exit_notifier);
 
-- 
2.51.0


