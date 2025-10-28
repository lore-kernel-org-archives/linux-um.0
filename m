Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D14CCF9E0
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ooKBC1eDKfdKcleVvvkixZdpBL8Ich2YbLbfX/B4glQ=; b=iiPxCsPJOx8utKRY5uK3702RbU
	GdSut9Z+Bpz5qBcX9QNYKC9sT5bFUi3F0PIBBh45DUY2GojbIBnKOsu+oNc9panQEl2JzcTzjGptC
	DW9oB5hRUTXJgmTbO1eJWCYUTFO4zRVXSV1dg5aXr0Y9QBJv54e562SeSxv+BuCiDhUfQYT7dCdjO
	D1zcd0x8cieHn2+ZeJiQnijmrdM4RUOG/lwuhpGm1S/Ew08Awx8WplPkWlpjo1LX9E7Ehg7WgJ8Xz
	1lw5dHj6ZPVfH3G5KC/dLVV8ORzxg+uDt0kd2B01Y1OmK7uUKIcMOAJE7+8mwRQUstQbVvAib0Nok
	JT29FHLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpT-0000000Fd0c-2Ss3;
	Tue, 28 Oct 2025 09:17:23 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpR-0000000Fcys-1XOo
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643037;
	bh=pLpK9WMmHxQL+UmXL2BRNL9YHlr3HJAmGpPpWZh9za0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U+a6P211/4XvUxWAKsYQOUFks4HNaWzQk8OLSQf9m41OMxtrAQAM4Bw89Ces0WUiX
	 v0AHKlr7R/J5zIR02pXLsR95jwlpU7cs9/lmyuvXp6pFW5X9JIFdzeidNG9xyOlrHO
	 2uNN9h3tYOgq87JRV/pzbYC8noegWMFq7VlBTxdE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:38 +0100
Subject: [PATCH 03/10] um: Split out default elf_aux_hwcap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-3-e930063eff5f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=941;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pLpK9WMmHxQL+UmXL2BRNL9YHlr3HJAmGpPpWZh9za0=;
 b=O5gJ+jOwEsAHrk5KZPP4TwQau/fdz95vgKIKxfOYVp6/PV/ok0lwndsYaEsJfWY4HcGigVgsg
 LyWjDLG7c/TBFz9ODtVE6y69f4yeLZPtk2aonTCktjVxwFlAwClOMI2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021721_563503_5CA912D2 
X-CRM114-Status: UNSURE (   8.51  )
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

Setting all auxiliary vector values to default values if one of them
was not provided by the host will discard perfectly fine values.

Remove the elf_aux_platform fallback from the vDSO ones.
As zero is the correct fallback anyways, don't create a new conditional.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/os-Linux/elf_aux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index 4aadb9ea5ae3..9ee0e3199790 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -62,11 +62,9 @@ __init void scan_elf_aux( char **envp)
 		}
 	}
 	if ( ! __kernel_vsyscall || ! vsyscall_ehdr ||
-	     ! elf_aux_hwcap ||
 	     ! page_size || (vsyscall_ehdr % page_size) ) {
 		__kernel_vsyscall = 0;
 		vsyscall_ehdr = 0;
-		elf_aux_hwcap = 0;
 	}
 	else {
 		vsyscall_end = vsyscall_ehdr + page_size;

-- 
2.51.1.dirty


