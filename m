Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959DCC98310
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wyfpAY+TrDw7I8wdDiHFn9UTsWh8RV6OmR6zp/A88/4=; b=yyXXS1zzx6nKTCl4jpckfW7jpD
	HpqRE8kLvZF03mNrsTYFOQSQ5MT8hHJayb02ylC0Zca6zYaHfCvvLBH7R3hqy+rXD4Hy0RSzQNZGk
	jKp9+6cRs8BwF6g7yGXwkcsUrrawEonLgXzWhVBg7ZpmZHJF1/sGK7n4iWgCDfrwQ+U8ZfUY4X75W
	wIQrxVOKzhKNJS/IVur2C4pTc7ORfpbGT1xoZnps+/ppOncCzdIV25ozzVGDiFgBrAM7MCjVIKXmh
	ntx/Fx//qOe/9z8BX5p5gKHg4lO8PKGD4iNyxf5gSDvoD9gFprkoC3zFH2l1OCjMSH271GGt5kDBw
	yHCKoF6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9dHQ-0000000ABWI-38T2;
	Thu, 24 Sep 2026 06:50:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9dHN-0000000ABUR-0R2b
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 06:50:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wyfpAY+TrDw7I8wdDiHFn9UTsWh8RV6OmR6zp/A88/4=; t=1790232601; x=1791442201; 
	b=ejr5b78Fn0qwOrMzidUoy4GvDaY19F/+CX7PhcRzW4MF81RYXzr6LLQi/LVfg/WY0vobgoHG43p
	nFPsuMeBjmdZk8NEckkw0xZnPLU0GxoqJMmqReWAo3erPdjCAJtf5V0JAUkYNc6fqKQ0EaiFMyVF/
	ercogk6tjx0JrQFkbaNGSy53BM79JvN6lXPHYby7hgMYOS9D7/bxG8h7fYIaCcvAW0YRManRVRIdh
	KhJk9G7tq++iDGQxx4iDItjrSrJj2uCl4YC/6uk9qaMY8rdmV53r4jTqr4Kssle7ET3n9ZoLw9HR4
	mN7pyNkqIg9rtwbKkE5vCGkg3TeVM51+fMnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9dHF-00000008t0P-3OTJ;
	Thu, 24 Sep 2026 08:49:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] um: move init text between __init_begin/end
Date: Thu, 24 Sep 2026 08:49:44 +0200
Message-ID: <20260924084946.2bfe0f25e6e2.I021d3a909687794eb2c3435fdfcb7f67e3ec4ba1@changeid>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_235001_172645_F8FD203F 
X-CRM114-Status: GOOD (  13.10  )
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

Today only the init data is there, which means any
backtrace (or other pointer printing) involving an
__init function can't print its name.

Move the initdata and include the init text between
the markers so this works.

This also enables unmapping the initdata since it's
no longer part of the overall data (which kmemleak
scans, so it would crash otherwise).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/dyn.lds.S | 8 ++++----
 arch/um/kernel/uml.lds.S | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index ad3cefeff2ac..875db0130d75 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -20,8 +20,12 @@ SECTIONS
   __binary_start = .;
   . = ALIGN(4096);		/* Init code and data */
   _text = .;
+  __init_begin = .;
   INIT_TEXT_SECTION(PAGE_SIZE)
 
+  init.data : { INIT_DATA }
+  __init_end = .;
+
   . = ALIGN(PAGE_SIZE);
 
   /* Read-only sections, merged into text segment: */
@@ -98,10 +102,6 @@ SECTIONS
 
   #include <asm/common.lds.S>
 
-  __init_begin = .;
-  init.data : { INIT_DATA }
-  __init_end = .;
-
   /* Ensure the __preinit_array_start label is properly aligned.  We
      could instead move the label definition inside the section, but
      the linker would then create the section even if it turns out to
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 30aa24348d60..d161518d7195 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -28,8 +28,12 @@ SECTIONS
   . = ALIGN(PAGE_SIZE);
 
   _text = .;
+  __init_begin = .;
   INIT_TEXT_SECTION(0)
 
+  init.data : { INIT_DATA }
+  __init_end = .;
+
   .text      :
   {
     _stext = .;
@@ -70,10 +74,6 @@ SECTIONS
 
   #include <asm/common.lds.S>
 
-  __init_begin = .;
-  init.data : { INIT_DATA }
-  __init_end = .;
-
   .data    :
   {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
-- 
2.55.0


