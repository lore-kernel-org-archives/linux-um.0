Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F46F107761B
	for <linux-um@archiver.kernel.org>; Wed, 18 Mar 2026 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7zx4rBcbFiRvky88H5kjE+8013rEEc/aZGIe+DT4bEQ=; b=J0q3n43oiyiCItMWy0f1AOyQEh
	Kidu4IbhCrNe6GT7a5gMOblcatMSPhLtztnYc2obcDSG/D+0Ln1EA8E1t1MxSZhJulLYH3AkaMOYE
	wsfDZDdyi2dAtDoPEYjoZRe8DWpVX0WWcWTwlRV+S9Y9ilYawMw3PWaOz+DIFnhVwwY8kJtU92Okm
	d+D7xJQOexsq8F9hLBAnD9DF1eFAWP2MFBfWmPD0Ttt0rPMRzu+ErHLUs3E9NeEZVadXgB6+cnUzH
	h3t9y8VboGBC1AfWtQ5Scn01c70v2UaGu1XJFveD3Twye80STIUiSIBvf76lU+30MXbIoc26IYI/5
	XZrhgvkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2y3Q-00000009M2L-1YYQ;
	Wed, 18 Mar 2026 21:03:48 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2y3M-00000009M1n-3QSD
	for linux-um@lists.infradead.org;
	Wed, 18 Mar 2026 21:03:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773867818;
	bh=dfv/eQEp0mKrAhy6LpvP3IrZBed3OBDXNU823nBuSO8=;
	h=From:Date:Subject:To:Cc:From;
	b=lANBJ9ClLmfYvye1IvxnFclFgDmFKlVTDsmUjyjwmiVSpJBFB6w3fxAfJwWZTFmzi
	 gjPY3RC2CiE1y42NEpKhq5TjEAsG4sRrMJ88MXmTkR8G+d024OYxEiN+njfw81dEKh
	 RsknVzs8iJ/rKP6XH5lcbP7vWY8a/IhhUuM4RhV4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 18 Mar 2026 22:03:26 +0100
Subject: [PATCH] x86/um: fix vDSO installation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-um-vdso-install-v1-1-26a4ca5c4210@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBvQhP6uEi0kxxooC6ckiO6et
 PwW7z0gFJkE+uKBSImF95ChywKmxYaZkF02VKqqldEtXhsmJztykNOuKyrTkGq98502kKsjkuf
 7Pw7j+374qV73YQAAAA==
X-Change-ID: 20260318-um-vdso-install-037e08fdf913
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773867817; l=1573;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dfv/eQEp0mKrAhy6LpvP3IrZBed3OBDXNU823nBuSO8=;
 b=uHRZUwnETo1aGDc/MLYWeRufxaYvrzBgggbPKIENCMyYp7qlU2TqMsb30QQRVFqbdDsW1x7lS
 xmrhUYTSA3kDASJRubjYM+4a68tS4rkwSqyWuDcepViYyqOo4X6PBc0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_140345_006764_1EEC9528 
X-CRM114-Status: GOOD (  10.34  )
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

The generic vDSO installation logic used by 'make vdso_install' requires
that $(vdso-install-y) is defined by the top-level architecture Makefile
and that it contains a path relative to the root of the tree.
For UML neither of these is satisfied.

Move the definition of $(vdso-install-y) to a place which is included by
the arch/um/Makefile and use the full relative path.

Fixes: f1c2bb8b9964 ("um: implement a x86_64 vDSO")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Not sure about the Fixes: tag. This seems to have never worked before
for all kinds of reasons.
---
 arch/x86/Makefile.um      | 2 ++
 arch/x86/um/vdso/Makefile | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index c86cbd9cbba3..19c13afa474e 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -60,4 +60,6 @@ ELF_FORMAT := elf64-x86-64
 LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
+vdso-install-y += arch/x86/um/vdso/vdso.so.dbg
+
 endif
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 8a7c8b37cb6e..7664cbedbe30 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,8 +3,6 @@
 # Building vDSO images for x86.
 #
 
-vdso-install-y += vdso.so
-
 # files to link into the vdso
 vobjs-y := vdso-note.o um_vdso.o
 

---
base-commit: 3429028f9eb355654d81e02c22903e77075a4e8e
change-id: 20260318-um-vdso-install-037e08fdf913

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


