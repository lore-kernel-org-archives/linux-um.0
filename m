Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BE6C982E1
	for <linux-um@archiver.kernel.org>; Mon, 21 Sep 2026 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P9d9IuyhNWmJnXlvoMGELDNfrs4n7zj8cv/0sALqrSY=; b=DghKR6LdVJiTbLOpDfhIMtEXet
	0KXdOHTJ9Q/w1t9227bloc/eNYC1FMuOgzuDOh1YwJ9weJiRlBIm6dnXj39tPLgJyUP9ePXET50Rr
	nxfdIbWCdOQsoIQjl59hLPcrFvJKeCsrCmf6v3/RLoPQNk6Goq+4UMMXepILa1AS3RkAcJU6LVk9U
	13H0JWZ0yBa2lqITsg+Ywd/ep35YvxAVLcqLvDRLYm02HfKhfQ5yQzGnMjSG+t9BfS1A+2rMSTTIn
	q/e900xqiBihmEsUMyhUQgMheTVEMRr1sufz/3XTo9FwbTBSW86wVcDdG+QxGyAtjotEM5EH+d8Ml
	4eWjdDlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8bHT-00000001hcJ-2Bhf;
	Mon, 21 Sep 2026 10:29:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8bHO-00000001haq-3Sau
	for linux-um@lists.infradead.org;
	Mon, 21 Sep 2026 10:29:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=P9d9IuyhNWmJnXlvoMGELDNfrs4n7zj8cv/0sALqrSY=; t=1789986586; x=1791196186; 
	b=Q5aMKV5zMIX0c0vJjr/DBwOLGfdzpLQxyPbO22uA3J3W9HtzKwv9vW3s+CgPyZ4UqfADl8DC8k2
	qBBpgRz0Tyj193jvG+0jz/RqSW0jjuMM35crayijBKJlYqnkVj37yGqfkECYjWq3gNlty6qZyGnAs
	b4hTWetR+GRH0+shW9XLAsZAOM/UHyxu25ltBFKX3wFup8zrkP37/t0J6HqhnxJq1f3WkwFmMdkjA
	g4N0tovC+irpF5YpGQbBzXEHAk8ux10IFDg78OPERLSoW2i8BOb1SSmCuNFg6pf7XTcNxzmcI/Fwo
	ZMv006PLGmba8Xr2JI4L6R2LuI0OyqLBtNOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8bHH-00000005kJr-3Gyl;
	Mon, 21 Sep 2026 12:29:40 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: mprotect() __init memory
Date: Mon, 21 Sep 2026 12:29:37 +0200
Message-ID: <20260921122937.3821fec01e82.Ib959ff1baad7a45e2b804209b530040e69e4b046@changeid>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_032946_876805_F033F18A 
X-CRM114-Status: GOOD (  12.18  )
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
 arch/um/kernel/dyn.lds.S |  2 ++
 arch/um/kernel/mem.c     | 11 ++++++++---
 arch/um/kernel/uml.lds.S |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index ad3cefeff2ac..5d3d5ef6ebec 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -98,8 +98,10 @@ SECTIONS
 
   #include <asm/common.lds.S>
 
+  . = ALIGN(PAGE_SIZE);
   __init_begin = .;
   init.data : { INIT_DATA }
+  . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
   /* Ensure the __preinit_array_start label is properly aligned.  We
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 1eef0e42ef5d..00c469fd28ee 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -83,12 +83,17 @@ void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
 }
 
 /*
- * This can't do anything because nothing in the kernel image can be freed
- * since it's not in kernel physical memory.
+ * We could munmap() this instead, but then libc allocations could
+ * land in this area and stray initdata access could erroneosly
+ * succeeded - just mprotect() it to reliably catch bad accesses.
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
index 30aa24348d60..7085ba6fcb93 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -70,8 +70,10 @@ SECTIONS
 
   #include <asm/common.lds.S>
 
+  . = ALIGN(PAGE_SIZE);
   __init_begin = .;
   init.data : { INIT_DATA }
+  . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
   .data    :
-- 
2.55.0


