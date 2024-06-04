Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D0FC25B78
	for <linux-um@archiver.kernel.org>; Tue,  4 Jun 2024 22:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5BFhMURlOxwbCZPlt3t+cMRvFnuBznLgUYvajgNDozE=; b=LUUuKnH7kpp5E1e9XfApMGWLkH
	ohxcPs/DS7IDWykxYwEJxhxHCPvWxeWK3U43df5YgEmet1kZqWBgXosLEyJhTFPf8WQ8EATybc8GU
	cUKD3XVjlz9cggn5+okMcsGO8opjvtvHq/mfH4NL/AMoVpRRgId5PNH7suvHvHyXBppFBIyH6fPQ7
	Q9OI3yu4AeS7oX7s16B/pWBCTxI6NRAlD1Clxv64E9qF6x1fXqOilmt6nTDrwZS+l3dAEY6hpBE2i
	emZq9s3BFftqMqXPnCS7NF7yoPCJhah8gGdw5SXINVM4DmYFpUJt9Kw4K7Qf/MZBwKgg2XQRpAGzT
	YJw/jnPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcqO-000000045C9-266G;
	Tue, 04 Jun 2024 22:41:28 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcqL-000000045Av-000U
	for linux-um@lists.infradead.org;
	Tue, 04 Jun 2024 22:41:27 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dfa72779f04so8221516276.1
        for <linux-um@lists.infradead.org>; Tue, 04 Jun 2024 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717540882; x=1718145682; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5BFhMURlOxwbCZPlt3t+cMRvFnuBznLgUYvajgNDozE=;
        b=DUoi5BVAxWHutEiMf3LD+h7soLGnHl9QefzOrh9ANW8fXNvsi3sRcqE7QK11jpPPhr
         oqWfkFTXWWmo06Nc8/AJhBN8ZKtfQ8bBa2pvId2hdcE127cDbkxu5hBAe3ZzrCguKrYl
         1T8N+DSPxOz0p8H6LYeHWUZOL1AIHSlBQdXNH3ZIW/3OyZg+MNSBLFrUq21ai4dEtAGE
         c8YNdJb7/EILUXMenh9qc25IumGKeujV36RlWePf7wQgU5HW5uAqd66PgYRLKsqpSmhL
         vQ6eqgvU1u8+CFnlIf0P5DaE+KaHkAixigtiShev4NQZyib2+VmvQ6KDrkte1XhVnnZz
         W/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717540882; x=1718145682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BFhMURlOxwbCZPlt3t+cMRvFnuBznLgUYvajgNDozE=;
        b=l7iIZ6AjxJ1B6et57eCSomb2gBOQZg4IC6hyw9aoWbA5qOGKdwif8KR6GB/tN826rT
         6ZIzGEI0+Oo9J9fSlP7yLeV/+lhbwiGFVo7/MLedp011btGDye9ryozStvBqPOSsQSUK
         6/4fqObRAkvtVI2HUtSoRLfAA4NiQHENh7pulvGqeFIhXsoat8usbxMyU00AnEPvCrTi
         vG3zUmn2or7sjlVjUMD18nDGo8D4xvsSPCL/FxomYTGVpvLui8Gqm1rmP2pTYNa8+ijv
         keo2k34+WTWXtSlLeiTtw6zCl6PtSTob+zgTTdpo1o2EKRQlJoB1n2fFdCGCIcr5FwIC
         /L9g==
X-Forwarded-Encrypted: i=1; AJvYcCV7n1GCbv/wYWpZY56uULPsHAWMkQver8WSr1N0UDdV0KSbuv/UYybPgegVklTBZ54zhRC2tkJ9BlW/O+w4AVoXrrPNOY2FOL0BowNx
X-Gm-Message-State: AOJu0YxP+WnVLshkS/x3ZoOG52grmk4JAxERYYxkzwScNcAOTp+F7kNV
	Gyo8zKL8JjOseUmGJMHEQ9kex8jBqu7iUn/iRhecy+BuGM/c9f5SkQp6ouvi4r1A8oOGU3Q8k7P
	ATzP1XF6p2w==
X-Google-Smtp-Source: AGHT+IFe9doWPRL9bdOBiprw606KPAUV1/yCDGjKHg9/0f16jSpDeFrPKk08bm1aGwBuEsC7VjTpzn499oFw4w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:120d:b0:dcb:e982:4e40 with SMTP
 id 3f1490d57ef6-dfacad28c85mr236994276.12.1717540882585; Tue, 04 Jun 2024
 15:41:22 -0700 (PDT)
Date: Wed,  5 Jun 2024 06:40:50 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604224052.3138504-1-davidgow@google.com>
Subject: [PATCH] arch: um: rust: Add i386 support for Rust
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_154125_078344_D9358E3E 
X-CRM114-Status: GOOD (  14.87  )
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

At present, Rust in the kernel only supports 64-bit x86, so UML has
followed suit. However, it's significantly easier to support 32-bit i386
on UML than on bare metal, as UML does not use the -mregparm option
(which alters the ABI), which is not yet supported by rustc[1].

Add support for CONFIG_RUST on um/i386, by adding a new target config to
generate_rust_target, and replacing various checks on CONFIG_X86_64 to
also support CONFIG_X86_32.

We still use generate_rust_target, rather than a built-in rustc target,
in order to match x86_64, provide a future place for -mregparm, and more
easily disable floating point instructions.

With these changes, the KUnit tests pass with:
kunit.py run --make_options LLVM=1 --kconfig_add CONFIG_RUST=y
--kconfig_add CONFIG_64BIT=n --kconfig_add CONFIG_FORTIFY_SOURCE=n

An earlier version of these changes was proposed on the Rust-for-Linux
github[2].

[1]: https://github.com/rust-lang/rust/issues/116972
[2]: https://github.com/Rust-for-Linux/linux/pull/966

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/rust/arch-support.rst |  2 +-
 arch/um/Kconfig                     |  2 +-
 rust/Makefile                       |  2 +-
 scripts/Makefile                    |  2 +-
 scripts/generate_rust_target.rs     | 17 +++++++++++++++++
 5 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index b13e19d84744..750ff371570a 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -18,7 +18,7 @@ Architecture   Level of support  Constraints
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
 ``riscv``      Maintained        ``riscv64`` only.
-``um``         Maintained        ``x86_64`` only.
+``um``         Maintained        \-
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 93a5a8999b07..b6ac49fec5bb 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -31,7 +31,7 @@ config UML
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
 	select HAVE_ARCH_VMAP_STACK
-	select HAVE_RUST			if X86_64
+	select HAVE_RUST
 
 config MMU
 	bool
diff --git a/rust/Makefile b/rust/Makefile
index f70d5e244fee..83f675adbfab 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -426,7 +426,7 @@ $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--re
 $(obj)/core.o: private rustc_target_flags = $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 	+$(call if_changed_dep,rustc_library)
-ifdef CONFIG_X86_64
+ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
 $(obj)/core.o: scripts/target.json
 endif
 
diff --git a/scripts/Makefile b/scripts/Makefile
index fe56eeef09dd..dccef663ca82 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -12,7 +12,7 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_builder
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_gen
 
-ifdef CONFIG_X86_64
+ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
 always-$(CONFIG_RUST)					+= target.json
 filechk_rust_target = $< < include/config/auto.conf
 
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 641b713a033a..87f34925eb7b 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -169,6 +169,23 @@ fn main() {
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
         ts.push("target-pointer-width", "64");
+    } else if cfg.has("X86_32") {
+        // This only works on UML, as i386 otherwise needs regparm support in rustc
+        if !cfg.has("UML") {
+            panic!("32-bit x86 only works under UML");
+        }
+        ts.push("arch", "x86");
+        ts.push(
+            "data-layout",
+            "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i128:128-f64:32:64-f80:32-n8:16:32-S128",
+        );
+        let mut features = "-3dnow,-3dnowa,-mmx,+soft-float".to_string();
+        if cfg.has("MITIGATION_RETPOLINE") {
+            features += ",+retpoline-external-thunk";
+        }
+        ts.push("features", features);
+        ts.push("llvm-target", "i386-unknown-linux-gnu");
+        ts.push("target-pointer-width", "32");
     } else if cfg.has("LOONGARCH") {
         panic!("loongarch uses the builtin rustc loongarch64-unknown-none-softfloat target");
     } else {
-- 
2.45.1.288.g0e0cd299f1-goog


