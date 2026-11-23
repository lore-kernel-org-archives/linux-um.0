Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A888606A339
	for <linux-um@archiver.kernel.org>; Mon, 23 Nov 2026 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=erzCoDer;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=m0qrJodb;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=E5RDjo0r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6ha/Vi89GXA1dWoPWSXoNX2UQD22cCvUbJLDuPRU8LE=; b=erzCoDer7XQOUb
	9/Py3Pz/M/JXGUN21Qi30+41YJjcQzn29W/VXOt6awszXENp31F9SK90Ie3qS27ynLTTgKRa+qSj5
	oB7bIFRAwBwWrUX1Ah1eR/OcHwI4moDDoekwV15ovGgo5g1XvGalMGQs9n78wdfDaPCtS3pqfgkzL
	lGyvxPuxeEzx7FOwbODgJ2Ek/3erks2/sZAdxx01TdGi2uZEoIYZCiJ8xMSIoqL5f0eWl3yp+vLdB
	neYeTMfD+y9sjSIae377zqFT4bh7esED+JeAuZ9yNHLDLpZCC1itzkfNocG2HTm+rV4KRSQPGiCv9
	w3Ht0f/ilsFR1PY6Qssg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVUSa-00000003efK-26PD;
	Mon, 23 Nov 2026 13:51:56 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVUSL-00000003eFy-1WpC;
	Mon, 23 Nov 2026 13:51:48 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ha/Vi89GXA1dWoPWSXoNX2UQD22cCvUbJLDuPRU8LE=;
	b=m0qrJodblgSHfzkge/b+c0QCMBHtFhMmCA6Vyr2H7WBleCIYh+lMqmV0IKteG9E2pikiZO
	y1JjkkjTUm66PulTK2p3QfpFPfiq0Sm3AHnRfHl8yDhGDzYNRHWeqg5cF7tcl78L1RkR/n
	WPuYxHiHo2IYC4A+sg7EC+/1EcXp3blyHeQ6KRs4nnNNyW2uY1A+PhOCAIi3oMtnZTDkV0
	NxM1dvYOi001/WyxLtFcc0h9eQpHZI0XWYY8P4cO9FYCbLxOMNPr6OKl3dnlyQMMuZGJAD
	Te3Y/nY9Wdefcyj10JqyBH/pqn70kpgTO2Xqjlvxo2FDmdYuNvSq8xtqlC4i/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ha/Vi89GXA1dWoPWSXoNX2UQD22cCvUbJLDuPRU8LE=;
	b=E5RDjo0rxSRWJZCsaguvONyxWiePtX/w5e+rniAAAlKK8WxlOgxIrKHbdHR03YakmbzKxe
	lX7JYjn+2xicGaBg==
Date: Mon, 23 Nov 2026 14:51:01 +0100
Subject: [PATCH v6 10/11] sparc: vdso: Enable the vdsocheck tool
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-vdso-absolute-reloc-v6-10-161e218dd217@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=2332;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6Cz0yJ9M9WbiIcD7w4L4KrbFFaP4kbTGha8gKHJR3nY=;
 b=CILuTEE+Fxr6rbHT12PlkxKHS0mC2FrvmEnB5ZbAm/6ReS1zpHxcD5xSsaLEEMXokqtxppLR0
 Uh4X7juWCr+B9/J50Tb7NWk5LeUrNQkbxzudL/33leg6I3v7r7q9/fa
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_055143_772212_F5AE3F53 
X-CRM114-Status: GOOD (  11.63  )
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
 arch/sparc/Kconfig          | 1 +
 arch/sparc/vdso/Makefile    | 5 +++--
 lib/vdso/check/vdsocheck.rs | 7 +++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 742ffff8c37f..90df77235184 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -114,6 +114,7 @@ config SPARC64
 	select ARCH_SUPPORTS_SCHED_SMT if SMP
 	select ARCH_SUPPORTS_SCHED_MC  if SMP
 	select ARCH_HAS_LAZY_MMU_MODE
+	select VDSO_CHECK
 	select GENERIC_GETTIMEOFDAY
 
 config ARCH_PROC_KCORE_TEXT
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 83fb2aca59cb..8bb235c3a618 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -28,7 +28,7 @@ CPPFLAGS_vdso.lds += -P -C
 VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 \
 			-z max-page-size=8192
 
-$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) $(vdsocheck) FORCE
 	$(call if_changed,vdso)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
@@ -99,7 +99,8 @@ $(obj)/vdso32.so.dbg: CHECKFLAGS = $(CHECKFLAGS_32)
 $(obj)/vdso32.so.dbg: FORCE \
 			$(obj)/vdso32/vdso32.lds \
 			$(obj)/vdso32/vclock_gettime.o \
-			$(obj)/vdso32/vdso-note.o
+			$(obj)/vdso32/vdso-note.o \
+			$(vdsocheck)
 		$(call	if_changed,vdso)
 
 #
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 120d8fa551e6..245d8af9f704 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -172,6 +172,13 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_SPARC | bindings::EM_SPARC32PLUS | bindings::EM_SPARCV9 => {
+            AllowedRelocations {
+                in_object_file: &[6 /* R_SPARC_DISP32 */],
+                ..Default::default()
+            }
+            .into()
+        }
         _ => None,
     }
 }

-- 
2.56.1


