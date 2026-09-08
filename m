Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D41AC79FA0
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R0gSNJNsFiBELJzc2W3yE5oEemx5pk46RuJIr17mKUU=; b=I4BaFnhnxmUNj+laQVkNG1RoxN
	N623vDm1ZNEIZ0DDy8e+uJ6SNf53v7FTIG11W1MJwPfcwjSJGf/aQlBLcVMCrn5ReROA00G0CBXSE
	I4gjRLXpvs/ZokhIowRefe+54oFXt+XONZoB6tosTsUX1HI/K2v2gLu958BS2CC+wWNTj+zVcxPU+
	MA0BHUpiQPTZs2VznsCOo2KaR9hBlgCPQZI+WVtnCNCxc29KbGgVNcIUsBhJVPxSc1XWt0YeG3GlA
	sINZwKIFs4cxlp1+pFu82HsLvFwLgOWvUCN7bbDvIO7+pDooLwYHGQzFRSVIYuPWuh4dAkqltkyYq
	Iu4d2E+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3rqE-00000008WZd-2IMD;
	Tue, 08 Sep 2026 09:10:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3rqB-00000008WYb-0kS8;
	Tue, 08 Sep 2026 09:10:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8375160A98;
	Tue,  8 Sep 2026 09:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569471F00A3A;
	Tue,  8 Sep 2026 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788858606;
	bh=R0gSNJNsFiBELJzc2W3yE5oEemx5pk46RuJIr17mKUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DAE45L0Ti7ZzN2J9EggKEpXt9EOFC/xe7EhCLBEAgKZ1EKM0gpJTm6lUAH9Rv1Y/l
	 Qb9gt8wqAJzrDQsE15lcnh+2LUSKHF7Y85tsfXTkApAmKRChoYKRr7LNH1NO5zCDxA
	 DgSV71bDNblo942RePIiEaOET6DD2BAm6jQXNwGXYyYXCVrrPfTDwooEAWl2+nKYnh
	 ROImd7jwopGGxZDYzhcgEHbseuZcsu9rqsTTi0oEx18R978jIBC68KJY6GiEvY9ucn
	 ZPViZj8X62xbMqmZxsQcKY9LdenN66zHgBKx4TLNgSPHoQy5QHpClKrY1uem3vgjH+
	 BNFhyDw3+tpqw==
Message-ID: <41c824f9-aa04-49a4-9d0a-9ffba7b014b4@kernel.org>
Date: Tue, 8 Sep 2026 11:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/24] tools headers UAPI: Sync ELF headers with the
 kernel sources
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
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
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 08/09/2026 à 08:33, Thomas Weißschuh a écrit :
> Pick up changes from the UAPI ELF header files.
> This picks up general changes to elf.h, elf-em.h which was forgotten
> previously and the new elf-r.h.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/include/uapi/linux/elf-em.h |  71 ++++
>   tools/include/uapi/linux/elf-r.h  | 696 ++++++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/elf.h    | 112 +++++-
>   3 files changed, 868 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/elf-em.h b/tools/include/uapi/linux/elf-em.h
> new file mode 100644
> index 000000000000..ef38c2bc5ab7
> --- /dev/null
> +++ b/tools/include/uapi/linux/elf-em.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _LINUX_ELF_EM_H
> +#define _LINUX_ELF_EM_H
> +
> +/* These constants define the various ELF target machines */
> +#define EM_NONE		0
> +#define EM_M32		1
> +#define EM_SPARC	2
> +#define EM_386		3
> +#define EM_68K		4
> +#define EM_88K		5
> +#define EM_486		6	/* Perhaps disused */
> +#define EM_860		7

Add a comment that it is /* Intel 80860 */ to avoid confusion with 
powerpc 860

> +#define EM_MIPS		8	/* MIPS R3000 (officially, big-endian only) */
> +				/* Next two are historical and binaries and
> +				   modules of these types will be rejected by
> +				   Linux.  */
> +#define EM_MIPS_RS3_LE	10	/* MIPS R3000 little-endian */
> +#define EM_MIPS_RS4_BE	10	/* MIPS R4000 big-endian */
> +

