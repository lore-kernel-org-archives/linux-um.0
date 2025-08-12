Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF6CC87FCB
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 05:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Ohsn0uRwU+hqw8smnbWosllb5/RpGYnB9VEAvO1A/o=; b=fY1+4bmcz3hA6F4ryP6GqhwB+h
	9NzcrTEG12M2UFyTuLfTiYf2XsPk9Zx43ke7M0bzVg8dzuA2FC+YNEz+9wSdvvl4qwgn9yrICZ9dG
	9MHi/GpVkWajHMpCAOvN41NjO/H4QVY8NqOtKyWTE6PIw3WG/vCCUYKMIgtr4qRP41FFkbeucNQmX
	Z5uhmkD5ZiO+QxxtbazIjA9SnNWF+ffPLDPr4aYi562DzjIch28Ho0U+VAP9+ZRbBv22KWHsD0Cqh
	vbPnVzvnznnPrwvD7m1wOs6Pg+9/Tkv/e+FxuKaP3RsWBKjjG3sRK+1LlmhzDgciDdReLHUF7xCo1
	NszbJMKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhpC-00000009vsl-3lGD;
	Tue, 12 Aug 2025 05:45:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhok-00000009vJJ-40Ab;
	Tue, 12 Aug 2025 05:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=4Ohsn0uRwU+hqw8smnbWosllb5/RpGYnB9VEAvO1A/o=; b=URTQDr/WWwAmkbyVvJeHQu62Hx
	dHPlLMGquQLwL7qkk/OHK1hK2XaEf1gw3GadT4vjf7JM4YwTQsR38UsruTKlzWZUf4zefdgNsmQ6G
	c8erc/kqIJGWACu7kvOAZswUbDzSkpD7ICikvR4D4z5HRCB86CehKuG5iMuC5xW4lXC0Q+Le3U0I7
	ow9jz3erzBfMq59QmdRct40ACJVRE/LVk+aba/YCqL9EY1UfNwLe/OT33CVcKWqs2b0jJPsrNaYm5
	ELZH42yAHQd54nFep9Ynw9uYApZm9ejKpDgVUsmdT8lMNRkon3qD/OCkfVQ2/kSUockCrQ0zQ/FHP
	snWF82GA==;
Received: from galois.linutronix.de ([193.142.43.55])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhog-0000000FgEl-2Xv3;
	Tue, 12 Aug 2025 05:45:01 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ohsn0uRwU+hqw8smnbWosllb5/RpGYnB9VEAvO1A/o=;
	b=gVUd2BKNRu49lqg4NSeZ4pKy2oD1HLdzTFOjP5wa3OkUArCPejQi3q6nUUr2hwWVlPH2Kd
	CpxufrleSj5IZe8RVpKM1ltFMzRJO9obwhqsMGuapaXgAqGhXqHAW1SITBjzjuIFxYogme
	VHW9rhxA7fc8nsd57iZTz0NzWxS4qCvj0HR7XdalckB95CeAtDcPREEN4EOpD8wSUEK1Fj
	JpEDuofzGC0RATmSZcEZf8c/4R+6SxzYN4hGrvSuM267wDyFyN3n0HVqzoxPKY02BuyYgJ
	Z9VulQJw/Kd9S+FCzxMpZgWlnADluI2ZtXqh+SyfPfSKvhoitMn+YWd5L9OT6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ohsn0uRwU+hqw8smnbWosllb5/RpGYnB9VEAvO1A/o=;
	b=E3zfUlZMz5EWlnuWD04WRwJZzaIYqsb9Hq174OOh7rbwH0by1UeqdRfVLVDKyXeX8pZQ9r
	AHYbNMgU+lq97wCQ==
Date: Tue, 12 Aug 2025 07:44:37 +0200
Subject: [PATCH v4 24/24] vdso/vdsocheck: Drop the transitional kconfig
 option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-24-61a8b615e5ec@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=1638;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XgLT+HRfIExEaxGQakA0kG9YYMgwqfszT+N1NJLYmAY=;
 b=1I1jQfDAIUdxhhr5poZTNsBtXG7kI9OeSFZyV1uG5GiskTP3f4x0XtJf5y22KDovg2SDqYoC/
 1/LS9SuRW0lC44pibDwoRDG1rIxAT00dk7cwwtQfK+pJ8Esyu7dhqf4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_064458_968341_A3C513A7 
X-CRM114-Status: UNSURE (   9.31  )
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

All users of the generic vDSO are now using the vdsocheck tool.

Remove the now unnecessary kconfig option.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/Kconfig          | 14 --------------
 lib/vdso/Makefile.include |  2 +-
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 567ac937a9c3084fd5669e1b890b667af8a2f12d..45df764b49ad62479e6456e00c053e46131936a3 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -48,17 +48,3 @@ config GENERIC_VDSO_DATA_STORE
 	bool
 	help
 	  Selected by architectures that use the generic vDSO data store.
-
-config HAVE_VDSOCHECK
-	bool
-	default y if X86
-	default y if ARM
-	default y if ARM64
-	default y if PPC
-	default y if RISCV
-	default y if LOONGARCH
-	default y if S390
-	default y if MIPS
-	help
-	  Selected for architectures that are supported by the 'vdsocheck' progam.
-	  Only transitional.
diff --git a/lib/vdso/Makefile.include b/lib/vdso/Makefile.include
index 759fe41b48f658c399f54aa7d54a3dfeb07e5c9c..a5621b1d6ab51fde3fdab6e72309d51943939860 100644
--- a/lib/vdso/Makefile.include
+++ b/lib/vdso/Makefile.include
@@ -6,7 +6,7 @@ GENERIC_VDSO_DIR := $(dir $(GENERIC_VDSO_MK_PATH))
 c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) := $(addprefix $(GENERIC_VDSO_DIR), gettimeofday.c)
 c-getrandom-$(CONFIG_VDSO_GETRANDOM) := $(addprefix $(GENERIC_VDSO_DIR), getrandom.c)
 
-ifeq ($(CONFIG_RUST_IS_AVAILABLE)$(CONFIG_HAVE_VDSOCHECK),yy)
+ifdef CONFIG_RUST_IS_AVAILABLE
 vdsocheck := lib/vdso/check/vdsocheck
 
 $(vdsocheck): FORCE

-- 
2.50.1


