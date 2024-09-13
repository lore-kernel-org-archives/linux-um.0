Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AE4FA3758
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1FuKiPSld/oYv//xOISSS40HvaDisvjXvuuK86xHqs=; b=EUOrDUNPBNHPOpgEArY/Bu5UQK
	gJ1gu3ZalF4OZdZW0taNfMqjrmC6ACqz5DnJkNfHX56QMCsDmY8KKyDGoLETw4zNLxqUDaglrJ1rr
	yPdRH6cC7exr9UycbvdQxL+fqWbjlXQJq35Emmn5YzQwqu+Qr8qPyZF1B5BBjx/HZA2wgs+jdaS6g
	tncKWv1x/j0ptxAEcFWPDQ3HT976M9O2eZbCGDMYJZwlzVGKLnbYYRIwgrjTDxcoFdugnSl8CnsbS
	anDs175zH0YoQuqxAs3cwOufxX8gY1wsX8srIDO7+5GVyZrle0rnDnuf/RPiW7MnoGf6ozk38cReI
	0TQaXqNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6c8-0000000G4rk-1wYh;
	Fri, 13 Sep 2024 13:45:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6c6-0000000G4pj-0i0L
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J1FuKiPSld/oYv//xOISSS40HvaDisvjXvuuK86xHqs=;
	t=1726235129; x=1727444729; b=BPNuy5GUgukFmaDlOGsiOT5euh18qwQPZxWSCSjXXfUUgVN
	LgKNmhjuiPtsS/12SaN6jm5UU05zvJzLS1KttZDBqg0ejjXefDgMtLtutKxbaUMQwcgi14ruPNV8I
	SvSeUtip6TsL/9j4hTJBHtyO8iTdS5QKI9BoekWvB2kUAxPhUDj2w9Ox8MIuyRtDQgmhsXrCqF1YT
	w0S35vVYbsT7YBzDekQaNDvfwmwb6kDe4dbtkCcL6COG7pnpms3dYzZttmc+hUWtnvDQkLlJejdpx
	ld8PkxX0Pm2uml9ArH/m+VGscV2/makOwt6eIe5qMrS0yjKT1RyPvzxeWz+ySnsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6c3-0000000GZ3W-3rLi;
	Fri, 13 Sep 2024 15:45:28 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 5/5] um: Set HAVE_EFFICIENT_UNALIGNED_ACCESS for x86
Date: Fri, 13 Sep 2024 15:44:42 +0200
Message-ID: <20240913134442.967599-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913134442.967599-1-benjamin@sipsolutions.net>
References: <20240913134442.967599-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064530_242158_FD332271 
X-CRM114-Status: UNSURE (   7.15  )
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

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
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


