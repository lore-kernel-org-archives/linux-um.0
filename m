Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B288DEE01ED
	for <linux-um@archiver.kernel.org>; Tue, 10 Sep 2024 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bvynRCUBQX+ODy3J6n6xj+RzaI1Kri85eTo3ZDdTcbU=; b=V3bG3Xsya6c585d6uhBv3L7uzY
	sb3fEOHs9lDXGNjYytxwQgT6l3Va0wxDTnIYAiYw9bGcDa4zoXisTJMvU4iLo8hC/JOdQdydkyDK5
	qBOgdlpOVpSd06vXE8TsxgzUDZJ6ltRkKDRxWHdxXjXb6jEp4YNUhV6za+Oe/0Fvs72Wjy+cYzNki
	Bmj3FCAB43OzTpdtIj4zJ4jwk6cIWQjKdokVEZG1o37EMgZ56EBX/5nYPWNtGvMpYbGLAiK2pFHx8
	XXSHNJYMLiWP3cpLw354aiyAc0hTI/ClPf/3eZytqcT2sDjyrdCmMK81mmYNZ130mGK/flEf42nUO
	e2EqXYWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so9LS-00000007KYi-3zXy;
	Tue, 10 Sep 2024 22:28:22 +0000
Received: from angie.orcam.me.uk ([2001:4190:8020::34])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so9LP-00000007KY3-3xIm
	for linux-um@lists.infradead.org;
	Tue, 10 Sep 2024 22:28:21 +0000
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 24E6892009C; Wed, 11 Sep 2024 00:28:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1E05C92009B;
	Tue, 10 Sep 2024 23:28:18 +0100 (BST)
Date: Tue, 10 Sep 2024 23:28:18 +0100 (BST)
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
In-Reply-To: <54ce7574-43fd-40ee-9ae9-dd72283d1040@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2409102318270.60835@angie.orcam.me.uk>
References: <20240905-mips-rust-v2-0-409d66819418@flygoat.com> <20240905-mips-rust-v2-3-409d66819418@flygoat.com> <alpine.DEB.2.21.2409082138160.60835@angie.orcam.me.uk> <035ccfe5-c368-4cd9-8e0d-34e0e355cb05@app.fastmail.com> <alpine.DEB.2.21.2409101643210.60835@angie.orcam.me.uk>
 <54ce7574-43fd-40ee-9ae9-dd72283d1040@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_152820_171131_C99141B2 
X-CRM114-Status: GOOD (  21.34  )
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

On Tue, 10 Sep 2024, Jiaxun Yang wrote:

> >> We have no good way to tell ISA reversion prior to R1 just from Kconfig TARGET_ISA_REV,
> >> valid numbers for TARGET_ISA_REV are only 1, 2, 5, 6 from Kconfig.
> >
> >  This approach doesn't work for some MIPS architecture processor configs 
> > anyway, e.g. what ISA revision will CPU_P5600 imply here?
> 
> TARGET_ISA_REV will be set to 5 for CPU_P5600 (CPU_MIPSR5 will default to y
> on CPU_P5600, and CPU_MIPSR5 sets TARGET_ISA_REV to 5). 
> >
> >  However if there's a need (and previously there wasn't), then I think it 
> > can be sorted in a straightforward way.  We have just a bunch of CPU_* 
> > settings and we can define corresponding ISA_* settings to select, e.g. 
> > ISA_MIPS1, ISA_MIPS3, ISA_MIPS32_R1, ISA_MIPS64_R6, and so on, based on 
> > information extracted from per-CPU_* `-march=' compilation flags from 
> > arch/mips/Makefile (possibly combined with ISA data obtained from 
> > GCC/binutils for said flags).
> >
> >  It could be a bit tedious to write, but not a big challenge really, just 
> > mechanical work.
> 
> TARGET_ISA_REV is guaranteed to be aligned with CPU's supported ISA for now,
> so I see no reason to invent another set of symbols....

 Ah, OK then, I missed these bits, thanks for pointing them out.

 So we only need to define CPU_MIPS1, CPU_MIPS3, and CPU_MIPS4 settings
(we have no support for any MIPS II CPU; there was the R6000 only at that 
ISA level, exeedingly rare and unreliable) analogously to and along with 
the existing CPU_MIPSR1, CPU_MIPSR2, etc., which is even simpler.  They 
can then be used accordingly for TARGET_ISA_REV == 0, either directly or 
perhaps via an additional TARGET_LEGACY_ISA_REV setting.

  Maciej

