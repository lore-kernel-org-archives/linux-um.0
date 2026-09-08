Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC024C79FAB
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTryvsBgAeqTDNlupTdhz6+byj4x0uN8hxYjIi8mWPU=; b=zB6mN7hpsLXwqCkJkIx5eXTKVb
	TBr3Tbnq1rSdx9CV2wsEuKdaen3vJmy6rAWbfK2FP63YGpO4VjcV0BAzznxwd80GHGKfa1oLEWOOl
	nuRwDZHplUHmTG3lBanjqJW4H6majQDrGVx5s2ApqZAGmIoc5S1iP52KrhthNZR7Xwn0ILB2Agooz
	jVTZaH+zjOttxU6upPt36z4lqRBILJGRVbSAsB0WuxBa1AWPckaaLgc8yNfI1jSP362KCnkAxSJmp
	e7DTxgdUrnloDFu6lJ2WVVjG9tPm+9hhlbW/9GuLMyS/LG9fgYiYmpWvy8O2fvWR1gw1QFUSIRTVe
	1oMpVPJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3pP8-0000000893t-1VMh;
	Tue, 08 Sep 2026 06:34:02 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3pOz-000000088tD-1G8x;
	Tue, 08 Sep 2026 06:33:56 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTryvsBgAeqTDNlupTdhz6+byj4x0uN8hxYjIi8mWPU=;
	b=CwOxcB8AhS+rAzoxJxOQZHdTCbx79N6KAe69evSjNQbl8+rQOeBnH057j6GmLbV1DALhq8
	17U86cF62BuTdyueeDeto2D3eKopssoZOXhfcShRfEm5vXV6EqTT598jVyGbc2eORkyLVh
	OrwoiGkQRnDZ5E3ZEV6tw1/gABJPNjg4OfwRNlUx3ukssHhmiUBD9qEjMNgBfiYtN8PegH
	fJT8dIULNkNCSoAbP1VkL7AglDnc0gE8QsTSkJtq+4VoaJqGXcwtWw3SUrOnTednE0pAqq
	eJlyWNdWyLf6mcTMJcSduvMoo3qm72MxPilwuvS8hVqXRSHO5+8hOKLulZ6+Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTryvsBgAeqTDNlupTdhz6+byj4x0uN8hxYjIi8mWPU=;
	b=UvUYKzc74oAN8gP1sKHkjA19TUNUTqCMuc0TKrdtCmkCKri8UrtRvdSUSmYYYqwSID6op/
	x/iNcRKTPUHvcBDw==
Date: Tue, 08 Sep 2026 08:33:38 +0200
Subject: [PATCH v5 04/24] arm64: elf: Move relocation constants to UAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-4-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=4332;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1i3Et1Jffcz0JOiDRayZilcvn94+w8pBUDpHzT1KG5A=;
 b=gk9oLI1obuvHKDYtmwIh7hRv/wNktDBEtLCnmMT6kMIL5ciJHyu+C7IEaeVwMOyG2DE4YvlNZ
 Q87Mb3y4KJ2C8RfQ2jmI4dzP+9h+ated8T54tLF6WOAYZo1VDmVkg+O
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_233353_480087_EE6507B5 
X-CRM114-Status: GOOD (  11.14  )
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

These constants are useful for cross-platform userspace, for example to
process ELF files during kernel cross-compilation.

Move them from the kernel-private architecture-specific header to the UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/elf.h | 54 --------------------------------------------
 include/uapi/linux/elf-r.h   | 52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index cfdf4c5ac08b..43f3763807a2 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -13,60 +13,6 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 
-/*
- * AArch64 static relocation types.
- */
-
-/* Miscellaneous. */
-#define R_AARCH64_NONE			256
-
-/* Data. */
-#define R_AARCH64_ABS64			257
-#define R_AARCH64_ABS32			258
-#define R_AARCH64_ABS16			259
-#define R_AARCH64_PREL64		260
-#define R_AARCH64_PREL32		261
-#define R_AARCH64_PREL16		262
-
-/* Instructions. */
-#define R_AARCH64_MOVW_UABS_G0		263
-#define R_AARCH64_MOVW_UABS_G0_NC	264
-#define R_AARCH64_MOVW_UABS_G1		265
-#define R_AARCH64_MOVW_UABS_G1_NC	266
-#define R_AARCH64_MOVW_UABS_G2		267
-#define R_AARCH64_MOVW_UABS_G2_NC	268
-#define R_AARCH64_MOVW_UABS_G3		269
-
-#define R_AARCH64_MOVW_SABS_G0		270
-#define R_AARCH64_MOVW_SABS_G1		271
-#define R_AARCH64_MOVW_SABS_G2		272
-
-#define R_AARCH64_LD_PREL_LO19		273
-#define R_AARCH64_ADR_PREL_LO21		274
-#define R_AARCH64_ADR_PREL_PG_HI21	275
-#define R_AARCH64_ADR_PREL_PG_HI21_NC	276
-#define R_AARCH64_ADD_ABS_LO12_NC	277
-#define R_AARCH64_LDST8_ABS_LO12_NC	278
-
-#define R_AARCH64_TSTBR14		279
-#define R_AARCH64_CONDBR19		280
-#define R_AARCH64_JUMP26		282
-#define R_AARCH64_CALL26		283
-#define R_AARCH64_LDST16_ABS_LO12_NC	284
-#define R_AARCH64_LDST32_ABS_LO12_NC	285
-#define R_AARCH64_LDST64_ABS_LO12_NC	286
-#define R_AARCH64_LDST128_ABS_LO12_NC	299
-
-#define R_AARCH64_MOVW_PREL_G0		287
-#define R_AARCH64_MOVW_PREL_G0_NC	288
-#define R_AARCH64_MOVW_PREL_G1		289
-#define R_AARCH64_MOVW_PREL_G1_NC	290
-#define R_AARCH64_MOVW_PREL_G2		291
-#define R_AARCH64_MOVW_PREL_G2_NC	292
-#define R_AARCH64_MOVW_PREL_G3		293
-
-#define R_AARCH64_RELATIVE		1027
-
 /*
  * These are used to set parameters in the core dumps.
  */
diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 001884641e77..cf931fc05afa 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -61,4 +61,56 @@
 #define R_ARM_THM_MOVW_PREL_NC	49
 #define R_ARM_THM_MOVT_PREL	50
 
+/* AArch64 static relocation types */
+
+/* Miscellaneous. */
+#define R_AARCH64_NONE			256
+
+/* Data. */
+#define R_AARCH64_ABS64			257
+#define R_AARCH64_ABS32			258
+#define R_AARCH64_ABS16			259
+#define R_AARCH64_PREL64		260
+#define R_AARCH64_PREL32		261
+#define R_AARCH64_PREL16		262
+
+/* Instructions. */
+#define R_AARCH64_MOVW_UABS_G0		263
+#define R_AARCH64_MOVW_UABS_G0_NC	264
+#define R_AARCH64_MOVW_UABS_G1		265
+#define R_AARCH64_MOVW_UABS_G1_NC	266
+#define R_AARCH64_MOVW_UABS_G2		267
+#define R_AARCH64_MOVW_UABS_G2_NC	268
+#define R_AARCH64_MOVW_UABS_G3		269
+
+#define R_AARCH64_MOVW_SABS_G0		270
+#define R_AARCH64_MOVW_SABS_G1		271
+#define R_AARCH64_MOVW_SABS_G2		272
+
+#define R_AARCH64_LD_PREL_LO19		273
+#define R_AARCH64_ADR_PREL_LO21		274
+#define R_AARCH64_ADR_PREL_PG_HI21	275
+#define R_AARCH64_ADR_PREL_PG_HI21_NC	276
+#define R_AARCH64_ADD_ABS_LO12_NC	277
+#define R_AARCH64_LDST8_ABS_LO12_NC	278
+
+#define R_AARCH64_TSTBR14		279
+#define R_AARCH64_CONDBR19		280
+#define R_AARCH64_JUMP26		282
+#define R_AARCH64_CALL26		283
+#define R_AARCH64_LDST16_ABS_LO12_NC	284
+#define R_AARCH64_LDST32_ABS_LO12_NC	285
+#define R_AARCH64_LDST64_ABS_LO12_NC	286
+#define R_AARCH64_LDST128_ABS_LO12_NC	299
+
+#define R_AARCH64_MOVW_PREL_G0		287
+#define R_AARCH64_MOVW_PREL_G0_NC	288
+#define R_AARCH64_MOVW_PREL_G1		289
+#define R_AARCH64_MOVW_PREL_G1_NC	290
+#define R_AARCH64_MOVW_PREL_G2		291
+#define R_AARCH64_MOVW_PREL_G2_NC	292
+#define R_AARCH64_MOVW_PREL_G3		293
+
+#define R_AARCH64_RELATIVE		1027
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.55.0


