Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3492DCA0EDB
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZNmm+0jjK/cu4H5GKrhccpCqW984gVWKwBZnN5hgc4w=; b=Gc3vqU+L2K8a/AFxW7j4bV9Ahd
	AjfIW21FRGXfrZIGP5dcP9IHm+nIJeU/kRvHYgHWoNOaTnxegUpgtnxk3usXWCeTR0zdGnd18bUbD
	LtPnNbcLxni2/eZmm59TujCSUVFP8SAJ3uG/RBCrE3uXEzc8B31gHXaFZWaIWWEjwn9awefWASbRm
	1DOLkkDmvdTC8PE6WpexIpq3bbr9PXasQLSgjaf5Pf16zBWMJBRrsWUF8cM3+3FpObpbtg4lpiHLB
	Vh4QFhTDtU/EwEfpFkT40Hz91z9DU8nQSSudrl/7F/J5JCD040P9sqMlTeFeHZwPFckDLtt4xOA+K
	idEwoKCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljwM-0000000ABFA-3rzv;
	Tue, 12 Aug 2025 08:01:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoh-00000009vEU-3Q0C;
	Tue, 12 Aug 2025 05:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZNmm+0jjK/cu4H5GKrhccpCqW984gVWKwBZnN5hgc4w=; b=jtPl9ZC2c3HPkOi7p4g8+rD7Ih
	f62S9+2mZelNf55W5HSrUSO+P37Fwime1AeDKbAvlUEc9bxx/dOdRQrv7LyLQyVyaVQb5dT2HN05p
	whskvhDOGZ3a8xB8T78m0/MGXov4APbhnKJABI7+jVGlg6eDivpJCAX5/MrU9ShGCdzL7n3Y8PXLy
	g6x1ImFoRsIsq/W97fgVA9T1AG7A5Qw19IbYFA0lpfLq0mRuK3RatGJyzEeAvd2JnjnLQsD1GJtsd
	5mz+LjNlbnmX9GIo5FBFaMjkznY4gpWlvSRM68RfA2x8QzGOQPMQ8Blf1Gue3SdU5f/kxdvH186yc
	ag27h7jA==;
Received: from galois.linutronix.de ([193.142.43.55])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoc-0000000FgDV-2kZy;
	Tue, 12 Aug 2025 05:44:57 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNmm+0jjK/cu4H5GKrhccpCqW984gVWKwBZnN5hgc4w=;
	b=YVIBrzVs6jMRgP60RbLocRZINlpYIvgh/R8TmjjX9sgPwnMSGZAXRyMlQNpfj8cGpZ/fxK
	G1/ToFEH5kb8MyAyKBkqwWZy3FKtIaGyFnw/jDcC7cDfkV57unEWUErdw+4OFfUlhZ4I+Z
	u8LwflPKLpav+TZK1MYkSfenBQn967+uc5qSfgthMGz/rbRyu5ep6Dm6EBqZkIbqP0QvA/
	DEO9YwRG3oLtdNHQfyHGqGzKfO4J2v2y0izQdU6www5cNj6J0F/5SABcNgh9oQkLaiJmvS
	5ypEzeVA2rzpysAIPhXAr1gdv1DqmozBuroN9m2hnP3Ep+YD2Fk+LtTvniAoEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNmm+0jjK/cu4H5GKrhccpCqW984gVWKwBZnN5hgc4w=;
	b=AHGoK11e3ONpNsRnJ36Q4yzXjYjg8Xc+9ohCcoySpaOfSk5kLWkDoRsDYtFjalcZguXquc
	0s1EVjzvsI3du6Bg==
Date: Tue, 12 Aug 2025 07:44:34 +0200
Subject: [PATCH v4 21/24] s390/vdso: Enable the vdsocheck tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-21-61a8b615e5ec@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=3294;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=PbETMq9VTMEwxP8nGcVWnIK4aa/sB1ug5A+6i2j8Dag=;
 b=0cxT7S8ALFBcremtG1GBYu7CMsjCUUhSxQ1TwTPoImStmnRVATckJ934fbovkMMjfs5d2wReE
 xM4bYW6HkdvAmAnJ8M3DKlcu59tynIH+5lbTlWBXo2H7IRGxFBIBEy2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_064456_413678_E50ED7A3 
X-CRM114-Status: GOOD (  12.33  )
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
 arch/s390/kernel/vdso32/Makefile | 4 ++--
 arch/s390/kernel/vdso64/Makefile | 4 ++--
 lib/vdso/Kconfig                 | 1 +
 lib/vdso/check/vdsocheck.rs      | 8 ++++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 1e4ddd1a683ff84492f0f4b48d0efa00688129c2..6e8fba248d1aa8787f44aca2d82d77c245871b65 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -36,9 +36,9 @@ CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
 
 quiet_cmd_vdso_and_check = VDSO    $@
-      cmd_vdso_and_check = $(cmd_ld); $(cmd_vdso_check)
+      cmd_vdso_and_check = $(cmd_ld_vdso); $(cmd_vdso_check)
 
-$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(vdsocheck) FORCE
 	$(call if_changed,vdso_and_check)
 
 # strip rule for the .so file
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index d8f0df74280960cb351154a8a73b4f7fe83a9125..1334b6a188cedc883fe98dc271a995ee690c7fad 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -46,10 +46,10 @@ CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
 quiet_cmd_vdso_and_check = VDSO    $@
-      cmd_vdso_and_check = $(cmd_ld); $(cmd_vdso_check)
+      cmd_vdso_and_check = $(cmd_ld_vdso); $(cmd_vdso_check)
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj-cvdso64) FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj-cvdso64) $(vdsocheck) FORCE
 	$(call if_changed,vdso_and_check)
 
 # strip rule for the .so file
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 0fe70b3604f9925ef8c5608bb4cac24d3a28faab..b5b6673897e24a1f36147c21d00dff057f293980 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -57,6 +57,7 @@ config HAVE_VDSOCHECK
 	default y if PPC
 	default y if RISCV
 	default y if LOONGARCH
+	default y if S390
 	help
 	  Selected for architectures that are supported by the 'vdsocheck' progam.
 	  Only transitional.
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 93819f668d8a4f623f41403bb09b42c4aec2c8de..01073062f2b2d276291ccfbc6aa516f14a13fdd5 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -138,6 +138,14 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
                 bindings::R_LARCH_32_PCREL,
             ],
         }),
+        bindings::EM_S390 => Some(AllowedRelocations {
+            ignored_object_file_sections: None,
+            in_object_file: &[
+                bindings::R_390_PC32,
+                bindings::R_390_PC32DBL,
+                bindings::R_390_PLT32DBL,
+            ],
+        }),
         _ => None,
     }
 }

-- 
2.50.1


