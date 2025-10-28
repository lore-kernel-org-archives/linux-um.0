Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D304CCCF9EF
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2l+TS1LMPx7p4hg9dw/BzaoTvSuCmUu6gVv2GXD+OOk=; b=tLjWRJEgiBRCatc7mdgjtg1Flh
	eUM9EQxgTDfKHXQm2QBCQqK8QQn1S9JKyUZWa7T3yg9XmC9XZ6sXYiYc8bGdLKxDet+3sh5DWT67Z
	1aCs/LNrP126ujXB9h3zRorKhwrUJxJOsxV0+ICfZ374zV7lilA+vK8cxuDUCTc+myFqFuLqq3Zr1
	cYvRxw5TFt8oyeYQmVcrd8gIhuVkxn4z8Fd5gRWp22Cen2vl0AfbjAxa8UNbCzgv+372PUduDbTSJ
	5I/8ZEi2iK3hXlR9/n+tHdtGmgqviz0ZF9QMZcq9S+66qYPw4SR5IuSQngqkUDSJypfGTmyV4gQ6c
	U6t2FHIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpZ-0000000Fd4o-2Kwf;
	Tue, 28 Oct 2025 09:17:29 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpT-0000000Fczl-0RCi
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643037;
	bh=wVCfXhX9gFOuIM1xQSYX/MuDADsnjta9ksjbCV8j1aI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A7PL0Uetb0vlc4ijKa9jjavmz5+neq80T0IwIUe00l43iq8uhX14/EuBt+ppWAmDl
	 KUf0q8mnw6o2DB3eCoB98duMuZSTfwBSxMkqpziZzyXFjCEzZw2205LxAL7wXOtD3W
	 32oxXXyxHPoHZBqibMOS/9ma5dHYKOaK9T1jjWzo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:36 +0100
Subject: [PATCH 01/10] um: Split out default elf_aux_platform
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-1-e930063eff5f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1040;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wVCfXhX9gFOuIM1xQSYX/MuDADsnjta9ksjbCV8j1aI=;
 b=LhVFRghTmmP714gZhBulmaoihKd0f0VHzMs3eM+Bz2Cmqsv3SkDHbn+Naifonr7vh0qOBz1qm
 +z67DoHCAyeBU8AmUiQXuyNKzejI1lEP2jTG2CUIC4+3TqOBckzoq7J
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021723_298367_D4D42C98 
X-CRM114-Status: UNSURE (   9.18  )
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

Move the elf_aux_platform fallback to its own conditional.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/os-Linux/elf_aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index 0a0f91cf4d6d..a62fe39e85c9 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -62,14 +62,16 @@ __init void scan_elf_aux( char **envp)
 		}
 	}
 	if ( ! __kernel_vsyscall || ! vsyscall_ehdr ||
-	     ! elf_aux_hwcap || ! elf_aux_platform ||
+	     ! elf_aux_hwcap ||
 	     ! page_size || (vsyscall_ehdr % page_size) ) {
 		__kernel_vsyscall = 0;
 		vsyscall_ehdr = 0;
 		elf_aux_hwcap = 0;
-		elf_aux_platform = "i586";
 	}
 	else {
 		vsyscall_end = vsyscall_ehdr + page_size;
 	}
+
+	if (!elf_aux_platform)
+		elf_aux_platform = "i586";
 }

-- 
2.51.1.dirty


