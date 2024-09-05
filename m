Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFA3CD5BC5
	for <linux-um@archiver.kernel.org>; Thu,  5 Sep 2024 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0L6FxNpj/PudHapXC4OU2emJoWIjVzEfXLmyz4x/E4E=; b=lW3tkdziIeTW06
	P9hf3a45O9X/6Xxf/0xFOpYaPumIlCFpbFXJNOJ217VJVAQ9VwZNdBIft8rvZt6x80aF/vXRZT91s
	SQydWflLYzt0DH8LP7XKFcxIDawEdUwYLakpAHBuJhSwTQCcmoQ3Td/IWNVX2kUjSl+Tx8+0ftHC9
	pgKjyiIk6FkbKeEmHoy+9f+r7tm+/dZdTO+v0aZGeIdeSwP9EI2hQItBu2UxuxdwCCb6hEU5/SToQ
	wH5QQ4axndh8PP/vxWyt9tMYpV6I/E04l841UQbEL2TKdsR4twHmPG0owAPhaYaEVWBpB5oeHbBdQ
	tCSkUL4ggqBXJCieX1bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smCcW-00000008YBN-30it;
	Thu, 05 Sep 2024 13:33:56 +0000
Received: from fhigh7-smtp.messagingengine.com ([103.168.172.158])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smCbw-00000008Y08-2phO
	for linux-um@lists.infradead.org;
	Thu, 05 Sep 2024 13:33:22 +0000
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB1F31140263;
	Thu,  5 Sep 2024 09:33:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Sep 2024 09:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1725543197; x=1725629597; bh=0L
	6FxNpj/PudHapXC4OU2emJoWIjVzEfXLmyz4x/E4E=; b=PdMvnsb/OntTB8LKjc
	4FMd2sBTGmsLLu7Qc6v5dKt9ugU47ve2tbKW8tRsjwTvSOpa7BFJ0APLPQlLss7m
	304fSR9XiLY6NlDBY7eVdXG0kX9uPdhd9IJiK5ZD4dgzi17d54p3+tCAnIank3fw
	610VKgvDZDpuCLRwLK0UlC84k5BYptDelvRbuqCNiGobkfDgUN0Mjmo6w9+N3oyf
	sNI9SCjfGckTG8tLsCX/avX1T+SCE3oUuolSbW1DCbBdszdSr0PMnaPmwKb8NdYi
	HcUZxqr29LMq/cxocz4vlmj2AY2ufhPdWBkYUpff33U6V7C+TaL2RVoTQjJzeDHf
	76JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1725543197; x=1725629597; bh=0L6FxNpj/PudH
	apXC4OU2emJoWIjVzEfXLmyz4x/E4E=; b=Y+Nnp21aOOWlw1BXngSS0dK3Oq92o
	KQ5ffLqsYD+FSSZmFj5MID8NjE4uHa8QyOLkcI2U8v4Jr9gXcUa6qBAIFdVL8tGv
	sg1e1/w6q0M7cVrNgrdhOkQXmKMF9HQygSZSHd3dew5Hc3kWSUrTeO/0r7uZGDxv
	+Yrla2VmFJIXWiWqN8TIvXkTq21kb+atxoGVcqd+OJ5qcHODTUCi5UFG4E9MqDRV
	GWn2dW0cEumSKmBoymeXWZeJqibVzLkXkYnms3BUDwtzfh7HJKbg+RNO93cx9JvZ
	NRa6dhPtGQE9bXVY/hByM9O4KT5Bz6HvsE2qcM5DiL1m+/CsRApzVdB6Q==
X-ME-Sender: <xms:G7PZZmnLsLylXlG6CQGcPrlbeUbLhLJ2zr3dfhFTXOofyhf78O45MA>
    <xme:G7PZZt0NyQjzXWRGWkZWn_HzrTqE5Z8Af29Nh_g-lriJz7k7nnS-gzs_Cc0VqiIPV
    TTHYWk44hc8-W_hR80>
X-ME-Received: <xmr:G7PZZkrNK8WgPaP8q-p8iZyBsyn8bVgW4tRzsqvlm24rtEH7JJ_V6_iznrNJo_juhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomheqnecuggftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeu
    gfegvdeuueejkeejteekkedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
    gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeegtddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepnhguvghsrghulhhnihgvrhhssehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtph
    htthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhr
    rghmrghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrghessh
    grmhhsuhhnghdrtghomhdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhm
    rghilhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhm
    ihhpshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G7PZZqlQMv-YYB0XC88UY0jLTGZdF5L2Q-PtRXFzE349eMlE-oSi1A>
    <xmx:G7PZZk3y8wLJx7CTmrlsU_VCnz_yRFWNLstW-KImm0MMNawWM81JNg>
    <xmx:G7PZZhv1cRNHSfodrQXmL5dPrHRxtuJzSQr8sthoPTKc8j7PaViZFw>
    <xmx:G7PZZgUwPXtfzod7pnnUm_Ui6vsW6b5N_qtKmbHHY0F7BgVG7kM-FQ>
    <xmx:HbPZZtoSbg8Issh36bt-E_kNQL2RrHmisjXXArIsRPGKKIQsrMcS9Ym->
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 09:33:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/3] rust: Initial MIPS support
Date: Thu, 05 Sep 2024 14:33:04 +0100
Message-Id: <20240905-mips-rust-v2-0-409d66819418@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCz2WYC/23MQQ6CMBCF4auQWVtTipriinsYFrWdgUmEkrYSC
 endraxd/i8v3w4RA2OEe7VDwJUj+7mEOlVgRzMPKNiVBiXVRbayERMvUYR3TIKMRnK6uVlsofy
 XgMSfw3r0pUeOyYftoNf6t/5T1lpIIcmRfCpyV00dvbbBm3S2foI+5/wFnrA6GaQAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=qjUaAPTaliz5J4cRsvrBexPWV1blwkxxWIdH50rGLzI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSbm8WDZl+5WGVsyf1um8wVFU1W6U2W0X3qSl9Ppe27O
 eUcK4d1RykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzk+S+G/3GGcy7/1rDjUWn5
 7r3Wwaiz+uCjNbYZWflG/gv/562f/Izhf1HrrqVry4N7Pys8+F3ncCC266zR/9i8mc2+weJhCeV
 zuAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_063321_100166_31EDBF63 
X-CRM114-Status: GOOD (  11.41  )
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

Hi Folks,

This series added MIPS arch support to rust for linux,
hopefully MIPS is not too late to the party :-)

Sample rust module tested on R4000(el),mips32,mips32r2el,mips64,
mips64r2el,mips64r6el.

Please review.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Address review comments on wording & style (See individual commit messages)
- Add microMIPS support
- Link to v1: https://lore.kernel.org/r/20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com

---
Jiaxun Yang (3):
      rust: Introduce HAVE_GENERATE_RUST_TARGET config option
      MIPS: Rename mips_instruction type to workaround bindgen issue
      rust: Enable for MIPS

 Documentation/rust/arch-support.rst                |  1 +
 .../translations/zh_CN/rust/arch-support.rst       |  1 +
 Makefile                                           |  3 +
 arch/Kconfig                                       |  8 +++
 arch/mips/Kconfig                                  |  2 +
 arch/mips/include/asm/dsemul.h                     |  2 +-
 arch/mips/include/asm/inst.h                       |  6 +-
 arch/mips/kernel/ftrace.c                          |  2 +-
 arch/mips/kernel/kprobes.c                         |  2 +-
 arch/mips/math-emu/cp1emu.c                        | 18 +++---
 arch/mips/math-emu/dsemul.c                        |  8 +--
 arch/um/Kconfig                                    |  1 +
 arch/x86/Makefile                                  |  1 -
 arch/x86/Makefile.um                               |  1 -
 rust/Makefile                                      |  2 +-
 scripts/Makefile                                   |  4 +-
 scripts/generate_rust_target.rs                    | 68 ++++++++++++++++++++++
 17 files changed, 105 insertions(+), 25 deletions(-)
---
base-commit: 469f1bad3c1c6e268059f78c0eec7e9552b3894c
change-id: 20240903-mips-rust-fa8efd836ce9

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


