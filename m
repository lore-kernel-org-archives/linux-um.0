Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06591CA0EC4
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 08:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xnh72HUbhzd4qempQkZ++BS8+pzvYgS+1ottOAOyHdU=; b=OEiMqy2XHvw6Q9MSv8PWkNbE0a
	zIB0+xObXAZBxeUxKl65FjY0hxQ0ZPU8AhX2GW+2mQ2fAE/ZMofQPENlFYqBTDNQZnijdWvzrumIO
	TxrIxla35iMZYusjD+CCPKEWySF1HNf4/TgC6MGqE8/fj3cp+g0077JPlQRfkW+L+RFqP3en5+dSp
	X5bs9Wvyv1rTxnhmYk6rSPG9uOtMrRzOIQ1CBI5dElUAC3cwLh+xNEk6WXG3fX7hBrsYEKshlvRxv
	WThdj0rTStHN8XEMCeFBsV3CZ9fjVC5xwe1JGYhhVx3dvizvoR2CE3vvHBwrmM6Y4fubTwRmEgZC5
	Zr4XsYkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljwI-0000000ABAz-3AYt;
	Tue, 12 Aug 2025 08:00:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoa-00000009v4T-1Cp0;
	Tue, 12 Aug 2025 05:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=Xnh72HUbhzd4qempQkZ++BS8+pzvYgS+1ottOAOyHdU=; b=bnI7iMMaDryt+krBU51cfFXNBb
	k9ZU/NBVesUU84g5JUXMUQsihjy1e+8p02c5F5ZUPflhbKZyY976VF44EnG2M7H3fautBYiHDyDkD
	lX4LYkrS9jrJQgjpcQo35gEKJI2P/HxzQjsIXbgwAS111hO0iwlf0o8+LoAYRDjDSvox3P/hHWjYC
	sT3V/k4N+MtBm7rDLDJG4Mp7uywb74Z1iSSxFbrp9DsRCTVmzMVzro9ntZ3nOj5B7toLs0s7zgjvB
	Gu0fS90xpPBYA450ZDFH6WTszE/Dv83HS16Di1PtptwEwqWdolT5HJeulGK8ZWUhJzuqqKIQSQPZB
	iaD72O6w==;
Received: from galois.linutronix.de ([193.142.43.55])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoV-0000000Fg7e-2JYv;
	Tue, 12 Aug 2025 05:44:50 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xnh72HUbhzd4qempQkZ++BS8+pzvYgS+1ottOAOyHdU=;
	b=M7S40MwV/29NPfO9Sasy+ADfYcsvNi5Apjwn245Ady0D3VOmbwdncNTgeKb1CtGlZMH2y5
	VLb+3/m+Kr/szGiTLJd4uAnGlG3BOQdpLLeDU2s3RuY0jGaoJQ9CoZ8ywkJenQVTh8q1ZU
	AzYugh31VGsAyOYBGTv9zwM7UTdCqcxGOgnyVS8W0fkGMwNgHzjkZfXtr0UvL1e7UJMMmF
	nJcpgacbXj6Sj/nRL1V06LnhMjF7zs1jSvpx57y2lKdkro1SgilU5GZG0SWcrItG0ikYUg
	AXOR889bzaLnAigaurgMDW06LMjY90s899cXrcGjUdmhdbEMejfGbP4Qf1yxPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xnh72HUbhzd4qempQkZ++BS8+pzvYgS+1ottOAOyHdU=;
	b=oT3QciTbYI+S9gc2w0Nm9Wh0wRDtrD56Uiy+WUIfVLkM867MFCQ7qwFFCJ/zKjjlLlWrmY
	vK59scPXpcCQ33AQ==
Date: Tue, 12 Aug 2025 07:44:27 +0200
Subject: [PATCH v4 14/24] arm64: vdso: Enable the vdsocheck tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-14-61a8b615e5ec@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=2714;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3K4dUUVStWjQ5/WBfnnWwj1hNxnDgSGwmxNLWqKjR7g=;
 b=yJ2PupWNQCp+kR/s6ueQVFH3FycSSSmFfTc8D7vtTv0iU6LC1cQ44wErnQahnnu4cKtXubosj
 a7zqtL+HXllCbNMWl3p7/xwQr+4L7lGG20l7mLQYJBiX+218aWqN4J7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_064447_934931_8A0A8690 
X-CRM114-Status: GOOD (  12.18  )
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

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/kernel/vdso/Makefile |  4 ++--
 lib/vdso/Kconfig                |  1 +
 lib/vdso/check/vdsocheck.rs     | 11 +++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 7dec05dd33b70ea8fc734e0c13af9ec4568d80a8..9fac0e54097dc552dbfe81074da71492c79c9230 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -61,7 +61,7 @@ targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
 # Link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 # Strip rule for the .so file
@@ -79,4 +79,4 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 
 # Actual build commands
 quiet_cmd_vdsold_and_vdso_check = LD      $@
-      cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
+      cmd_vdsold_and_vdso_check = $(cmd_ld_vdso); $(cmd_vdso_check)
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 84bff59ccef4acd95159d03e96991161a029fb2d..3037b15476bb60ee47c1e083eae3968ab9604f59 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -53,6 +53,7 @@ config HAVE_VDSOCHECK
 	bool
 	default y if X86
 	default y if ARM
+	default y if ARM64
 	help
 	  Selected for architectures that are supported by the 'vdsocheck' progam.
 	  Only transitional.
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 23970b9d05dc320eb4966967904deae661171b15..a695aed95ad391a0c55e5388bc6d1f1141fd784e 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -54,6 +54,17 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
                 bindings::R_ARM_PREL31,
             ],
         }),
+        bindings::EM_AARCH64 => Some(AllowedRelocations {
+            ignored_object_file_sections: None,
+            in_object_file: &[
+                bindings::R_AARCH64_PREL64,
+                bindings::R_AARCH64_PREL32,
+                bindings::R_AARCH64_PREL16,
+                bindings::R_AARCH64_LD_PREL_LO19,
+                bindings::R_AARCH64_ADR_PREL_LO21,
+                bindings::R_AARCH64_CALL26,
+            ],
+        }),
         _ => None,
     }
 }

-- 
2.50.1


