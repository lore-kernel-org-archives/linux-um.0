Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956C3C79FB2
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 06:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IidQ31ouFEpYA+nS17u9E6l6j5+J0X/Qbfbzc/4EoAk=; b=kQfCU3XRAY73/D1erALVrY4CLr
	yQxSUkyZTWidV2SYZ6i74wwsgBQAIkJCEJDsnNFKvftMrrIJXFt2AQoRRpzZxQK/daa/dt96zGhOk
	KdphE+NmnUxPvrIxZlPWl5P9KvoW/z08OAPVvVnSU7wU+aEj1gRCSXPmxoqhXtW+pqeLa4vwo+2p+
	UlVyFqi3WDbThae6Ku067J0QMfg+FHGMOE5jMWef1sXWKdLI4t5mf1bZKb2x2fjWI1/5wTxjtoT57
	trr3rpMM9TDxg70x3uAyTbJtlM+BB+zCnhOE2V2WCW6gj7Tm0tQofovW6l2AVJ64iU4bizbxgL67o
	lqpEuzNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3pQ9-00000008AhY-0nwd;
	Tue, 08 Sep 2026 06:35:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3pPI-000000089HN-28MG;
	Tue, 08 Sep 2026 06:34:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=IidQ31ouFEpYA+nS17u9E6l6j5+J0X/Qbfbzc/4EoAk=; b=eYn5jHayOrRGt5jHi6sL0tVK+E
	3wHUmAzIebpoYA1aYAukiFp45vvmAAUMqFNe+5TIKV7miaw7uwa/73SvNkaS7HyCCVP+SxnDIegB2
	xpD4gfKTwXlxROTXKF69+fZf1CkpiO4lQNmJKuYpfOCnFyof1NcDuwBfEwjtDUXtPe6yJvYLECiT3
	8YG9g/ZVHEABiXA2Z1zDqiwqYbW5ZiJZky7Zj4meNYFergfvcf2l/u8t/hhY/NJkC1kpJ3b7tVlmp
	XqUOjHYY+39TZkRXwV3cXDz3qmXFnMvUNbL0ueKvB8BUzGRsQbGEH9/x1Zksbl6x4Qwsc78baWnQd
	QkARHRUw==;
Received: from galois.linutronix.de ([193.142.43.55])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3pPB-0000000Gyk4-3rXK;
	Tue, 08 Sep 2026 06:34:11 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IidQ31ouFEpYA+nS17u9E6l6j5+J0X/Qbfbzc/4EoAk=;
	b=13h/LZm3oUN5NX5d1pSwDpq6WOOrKuWkeooevs0Slh2NpnZURtKGe5KDBp1tQw/iOP/Foz
	jG+leFqUbZb1il3/yws247n0LE1Oo2UrRebiDasMImoeAvycvfaJtgt5FG43hx0rRvf/kt
	b+qd66u6bARnZouWXpm8baIEtwrHmqnbB+RfcaWW8MXCqXeqNj1m+ijLG4q2iVvSt4mr5y
	vJu0ZR+0GxgCwURI/L5/KXvu6rMPzu3XO6orwkZFexgMHMpLQ9jIedo5jxhPNs6DVioHIi
	NBeKQtqchUF1TAHOOMcD+uSWgwhGZFMn6e2sbJf5DzX9oTp0lkDYo51oJaVyWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IidQ31ouFEpYA+nS17u9E6l6j5+J0X/Qbfbzc/4EoAk=;
	b=iI6SCa0eTjj8cRYwu7N3BX4E5LcC26uVQ6b5eTpae2XyKJDB0AL3DOO+Qmt0gRz3YcZJfO
	b4Ep6HUDa68rhZAg==
Date: Tue, 08 Sep 2026 08:33:54 +0200
Subject: [PATCH v5 20/24] s390/vdso: Enable the vdsocheck tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-20-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=2270;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MheUrTVMsMhlO1Hx/uIAQcNaOa1zLZs90zNsA4xVFXI=;
 b=QPV6rtkThGmgCrpePDg3k3KYmTBWvY98MetgMiUyonNPORVe5K/DIqywgywggjAngHoM9YG0V
 mAFJANMdk6aBtyL1evmiJG/8n0kShbhIewzAsKEqRmtcX5PbBAf3zZb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_073406_287811_565401DB 
X-CRM114-Status: GOOD (  10.60  )
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
 arch/s390/Kconfig              | 1 +
 arch/s390/kernel/vdso/Makefile | 4 ++--
 lib/vdso/check/vdsocheck.rs    | 9 +++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4b51bc6e8948..bc12367a7b00 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -291,6 +291,7 @@ config S390
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY
 	select USER_STACKTRACE_SUPPORT
+	select VDSO_CHECK
 	select VDSO_GETRANDOM
 	select VIRT_CPU_ACCOUNTING
 	select VMAP_STACK
diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
index 35c834b895ec..509ef3f1e2eb 100644
--- a/arch/s390/kernel/vdso/Makefile
+++ b/arch/s390/kernel/vdso/Makefile
@@ -44,10 +44,10 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 $(obj)/vdso_wrapper.o : $(obj)/vdso.so
 
 quiet_cmd_vdso_and_check = VDSO    $@
-      cmd_vdso_and_check = $(cmd_ld); $(cmd_vdso_check)
+      cmd_vdso_and_check = $(cmd_ld_vdso); $(cmd_vdso_check)
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) $(obj-cvdso) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) $(obj-cvdso) $(vdsocheck) FORCE
 	$(call if_changed,vdso_and_check)
 
 # strip rule for the .so file
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 4aeb7094e552..b2135cf9add3 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -148,6 +148,15 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_S390 => AllowedRelocations {
+            in_object_file: &[
+                bindings::R_390_PC32,
+                bindings::R_390_PC32DBL,
+                bindings::R_390_PLT32DBL,
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.55.0


