Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA79FA375B
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZB4Wk7EKq3swEhgTMXe08Tf2koYQsonQnyuvemBBqPU=; b=0zAk3X/u+tVmskdi1PhkLtJ2jQ
	oGjb6cvlqCNtuAMs3FfbvA3USOzt2DT5kaX1Nu3Xr9OYE3NuLNSy01eBTkcwDS/j+22/JtIenPYws
	EMxZZz7ms/hsGeKdyLJMBR2fJ3R3xJFT2K/vWHCKxdaQjCZVGY93KHKW2rFQRJkewJKacH7dgdBBY
	w3H+sCncjgbvNT/vFUt95/n27I+bOBX9zJMwFblZOOGAdE31logrmeTU0gO4pMnO6sGQ8q7lgJq4+
	NGh8dmhVrqOttnDKmi/bgyCcl9F3ufHxDQhUc0Ug+8aXPvHS9GNXHi3S2djl9l8HTPPT2rVKirPja
	3YWuec1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6Te-0000000G3DC-2aXG;
	Fri, 13 Sep 2024 13:36:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6TH-0000000G38v-1UVH
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:36:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZB4Wk7EKq3swEhgTMXe08Tf2koYQsonQnyuvemBBqPU=;
	t=1726234583; x=1727444183; b=fELtsI1b/I/qqXPE+3oSS/LJIVqgsLs4gx/3+n4avmFsoHz
	Qc0+QFGmb5aMC9A8xfKnqU1kr3hIekzYu4jtPoycq50pk+hLHeJdXlQp9SKNxqpxM10yavtwtcZeJ
	wDYyTKWeyV4iLfxt2oGYRWGExTUP6mmAREzUjJMyraTw+v0gIFkg79O2n4vB+sFCGFotNJDZmzLBq
	zRrvz8LlbyhV0B23o4xfY8IhKemDS4PhfuvwHVFa7vnvtmtR3ogzv5BaK+Uz4v5259/gJyhiPFfe2
	POQglUT8EA3VZE9iMKNrdmKDSdBWwlTnMkrKMJtO3iNF8yAyh3SECHivzDZ3AzEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6TE-0000000GXf6-3kFh;
	Fri, 13 Sep 2024 15:36:21 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 5/5] um: Set HAVE_EFFICIENT_UNALIGNED_ACCESS for x86
Date: Fri, 13 Sep 2024 15:36:02 +0200
Message-ID: <20240913133602.963167-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913133602.963167-1-benjamin@sipsolutions.net>
References: <20240913133602.963167-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_063623_416898_84BCCDA3 
X-CRM114-Status: UNSURE (   6.98  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The x86 port of UM has efficient unaligned access. Set the option as it
is appropriate and will e.g. cause UBSAN to not enable unaligned memory
access checking by default.
---
 arch/x86/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 186f13268401..dc56c608ce69 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -10,6 +10,7 @@ config UML_X86
 	def_bool y
 	select ARCH_BINFMT_ELF_EXTRA_PHDRS if X86_32
 	select DCACHE_WORD_ACCESS
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
-- 
2.46.0


