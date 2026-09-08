Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572C2C79FAA
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITX6vbZ0p2MNUnqySgiQU1yaeBX1Pv0fohxsnS17XIE=; b=UcFBvcFJ7945wCksl9dn+T1POV
	d4R5SeR8LyK2GUXHxzylCSllCKxGKfJ3kYrKBPJAoNrwRZgpFfwtiubjsgv5rz22wkiYzeFgasoUy
	CpBXmizPIBksw7vQSrgm8ddcguDHp8rBbCFAgaPoWEra9PrS7SaM18zpW+nZyGmDJfDv80PaU3mxD
	5M3RwVw3FRRYXujp1/sRSbjn2jbX6GBj6UxbkN5WELT/bSorvZu75vE0G1SkhmMunsVRgFl4vAAcd
	MsKkZMm7PyY9X5VLk1zwt3BPr5nzoMW+U09+Xc1Sq2KRl5/z1eKuhQftIXlS8CGI+rCTKBRKPtJgk
	Mj9tvf+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3pP7-0000000893F-3RSk;
	Tue, 08 Sep 2026 06:34:01 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3pOy-000000088sq-2NEZ;
	Tue, 08 Sep 2026 06:33:55 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITX6vbZ0p2MNUnqySgiQU1yaeBX1Pv0fohxsnS17XIE=;
	b=rfwyK8rjLPkePRrnJHe5/m9/qJsnrWMCt3iK+M7M5ZYc6dfObs52IIDnFx5QgND5xV+RSg
	DULbnxSrs1cNZLOgC5w74szhXRhwXueEKLWD5PiJIbFVmAO7uDHSPwLz9pK6DrIC85jwBv
	NptQJNDLTlAl0caYUrvufk5jk9bhHOty9MKSjt4bQXd4/hUZnyPvtRUw6CVU8HCzHPiKDf
	Qrx91oCLhunvM867s5Vs+oHAu9RifHTN2uGkz5Y7TRc6k2c42aM+pQ0MXz05XTOHWGO/tF
	rgfxs/zda+BfhYnlFo95QXEfk/RSRvCg32nIwzWZtUQue6L7jrsHr6BvZdL3SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITX6vbZ0p2MNUnqySgiQU1yaeBX1Pv0fohxsnS17XIE=;
	b=kmw243Q2lOefM6sErINOe0v2bdegFzSBOYOJ/mtefV8467qCIp/KHbzuaZEJV6LMACNvq/
	kbGYSfPlNIXmtvCA==
Date: Tue, 08 Sep 2026 08:33:36 +0200
Subject: [PATCH v5 02/24] x86/elf, um/x86/elf: Move relocation constants to
 UAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=5793;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=EP6eD/uZ0V4wHN9+/JxWHWsljJ+xT4xd0R266HOP2Mk=;
 b=9fiwRBRCJd/GEgS5mAJxYeP44dMtEzEA5a59lLmblClvso6Eb+4WwYMKSod5q7tvCst53OR2v
 u8IKRzDMhHhAzblZpImUk9ElKP8BMqVg+cBR+BubteVty4SyzNMiSs+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_233352_772364_A9B7C0C2 
X-CRM114-Status: GOOD (  11.68  )
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
 arch/x86/include/asm/elf.h | 33 ---------------------------------
 arch/x86/um/asm/elf.h      | 33 ---------------------------------
 include/uapi/linux/elf-r.h | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 66 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 4133c790e71a..ad84c0f60459 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -22,19 +22,6 @@ typedef struct user_i387_struct elf_fpregset_t;
 
 #ifdef __i386__
 
-#define R_386_NONE	0
-#define R_386_32	1
-#define R_386_PC32	2
-#define R_386_GOT32	3
-#define R_386_PLT32	4
-#define R_386_COPY	5
-#define R_386_GLOB_DAT	6
-#define R_386_JMP_SLOT	7
-#define R_386_RELATIVE	8
-#define R_386_GOTOFF	9
-#define R_386_GOTPC	10
-#define R_386_NUM	11
-
 /*
  * These are used to set parameters in the core dumps.
  */
@@ -44,26 +31,6 @@ typedef struct user_i387_struct elf_fpregset_t;
 
 #else
 
-/* x86-64 relocation types */
-#define R_X86_64_NONE		0	/* No reloc */
-#define R_X86_64_64		1	/* Direct 64 bit  */
-#define R_X86_64_PC32		2	/* PC relative 32 bit signed */
-#define R_X86_64_GOT32		3	/* 32 bit GOT entry */
-#define R_X86_64_PLT32		4	/* 32 bit PLT address */
-#define R_X86_64_COPY		5	/* Copy symbol at runtime */
-#define R_X86_64_GLOB_DAT	6	/* Create GOT entry */
-#define R_X86_64_JUMP_SLOT	7	/* Create PLT entry */
-#define R_X86_64_RELATIVE	8	/* Adjust by program base */
-#define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative
-					   offset to GOT */
-#define R_X86_64_32		10	/* Direct 32 bit zero extended */
-#define R_X86_64_32S		11	/* Direct 32 bit sign extended */
-#define R_X86_64_16		12	/* Direct 16 bit zero extended */
-#define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
-#define R_X86_64_8		14	/* Direct 8 bit sign extended  */
-#define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
-#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
-
 /*
  * These are used to set parameters in the core dumps.
  */
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 22d0111b543b..b768497d5ee1 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -12,19 +12,6 @@
 
 #ifdef CONFIG_X86_32
 
-#define R_386_NONE	0
-#define R_386_32	1
-#define R_386_PC32	2
-#define R_386_GOT32	3
-#define R_386_PLT32	4
-#define R_386_COPY	5
-#define R_386_GLOB_DAT	6
-#define R_386_JMP_SLOT	7
-#define R_386_RELATIVE	8
-#define R_386_GOTOFF	9
-#define R_386_GOTPC	10
-#define R_386_NUM	11
-
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
@@ -72,26 +59,6 @@
 
 #else
 
-/* x86-64 relocation types, taken from asm-x86_64/elf.h */
-#define R_X86_64_NONE		0	/* No reloc */
-#define R_X86_64_64		1	/* Direct 64 bit  */
-#define R_X86_64_PC32		2	/* PC relative 32 bit signed */
-#define R_X86_64_GOT32		3	/* 32 bit GOT entry */
-#define R_X86_64_PLT32		4	/* 32 bit PLT address */
-#define R_X86_64_COPY		5	/* Copy symbol at runtime */
-#define R_X86_64_GLOB_DAT	6	/* Create GOT entry */
-#define R_X86_64_JUMP_SLOT	7	/* Create PLT entry */
-#define R_X86_64_RELATIVE	8	/* Adjust by program base */
-#define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative
-					   offset to GOT */
-#define R_X86_64_32		10	/* Direct 32 bit zero extended */
-#define R_X86_64_32S		11	/* Direct 32 bit sign extended */
-#define R_X86_64_16		12	/* Direct 16 bit zero extended */
-#define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
-#define R_X86_64_8		14	/* Direct 8 bit sign extended  */
-#define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
-#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
-
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 2c382c8a4807..45a160ecf405 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -2,4 +2,38 @@
 #ifndef _UAPI_LINUX_ELF_R_H
 #define _UAPI_LINUX_ELF_R_H
 
+/* i386 relocation types */
+#define R_386_NONE	0
+#define R_386_32	1
+#define R_386_PC32	2
+#define R_386_GOT32	3
+#define R_386_PLT32	4
+#define R_386_COPY	5
+#define R_386_GLOB_DAT	6
+#define R_386_JMP_SLOT	7
+#define R_386_RELATIVE	8
+#define R_386_GOTOFF	9
+#define R_386_GOTPC	10
+#define R_386_NUM	11
+
+/* x86-64 relocation types */
+#define R_X86_64_NONE		0	/* No reloc */
+#define R_X86_64_64		1	/* Direct 64 bit  */
+#define R_X86_64_PC32		2	/* PC relative 32 bit signed */
+#define R_X86_64_GOT32		3	/* 32 bit GOT entry */
+#define R_X86_64_PLT32		4	/* 32 bit PLT address */
+#define R_X86_64_COPY		5	/* Copy symbol at runtime */
+#define R_X86_64_GLOB_DAT	6	/* Create GOT entry */
+#define R_X86_64_JUMP_SLOT	7	/* Create PLT entry */
+#define R_X86_64_RELATIVE	8	/* Adjust by program base */
+#define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative
+					   offset to GOT */
+#define R_X86_64_32		10	/* Direct 32 bit zero extended */
+#define R_X86_64_32S		11	/* Direct 32 bit sign extended */
+#define R_X86_64_16		12	/* Direct 16 bit zero extended */
+#define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
+#define R_X86_64_8		14	/* Direct 8 bit sign extended  */
+#define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.55.0


