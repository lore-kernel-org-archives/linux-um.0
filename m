Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E946CCF9E0
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r+OpakVxPJ/8rFYZ6shm+dgcRKRinbxn3aHYzX6Nx9A=; b=bMIDF9minDbJMD9zcbVogCtRyB
	shm27dQCOTKE1x52CnbokqYKTN16L0K0q2mG+6WDooDf+bHynj5t2x6IXfx6AevE4UbpcLyF4Sqgm
	sdhpUYzYlAmHc6Yzk/2mQJbg+Q+iDCguP2XiH28ojfOGc2alKyfnBGTYAeHzZ3uKlPekHwDC52ymz
	J2ZiuWThmUI6ASVmdac/FJ5sPy+de5jsnLQQ66hVVh7ekPl/z+Sj0hncNOKfNH91EQ3JHkx9RR1rj
	afta38rOQtf8y/iuzxn08lZl6NEI3YiaQZWomPUpKmIVupj+DerJRgf6/OzgHLSwj7t+F7VfSAq1A
	QmkmTp9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpd-0000000FdA8-0DXJ;
	Tue, 28 Oct 2025 09:17:33 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpV-0000000Fd1D-3gRX
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643039;
	bh=QvY+nAXDRHky/oaQZhIuoK3hf3WfhaB7cgzN/dQrG7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EMVGtZMPhsecf5rpkJJ/jcc3uyvDjTFHD2vNe/tl526UmuYjZKm36042T/jZYyorp
	 fvLPcNE5mwYXs0SzI2Et9znl+dcWpVVVSfbmN7Bq3fMSrcw4jQr2MMgH6IjpcKI0z6
	 1x3jeHenNrFto9cZMgy3jsqz9/MfdcOnj4CBY3Mg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:44 +0100
Subject: [PATCH 09/10] x86/um: Remove FIXADDR_USER_START and
 FIXADDR_USE_END
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-9-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1070;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QvY+nAXDRHky/oaQZhIuoK3hf3WfhaB7cgzN/dQrG7M=;
 b=6eLwZ6/9TeBOy4ZjspiFcrQRDfICig8yzA6Y3xnYNYR2RoI6gjbrzGzbn6VKROBqqC7L1VjTm
 x5TBTjM7lAGDRSthAoXmnP69TGoARREVZ8AWHbT3bsy56gshRzuxU42
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021726_094140_0881F5E3 
X-CRM114-Status: UNSURE (   6.89  )
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

There are no users left.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/asm/elf.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 8d7df4684c38..fdd5a612f678 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -72,10 +72,6 @@ extern char * elf_aux_platform;
 #define ELF_PLATFORM_FALLBACK "i586"
 #define ELF_PLATFORM (elf_aux_platform ?: ELF_PLATFORM_FALLBACK)
 
-/* No user-accessible fixmap addresses, i.e. vsyscall */
-#define FIXADDR_USER_START      0
-#define FIXADDR_USER_END        0
-
 #else
 
 /* x86-64 relocation types, taken from asm-x86_64/elf.h */
@@ -157,10 +153,6 @@ extern char * elf_aux_platform;
 
 #define ELF_PLATFORM "x86_64"
 
-/* No user-accessible fixmap addresses, i.e. vsyscall */
-#define FIXADDR_USER_START      0
-#define FIXADDR_USER_END        0
-
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,

-- 
2.51.1.dirty


