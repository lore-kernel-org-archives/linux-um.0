Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD17CD5BC9
	for <linux-um@archiver.kernel.org>; Thu,  5 Sep 2024 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z2B0F8060umJHdopRQNGtZEBNjqM4wVRBCzxrvcUhSw=; b=SwptytHn+JJ4agpBBdtJdEpBTr
	64U598OsANMAHpvlc6uaH1uMymB1/Bv1040VKWe3px+/l94y/NZCPj0OTh2iv+u6A74kIa0pV2SNL
	YwHGECX+K919/L6hSJrfXU+qp0w7JUwtpB4dy8LiWxMhm1LA/A691Wu/gFl+gx6tSX7c74PaSkMdY
	Fa8sAa9VK5opqLZNiS0TkKqcAKA6GZ4HNT86OSDu3L2fXXL9glv55emYqml17sKOWIlB5HWqYsEvh
	8fPNuxqN9LWbt+8+sTaRU/7+xamZbsWudBl/62sbwLO0hxLwey0CwaOL91AVSCWaefwS4DzhGmyrj
	AyrYExXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smCcY-00000008YD4-33WV;
	Thu, 05 Sep 2024 13:33:58 +0000
Received: from fout3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smCc8-00000008Y3V-1sXN
	for linux-um@lists.infradead.org;
	Thu, 05 Sep 2024 13:33:34 +0000
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E231138026D;
	Thu,  5 Sep 2024 09:33:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 09:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725543211;
	 x=1725629611; bh=z2B0F8060umJHdopRQNGtZEBNjqM4wVRBCzxrvcUhSw=; b=
	DUFu6lhN0qGUhUYatTxIHgIP6kNGLyzy1blThsogwkg/3YJpEEBIwCKMlq7I0x1Z
	oNoQpZ7ZheO+hVtlcv1fYCYq0CtsOuy+HKefI8MWS0ZeJaelN7SuOW8O6ZUXrlJt
	uU4qjMH6EuOul/uAKLiSvEeJkShmOkA9Jwwy5p5M8Yfz+uWlTrRBo53fEH9KXY40
	0yZ8ycmK43QeHVOIt6J3CqM05Ukl9bQwSMsHXMWXLdv9hq7IJunrKt8nVwKIE3DC
	72Br4R32cdWaCV0zXCznxc+4/lCjeg6gjLTlIKzV6RrV9Gr4lm3Z+PX45ocQkjOy
	gcwLmR3WuFRHE21bU32Ccw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725543211; x=
	1725629611; bh=z2B0F8060umJHdopRQNGtZEBNjqM4wVRBCzxrvcUhSw=; b=h
	CRduZd0GkqMWAd0FuBYs1gHD3z8D+TUxc1eo7fMCVsiIYH3kObPBA/342p5kcXg9
	GxyRnK1t0guZHd7ZQo3Piq60+XURaNkjhXRwue3GC1TftadQbqdPLOdBMqc8r+H1
	jn3e3/jAR/HKeqwpz5wqlAhRDiTw8ey7B33eHHw9GLZjYB3397AgnhERzjZ95wjI
	TPzwx2CbDmQR45ldUA8hCNeuRkHLP8qudFe7IFqWE22Sb53Kr/UVw3L2tMB+BYzs
	K+bU/hx8BZfGXIbONG2oJj4BQljaPFU/pqrMIrd+khsmwZq1Kze1Ph5WKIxnvkfI
	fd//X7b4hXlRN0BZQ0hUA==
X-ME-Sender: <xms:K7PZZikKuo4dBB9dwPUZk80GPVNUM3Zvo_WEJlipLLW0vdx7xKKPIQ>
    <xme:K7PZZp1FGR5i7xRiXcWunZ-3fIAK0OGYYWNQmPAeFcO42mDdrcHBKDGcjS3gyAoJf
    nhJgsy3BRbVoSOV6-k>
X-ME-Received: <xmr:K7PZZgoKas-EFPjTj6M2xizcnuAFOIOEgq-HxZV-La4ZM9Wzo8NIm0CNfS7AAZcF4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepledutdeigeehvdegkedvudevffdt
    hedttddtjeevuddtgfektdekgfdtgedtieevnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehj
    ihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeegtd
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhguvghsrghulhhnihgvrhhssehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhh
    ihhrrghmrghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgh
    esshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothho
    nhhmrghilhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhmihhpshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K7PZZmmuRsdvqfTkmRryL-SDkL3pNEWsJoFpaoneO3Qet3U9AWJMvA>
    <xmx:K7PZZg1d2myNx9xVVoFzDWf_ZFLSYvoPZl-Vq7FoDLyn0B-enpRdbw>
    <xmx:K7PZZtvodRceTSBHOW1A5rJfgMLO7_6byu6CKbSfLqTyr4rLQYf54Q>
    <xmx:K7PZZsV46vKg8iGkmtpIP5NYFvd4GbSUI3YZoAKgjBiaCmNlJ0EKvg>
    <xmx:K7PZZppfaojp8iFBlAPZHohDQMbFXKzobUe2qMIZfC1yh3KPpusjNJvt>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 09:33:27 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 05 Sep 2024 14:33:07 +0100
Subject: [PATCH v2 3/3] rust: Enable for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240905-mips-rust-v2-3-409d66819418@flygoat.com>
References: <20240905-mips-rust-v2-0-409d66819418@flygoat.com>
In-Reply-To: <20240905-mips-rust-v2-0-409d66819418@flygoat.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
  Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,  Richard Weinberger <richard@nod.at>,
  Anton Ivanov <anton.ivanov@cambridgegreys.com>,
  Johannes Berg <johannes@sipsolutions.net>,
  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
  =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,
  Andreas Hindborg <a.hindborg@samsung.com>,
  Alice Ryhl <aliceryhl@google.com>,
  Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
  Steven Rostedt <rostedt@goodmis.org>,
  Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,  Jonathan Corbet <corbet@lwn.net>,
 Alex Shi <alexs@kernel.org>,  Yanteng Si <siyanteng@loongson.cn>,
  Nick Desaulniers <ndesaulniers@google.com>,
  Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-um@lists.infradead.org, rust-for-linux@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, llvm@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5800;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=dVkj/exm1KSiU0b/0TGp9u+BBn+LGdFz9eAdIeMiN8A=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSbm8Xny0wpaS6zMgrh3PNl5YuLz+8Zsv5d7N0mF9oho
 p24+WxwRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExEIJaRoe9RxA3OG0se3WJ6
 lOPL4i1dUTfX6Kdsc/8qDvWVAusyXjAydDeeWrP5vHfo5tqXnse38Po/+p/++EsJD/+NDq7tRj0
 H+AE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_063332_618517_BAA2DB10 
X-CRM114-Status: GOOD (  13.02  )
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

Enable rust for linux by implement generate_rust_target.rs
and select relevant Kconfig options.

We don't use builtin target as there is no sutiable baremetal
target for us that can cover all ISA variants supported by kernel.

Link: https://github.com/Rust-for-Linux/linux/issues/107
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2:
	- Add micromips flags
	- Sync issues with upstream
---
 Documentation/rust/arch-support.rst                |  1 +
 .../translations/zh_CN/rust/arch-support.rst       |  1 +
 arch/mips/Kconfig                                  |  2 +
 scripts/generate_rust_target.rs                    | 68 ++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 750ff371570a..ab6c0ae5a407 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -17,6 +17,7 @@ Architecture   Level of support  Constraints
 =============  ================  ==============================================
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
+``mips``       Maintained        \-
 ``riscv``      Maintained        ``riscv64`` only.
 ``um``         Maintained        \-
 ``x86``        Maintained        ``x86_64`` only.
diff --git a/Documentation/translations/zh_CN/rust/arch-support.rst b/Documentation/translations/zh_CN/rust/arch-support.rst
index abd708d48f82..1eaa6c3297ac 100644
--- a/Documentation/translations/zh_CN/rust/arch-support.rst
+++ b/Documentation/translations/zh_CN/rust/arch-support.rst
@@ -21,6 +21,7 @@
 =============  ================  ==============================================
 ``arm64``      Maintained        只有小端序
 ``loongarch``  Maintained        \-
+``mips``       Maintained        \-
 ``riscv``      Maintained        只有 ``riscv64``
 ``um``         Maintained        只有 ``x86_64``
 ``x86``        Maintained        只有 ``x86_64``
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 43da6d596e2b..a91f0a4fd8e9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -90,6 +90,8 @@ config MIPS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
+	select HAVE_RUST
+	select HAVE_GENERATE_RUST_TARGET
 	select HAVE_SPARSE_SYSCALL_NR
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 863720777313..bbdf8a4dd169 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -141,6 +141,13 @@ fn has(&self, option: &str) -> bool {
         let option = "CONFIG_".to_owned() + option;
         self.0.contains_key(&option)
     }
+
+    /// Returns the value of the option in the configuration.
+    /// The argument must be passed without the `CONFIG_` prefix.
+    fn get(&self, option: &str) -> Option<&String> {
+        let option = "CONFIG_".to_owned() + option;
+        self.0.get(&option)
+    }
 }
 
 fn main() {
@@ -203,6 +210,67 @@ fn main() {
         ts.push("target-pointer-width", "32");
     } else if cfg.has("LOONGARCH") {
         panic!("loongarch uses the builtin rustc loongarch64-unknown-none-softfloat target");
+    } else if cfg.has("MIPS") {
+        let mut features = "+soft-float,+noabicalls".to_string();
+
+        if cfg.has("CPU_MICROMIPS") {
+            features += ",+micromips";
+        }
+
+        if cfg.has("64BIT") {
+            ts.push("arch", "mips64");
+            ts.push("abi", "abi64");
+            cfg.get("TARGET_ISA_REV").map(|isa_rev| {
+                let feature = match isa_rev.as_str() {
+                    "1" => ",+mips64",
+                    "2" => ",+mips64r2",
+                    "5" => ",+mips64r5",
+                    "6" => ",+mips64r6",
+                    _ => ",+mips3",
+                };
+                features += feature;
+            });
+
+            ts.push("features", features);
+            if cfg.has("CPU_BIG_ENDIAN") {
+                ts.push(
+                    "data-layout",
+                    "E-m:e-i8:8:32-i16:16:32-i64:64-n32:64-S128",
+                );
+                ts.push("llvm-target", "mips64-unknown-linux-gnuabi64");
+            } else {
+                ts.push(
+                    "data-layout",
+                    "e-m:e-i8:8:32-i16:16:32-i64:64-n32:64-S128",
+                );
+                ts.push("llvm-target", "mips64el-unknown-linux-gnuabi64");
+            }
+            ts.push("target-pointer-width", "64");
+        } else {
+            ts.push("arch", "mips");
+            cfg.get("TARGET_ISA_REV").map(|isa_rev| {
+                let feature = match isa_rev.as_str() {
+                    "1" => ",+mips32",
+                    "2" => ",+mips32r2",
+                    "5" => ",+mips32r5",
+                    "6" => ",+mips32r6",
+                    _ => ",+mips2",
+                };
+                features += feature;
+            });
+
+            ts.push("features", features);
+            if cfg.has("CPU_BIG_ENDIAN") {
+                ts.push("data-layout",
+                        "E-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64");
+                ts.push("llvm-target", "mips-unknown-linux-gnu");
+            } else {
+                ts.push("data-layout",
+                        "e-m:m-p:32:32-i8:8:32-i16:16:32-i64:64-n32-S64");
+                ts.push("llvm-target", "mipsel-unknown-linux-gnu");
+            }
+            ts.push("target-pointer-width", "32");
+        }
     } else {
         panic!("Unsupported architecture");
     }

-- 
2.46.0


