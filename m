Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9EDCD37A9
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dBUfKeVf2UEZTsAZiC5iNPpiBQ1B2GtTe75No1Oz86U=; b=ntPbpJlR4yef1s
	GSROB4Sb+5M5t+NjaeOu1z+rOQnlguQ33uA+PAuvPOwLKY8lGxeDEWtopm2VFnpum+Hlt45WiE6Gv
	hmlJS7HvejCIM8vJtFh98vz8NCOSA27KjiWYZE5fTu9EErNSvJT2ZEycV4PtRchwT9chCfdB+cA97
	//GiNkpq581KUTDzGmvtAtJxYWwRd2nVbPptK+ipDCBIvKJMVoDiKhNpB0h9wyaam8KF3PVYwjPYf
	KdJsjBvQXfUnYWT6reQvlKDogsBWUY8Bo3NCU8pkWk/tsv99VoE/GYdQ6VoKs7/rjlGAghIyrNsta
	naFwdctoQd0SZWkUzv0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slX8W-00000001GJn-0de9;
	Tue, 03 Sep 2024 17:16:12 +0000
Received: from fout7-smtp.messagingengine.com ([103.168.172.150] helo=pfout7-smtp.messagingengine.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slX7I-00000001FtI-1gVe
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:14:57 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 006EB13803CF;
	Tue,  3 Sep 2024 13:14:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Sep 2024 13:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1725383692; x=1725470092; bh=dB
	UfKeVf2UEZTsAZiC5iNPpiBQ1B2GtTe75No1Oz86U=; b=12VGiL+FFCka10zW+c
	kC5wRGUWUt4NWGeHJMbTeZD9/TRhy5/yPewvphUFUcEiWQS4kfqku1he0miBKhOz
	72dtoYzShDiQs5s49LyxDG6uE1+9oRHfvuqGHKL6SpoEmmYy3GCG62rZQRWJdGkl
	oVImBnC3pkpvR4bBwaU1qd0B3r37CTWJN1aqAPzFgXtAaiuROGw2Kjnozppbi5L3
	EEzfEmQLpEjA64RxMrL0DQmYkeXnnNrxfl9NCjO4gAfa6uG787+ZZlSboQjkUC0/
	yRDgX+GP6tFcpJ9sSl7BXWYsTe8ymfGw7Y1UY5LHrW/NAIibMb7+tuAqZN/fVz0W
	bUUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1725383692; x=1725470092; bh=dBUfKeVf2UEZT
	sAZiC5iNPpiBQ1B2GtTe75No1Oz86U=; b=giyy0SpStln1MvyZnmrs0i5R9QIjv
	mML5XtoWlbAot5P3sn5ZMXPppVE2LMSvIu2nTd1pXP/3v31HIhJ664/i8pSo3leS
	9QUtimSyggthryclPp+9mbFZnP82ifmN15IPbu5J7NdvGJRHJUAAhwDK+EIqb7wz
	wf8TAhgvHo/bfQBeNSPP6NCYcG7w7WJcnYBZNCNuAorxLhHjq+wUZkA1WgLcnsCx
	BnGE4Bh7RgglN1jJjxy/pAZS6pgtjH/UGtO4bJdJ9g3f97A0oX/bQKpknBE3iGJB
	S7lR4VgnhqWuDuhtyXmSRzQIyfeY+ARGz3fOeXcGoRV1SSHDr47mL45hg==
X-ME-Sender: <xms:CkTXZo5SqroS1sTNLgmrJDDHbG62xfu399l__B3wSSQGJ2Ef_eB_Hw>
    <xme:CkTXZp7WjgcUnau8yyob-H9QOhAg5ZUzsfNJ08YiYpjyYnOG7mqh8o3Z77MtbYtPX
    2X3blepGamfy7-5lK8>
X-ME-Received: <xmr:CkTXZnetq2EXvHxxzk55tZ1D6ikuj7lK4hVAxF16JX2kvGLcDX96PeJ1PEA-i9ZEAyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
    ucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhmqeenucggtffrrghtthgvrhhnpedufffffffhueehvefhgfelveekueeg
    teefgeeiieejheefkeehkeevudevieegueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgt
    ohhmpdhnsggprhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepthhssgho
    ghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphhtthhopehjohhhrghnnh
    gvshesshhiphhsohhluhhtihhonhhsrdhnvghtpdhrtghpthhtoheplhhlvhhmsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepthhglhig
    sehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepsghjohhrnhefpghghhesphhroh
    htohhnmhgrihhlrdgtohhmpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:CkTXZtIxiTQESdo22N2eGnQfM_DMR0BEH7Ch8icyR6wnbcBN5EKewA>
    <xmx:CkTXZsKmCOdFuq5CENNbP-OeT0jqudA2kT3sgSiiKfmmQUrNVVcbRA>
    <xmx:CkTXZuzoP5yjEJ56bl-Ofj_XUo4ysmA4W5UUu-RnvIOWA88K2k0QSA>
    <xmx:CkTXZgLGp8ZVxkCkb25EOMe2XEZrIqFs8koY2WqRhcDbHJ3ezgQfcQ>
    <xmx:DETXZseSggvY7dvJI0wBC6GSv6tWlR2lQ4COPW1xAhYH2piybbcKdMyE>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 13:14:46 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] rust: Initial MIPS support
Date: Tue, 03 Sep 2024 18:14:33 +0100
Message-Id: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlD12YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNj3dzMgmLdotLiEt20RIvUtBQLY7PkVEsloPqCotS0zAqwWdGxtbU
 AkM9ljVsAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=yHsKOiUFp2MiVqGWwQV43VcJHwo6PG/N8EqTaf5dnE8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTrLmwX27bfZTp0Rqz9StjDHXtX9Dek3XgaOfPK4zubX
 Q9oa/t97ChlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICLHGdkWFu0bHI876v+lp2J
 xaYTQ7OLJ7xm4rsn/PhAL2v0rcwHYgz/TKWfeb5fNut3m9/qe0WS2/tSW6vUtjrMn1hxc/WOBPN
 uDgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_101456_765613_5B588FF4 
X-CRM114-Status: GOOD (  10.61  )
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
Jiaxun Yang (3):
      rust: Introduce HAVE_GENERATE_RUST_TARGET config option
      MIPS: Rename mips_instruction type to workaround bindgen issue
      rust: Enable for MIPS

 Documentation/rust/arch-support.rst                |  1 +
 .../translations/zh_CN/rust/arch-support.rst       |  1 +
 Makefile                                           |  4 ++
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
 scripts/generate_rust_target.rs                    | 64 ++++++++++++++++++++++
 17 files changed, 102 insertions(+), 25 deletions(-)
---
base-commit: 469f1bad3c1c6e268059f78c0eec7e9552b3894c
change-id: 20240903-mips-rust-fa8efd836ce9

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


