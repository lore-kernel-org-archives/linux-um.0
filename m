Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7B6CCA476
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaOiceD8AzIEGCDQ5kBv+r0GHHl/O1zjqW5YawrIHbs=; b=M+J9doAnmQzbC45Cp9exrapkhS
	qC04IXF3I+xUA1D/jTu4wjq/wpO7UIcE1s3UmtMIZH+z5zkVmWZKY5K8ErpFofH1B4zXlyzq7UORT
	WWzoi0AsPxuyoKZtdgtjHzbdChrLzTRyqI6qvAlFS89Yl6g2m5LwLfp5+4A7RRNCcvk4PUo412oKL
	vlKAcfP8AP6lkukMzz3J0PbG12P89zrheKZPpQeRT+OX13SC6Uw0aRnyfVeG+8lbV8GHrXJbl2kk0
	U0mfPpRZvxbV/ibjtxmzuKejRsnvz3vY/TC1ZM4HKlFNqGxcJGS1YvSUneooMeTa+Z5YM4RrcYH2R
	9UIxAq4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fym-0000000Cv9X-1Qui;
	Mon, 13 Oct 2025 10:40:36 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fyj-0000000Cv58-3k4c
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 10:40:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352024;
	bh=fzbFR5HRnGrKHRndRJ8HHP3IHBABgYcit+jrA4C+kmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C/IUQwJRljYYCG64In1mr1nBxn9Tmc/5hOpZiMh09bqkYMVVIFFirEqV+s66BiwcS
	 /PZlG7UCuvio8IhpNmitlH2pvfLYu+7G3KxBZHxqATtPFcD+f1Jh0w84XMh4K6COw1
	 SW+LaqUQkqMUtV1Isj6A3RRL/FzEElq3Vsf/0rI0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 12:40:21 +0200
Subject: [PATCH 4/4] x86/um/vdso: Drop VDSO64-y from Makefile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-uml-vdso-cleanup-v1-4-a079c7adcc69@weissschuh.net>
References: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
In-Reply-To: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=749;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fzbFR5HRnGrKHRndRJ8HHP3IHBABgYcit+jrA4C+kmQ=;
 b=oTuqtMKWBTQHe1Og6mGe7pRgLqIMi3izMEb85Zh1vxzG84LlxI8l3H7Rp3s14EZTLfbcb5KzH
 H3XYP1eH6S6B3wX0SQEBZCcMsonIIQAMT74yuPXPlK5isdMR19SfGO3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_034034_076210_C90A0ECF 
X-CRM114-Status: UNSURE (   7.67  )
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

This symbol is unnecessary, remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/vdso/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 7478d11dacb7..8a7c8b37cb6e 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,16 +3,13 @@
 # Building vDSO images for x86.
 #
 
-VDSO64-y		:= y
-
-vdso-install-$(VDSO64-y)	+= vdso.so
-
+vdso-install-y += vdso.so
 
 # files to link into the vdso
 vobjs-y := vdso-note.o um_vdso.o
 
 # files to link into kernel
-obj-$(VDSO64-y)			+= vdso.o vma.o
+obj-y += vdso.o vma.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 

-- 
2.51.0


