Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD039CF9C6B
	for <linux-um@archiver.kernel.org>; Tue, 24 Sep 2024 11:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uesUgXKcuD6/H4Y+YFlZ813Zr2o+1Hc2ZY8mqB7xfQs=; b=tv+lardXYF+Lso+skzxf3RgJXR
	F///vqAIyXRpwmueFtx2ClnBdRXIhkab64JfPMWHdcSW1ofFPBaYLVGz8CTKuc99Ex1VcZIIjY5nb
	5KPSqyJzp4u4yvIsSwVOp5F2I13iBdYfgSiqZuMo7L41Z/8tblKlRKvpsfITd8PTWvcYd8g1HEGnP
	befnFmVE9Lg4/3HqSSXxhgXV+GN0lao2cgz1ggvr+yn7jdTvnINel/ue/PeSroIggWnsBWlM8InKD
	xsYeTVe2P9DH2nIVFRQ5uJdVqp1gtI78oCFp+uV/vVObugOxj02NsnADcJBXvjbkXy3ErxfEQrcEa
	zGaxZ7bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st3pg-00000002BEQ-05kx;
	Tue, 24 Sep 2024 11:35:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st3nl-00000002AjK-0hwx
	for linux-um@lists.infradead.org;
	Tue, 24 Sep 2024 11:33:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 919755C5B3F;
	Tue, 24 Sep 2024 11:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89667C4CEC4;
	Tue, 24 Sep 2024 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727177632;
	bh=8G/AwMuPFWeIfpDvKPSLumJJ4v+oa4GpZ94o+TWeUa4=;
	h=From:To:Cc:Subject:Date:From;
	b=jnLoO4kMy2kpBEq5dzngf4PuSKwwF/MATTPFjp3zATglpp3GTf4B9Eo/u7tereUIH
	 7NrK9byrODwHzldZKzp+0n/GWqFoRgg2+Nm3SYYKupLclCWACKQTOPaMdgPEfr1X9V
	 2FI6ZEMuMZXTust9I8ZSeO3l8KgUHdGf9wf6nroGVlORN8pwnrzsfN9yUWM8EB2p8Q
	 GR5Dv9a3GlJjmI7PwW3N9O4TRM1cy2b+WvaaVn62gdtxRfGGNh90LLk/qZaor+uK1Y
	 m+XgfzbTjZx+DvPvpbmaaTfshhnxEyGSqe8pe2x5alOFK/V16tK7BP106/6ufvDt5L
	 mf9fqzvs5AQ4Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Ignat Korchagin <ignat@cloudflare.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: remove dependency on undefined CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
Date: Tue, 24 Sep 2024 20:33:40 +0900
Message-ID: <20240924113342.32530-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_043353_318786_D5BB984E 
X-CRM114-Status: UNSURE (   9.97  )
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

CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS is not defined anywhere.

In the submitted patch set [1], the first patch "um/kconfig: introduce
CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS" was not applied.

Only 2/3 and 3/3 were applied, which are now:

 - 730586ff7fad ("um: Allow static linking for non-glibc implementations")
 - 5e1121cd43d4 ("um: Some fixes to build UML with musl")

Given that nobody has noticed the missing first patch for many years,
it seems it was unnecessary.

[1]: https://lore.kernel.org/lkml/20200719210222.2811-1-ignat@cloudflare.com/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/um/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index dca84fd6d00a..71b592b49240 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -95,7 +95,7 @@ config MAY_HAVE_RUNTIME_DEPS
 
 config STATIC_LINK
 	bool "Force a static link"
-	depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || !MAY_HAVE_RUNTIME_DEPS
+	depends on !MAY_HAVE_RUNTIME_DEPS
 	help
 	  This option gives you the ability to force a static link of UML.
 	  Normally, UML is linked as a shared binary.  This is inconvenient for
-- 
2.43.0


