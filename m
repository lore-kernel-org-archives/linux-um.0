Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99223C98316
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jvcw1OFQJ/inZUNd+zjDNJ/P6c1F53gL3jHeWGbl7GU=; b=bWXRYzecTOGWyJdZpa80hQwUgU
	lGdFMIfAsC4CmTpGQkRk4JnarmSWgVecyF/nTzKRNNQBxQ4R4ugPtbqhFVG3/R4EbqmoY80YxCHoh
	PNCxeC6cxE/JmnZZ0kMeZtqin/8sdR9kTGpHalaU0cANtebJPQwxZaxL4a0kcD9jBMKLATy004Vd8
	A+vbz5j1WBk15aC4QTthZZU5Lk/4uBrRiDSfflbu2lFF4LamacEo4GG/EvTJmzohxaGeDNsBBjukD
	JER4LctKwbEeOwKFc4/ciO1ld3D6ezTBQkp2wHiSNxAUnskgD0QkJd19BpoM5H5T8dU/FPEQISzWc
	SxjWHuYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9dHQ-0000000ABWY-3jVx;
	Thu, 24 Sep 2026 06:50:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9dHN-0000000ABUd-0RZo
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 06:50:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Jvcw1OFQJ/inZUNd+zjDNJ/P6c1F53gL3jHeWGbl7GU=;
	t=1790232601; x=1791442201; b=aon7imUiqRguHzEl/wulcpzleTaAEAtLxGmiUuQFXvL9A0c
	pkfEi926tcdaboVtK647okPuZx8ipXWerJ6EHeEgCcSrWCtY2P0ghVy8LPfAvYmCDXKDSqkL2p4du
	AA5ttIpR/6STE1fgI5UB17EgmE7BhoOy93K7ZN/60BwuYf1/Lg5rXC6KVDgALiN0LmMKdKFSJDiZg
	ETsjI/FigzMpl7H6b8RrRx2LcOVSVmkrgsKoOhLaZb1bND+5MslC/83ArIr61/GQIVd8FmMFf7bg2
	0JI95i5SANdyf2ibATZ7060misEP4PJV9PxoBDrieGOuvDbGF0M4e2kKmiNlDvJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9dHH-00000008t0P-3tsO;
	Thu, 24 Sep 2026 08:49:56 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] um: mprotect() __init memory
Date: Thu, 24 Sep 2026 08:49:45 +0200
Message-ID: <20260924084946.d118ec78e604.I993b671566a4e842dcc290b78f1c0004050362ba@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924084946.2bfe0f25e6e2.I021d3a909687794eb2c3435fdfcb7f67e3ec4ba1@changeid>
References: <20260924084946.2bfe0f25e6e2.I021d3a909687794eb2c3435fdfcb7f67e3ec4ba1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_235001_172233_22A75319 
X-CRM114-Status: GOOD (  14.04  )
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

Unlike what the comment says, we could munmap() this (but
not reuse it for guest allocations), but then stray libc
allocations could technically conflict, so mprotect() it
to catch access bugs. Align it in the linker scripts too
so that all of it can be covered, not just some.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - move sections first (new first patch)
 - fix typos
---
 arch/um/kernel/dyn.lds.S |  3 +--
 arch/um/kernel/mem.c     | 11 ++++++++---
 arch/um/kernel/uml.lds.S |  1 +
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 875db0130d75..042e8d7fba0a 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -24,9 +24,8 @@ SECTIONS
   INIT_TEXT_SECTION(PAGE_SIZE)
 
   init.data : { INIT_DATA }
-  __init_end = .;
-
   . = ALIGN(PAGE_SIZE);
+  __init_end = .;
 
   /* Read-only sections, merged into text segment: */
   .hash           : { *(.hash) }
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 1eef0e42ef5d..5c1898c9ed53 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -83,12 +83,17 @@ void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
 }
 
 /*
- * This can't do anything because nothing in the kernel image can be freed
- * since it's not in kernel physical memory.
+ * We could munmap() this instead, but then libc allocations could
+ * land in this area and stray initdata access could erroneously
+ * succeed - just mprotect() it to reliably catch bad accesses.
  */
-
 void free_initmem(void)
 {
+	unsigned long start = PAGE_ALIGN((unsigned long)__init_begin);
+	unsigned long end = round_down((unsigned long)__init_end, PAGE_SIZE);
+
+	if (end > start)
+		os_protect_memory((void *)start, end - start, 0, 0, 0);
 }
 
 /* Allocate and free page tables. */
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index d161518d7195..ac53e0fa9efe 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -32,6 +32,7 @@ SECTIONS
   INIT_TEXT_SECTION(0)
 
   init.data : { INIT_DATA }
+  . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
   .text      :
-- 
2.55.0


