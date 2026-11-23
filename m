Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D9606A327
	for <linux-um@archiver.kernel.org>; Mon, 23 Nov 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3oasEMWU;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SiwubxeC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PafwDopS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pjaHNfa5Y44gCMgWsYt1z6nK9zr8xQHMwn0hbi1HiNM=; b=3oasEMWUSLKBhg
	UZQ2V/CDhljh7weAR+sgIRGhoHp4KPnzbbKwXr4uSecnmAH/ztF+NCy67ZtPtzVTi9R6Gi9+IfEz1
	GRUGDX3+oMmhziragleFLfSjWOUEVB+v+sP9pkCp/0veK9JX94g+/Z0wyhNhHUlwlLzNNvriz2tp3
	uB8fmzjBuA3DBMYHkHqR5ILpWZ+GnXS3Cjlob6TNKJXDpkPBzUSOUxJfXotvN9vXxSnip8K31at+k
	n5oqmwws01YwlqlAkOwECkfowUJ5gTbHu2KUwkgBsdhcnHd5wekiveICL4P/ynpgZyfSIDFU+3oI4
	TdZuqnA8PBLb91bEfjeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVUSZ-00000003edT-37dH;
	Mon, 23 Nov 2026 13:51:55 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVUSH-00000003e9i-0gLB;
	Mon, 23 Nov 2026 13:51:40 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjaHNfa5Y44gCMgWsYt1z6nK9zr8xQHMwn0hbi1HiNM=;
	b=SiwubxeCodkmCiyMiY0r3O3GYOxwf9QzlLWSX2cpPhBgivhjzkKnYInYXnUPRJ9q1AM6fa
	9KkieGgGHK4lkoTLljHPihz1R+eHTQWESt5TuMG50onKo49h7JofyUYZZjilfRnsoib5mr
	Qiqs0Z3BCxBrRWAky4Cn2HdCp/gn12+i0i5+6/PA8n1jhoJpgxx+HlaevhQMaSmZl+G+TQ
	JsfPuj61DWlLMARl4U0pr8/7yoD0mIcpoVMSqSy6jG/w5ANlrvclfuNYCWounvhNVvu7wn
	eqhn8B09ZzFesEu1LdSxg18G2PPjAT1Do9Jhxt/FuTIm9kaITu6bjzCFpHdSyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjaHNfa5Y44gCMgWsYt1z6nK9zr8xQHMwn0hbi1HiNM=;
	b=PafwDopSrXMBMvIj+bOD/YaIZDnPhIeNmmxdQxl/A5OHikWrncrLqgZj1zSo7Go0RBz1dv
	KMFUL9taJSMknzDA==
Date: Mon, 23 Nov 2026 14:51:00 +0100
Subject: [PATCH v6 09/11] MIPS: vdso: Enable the vdsocheck tool
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-vdso-absolute-reloc-v6-9-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
In-Reply-To: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
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
 Peter Zijlstra <peterz@infradead.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=3612;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Upl7hsN7pYYITVcy/+9101coWRtl3qz4kkbkOxlORLo=;
 b=1fcEqYJBI/20+ipq+0gDhD2Hd2sHPo/b0TvsKaodh5hN8w9Rzt6iK8kpNsUn/MbwZcKE9qON0
 QkgrCaLMbbZBAsGdd/7c8BYFky+KQdnee/5otFkVjoWKNloGTmEJP3S
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_055137_391875_D2EF38BB 
X-CRM114-Status: GOOD (  10.62  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/Kconfig           |  1 +
 arch/mips/vdso/Makefile     |  8 ++++----
 lib/vdso/check/vdsocheck.rs | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ed17c9b1624c..31c247c2faeb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -106,6 +106,7 @@ config MIPS
 	select TRACE_IRQFLAGS_SUPPORT
 	select ARCH_HAS_ELFCORE_COMPAT
 	select HAVE_ARCH_KCSAN if 64BIT
+	select VDSO_CHECK
 
 config MIPS_FIXUP_BIGPHYS_ADDR
 	bool
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 00d3ba2c482a..63060057cd21 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -66,7 +66,7 @@ quiet_cmd_vdso_mips_check = VDSOCHK $@
 #
 
 quiet_cmd_vdsold_and_vdso_check = LD      $@
-      cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check); $(cmd_vdso_mips_check)
+      cmd_vdsold_and_vdso_check = $(cmd_ld_vdso); $(cmd_vdso_check); $(cmd_vdso_mips_check)
 
 quiet_cmd_vdsoas_o_S = AS      $@
       cmd_vdsoas_o_S = $(CC) $(a_flags) -c -o $@ $<
@@ -103,7 +103,7 @@ $(obj-vdso): KBUILD_AFLAGS := $(aflags-vdso) $(native-abi)
 
 $(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
 
-$(obj)/vdso.so.dbg.raw: $(obj)/vdso.lds $(obj-vdso) FORCE
+$(obj)/vdso.so.dbg.raw: $(obj)/vdso.lds $(obj-vdso) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 $(obj)/vdso-image.c: $(obj)/vdso.so.dbg.raw $(obj)/vdso.so.raw \
@@ -141,7 +141,7 @@ $(obj)/vdso-o32.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) -mabi=32
 $(obj)/vdso-o32.lds: $(src)/vdso.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
 
-$(obj)/vdso-o32.so.dbg.raw: $(obj)/vdso-o32.lds $(obj-vdso-o32) FORCE
+$(obj)/vdso-o32.so.dbg.raw: $(obj)/vdso-o32.lds $(obj-vdso-o32) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 $(obj)/vdso-o32-image.c: VDSO_NAME := o32
@@ -181,7 +181,7 @@ $(obj)/vdso-n32.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) -mabi=n32
 $(obj)/vdso-n32.lds: $(src)/vdso.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
 
-$(obj)/vdso-n32.so.dbg.raw: $(obj)/vdso-n32.lds $(obj-vdso-n32) FORCE
+$(obj)/vdso-n32.so.dbg.raw: $(obj)/vdso-n32.lds $(obj-vdso-n32) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 $(obj)/vdso-n32-image.c: VDSO_NAME := n32
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 1ef3f240f886..120d8fa551e6 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -157,6 +157,21 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_MIPS => AllowedRelocations {
+            ignored_object_file_sections: &[".rel.pdr", ".rela.pdr"],
+            in_object_file: &[
+                10,  /* R_MIPS_PC16 */
+                60,  /* R_MIPS_PC21_S2 */
+                61,  /* R_MIPS_PC26_S2 */
+                62,  /* R_MIPS_PC18_S3 */
+                63,  /* R_MIPS_PC19_S2 */
+                64,  /* R_MIPS_PCHI16 */
+                65,  /* R_MIPS_PCLO16 */
+                248, /* R_MIPS_PC32 */
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.56.1


