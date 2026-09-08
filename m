Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A253FC79FA1
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 09:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4bnahwswymvE5nOIFxOjV/veHxRfM8mUS2vFlMphLI=; b=OHH0YFMHyhFogd+m1s+K6iuksv
	WYD7h7gRb5vZwoAGaxFftfKYZhvcNAb3lNnYfuiaUc7MwfcvvQIym3jJS0eKCdW2slxMJOasfG5tE
	tSR22pGE2Af6TTqLo1mhallLVIv8DApY7yjSPildTLUpy6qba6+VFOohGL1aICcKHy0JU/V9b0NVn
	3/uPjUA1t9VT8Ov4JQ9bkmFTRk4FiWvrVRs6lNPn0wA8Ppud/ALvZQNSuPfrqjbJn0/26ww5j1BrU
	GXx3WFwmUmyYP0xZfDEww9EV8yIYNqjQ/qQnK+LkbhLqZrV4OqqDP4qOYWJ9mvY2v3YMXDaLxry9S
	tLl2em0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3sGr-00000008dDb-0GMu;
	Tue, 08 Sep 2026 09:37:41 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3sGn-00000008dBf-1Uka;
	Tue, 08 Sep 2026 09:37:38 +0000
Date: Tue, 8 Sep 2026 11:37:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788860254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4bnahwswymvE5nOIFxOjV/veHxRfM8mUS2vFlMphLI=;
	b=F99r3XWuTQu1aQaZj3Rg35vrK+Vh4xoW6esYP08KsnkTB5yxRHFlAX+DCSQ9MmE/ytdjCY
	bT6ZSwlbgz0Tp/9QlaRm9xj6k6x+gQowVBcql48kgWTi7EY8hoPzlCmCwOwmHC8SxOCa3J
	0icgZeoQJU6KNJO4gOL3qhihZkDuWn/jnlOBCrvGJD7o4Fnl7C36ruhip68Y+2nMvnOAVX
	9XoGZlIvgcOwA32mE4o6lEcMBu1d9f3urtNxvC6vBsxPGt/e/3MpqOApvFdmwEjj/Zakfp
	dC6HHcg6MFdoR4Ez1Du4OVqzN/fIOPQmWkTrSXFlU1lEDS+2M+h55TuuwKLKTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788860254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4bnahwswymvE5nOIFxOjV/veHxRfM8mUS2vFlMphLI=;
	b=Eal5NKMa9KoeM279byQBbEfyeEmUQxO7LFbQVe68UMo95PO7FvduzWF1IqJWwbafV544s9
	HhGMsegsgfpaGqBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-mm@kvack.org, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 11/24] tools headers UAPI: Sync ELF headers with the
 kernel sources
Message-ID: <20260908113701-7b7e8e99-81cd-40b3-8a33-f316defe6f45@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
 <06996199-5255-41d0-ba6a-ebeca57f61da@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06996199-5255-41d0-ba6a-ebeca57f61da@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_023737_537754_8C7F9A7B 
X-CRM114-Status: GOOD (  15.72  )
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

On Tue, Sep 08, 2026 at 10:56:58AM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 08/09/2026 ‡ 08:33, Thomas Weiﬂschuh a Ècrit†:
> > Pick up changes from the UAPI ELF header files.
> > This picks up general changes to elf.h, elf-em.h which was forgotten
> > previously and the new elf-r.h.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > ---
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >   tools/include/uapi/linux/elf-em.h |  71 ++++
> >   tools/include/uapi/linux/elf-r.h  | 696 ++++++++++++++++++++++++++++++++++++++
> >   tools/include/uapi/linux/elf.h    | 112 +++++-
> >   3 files changed, 868 insertions(+), 11 deletions(-)
> > 
> 
> > diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
> > index 5834b83d7f9a..88bdcbb526c1 100644
> > --- a/tools/include/uapi/linux/elf.h
> > +++ b/tools/include/uapi/linux/elf.h
> 
> > @@ -312,7 +323,7 @@ typedef struct elf64_phdr {
> >   #define SHN_ABS		0xfff1
> >   #define SHN_COMMON	0xfff2
> >   #define SHN_HIRESERVE	0xffff
> > -
> > +
> 
> Getting the following warning when applying this series with 'b4 shazam'.
> 
> /home/chleroy/linux-powerpc/.git/rebase-apply/patch:846: trailing
> whitespace.
> 
> Seems to come from here.

That's also present in include/uapi/linux/elf.h.
I'll add a fix for that, too.

> 
> >   typedef struct elf32_shdr {
> >     Elf32_Word	sh_name;
> >     Elf32_Word	sh_type;

