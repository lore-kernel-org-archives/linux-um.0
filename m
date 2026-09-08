Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69F6C79F82
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gw6uq3WoFDGFRXHX5w46jvhy16/noKc2NTzTXodoE8A=; b=ZrKewxTt+Q9+SQWyWn2/p+cFAF
	FPQ0DcNkLIYV4H0GesO6/7fVSFZ8VULOh8eLeSWrawSyiNSRkM1CUSsednhBTUWX6A5M8otau/Sss
	b0oGWz2AoZiXYak8jnJDtRWxDGKhcpF6PdDncZ0FDf67E4UNytBk7vE2yOBZnlOXKyPja/JzsIHTW
	YWD2tob1yRAoQDpiiFE4CSGfq3Nf7AyNGEkMDp98y+PBR2K1q7J7a2mhr+lV7AKp5cFAeIBgl6lQX
	XiKn9uFqGqUnGGhqZxkv2IydngrH4YtRgcqU3R4BgjYMhHc5HMAUWKPAvJHPI1jiDnAb0emGusAwR
	bKID109g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3rhb-00000008UWO-0qtF;
	Tue, 08 Sep 2026 09:01:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3rhZ-00000008UVW-2FX3;
	Tue, 08 Sep 2026 09:01:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C2F2A60A9D;
	Tue,  8 Sep 2026 09:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32141F00A3A;
	Tue,  8 Sep 2026 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788858072;
	bh=gw6uq3WoFDGFRXHX5w46jvhy16/noKc2NTzTXodoE8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f83UuFnG2Ca/NIEjfDrXHeoFRlnHHZpsg6wFetI10F3cQyUjArbK42hgG7Zxex4/s
	 3n5zZu9KkJ8dQxHTmVqB83udBP8YhBTSDsyRdMErALYpUYjulzhr6oGyq5X7IeS2MN
	 EWxFsYnacMcuz5tJFBTbZAf9tMz+RnlOTNhnRLhdadOeXHk0h+wn50SECkFRbxVslO
	 f7Ig1YtXoYtaZhrD1KEcBCtAna7hL00y1ZjgmW4/d0yWZBbhpb2lMH7Bv47zh1k7nI
	 CEirgVNGd9giuxhLxrRDAZzVqimdNslxWSYeJo/LDlSLy8epheEmJ4uqQpNMU7Oumx
	 oYzy9KZ7DvXJQ==
Message-ID: <060be36f-5e8d-4596-a4e6-844e5930baac@kernel.org>
Date: Tue, 8 Sep 2026 11:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/24] elf, uapi: Add a header for relocation constants
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
 <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-1-3a93791af1cf@linutronix.de>
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
> While the numeric constants for relocations are architecture specific,
> it is still useful to get access to them from other architectures.
> Also the definitions are useful for userspace in general.
> For example tools processing elf files during a kernel cross-compilation
> can make use of them.
> 
> Introduce a dedicated header for them, similar to the elf-em.h header.
> For now the header is empty but it will be filled step by step in
> upcomming commits.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   include/uapi/linux/elf-r.h | 5 +++++
>   include/uapi/linux/elf.h   | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> new file mode 100644
> index 000000000000..2c382c8a4807
> --- /dev/null
> +++ b/include/uapi/linux/elf-r.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_ELF_R_H
> +#define _UAPI_LINUX_ELF_R_H
> +
> +#endif /* _UAPI_LINUX_ELF_R_H */
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index ee30dcd80901..b3e312255552 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -4,6 +4,7 @@
>   
>   #include <linux/types.h>
>   #include <linux/elf-em.h>
> +#include <linux/elf-r.h>
>   
>   /* 32-bit ELF base types. */
>   typedef __u32	Elf32_Addr;
> 


