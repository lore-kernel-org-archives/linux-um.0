Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957C2EDE99A
	for <linux-um@archiver.kernel.org>; Tue, 10 Sep 2024 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aiqfy8SMxsuFw5CUtGme7MMb8xjimIcC9JtgzgDl7lk=; b=N9sULVmuv+aYcC1/E9NcMvMNFS
	UlYolPYir81uaQ2joCdL272Uqtgfqkyw8PgHQj/Z6NV/zZy8kJedUM13zyk0xmFR4mmBHXJCUw+8x
	j1ydpIWwxWKnJP0862biXXs3a9oCfjQal0kxNhSJMtxYCmy4s3VRB/tsUzqsbQC7SFL0qnC3w6xe/
	LILWlpJ0qNOX9nFEFvPeXyJAxV/mPq1y+YfwqajBVqyhE/2Az5lFPEZZLmfNKOsbkQgYJQC1/dtQd
	8/DsP8wXYCXyiHoYYSQ3IqL3OgX2k/vbVsYRlhmd0HzRG4nFSUpzq4wY1BsHe/ixDoM4j+7Infr5A
	8zLjfdaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3LI-00000006Gsz-3OdP;
	Tue, 10 Sep 2024 16:03:48 +0000
Received: from angie.orcam.me.uk ([2001:4190:8020::34])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3LF-00000006GrI-1TaL
	for linux-um@lists.infradead.org;
	Tue, 10 Sep 2024 16:03:47 +0000
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A5A2792009C; Tue, 10 Sep 2024 18:03:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A14D492009B;
	Tue, 10 Sep 2024 17:03:39 +0100 (BST)
Date: Tue, 10 Sep 2024 17:03:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
cc: Masahiro Yamada <masahiroy@kernel.org>, 
    Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
    Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
    Wedson Almeida Filho <wedsonaf@gmail.com>, 
    Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
    =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Benno Lossin <benno.lossin@proton.me>, 
    Andreas Hindborg <a.hindborg@samsung.com>, 
    Alice Ryhl <aliceryhl@google.com>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
    Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-um@lists.infradead.org, rust-for-linux@vger.kernel.org, 
    "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
    linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
    llvm@lists.linux.dev
Subject: Re: [PATCH v2 3/3] rust: Enable for MIPS
In-Reply-To: <035ccfe5-c368-4cd9-8e0d-34e0e355cb05@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2409101643210.60835@angie.orcam.me.uk>
References: <20240905-mips-rust-v2-0-409d66819418@flygoat.com> <20240905-mips-rust-v2-3-409d66819418@flygoat.com> <alpine.DEB.2.21.2409082138160.60835@angie.orcam.me.uk> <035ccfe5-c368-4cd9-8e0d-34e0e355cb05@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_090345_575296_B66A7C64 
X-CRM114-Status: GOOD (  21.55  )
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

On Mon, 9 Sep 2024, Jiaxun Yang wrote:

> >> diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
> >> index 863720777313..bbdf8a4dd169 100644
> >> --- a/scripts/generate_rust_target.rs
> >> +++ b/scripts/generate_rust_target.rs
> > [...]
> >> +        } else {
> >> +            ts.push("arch", "mips");
> >> +            cfg.get("TARGET_ISA_REV").map(|isa_rev| {
> >> +                let feature = match isa_rev.as_str() {
> >> +                    "1" => ",+mips32",
> >> +                    "2" => ",+mips32r2",
> >> +                    "5" => ",+mips32r5",
> >> +                    "6" => ",+mips32r6",
> >> +                    _ => ",+mips2",
> >
> >  What's the consequence of using `mips2' rather than `mips1' here?  How 
> > about other ISA revisions, e.g. `mips4' (that also applies to the 64BIT 
> > leg)?
> 
> LLVM's mips1 backend is a little bit broken beyond repair, so I tried to use mips2
> as a baseline. I should probably let HAVE_RUST depend on !CPU_R3000 to get it covered.

 GCC works just fine I suppose, just as with the other language frontends, 
doesn't it?

> We have no good way to tell ISA reversion prior to R1 just from Kconfig TARGET_ISA_REV,
> valid numbers for TARGET_ISA_REV are only 1, 2, 5, 6 from Kconfig.

 This approach doesn't work for some MIPS architecture processor configs 
anyway, e.g. what ISA revision will CPU_P5600 imply here?

 However if there's a need (and previously there wasn't), then I think it 
can be sorted in a straightforward way.  We have just a bunch of CPU_* 
settings and we can define corresponding ISA_* settings to select, e.g. 
ISA_MIPS1, ISA_MIPS3, ISA_MIPS32_R1, ISA_MIPS64_R6, and so on, based on 
information extracted from per-CPU_* `-march=' compilation flags from 
arch/mips/Makefile (possibly combined with ISA data obtained from 
GCC/binutils for said flags).

 It could be a bit tedious to write, but not a big challenge really, just 
mechanical work.

> Given that mips 2 and 3 binaries (Rust object files) can link run flawlessly on all pre-R6
> (despite R3000) hardware with matching bitness, they were chosen as fallback here.

 I'm fine with having a MIPS1/R3000 exception for broken LLVM, but I see 
no reason to disable it for GCC.

  Maciej

