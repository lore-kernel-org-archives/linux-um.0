Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A0BC98311
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mIP1US3tTX7jfvvkUTy6BT/ZWw3jQ0jUbIHTlBoPnoo=; b=VTh+QBPXNEp5a0WWBRVaFqjusU
	S0ezpYE6EMCVE5CQ7VXEXpd4tiO2dVhnZKfn0yYJVhpcDQXJayLey6mYVFVUc44u6QUIa8QIC2Ydq
	mO+A9QeSqwbnfSFEVHADaJKX3kWxiuMwWL4IOsA+ijT9zTh6SpF1YKEiT0gpqCB6fbkEDBV4eChEk
	7eOFL3yUUYkX6oBvKG7p/c2EFzdbMEnomIwMIEauozo9HAqz6PCV4lUrX23H9A7fKY9w3lL0xnvRH
	wr2rM5fNbRBpIgAC29Mog4jt8cDlerQs9BfvKmcPXLmWDTBynYEzxTdSU5KQDty/M7id2E/eFsZf/
	PKbW+w1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9P0T-00000008krV-0x5Y;
	Wed, 23 Sep 2026 15:35:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9P0O-00000008kom-3ncv
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 15:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mIP1US3tTX7jfvvkUTy6BT/ZWw3jQ0jUbIHTlBoPnoo=;
	t=1790177732; x=1791387332; b=gXP2B1mzNwzPM6SCghC2e7uRJ3BLhC6+Vk+V+GbhT4sgO75
	5ouWP/slD2ODnesiWD9AcvKjz4ZbhsxiQ6atfa1QZTEzjF7vM1T1gy5lUYwVu2IiS3HL33O8jkLfp
	vR2ZzrKUSIOarDnlFg9cmNQyx6QgDnzkVcpmeEcUei32EgunR3FW69tQPereW62TgRwcbRfnzaVaf
	6+7jIxGzuou67bypl5xo5M2eDNZwGI+578rFITPIbSA+swGMMQ9qBfmo7ktekJHD6pItT8KIbjvi/
	d4eUSv4Ob2SjbsuYXBP9J1x37MpAJiLoI47ZhpwnVDlAE5enALBWv1mhJGaeoUeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9P0J-000000083zz-3YXa;
	Wed, 23 Sep 2026 17:35:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] um: link .lbss/.ldata/.lrodata correctly
Date: Wed, 23 Sep 2026 17:34:30 +0200
Message-ID: <20260923173523.3675aee4f2fc.Id8b553b971d1428abb1bd1222016758314af3098@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923153523.987904-5-johannes@sipsolutions.net>
References: <20260923153523.987904-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_083533_248398_F6A57899 
X-CRM114-Status: UNSURE (   9.50  )
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

From: Johannes Berg <johannes.berg@intel.com>

clang 23 for me seems to put a bunch of data into these
"large" sections, causing said data to not be considered
kernel data by the kernel, in turn causing all kinds of
strange bugs. Link the data from these sections in the
right place rather than leaving them separate.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/common.lds.S | 2 ++
 arch/um/kernel/dyn.lds.S         | 2 ++
 arch/um/kernel/uml.lds.S         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index fd481ac371de..6585cb93e6eb 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -11,6 +11,8 @@
 
   RO_DATA(4096)
 
+  .lrodata : { *(.lrodata .lrodata.[0-9a-zA-Z_]* .lrodata..L*) }
+
   .unprotected : { *(.unprotected) }
   . = ALIGN(4096);
   PROVIDE (_unprotected_end = .);
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index ad3cefeff2ac..a6b20c7953d6 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -117,6 +117,7 @@ SECTIONS
   .data           : {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
     DATA_DATA
+    *(.ldata .ldata.[0-9a-zA-Z_]* .ldata..L*)
     *(.data.* .gnu.linkonce.d.*)
     SORT(CONSTRUCTORS)
   }
@@ -159,6 +160,7 @@ SECTIONS
    __bss_start = .;
    *(.dynbss)
    *(.bss .bss.* .gnu.linkonce.b.*)
+   *(.lbss .lbss.[0-9a-zA-Z_]* .lbss..L*)
    *(COMMON)
    /* Align here to ensure that the .bss section occupies space up to
       _end.  Align after .bss to ensure correct alignment even if the
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 30aa24348d60..f7ec7e7f5981 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -78,6 +78,7 @@ SECTIONS
   {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
     DATA_DATA
+    *(.ldata .ldata.[0-9a-zA-Z_]* .ldata..L*)
     *(.gnu.linkonce.d*)
     CONSTRUCTORS
   }
@@ -107,6 +108,7 @@ SECTIONS
   PROVIDE(_bss_start = .);
   SBSS(0)
   BSS(0)
+  *(.lbss .lbss.[0-9a-zA-Z_]* .lbss..L*)
    __bss_stop = .;
   _end = .;
   PROVIDE (end = .);
-- 
2.55.0


