Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2195ACA0EC4
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 05:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fkg1bPVAb9WA2YqUFAts2+yGpStqlshJeZB7QeNp+t0=; b=Xug9I6JiHJV3XO52jw2Y8lVbTD
	JV3+Lt5FotZaaS4VZIgkfePkOVvjSnI8gf3xRZyOa4ewyY3TV5X0/W4+Ncia9ZIfbzeV98oYPwlSM
	P6f8FLWmqkRWArkvroXD0fjsumkEv1HR4aZxjh6BWgAOlWCaY3ht/yT2Hf/wMx1DHXZXcLSSZXtU1
	/PGY7VlPhUssidCoijSVVQq7n1inIV43RcHg07tMo0+pzdTFzvHBOLcueDaBtOGBVdxG94peurKM2
	DdCtfUzYCE8CyJ5vdBU6OSLGqX2ZtB0dhtrA/CtJw+Er6drXdQ3VG35bTgdji60alGUwtTi4LoLtl
	ADuwXKxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoj-00000009vJ2-2IRI;
	Tue, 12 Aug 2025 05:45:02 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoM-00000009umA-0WZQ;
	Tue, 12 Aug 2025 05:44:41 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkg1bPVAb9WA2YqUFAts2+yGpStqlshJeZB7QeNp+t0=;
	b=N76UFPTSvjeThA+4ICVorwdUz2s8ZBTjWR1raKncft+NQNhdlTNKoYd6wj0gT7cAbxv+He
	FE7MayaFHexzfgm/Yp4DlG4xj8TGfoHh0f8ywSrKQBqbK70ZNqO2hJY/5LH1ONpB3bm2fF
	0RquDx8QPyluO8dm4N27LQvRzbpNUVAtokTT44cYVgOjoonynV4tWBUNOFnpdvvFqN2vW/
	cqHS920uozuGIMKpo1JUVKZ5SsYaTxDg1jQTiuwXOBtzYIPbH1FXazmej1r4ZIDSLymeUq
	O47nmhPS1f34gThVDATO+qsLapdNHP6DdCleb9DwV6ETY1axDsp3NPlAl9AxjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkg1bPVAb9WA2YqUFAts2+yGpStqlshJeZB7QeNp+t0=;
	b=18Rnb2Fa+Sna+OwAhxFHp1cCA1vZWkRQkwkLDjGUq0Tg+U4CD7QY2hBzVgJKWM7gbtKJjk
	cBVlnZSy7GDhr0CA==
Date: Tue, 12 Aug 2025 07:44:21 +0200
Subject: [PATCH v4 08/24] s390/elf: Move relocation constants to UAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-8-61a8b615e5ec@linutronix.de>
References: <20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de>
In-Reply-To: <20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
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
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=11159;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vUmNFj6Lm6Qg8tI2kdLRPgt0Gi9m6tozlyRLJNyUZq8=;
 b=pjGOrRJ9QoAus+4BjG0iWI41Q7/LrybAda/1wC+pkd8eYTKMRXxTKKhRZpHAiMjn189aOQNGy
 s7yJj9MfgiZCn06a6qoiiSXi1l/3A/ZP0WoMSjzIIXyDJb+vGTsWrpB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_224438_490522_BBBBAF3E 
X-CRM114-Status: GOOD (  12.28  )
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
 arch/s390/include/asm/elf.h | 83 ---------------------------------------------
 include/uapi/linux/elf-r.h  | 83 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index a03df312081ef93f95ab70ccb5a5d2bdf88d84ec..ce5306178ceaaa17afdaa1fbe4896d0125d1ab09 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -8,89 +8,6 @@
 #ifndef __ASMS390_ELF_H
 #define __ASMS390_ELF_H
 
-/* s390 relocations defined by the ABIs */
-#define R_390_NONE		0	/* No reloc.  */
-#define R_390_8			1	/* Direct 8 bit.  */
-#define R_390_12		2	/* Direct 12 bit.  */
-#define R_390_16		3	/* Direct 16 bit.  */
-#define R_390_32		4	/* Direct 32 bit.  */
-#define R_390_PC32		5	/* PC relative 32 bit.	*/
-#define R_390_GOT12		6	/* 12 bit GOT offset.  */
-#define R_390_GOT32		7	/* 32 bit GOT offset.  */
-#define R_390_PLT32		8	/* 32 bit PC relative PLT address.  */
-#define R_390_COPY		9	/* Copy symbol at runtime.  */
-#define R_390_GLOB_DAT		10	/* Create GOT entry.  */
-#define R_390_JMP_SLOT		11	/* Create PLT entry.  */
-#define R_390_RELATIVE		12	/* Adjust by program base.  */
-#define R_390_GOTOFF32		13	/* 32 bit offset to GOT.	 */
-#define R_390_GOTPC		14	/* 32 bit PC rel. offset to GOT.  */
-#define R_390_GOT16		15	/* 16 bit GOT offset.  */
-#define R_390_PC16		16	/* PC relative 16 bit.	*/
-#define R_390_PC16DBL		17	/* PC relative 16 bit shifted by 1.  */
-#define R_390_PLT16DBL		18	/* 16 bit PC rel. PLT shifted by 1.  */
-#define R_390_PC32DBL		19	/* PC relative 32 bit shifted by 1.  */
-#define R_390_PLT32DBL		20	/* 32 bit PC rel. PLT shifted by 1.  */
-#define R_390_GOTPCDBL		21	/* 32 bit PC rel. GOT shifted by 1.  */
-#define R_390_64		22	/* Direct 64 bit.  */
-#define R_390_PC64		23	/* PC relative 64 bit.	*/
-#define R_390_GOT64		24	/* 64 bit GOT offset.  */
-#define R_390_PLT64		25	/* 64 bit PC relative PLT address.  */
-#define R_390_GOTENT		26	/* 32 bit PC rel. to GOT entry >> 1. */
-#define R_390_GOTOFF16		27	/* 16 bit offset to GOT. */
-#define R_390_GOTOFF64		28	/* 64 bit offset to GOT. */
-#define R_390_GOTPLT12		29	/* 12 bit offset to jump slot.	*/
-#define R_390_GOTPLT16		30	/* 16 bit offset to jump slot.	*/
-#define R_390_GOTPLT32		31	/* 32 bit offset to jump slot.	*/
-#define R_390_GOTPLT64		32	/* 64 bit offset to jump slot.	*/
-#define R_390_GOTPLTENT		33	/* 32 bit rel. offset to jump slot.  */
-#define R_390_PLTOFF16		34	/* 16 bit offset from GOT to PLT. */
-#define R_390_PLTOFF32		35	/* 32 bit offset from GOT to PLT. */
-#define R_390_PLTOFF64		36	/* 16 bit offset from GOT to PLT. */
-#define R_390_TLS_LOAD		37	/* Tag for load insn in TLS code. */
-#define R_390_TLS_GDCALL	38	/* Tag for function call in general
-                                           dynamic TLS code.  */
-#define R_390_TLS_LDCALL	39	/* Tag for function call in local
-                                           dynamic TLS code.  */
-#define R_390_TLS_GD32		40	/* Direct 32 bit for general dynamic
-                                           thread local data.  */
-#define R_390_TLS_GD64		41	/* Direct 64 bit for general dynamic
-                                           thread local data.  */
-#define R_390_TLS_GOTIE12	42	/* 12 bit GOT offset for static TLS
-                                           block offset.  */
-#define R_390_TLS_GOTIE32	43	/* 32 bit GOT offset for static TLS
-                                           block offset.  */
-#define R_390_TLS_GOTIE64	44	/* 64 bit GOT offset for static TLS
-                                           block offset.  */
-#define R_390_TLS_LDM32		45	/* Direct 32 bit for local dynamic
-                                           thread local data in LD code.  */
-#define R_390_TLS_LDM64		46	/* Direct 64 bit for local dynamic
-                                           thread local data in LD code.  */
-#define R_390_TLS_IE32		47	/* 32 bit address of GOT entry for
-                                           negated static TLS block offset.  */
-#define R_390_TLS_IE64		48	/* 64 bit address of GOT entry for
-                                           negated static TLS block offset.  */
-#define R_390_TLS_IEENT		49	/* 32 bit rel. offset to GOT entry for
-                                           negated static TLS block offset.  */
-#define R_390_TLS_LE32		50	/* 32 bit negated offset relative to
-                                           static TLS block.  */
-#define R_390_TLS_LE64		51	/* 64 bit negated offset relative to
-                                           static TLS block.  */
-#define R_390_TLS_LDO32		52	/* 32 bit offset relative to TLS
-                                           block.  */
-#define R_390_TLS_LDO64		53	/* 64 bit offset relative to TLS
-                                           block.  */
-#define R_390_TLS_DTPMOD	54	/* ID of module containing symbol.  */
-#define R_390_TLS_DTPOFF	55	/* Offset in TLS block.  */
-#define R_390_TLS_TPOFF		56	/* Negate offset in static TLS
-                                           block.  */
-#define R_390_20		57	/* Direct 20 bit.  */
-#define R_390_GOT20		58	/* 20 bit GOT offset.  */
-#define R_390_GOTPLT20		59	/* 20 bit offset to jump slot.  */
-#define R_390_TLS_GOTIE20	60	/* 20 bit GOT offset for static TLS
-					   block offset.  */
-/* Keep this the last entry.  */
-#define R_390_NUM	61
-
 /*
  * HWCAP flags - for AT_HWCAP
  *
diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 576d974db6e31f8a9cd995f7428c85bd41102415..c1309a63a7dc4495f22e3d8b51d3f97ab5809190 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -480,4 +480,87 @@
 #define R_LARCH_SUB_ULEB128			108
 #define R_LARCH_64_PCREL			109
 
+/* s390 relocations defined by the ABIs */
+#define R_390_NONE		0	/* No reloc.  */
+#define R_390_8			1	/* Direct 8 bit.  */
+#define R_390_12		2	/* Direct 12 bit.  */
+#define R_390_16		3	/* Direct 16 bit.  */
+#define R_390_32		4	/* Direct 32 bit.  */
+#define R_390_PC32		5	/* PC relative 32 bit.	*/
+#define R_390_GOT12		6	/* 12 bit GOT offset.  */
+#define R_390_GOT32		7	/* 32 bit GOT offset.  */
+#define R_390_PLT32		8	/* 32 bit PC relative PLT address.  */
+#define R_390_COPY		9	/* Copy symbol at runtime.  */
+#define R_390_GLOB_DAT		10	/* Create GOT entry.  */
+#define R_390_JMP_SLOT		11	/* Create PLT entry.  */
+#define R_390_RELATIVE		12	/* Adjust by program base.  */
+#define R_390_GOTOFF32		13	/* 32 bit offset to GOT.	 */
+#define R_390_GOTPC		14	/* 32 bit PC rel. offset to GOT.  */
+#define R_390_GOT16		15	/* 16 bit GOT offset.  */
+#define R_390_PC16		16	/* PC relative 16 bit.	*/
+#define R_390_PC16DBL		17	/* PC relative 16 bit shifted by 1.  */
+#define R_390_PLT16DBL		18	/* 16 bit PC rel. PLT shifted by 1.  */
+#define R_390_PC32DBL		19	/* PC relative 32 bit shifted by 1.  */
+#define R_390_PLT32DBL		20	/* 32 bit PC rel. PLT shifted by 1.  */
+#define R_390_GOTPCDBL		21	/* 32 bit PC rel. GOT shifted by 1.  */
+#define R_390_64		22	/* Direct 64 bit.  */
+#define R_390_PC64		23	/* PC relative 64 bit.	*/
+#define R_390_GOT64		24	/* 64 bit GOT offset.  */
+#define R_390_PLT64		25	/* 64 bit PC relative PLT address.  */
+#define R_390_GOTENT		26	/* 32 bit PC rel. to GOT entry >> 1. */
+#define R_390_GOTOFF16		27	/* 16 bit offset to GOT. */
+#define R_390_GOTOFF64		28	/* 64 bit offset to GOT. */
+#define R_390_GOTPLT12		29	/* 12 bit offset to jump slot.	*/
+#define R_390_GOTPLT16		30	/* 16 bit offset to jump slot.	*/
+#define R_390_GOTPLT32		31	/* 32 bit offset to jump slot.	*/
+#define R_390_GOTPLT64		32	/* 64 bit offset to jump slot.	*/
+#define R_390_GOTPLTENT		33	/* 32 bit rel. offset to jump slot.  */
+#define R_390_PLTOFF16		34	/* 16 bit offset from GOT to PLT. */
+#define R_390_PLTOFF32		35	/* 32 bit offset from GOT to PLT. */
+#define R_390_PLTOFF64		36	/* 16 bit offset from GOT to PLT. */
+#define R_390_TLS_LOAD		37	/* Tag for load insn in TLS code. */
+#define R_390_TLS_GDCALL	38	/* Tag for function call in general
+                                           dynamic TLS code.  */
+#define R_390_TLS_LDCALL	39	/* Tag for function call in local
+                                           dynamic TLS code.  */
+#define R_390_TLS_GD32		40	/* Direct 32 bit for general dynamic
+                                           thread local data.  */
+#define R_390_TLS_GD64		41	/* Direct 64 bit for general dynamic
+                                           thread local data.  */
+#define R_390_TLS_GOTIE12	42	/* 12 bit GOT offset for static TLS
+                                           block offset.  */
+#define R_390_TLS_GOTIE32	43	/* 32 bit GOT offset for static TLS
+                                           block offset.  */
+#define R_390_TLS_GOTIE64	44	/* 64 bit GOT offset for static TLS
+                                           block offset.  */
+#define R_390_TLS_LDM32		45	/* Direct 32 bit for local dynamic
+                                           thread local data in LD code.  */
+#define R_390_TLS_LDM64		46	/* Direct 64 bit for local dynamic
+                                           thread local data in LD code.  */
+#define R_390_TLS_IE32		47	/* 32 bit address of GOT entry for
+                                           negated static TLS block offset.  */
+#define R_390_TLS_IE64		48	/* 64 bit address of GOT entry for
+                                           negated static TLS block offset.  */
+#define R_390_TLS_IEENT		49	/* 32 bit rel. offset to GOT entry for
+                                           negated static TLS block offset.  */
+#define R_390_TLS_LE32		50	/* 32 bit negated offset relative to
+                                           static TLS block.  */
+#define R_390_TLS_LE64		51	/* 64 bit negated offset relative to
+                                           static TLS block.  */
+#define R_390_TLS_LDO32		52	/* 32 bit offset relative to TLS
+                                           block.  */
+#define R_390_TLS_LDO64		53	/* 64 bit offset relative to TLS
+                                           block.  */
+#define R_390_TLS_DTPMOD	54	/* ID of module containing symbol.  */
+#define R_390_TLS_DTPOFF	55	/* Offset in TLS block.  */
+#define R_390_TLS_TPOFF		56	/* Negate offset in static TLS
+                                           block.  */
+#define R_390_20		57	/* Direct 20 bit.  */
+#define R_390_GOT20		58	/* 20 bit GOT offset.  */
+#define R_390_GOTPLT20		59	/* 20 bit offset to jump slot.  */
+#define R_390_TLS_GOTIE20	60	/* 20 bit GOT offset for static TLS
+					   block offset.  */
+/* Keep this the last entry.  */
+#define R_390_NUM	61
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.50.1


