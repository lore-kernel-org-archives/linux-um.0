Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63C1CCD183
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t1mxEv6RpOJ9ToL71xyYV8XShcnXGEu8fegHnBhQtdA=; b=1jK74/YLMF5YzcIVLpaUYT/zYK
	Ec0ibjU0YFE9/qDcbrDmHLPnmF+4369rN2QweuZTHRlOMrk9+4nm9E4u91XllsDeoM0pOm/wUxLur
	fsbAL6Aapfzv9Usxc78slozxGoZ8ZGE9u8/cUWmOou6+p+S6gwpDIZsoDW0YgXwv6QolItazaaWHy
	c+CdL2QAbfXpsqjgAU1/Ac4VqQD126b3rHi9MvNux+HVZNY938/tgWUlUCf2EsBEt0U9vakpFMCfF
	wJ8Yi3VH2cA7iu6LDcPX/YJCK9AmNSEEFzLnnlc7SDJ3Mb0X7cSDBMZuJ0MbGUtxXK0XchMsWKaUN
	vdL55xqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fyg-0000000Cv6G-49HD;
	Mon, 13 Oct 2025 10:40:30 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fye-0000000Cv5B-3tkT
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 10:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352024;
	bh=4oJNqNidl2yJO66qwAhbfNuPC9Nd39kyLTxqx4jOV1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tbCze3m1twkQ3CIGnwhOAKKcmhdyw5pGuR9ZeUhD6owE3TbxlRc4J5m9FmzyVTHMd
	 BPTOxSPYW8VR6ytTBdgZ3pEX091qKTCLrZ0kZv7zTKihkmPc4pby51srDK5ISKQnL3
	 oQi+Pm+GE6oKBtJ2BKk7Vxo5Y7CQhMz/Gu2PLghY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 12:40:20 +0200
Subject: [PATCH 3/4] x86/um/vdso: Panic when vDSO can not be allocated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-uml-vdso-cleanup-v1-3-a079c7adcc69@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=1313;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4oJNqNidl2yJO66qwAhbfNuPC9Nd39kyLTxqx4jOV1A=;
 b=dNsqX7tCXD0nmEmuX7XmNq+Gkr9NBaN5EnQIDs+gLqoWtgE1rNz+qLBSnei8UgVgKXGPto8Dy
 IYjFqpjkVZFBrU9VGjsBxaJJKuax2gYGiMBQNCPudJPVIYB2ThM3N2l
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_034029_140122_C1A34DEF 
X-CRM114-Status: GOOD (  10.88  )
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

The vDSO address is added to the userspace auxiliary vectors even if the
vDSO was not allocated. When accessing the page, userspace processes
will crash.

Enforce that the allocation works.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/um/vdso/vma.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index dc8dfb2abd80..51a2b9f2eca9 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -10,7 +10,6 @@
 #include <asm/elf.h>
 #include <linux/init.h>
 
-static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
 static struct page *um_vdso;
 
@@ -25,17 +24,11 @@ static int __init init_vdso(void)
 
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
-		goto oom;
+		panic("Cannot allocate vdso\n");
 
 	copy_page(page_address(um_vdso), vdso_start);
 
 	return 0;
-
-oom:
-	printk(KERN_ERR "Cannot allocate vdso\n");
-	vdso_enabled = 0;
-
-	return -ENOMEM;
 }
 subsys_initcall(init_vdso);
 
@@ -48,9 +41,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		.pages = &um_vdso,
 	};
 
-	if (!vdso_enabled)
-		return 0;
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 

-- 
2.51.0


