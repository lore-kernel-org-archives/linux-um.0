Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1EDCCD1BF
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EiHGljfTW0x0l5Vc7RJb/kYc0HBlu5rG5oIX59OO+Bs=; b=hZ4sP19pSevZ2zTTKDysHmcJPx
	yDlEVbRqFzqCXCLuXUO69bJ2f02lj6FbjZnzAAlo9k5gE5/zULaPBzr1kBuY5feNG+mdvPfbAoVke
	B/hizug5hIA2Elq3DkW7lYTHc3lJvMdZD1VLIJtCAdOpykqXhjRDPDzlK3nEogDXCCjhzfZj5QKwb
	i40ectGZQC0MGPoHgXHiDn+c/N7QRwN25tRJ86XTjfkLwC/4D7AbtYL1bRrjgbmwHgPqD4hWgdC8+
	he5IjH72AYcVl31wJDyN74UVuVjSCylkDLmpJQFaTdcBvOYoEvbf9MCVZmCH7fS7/Lw6/q7nelXUv
	QdQmNPMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpY-0000000Fd4Q-2HfO;
	Tue, 28 Oct 2025 09:17:28 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpS-0000000Fcz6-22Ry
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643038;
	bh=YqbPywoFtgBAhJ6lpmIQMDms46YwcEmQamcwJS8MPbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CE5XHoGRDOoEaApc47qhv03YYfsONq7VVJBZYwGRaTvmwBAKafmHL//ik2DKXPkzf
	 gmwMlPdlLoBW9Pslfdm3bV3rdqFBhSGicrpArS95CHSqRb+3j7c2ofH6sBIUnJNaYX
	 IC6g6scpP8vwjDCqa6dH6izhO9s5oDYMgFcnwOeA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:37 +0100
Subject: [PATCH 02/10] x86/um: Move ELF_PLATFORM fallback to x86-specific
 code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-2-e930063eff5f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1152;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YqbPywoFtgBAhJ6lpmIQMDms46YwcEmQamcwJS8MPbA=;
 b=E3/22t0NPJGkRhdvBg2Xoo5C1xY8YBwldw9w21HcwS212L3vjfQkTyETGfgzLIK9fKxWFFmwW
 ah2FjRnmpmfB6dME8TsAbEtIgVmUPZDKctooDkcmJY7upgfRJ4JUimC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021722_687745_85C274C4 
X-CRM114-Status: UNSURE (   8.08  )
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

The generic UM code should not have references to x86-specific value.

Move the fallback into the x86-specific header.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/os-Linux/elf_aux.c | 3 ---
 arch/x86/um/asm/elf.h      | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index a62fe39e85c9..4aadb9ea5ae3 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -71,7 +71,4 @@ __init void scan_elf_aux( char **envp)
 	else {
 		vsyscall_end = vsyscall_ehdr + page_size;
 	}
-
-	if (!elf_aux_platform)
-		elf_aux_platform = "i586";
 }
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 62ed5d68a978..e7a045e01471 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -69,7 +69,8 @@
 } while (0);
 
 extern char * elf_aux_platform;
-#define ELF_PLATFORM (elf_aux_platform)
+#define ELF_PLATFORM_FALLBACK "i586"
+#define ELF_PLATFORM (elf_aux_platform ?: ELF_PLATFORM_FALLBACK)
 
 extern unsigned long vsyscall_ehdr;
 extern unsigned long vsyscall_end;

-- 
2.51.1.dirty


