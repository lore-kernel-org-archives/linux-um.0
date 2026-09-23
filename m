Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F00C9830E
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mG7Tui12WB7XiErbHDxjeogMjrlKI9cW2L0WpkAXDmg=; b=mLCmM2a6LvxaTsXn2CC8q21jIV
	IGFl6BQLyFKhwYAl+mLAvgm5nBijlCTkwOIK5W/3Y4vDGrr2J+4NTlEGM9X8iMtENBmnIqXyHYu6t
	1AG304HKNfqavFaTnyt9x6yyNi7DKEQ4C5o96jdtLXGdcC7U5H7rashF1MKY5pxFrf91jSSDo2tWw
	OoGE4LfBzOdZvckkhdYkOHnQx1OhWt6IsrDwavbH3MBg85k9ohReFZDUGtUpoPKopH+FPk50kh708
	7A6U5f7yxqqa4ztkmJYpMUkBZJeGM5o3MAceYcX6DhdJUabU9SWywCXx7K7IsCPq8kbFD/Y4pd3qn
	FXJOZaJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9P0X-00000008kuI-1hV6;
	Wed, 23 Sep 2026 15:35:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9P0U-00000008krp-0eNd
	for linux-um@bombadil.infradead.org;
	Wed, 23 Sep 2026 15:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mG7Tui12WB7XiErbHDxjeogMjrlKI9cW2L0WpkAXDmg=; b=GutcYIge+gJB7wZ5/6UMSJXyKt
	0HCZo+Xt0ClsZKYBpTQyXXXguqWMkGSq2v0N4JPT2tJAVGzbCey6httFY3YLVBE/63KhDlrZMuFTC
	FQIERhageL8BubeCjqy1I7vdqghLy3/JeAaziIR3fIrd+VWeKY0WBwn1FLLb5deVswa6nBCBZ56rn
	Lg8cl5KOruddt0npYfI5/bDxKGSMD03Lk0tWDnyK1gPJhRM0KpfZR6uzW33MKSWrVZjw0LcETeLdE
	tn7ZOQgO/Xk/JT6v1AecjAi62w2Uo863oyBA6IwyVvSffMsOs9EDHMSuPHGN+gBgUFMHy8cAKPo/Q
	SBoeC9qQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9P0R-0000000Ewgy-0a6b
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 15:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mG7Tui12WB7XiErbHDxjeogMjrlKI9cW2L0WpkAXDmg=;
	t=1790177735; x=1791387335; b=WNpF9Wu7ay5F3q9Oa/qJg94iX7D4bfDlQirCuvunMouG5iY
	1GhZthYjcSDmlwneaO1zi4jAWjvkIEQp7Ze/ZlaG8Phrl/MdQ2WFEW8Je0B6L0NrIwnTeAO6M232e
	WrgytXQs14vrZ1T5YH2DzSyxFUIMCMyWBazo26aRd+fR9lgeMSj0VezvZidaoEW91BXUvnX7HMqCP
	fzzihO6R3aP75VnezXjXnqhJKCQ8uwFPXvlPj6CN5FPHr0RGNftWMlsvouX2dSa/ETVy4mmWkCDFi
	RhGgiIJ1oH7Avl+qW9/W9MzOb4eQ0hqEy6mjPRCxRWF0K1u8YDAEP4yk8fMiYExA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9P0L-000000083zz-1ITg;
	Wed, 23 Sep 2026 17:35:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] um: improve checking for --no-warn-rwx-segments
Date: Wed, 23 Sep 2026 17:34:32 +0200
Message-ID: <20260923173523.15f90065ca57.I3079cffd8db3a639e93c3e2624c61bbebadc3cbd@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923153523.987904-5-johannes@sipsolutions.net>
References: <20260923153523.987904-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_163535_503004_928FD0CA 
X-CRM114-Status: UNSURE (   8.82  )
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

Since LLVM=1 might end up using different linkers for
CC as linker and LD, use detect --no-warn-rwx-segments
support using CC.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 937639edc295..d930c5f25fb9 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -134,9 +134,10 @@ LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 # Avoid binutils 2.39+ warnings by marking the stack non-executable and
 # ignorning warnings for the kallsyms sections.
 LDFLAGS_EXECSTACK = -z noexecstack
-ifeq ($(CONFIG_LD_IS_BFD),y)
-LDFLAGS_EXECSTACK += $(call ld-option,--no-warn-rwx-segments)
-endif
+# check --no-warn-rwx-segments with CC-as-linker since that gets used
+# for vmlinux and is where we need the option, in particular with LLVM=1
+# it might be different links (ld.bfd vs. ld.lld)
+LDFLAGS_EXECSTACK += $(call try-run,$(CC) -Wl$(comma)--no-warn-rwx-segments -shared -x c /dev/null -o "$$TMP",--no-warn-rwx-segments)
 
 LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS) $(LDFLAGS_EXECSTACK),-Wl,$(opt))
 
-- 
2.55.0


