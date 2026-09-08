Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EE2C79FAB
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 06:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5v9YeHlqv3ovO/ql+3n8/DnO9S76Q/KXTK4Iu9nIj8=; b=enyd+jWiP09XAX9QWQIpLB1x6v
	2aNSXyVcgTi7svnw0eGRKfXI5dCp4h7kw9pR1X7ICVVtg/HuIWC0h/sr5i8dFrAT1AoZ1EWCXdcGG
	Kkc7St1OshxUn3NBGVG4/sjXtr+UWJacMNz+ftm8c5swwGBuGZq3aszyAxdcgVGoiulYsVCDlwMCF
	Q14F7GX5DwPx9mN1TUeJCrgPsjJGX2mJMZOpi6oahQLWaEF+mjdrwSuTz3JZa/hsGNzcyJiADqzEg
	YlsbxPSNDLeO9MkHNCBuwaB155eMrXP2XGkXpMytDx+3cFcJA01ER59PJPnEK7GqJ7JwVhZTgPAFj
	p0N5FzYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3pPw-00000008AJu-43VJ;
	Tue, 08 Sep 2026 06:34:52 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3pP9-0000000893D-1ZKx;
	Tue, 08 Sep 2026 06:34:10 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5v9YeHlqv3ovO/ql+3n8/DnO9S76Q/KXTK4Iu9nIj8=;
	b=Duhd+tzhOIqAKD5Jsk7S5bIW+1/U+0lAyREaDyVMtUfkM+/2g6McMuZ8BVCtyusCW6KJhw
	wjBNCvGCpNGgmhFNn9x5FtX2pPVsVPQncpaQfdGxuDFM2F8njXe/d+MpW+sHlGTHGFoNTq
	Irhfb/b0d78bbsC8nUcr59RO2R6WK1QG6Wmmqjub7uMBsV8HzhabnT8Q3BXaImhnViQuCI
	99Y24z+RnYH8P+/0VTaa0of5QDISRCOgkSmlsMF9mLF5D2je6Fs4Q2NdAPmpcUGUDioSm3
	I7ouCpMLG1e5cQUG5eQhiKpjN9lpx2nzj/DsTf8/2g6tDQdVpp9HJVE2/Kspiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5v9YeHlqv3ovO/ql+3n8/DnO9S76Q/KXTK4Iu9nIj8=;
	b=TsyWF+JNT75r27JmDD427VBvLmTOCV3ff2Y7hv2xF0uvSSVXKhCkoTtj5xhp4+hfJtB9PC
	YrBA0mfCXrb6F8Cw==
Date: Tue, 08 Sep 2026 08:33:51 +0200
Subject: [PATCH v5 17/24] powerpc/vdso: Enable the vdsocheck tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=3226;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=PdmcaVe7pCu6upu7UTobIjeT+xi6m7cmShZzdDyDUqA=;
 b=KtzFUmFB6ajLIxA6GIlsiL6NZpPyhZkhtmdUQSlrxF2Z0EifBwB7dmyJS0AwkyNYLtHN5Uenz
 k87bxRvOvh3AuR3/IHMkszUyZg00Zcqz3Ne04gmZUna19VeKFdykejP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_233403_740971_52CB1D47 
X-CRM114-Status: GOOD (  10.66  )
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
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/kernel/vdso/Makefile |  4 ++--
 lib/vdso/check/vdsocheck.rs       | 27 +++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..f19e225cfc5c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -330,6 +330,7 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select VDSO_CHECK
 	select VDSO_DATASTORE
 	select VDSO_GETRANDOM
 	#
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 368759f81708..ca20b91b4373 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -81,9 +81,9 @@ targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o $(vdsocheck) FORCE
 	$(call if_changed,vdso32ld_and_check)
-$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o $(vdsocheck) FORCE
 	$(call if_changed,vdso64ld_and_check)
 
 # assembly rules for the .S files
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index e45a1fbc6829..429bdcd65818 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -69,6 +69,33 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_PPC => AllowedRelocations {
+            in_object_file: &[
+                bindings::R_PPC_REL24,
+                bindings::R_PPC_REL14,
+                bindings::R_PPC_REL32,
+                bindings::R_PPC_REL16,
+                bindings::R_PPC_REL16_LO,
+                bindings::R_PPC_REL16_HI,
+                bindings::R_PPC_REL16_HA,
+            ],
+            ..Default::default()
+        }
+        .into(),
+        bindings::EM_PPC64 => AllowedRelocations {
+            in_object_file: &[
+                bindings::R_PPC64_REL24,
+                bindings::R_PPC64_REL14,
+                bindings::R_PPC64_REL32,
+                bindings::R_PPC64_REL64,
+                bindings::R_PPC64_REL16,
+                bindings::R_PPC64_REL16_LO,
+                bindings::R_PPC64_REL16_HI,
+                bindings::R_PPC64_REL16_HA,
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.55.0


