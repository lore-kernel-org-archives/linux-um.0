Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B94ACE7AF1
	for <linux-um@archiver.kernel.org>; Fri,  6 Sep 2024 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+I42zW2gvwb42P+w76rbAsCJMAio1NmEp1MoB0PSeg=; b=vL8TfrrdqKcw496zpEyI2lj7gU
	9QhTTOCC0g1qlAvdR01tBlBUk3QILlfQvTOjjJNG1FPreWj/mnqlpzLmVby2BdihfMI4iA1gI7Q+V
	01yqzDbmGE5NdZ2lHmnpJvKjSWuKwgZMJz1hsqZGCTqaRIFl16RxLIjbo7ngkXc/497tP4Kw5q3xo
	pF1TA0EFdRc94Eu3ejSPqk1gTC8SoaijZMDjTsX7il4ol9RqObNnHJcaaspQ+vGirrGplXWRj6lMU
	Ksv5JAcphDuTym5b6VYup3K7Zx5osu4P/yEHsPqyYlr28g1XFyyLCqtJIba7pbJtBGg8Nq4LWmTxv
	QO1ZF+Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smUv1-0000000BSTm-2BQA;
	Fri, 06 Sep 2024 09:06:15 +0000
Received: from angie.orcam.me.uk ([78.133.224.34])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smUs4-0000000BRvb-15hJ
	for linux-um@lists.infradead.org;
	Fri, 06 Sep 2024 09:03:14 +0000
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 961EC92009C; Fri,  6 Sep 2024 11:03:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 900F792009B;
	Fri,  6 Sep 2024 10:03:06 +0100 (BST)
Date: Fri, 6 Sep 2024 10:03:06 +0100 (BST)
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
    linux-mips@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] MIPS: Rename mips_instruction type to workaround
 bindgen issue
In-Reply-To: <20240903-mips-rust-v1-2-0fdf0b2fd58f@flygoat.com>
Message-ID: <alpine.DEB.2.21.2409060455300.1802@angie.orcam.me.uk>
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com> <20240903-mips-rust-v1-2-0fdf0b2fd58f@flygoat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_020312_593064_13BFE024 
X-CRM114-Status: GOOD (  14.12  )
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

On Tue, 3 Sep 2024, Jiaxun Yang wrote:

> Rename it as mips_insn, which is not conflicting with anything
> and fits the name of header.
[...]
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 8c401e42301c..153c9666a77c 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -248,7 +248,7 @@ int ftrace_disable_ftrace_graph_caller(void)
>  #define S_R_SP	(0xafb0 << 16)	/* s{d,w} R, offset(sp) */
>  #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
>  
> -unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
> +static long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
>  		old_parent_ra, unsigned long parent_ra_addr, unsigned long fp)
>  {
>  	unsigned long sp, ip, tmp;

 This goes beyond renaming `mips_instruction' data type to `mips_insn'.

> diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
> index dc39f5b3fb83..7a1b1c3674da 100644
> --- a/arch/mips/kernel/kprobes.c
> +++ b/arch/mips/kernel/kprobes.c
> @@ -90,7 +90,7 @@ int arch_prepare_kprobe(struct kprobe *p)
>  	}
>  
>  	if (copy_from_kernel_nofault(&prev_insn, p->addr - 1,
> -			sizeof(mips_instruction)) == 0 &&
> +			sizeof(kprobe_opcode_t)) == 0 &&
>  	    insn_has_delayslot(prev_insn)) {
>  		pr_notice("Kprobes for branch delayslot are not supported\n");
>  		ret = -EINVAL;

 Likewise.

  Maciej

