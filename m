Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84329C79FB5
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 05:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XfBuOKvuia8jKU4jKhI6ImQ24+OP+x2lVvStL9kHB6c=; b=p5zejuLFhQfcsKJmdJlDYsVTfK
	zdZ7iTxFnnnz5+brPZCFjsFVUgL1FkqQ0Mu6G8WIDr/ulJcW+HKr2CKo5MaSnx1RsQozEc9Klnzla
	ObUros007OgATUPPH2j0t12GNZyYcCcsDj/y4l/4MFWJ0bxIdX/eu/GiwZi6TmXu/MizrhUd1RoeE
	g4u4fSau7qc/7kYu/KLPqvpFSv9LLVZa+iO+RDy98xSiL3nnNIkiTMy+6cvdWC1/WmegH2mpuGKM0
	cqgzi1Ri/7UywiVABqZKsGwIZi7/DHQfyGZxnVoZdfCnZkn7XcOHmiTs3QaPliZU45goKA6Z/rnk8
	4t0jKLKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4BLh-0000000Apdg-2g8n;
	Wed, 09 Sep 2026 05:59:57 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4BLe-0000000ApcX-23zY;
	Wed, 09 Sep 2026 05:59:56 +0000
Date: Wed, 9 Sep 2026 07:59:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788933591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfBuOKvuia8jKU4jKhI6ImQ24+OP+x2lVvStL9kHB6c=;
	b=CMEIGvTJ+RpDUpaQX63YOGpF9L1xMeGi9s7P9EumAFOOXvZhDn04zc5cDcznjmEwFWcMKn
	aV3mh9HSsioEvvDCuqmuPhxAz0EDxVz5FVZWfmObWfXRSybwQ1ZxDVQ4z0tJ5bj8HKl6QH
	2LpCD9FeG6rAkLbfiSKloV9FiP1FFipkSzlhBo3Zplknr1ofEEQBBTOoi2c+qR7w1FFuf1
	oLRZ1Ohqd/R7qrq1gOVWGdmCLZlvGzRsKpGh6crrwVT4V1hNIEeMZP96qZ+DAKQJ/Yh6qb
	V/ykB9y+Wc32WJFwaNxXjYic0iDsUwgblz+2Yps3KMILiE5BRXmRKCLGA9EuDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788933591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfBuOKvuia8jKU4jKhI6ImQ24+OP+x2lVvStL9kHB6c=;
	b=VonGHAfqnQoueeh6Hl3Lomphhnqa2H/lUyc5Ke65gvgt5gNmjnE70KZBPhdx4hgXdpJF0U
	tvpV+04d2I30q5AQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 02/24] x86/elf, um/x86/elf: Move relocation constants
 to UAPI
Message-ID: <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
 <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_225954_677991_3BCBBB68 
X-CRM114-Status: GOOD (  12.77  )
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

On Tue, Sep 08, 2026 at 08:12:38AM -0700, Borislav Petkov wrote:
> On Tue, Sep 08, 2026 at 04:26:00PM +0200, Thomas Weißschuh wrote:
> > The existing, generic ELF definitions are there.
> > The ELF stuff in include/linux/ is highly specific to Linux.
> 
> And putting them in UAPI casts them in stone. I wouldn't want to maintain them
> forever if not necessary.

These names and numbers are defined by the architectures' ELF specifications.
They are already cast in stone. For example see Table 4.9 of [0].
Changing them would break compilers, linkers, loaders and more or less every
existing ELF binary.

> > Also later in the patchset I want to expose the definitions to the
> > tools/ build. Exposing generic UAPI definitions to tools/ is a much
> > easier sell than include/linux/.
> 
> tools/ *copies* kernel headers on a "they're needed" basis. No need to put
> anything in UAPI for that.
> 
> It's even written down: tools/include/uapi/README

That is the documentation for the tools UAPI headers.

Also we already have other, closely related, ELF constants in the UAPI,
see {,tools/}include/uapi/linux/elf{,-em}.h.

[0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/jobs/artifacts/master/raw/x86-64-ABI/abi.pdf?job=build


Thomas

