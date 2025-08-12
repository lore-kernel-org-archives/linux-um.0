Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C379ACA0EDA
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 05:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Kjpq5eR3VtQueM0L6XasJAF39E5US6j25ec6FsCv3w=; b=tgMXOPKMonccJvjbZC7vkjKgXJ
	iWMe0dFfKmNoxAdUjtRo3XevPOcUeHUE9RFAVqX+MpwtIZtHDUoFvq65su9zQrrImpGAp9Ogr6YQg
	FgOImbcA+wcB0NVEwZ5t/hcY3ALRchzVfAGEWfPJp4cQn/qhaCtB7pKBbNUeT6ic6WGGl93De51qH
	bwOUkd6NujVUyGdR2NQxtGdPDf2P5mH2qlQwiCpq9PAfGF2F986txbgtzCb11/NF7GjiWit8Vvyio
	vENu/Tw6+QWfvmp8h6BidERHtlwv94zg099nzjSu6kt7eZKWa/FlDXbO2bHlQ/qTU9WTvJiqwLLqc
	q+cDHRtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhpC-00000009vrj-2Gcb;
	Tue, 12 Aug 2025 05:45:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhok-00000009vJI-3eCc;
	Tue, 12 Aug 2025 05:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=8Kjpq5eR3VtQueM0L6XasJAF39E5US6j25ec6FsCv3w=; b=MMdPPE74cS9IvtT4KTJTeWkfJN
	pGLBzufff8Z2vtRs2jAoabj+sDeqqk0UvcljbmY7x6lvbud6L1rv8nc12TyenymxX+idE/XaN+F1h
	Rk5T+o/G6QdANaGxTc5G29nUuRQnHYwOcKwtMVlc68/PcZq9AlUwnxFsNQnXUf0pfbkwUYWch7thu
	X6Ju5CExTsHpmWJeuF+DRy/YugXqKXTD+IW44mvUtU8p3fY8U3ozJvtE4P2cJAO1fsjRrIrXZ2lAj
	mWgJsgDIderjvPgc0bObvDT54MaLhKJBJ174KDVmrTa1g5sztsxT9ECSpKngfIhGz9DzdXbYlb1tp
	064ltShg==;
Received: from galois.linutronix.de ([193.142.43.55])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoe-0000000FgDe-1OQb;
	Tue, 12 Aug 2025 05:45:01 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Kjpq5eR3VtQueM0L6XasJAF39E5US6j25ec6FsCv3w=;
	b=DOgN3Y5EQB5kdutA1572V0LhXOZXnmRl6p0P18a1t7ObF9ucTKlbEHkVhxaejvdIZK3PIY
	lIUNnRcEoWpe9jMcL/sz5eDD1osU0bJplewxq79IGnmKl56iuX34wGlZkE8q0QXbW8ODPS
	/tRsjn5u/aceWhclEIiQoXuf5PoMDguQZFCa+gVrW0g1vlK8gccXdEQDtujNgXNNo0KdxN
	WuCKV7zOYOnI0NnSYDP7lGE+2WUwTHGjY7UEreXmXplASXvZjXyi/1+qv/lFjFdZDmXlU/
	TSNZ1c1JACCFOcsJSoennrnbZSFvpsaVg3kBWIxDpWM65m2K7yxEzt3JfuJQug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Kjpq5eR3VtQueM0L6XasJAF39E5US6j25ec6FsCv3w=;
	b=Xp94uLfRG/UGZ4I0EOrrP3/TrL+9J/C3gXEU1nyi3fx2RRuH8xCgRiBDmDN3dECl7takoc
	IY8Vx1R01mdHNgCQ==
Date: Tue, 12 Aug 2025 07:44:35 +0200
Subject: [PATCH v4 22/24] MIPS: ELF: Add more PC-relative relocation
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-22-61a8b615e5ec@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=1659;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Kx23G/jdGST0tg6021hFwad6UPxIH/+IOFc6beuEorU=;
 b=9721hy+2tPJhw7rgs5OUlE+6rM6NCuWPGCnHL0GckAQKuaqMknOzzL6abxn133J0vzAnS6u6/
 H4ms/FvzKN2ALTXQO9bp4r8ji2uMhcnak2odoRO0TaHpLw+mLogGUf1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_064458_693236_016DDC93 
X-CRM114-Status: UNSURE (   9.71  )
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

These are used by userspace and are necessary for the vdsocheck tool.

Also update the copy in tools/ so they can be used by vdsocheck.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf-r.h       | 6 ++++++
 tools/include/uapi/linux/elf-r.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index e750989e44e8f517d7dacf9d3a338af7a136e40f..9f7457ba1c63252d10b9ab25601581bd99af7a21 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -616,10 +616,16 @@
  */
 #define R_MIPS_PC21_S2		60
 #define R_MIPS_PC26_S2		61
+#define R_MIPS_PC18_S3		62
+#define R_MIPS_PC19_S2		63
+#define R_MIPS_PCHI16		64
+#define R_MIPS_PCLO16		65
 /*
  * This range is reserved for vendor specific relocations.
  */
 #define R_MIPS_LOVENDOR		100
 #define R_MIPS_HIVENDOR		127
 
+#define R_MIPS_PC32		248
+
 #endif /* _UAPI_LINUX_ELF_R_H */
diff --git a/tools/include/uapi/linux/elf-r.h b/tools/include/uapi/linux/elf-r.h
index e750989e44e8f517d7dacf9d3a338af7a136e40f..9f7457ba1c63252d10b9ab25601581bd99af7a21 100644
--- a/tools/include/uapi/linux/elf-r.h
+++ b/tools/include/uapi/linux/elf-r.h
@@ -616,10 +616,16 @@
  */
 #define R_MIPS_PC21_S2		60
 #define R_MIPS_PC26_S2		61
+#define R_MIPS_PC18_S3		62
+#define R_MIPS_PC19_S2		63
+#define R_MIPS_PCHI16		64
+#define R_MIPS_PCLO16		65
 /*
  * This range is reserved for vendor specific relocations.
  */
 #define R_MIPS_LOVENDOR		100
 #define R_MIPS_HIVENDOR		127
 
+#define R_MIPS_PC32		248
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.50.1


