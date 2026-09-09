Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6193C79F8C
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 06:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fsx+E+IxhTgqrNd5fDNEdWA4P4WjUu/zI9gxcY2gf1k=; b=POrY6NGj/Q44S0zcpubYH0ttVA
	bWFLazuvCkbzhHEw2MVzvIzgNj+P9UiTJnEVHVW6h/E6ScgMOmso6zn79V6789dvMukJWdNt1nxXz
	7ScM/0W/jUIvHRaiO4e8wXFBK81lcZRt1wBaQRM2vRrPvZUb+CHnsV89smv/prYkMdOWMtL+ooaAO
	68Z7BVI7qdQtoir8MSu5PneAoIkiTbG4Ts/kgR0avUR01lzjiM47XLkFFokTNI0M5D4roKO9zcidE
	BvlbYySxTkgzGXTCRPazUYjLIVA5HXxYejAU84kPAkcOnolhc4ImFp9HNpwZ/NEHIgudGKeSE5sWb
	T98Kh1pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4BUi-0000000Aqb7-2Mie;
	Wed, 09 Sep 2026 06:09:16 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4BUb-0000000Aqa6-3S9u;
	Wed, 09 Sep 2026 06:09:12 +0000
Date: Wed, 9 Sep 2026 08:09:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788934147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsx+E+IxhTgqrNd5fDNEdWA4P4WjUu/zI9gxcY2gf1k=;
	b=Ba8CFyueZIBv0OelbgTnQd8Liev5J1UqmQNZMlTvb9O8KcOJJTdoaB2ThyVqE1f8eVdkpB
	wTE4Lfz5SmplS9gum8fRJfjedlxYamdPBHVJ2zN0PmVQ/fAuza+eRyHTaqNl21luZW5FSV
	7mSECa3gWtr+fP2KkXm6iC1JdfB5MAxu3Qk/bZ7DsXkgsNE6bOUj/o8lxR1BIYweICcdVu
	Fm6yt/eraobBg9c2pGNyeS88edKZbZQw3VCce9fTmXPsolJkOwKGjp5YqUwJX6x49ccs+s
	3BERlZcIkDcJWAolf/r7TyPPNGX94YB/SldI2jSo7Dc4KeV5buIEb4c2Lh26vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788934147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsx+E+IxhTgqrNd5fDNEdWA4P4WjUu/zI9gxcY2gf1k=;
	b=fAJ6G75LaW8nnqqa43BRDYqlP7QW6Q+nfq2qssYjtogHzBntGBNA7rR18bMVBCUfwB7vq4
	TycChAiSqeQsMbBw==
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
Subject: Re: [PATCH v5 17/24] powerpc/vdso: Enable the vdsocheck tool
Message-ID: <20260909080124-ef171c1a-83ff-486b-b632-8613011a5a97@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
 <7c9f6ec3-5886-41ea-8803-d81019321d29@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c9f6ec3-5886-41ea-8803-d81019321d29@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_230910_164567_7B6E7DC4 
X-CRM114-Status: GOOD (  11.91  )
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

On Tue, Sep 08, 2026 at 04:41:09PM +0200, Christophe Leroy (CS GROUP) wrote:
(...)

> > diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
> > index 368759f81708..ca20b91b4373 100644
> > --- a/arch/powerpc/kernel/vdso/Makefile
> > +++ b/arch/powerpc/kernel/vdso/Makefile
> > @@ -81,9 +81,9 @@ targets += vdso64.lds
> >   CPPFLAGS_vdso64.lds += -P -C
> >   # link rule for the .so file, .lds has to be first
> > -$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
> > +$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o $(vdsocheck) FORCE
> >   	$(call if_changed,vdso32ld_and_check)
> > -$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
> > +$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o $(vdsocheck) FORCE
> >   	$(call if_changed,vdso64ld_and_check)
> >   # assembly rules for the .S files
> > diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> > index e45a1fbc6829..429bdcd65818 100644
> > --- a/lib/vdso/check/vdsocheck.rs
> > +++ b/lib/vdso/check/vdsocheck.rs
> > @@ -69,6 +69,33 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
> >               ..Default::default()
> >           }
> >           .into(),
> > +        bindings::EM_PPC => AllowedRelocations {
> > +            in_object_file: &[
> > +                bindings::R_PPC_REL24,
> 
> Not sure this is correct, see commit 42ed6d56ade2 ("powerpc/vdso: Block
> R_PPC_REL24 relocations")

(...)

The mentioned commit prevents the relocation in the final vDSO,
while my patch allows it in the intermediate object files.
In the final vDSO no relocations are accepted whatsovever.

