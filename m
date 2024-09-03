Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87061CD37AC
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuOQA+LeEAdoUFaZ37LQtKXkaxwkMq+TFIrVUVu3PCI=; b=HS8T7DpVrXvSDGg4h9VacP+HUP
	qarFOcFNPZAfO16CxztzWKLNfFAXJO0WRM0xPuLzCpyi8gdWUotJmoKj4v+3mJ2sg4r5qUbDjM4Ft
	aAeKuy9OhEoDEXlNR6SB5ZoQKntLASrQBOJixxCnLbdkO9FfN3+P2tWHn+Bm2L2TqH+ohYIXvwm7V
	t1ZPENzGzKYNF30kRhcWRaHayABk1WF6GVmyOdiwvswFyOzkPtcksCxw4t2KIvvdaiEo2lZ7ozkW9
	hz+9PlmatyooZ379RkZqth88X8NzR0r1obAUXqxRbneHwy3VyoMzeL6XoxAfi0NtfTzQ9IZM4r9VW
	DLpvIqvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slX8Y-00000001GLk-0Rlv;
	Tue, 03 Sep 2024 17:16:14 +0000
Received: from fout7-smtp.messagingengine.com ([103.168.172.150] helo=pfout7-smtp.messagingengine.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slX7T-00000001Fye-0ij4
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:15:09 +0000
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 79CAF13804B3;
	Tue,  3 Sep 2024 13:15:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Sep 2024 13:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725383706;
	 x=1725470106; bh=HuOQA+LeEAdoUFaZ37LQtKXkaxwkMq+TFIrVUVu3PCI=; b=
	PGuwc2O7DwWjBrPB/HKNhxJICtLiALHZ1BvRvWhStXJ8gnqzOKoSj6tt+R5nVX6t
	p1dIbQsCr7zQf8DsXXR2Oek+J1+vqhuJGF14O5PpfQ3garbuuuQsNwvQOUQ9MBwP
	RVlx3czKkoMfBGWyhpFJ96WqloomWnOyjPJpFlCcflJ/OK436iABaL8nhj2//JjS
	kz34DAHoDTKfm6cVaVWlm60akXnBTuMneRKZRYI5G7xBGLtGDRL/gHnRxCIA+AmH
	6Zuo52n3sA0k3y3cWIZVJ6gTZ2Tl2azNohLUV3Lj0rF/bAPMZUIwgjfp3x2Di48X
	px2go0KzFiAvMF7Z46iNRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725383706; x=
	1725470106; bh=HuOQA+LeEAdoUFaZ37LQtKXkaxwkMq+TFIrVUVu3PCI=; b=B
	Y+gPJ6xKRVodzijUaby+sjD5jFg9SiXGR3XGY0bQRk7ETcC3+NDuiQ3zjkau9P+v
	KCWNkVHKJGqyqOgV9+HE7lFl6BZ7oh6H274Jsjxai939dpWUMOS/0cAE/LghvvKv
	qT4Vqwgvx7GZY4xwZVdoafNHeMd0PFS/JbePDE6NOoHTMxSDAKsMped2ViA3i3U3
	3BPGLFqY8pf43twKczdhuu+xqIMBYqa5zomCDIVaGFVvwVYuTK25DFVlpVdAP8zx
	NCXRnGZfkXHLtRDk6xmpwh6DoindffxQZA2EQYTn1Q8qWpgqQWJ7DCiFrwPfm634
	j51/RoFZfHvXNJDVzryYw==
X-ME-Sender: <xms:GkTXZmeoOPdvZ1b_ZQmciHfvsJ-BxhmHcvZG3WsWaIc0BDQHx8nMYQ>
    <xme:GkTXZgNaVgNECtXozOoHtnUHuV2o-4HGOm-NimSqiZ6tv2_cAA_uR55IYvT5lcl3b
    KIsOAq3WHiPs3l8mxA>
X-ME-Received: <xmr:GkTXZnhdx4yoRzNWnoLc6YZNwpZoZjPbts1RH9RlHcB2a_fzlQ5may4_JrylB79miQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeluddtieeghedvgeekvdduveff
    tdehtddttdejvedutdfgkedtkefgtdegtdeiveenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    jhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohepge
    dtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnnhhordhlohhsshhinhes
    phhrohhtohhnrdhmvgdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrg
    hnkhgvnhdruggvpdhrtghpthhtohepjhhohhgrnhhnvghssehsihhpshholhhuthhiohhn
    shdrnhgvthdprhgtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggvvhdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehrihgthhgr
    rhgusehnohgurdgrthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgt
    phhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GkTXZj8IYI7dI92I0_MYtdb_HIlXnibQ7wxyeLQtMhuVx4RCvdcXtw>
    <xmx:GkTXZivho173yDKeYcCw9hujA3wz7ElCXRh3d5Mx6Fgbhw4GuIbV1Q>
    <xmx:GkTXZqEdnuYO6OjiOMTzmTmPmtd7ooTorLpmsUySibmwjOplhNMoLg>
    <xmx:GkTXZhPV-qCB7MMJ_qMZvx4-IbQqPgm1_riv-TWVkl9sN3ZSSlpN8A>
    <xmx:GkTXZoh5Ub0a4dAtz66ne4zEgREEXStWNJ82FUgMHemip19CHmOibpS2>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 13:15:02 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 03 Sep 2024 18:14:36 +0100
Subject: [PATCH 3/3] rust: Enable for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240903-mips-rust-v1-3-0fdf0b2fd58f@flygoat.com>
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
In-Reply-To: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5640;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=dTzaFLygGDWP88YqbuvgFJnSRc3/FfsgZOCccEPIFZI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTrLmy/VbhlTd99/7KW13KPufKGBw0FkU1B7Dszj5oUa
 Qn6Pl/ZUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABPZNZeR4eFshrNzVwhttrhd
 0yf5Z2d9yQ2X7gU8oWbsP76u15z0Q42RoefwMqE02eP7ns+pn328K6qhZqVvJm/ItXsCWye+OCD
 HzwwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_101507_397190_CD76F114 
X-CRM114-Status: GOOD (  13.06  )
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
 Documentation/rust/arch-support.rst                |  1 +
 .../translations/zh_CN/rust/arch-support.rst       |  1 +
 arch/mips/Kconfig                                  |  2 +
 scripts/generate_rust_target.rs                    | 64 ++++++++++++++++++++++
 4 files changed, 68 insertions(+)

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
index 863720777313..2b8054f17c47 100644
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
@@ -203,6 +210,63 @@ fn main() {
         ts.push("target-pointer-width", "32");
     } else if cfg.has("LOONGARCH") {
         panic!("loongarch uses the builtin rustc loongarch64-unknown-none-softfloat target");
+    } else if cfg.has("MIPS") {
+        let mut features = "+soft-float,+noabicalls".to_string();
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


