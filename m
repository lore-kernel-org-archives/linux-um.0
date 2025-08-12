Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6B0CA0EC4
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 05:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HfCt5JZT5TLY1vTOkO3zmfWoCgmYOOlaa/RcOHdKaps=; b=ea/shIlO0BiICFYxJ4Mp7EW4XO
	wqu60d2/5VrcNa7c2HlQYnPiegW7IZ7wpgU5wL7vTyKKGL47mvYTC7QRW+zgPZYg0vZ20rvhrmMFV
	76cRNU1Krgzv0dxbwc/WQQ8MoLOqtocIW/6Hp/tnce/biExKvS0kz8QDFk9xGU+/jgZ3iOJq44yfB
	wCE+Wj6wE+GaHns1Mb9ZYjH3Aejn9KR5R0eiobOspe/PMbdz//p10yadl41JBVF/1DfHLoyFLVwgd
	14NSrThLfGd9swojcgXgbv1jEjs4Na2tqHGC09Pr5RcD3Kk95j08SuJLv7ggpImVb3RvqfROX3G03
	+ciISEJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhp1-00000009vbo-1Ydj;
	Tue, 12 Aug 2025 05:45:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoY-00000009v2u-2kOf;
	Tue, 12 Aug 2025 05:44:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=HfCt5JZT5TLY1vTOkO3zmfWoCgmYOOlaa/RcOHdKaps=; b=VtPzKBVAtDLN6/Fexzl8I5Cdac
	czVAHGqufJtui/Fk5aNHivzcateQlmTayQJYzPh1QXgO4OPhyVR7thjtINaLoXD1QZbZqfH7nvu6+
	flO0XUuhL9reMUFIoqKgAmWVpEdGHNffJWTEe7d5LdjmaX7xTbTdtAEn518obGrk69hYJlDUtQ454
	knM84mA8YRSQoWe0a0GehVR416zCJiFlQLFmKi2vNK6/Q7H6mvA8eCRMGnTg73FqBmeYPzXjW96EH
	RjOk7t+T76ia/AN5kpEO6kZO9bZLDGGJfZjA8MM17d/nCkoWqjbHknFGjF1TbwUK52iHVEG33NHUr
	JUJgM+Yg==;
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoT-0000000Fg6s-0S00;
	Tue, 12 Aug 2025 05:44:48 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfCt5JZT5TLY1vTOkO3zmfWoCgmYOOlaa/RcOHdKaps=;
	b=zocDmbkM7SrtEfoMUMLk7syduA2FoS07iTJjRQxpoxVtJk6FCTcA63FHi4HDZhjOydKkAT
	DrrV0zBYz8rfc084esfgs4uuXAkhxzoVwcqdSmF7BEFWQKKsdlPKcE3LkSmnxFYonNODFZ
	2sN1ZNTgiR2KEOVXZQEVEMIVuHADKnDkoOaaebcfpKh5m4MlO1i3mxd6K0dfDn4f2gzo2k
	hM+ll5vK+/7O/uRdgK7BcmGop+bMKCmttdkUi9IyiFrD6fxo3aGU/1dH+Y4ccEvyjf/xRm
	ukysMSWz8XN0tHKKSQ2jKT60/8Q/5ewwHZkK0m/GvkKLUmwKhqnNwsd4lL/hmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfCt5JZT5TLY1vTOkO3zmfWoCgmYOOlaa/RcOHdKaps=;
	b=d4tRasLSDVTIK2B95jsGzJ+ah9uconnEpGunOzkAkX0RhJ6u8QF5Rm6WA7PtZmvXd7GJ+4
	tmhczEYwE7G4MtAQ==
Date: Tue, 12 Aug 2025 07:44:25 +0200
Subject: [PATCH v4 12/24] x86/vdso: Enable the vdsocheck tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-12-61a8b615e5ec@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=3221;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=y8zJkYgbdBbZEV0tFUnY1VVHpY6kpQMx7JNEIl5bx6U=;
 b=fENeUAc8ExvUZD2cHV52CW4BlgBth0NPCMcPLk1EKHf1hnG4lTQ/vRhPMnJvsZZXuIYsNnulZ
 VQ7lpvqs+SzB4XtQHOZ7OgLms0zrQWlEQppNKDCg82HN7J6F262h/0M
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_064446_711873_72F0E536 
X-CRM114-Status: GOOD (  11.06  )
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
 arch/x86/entry/vdso/Makefile |  6 +++---
 lib/vdso/Kconfig             |  1 +
 lib/vdso/check/vdsocheck.rs  | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index f247f5f5cb44dad706701dd5344c9a8031deffc1..9da9cdf8c976ccebac1429afd244d4c9ea6ef5fa 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -35,7 +35,7 @@ CPPFLAGS_vdso.lds += -P -C
 VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 \
 			-z max-page-size=4096
 
-$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) $(vdsocheck) FORCE
 	$(call if_changed,vdso_and_check)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
@@ -108,7 +108,7 @@ $(obj)/%.so: OBJCOPYFLAGS := -S --remove-section __ex_table
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
-$(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
+$(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) $(vdsocheck) FORCE
 	$(call if_changed,vdso_and_check)
 
 CPPFLAGS_vdso32/vdso32.lds = $(CPPFLAGS_vdso.lds)
@@ -144,7 +144,7 @@ endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
-$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) $(vdsocheck) FORCE
 	$(call if_changed,vdso_and_check)
 
 #
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index b461e2be6db80eae957c8e0a1ab573a85d78fd15..e9215084462dfb33a5cd55a57171d2ec4295a270 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -51,6 +51,7 @@ config GENERIC_VDSO_DATA_STORE
 
 config HAVE_VDSOCHECK
 	bool
+	default y if X86
 	help
 	  Selected for architectures that are supported by the 'vdsocheck' progam.
 	  Only transitional.
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 3c421100a91740ce3735edfbc9837ef49f55d8f8..c4feb75f93ec0a6a153a758ee7a51cc6f2f58bf1 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -34,6 +34,18 @@ fn is_ignored_section(&self, section: &elf::Section<'_>) -> bool {
 
 fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'static>> {
     match machine as u32 {
+        bindings::EM_386 => Some(AllowedRelocations {
+            ignored_object_file_sections: None,
+            in_object_file: &[
+                bindings::R_386_PC32,
+                bindings::R_386_GOTOFF,
+                bindings::R_386_GOTPC,
+            ],
+        }),
+        bindings::EM_X86_64 => Some(AllowedRelocations {
+            ignored_object_file_sections: None,
+            in_object_file: &[bindings::R_X86_64_PC32, bindings::R_X86_64_PLT32],
+        }),
         _ => None,
     }
 }

-- 
2.50.1


