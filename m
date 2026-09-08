Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118E5C79FA0
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=; b=D8mhngmo0UttRnatcUhX3ok+Na
	CwV43OM1MhwCG2kreqfx81IlQYrm6EMRzJX1IJtE2H+edi3S8zhNtd5eVjQJTq0cj2ShQQi2ozmJr
	r4s7w9ZbONV82Ww8dflMjT2CijouHgqgAq327Z0ukjQnpVcJaZzWQ8UAwiYiDuFe9JOYgNMW8cJPk
	CPqbhQq/wUk3tgT8BmiAXlqzjEjsHLRf2CQBepF3dZPgOydC1R8QcFLXzkSHj9n3Bjtvl2jdtGw+Y
	ESbQMfIU0YFt9lkpLXQekfZsvJA4OOQ+cvtkfmXtkgAixFDLfVYno/mQM4mQ1eCQK6yQIQ3mR2RQE
	8M6ipfcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qN5-00000008Hud-1Rw7;
	Tue, 08 Sep 2026 07:35:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qMz-00000008Hsg-2YBC;
	Tue, 08 Sep 2026 07:35:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=; b=PzaN6jM/MTJb5PMU6RyvBOTDNN
	zAM/tQph0m5KMZV7Qyfbv+UquXimqBmdW63JnocEob5Tpks06YABkNfs20mqe5QnCArGC0G/ftA6z
	g0hjP8pF4F2c+z6EQbYYjZ08NVw791dpnk7Ka76aCCuOz6TACW7mohRirEFp5wApEdP3gqwswpWUJ
	tsryMpa8tINsph1zdnodo9TE7VfeW3pUoqyEQj7LmoCD47SBTqrCJzKM+GEZSXg0Rg0wB3zC9VQFh
	jwBg5snEsjU6tPH45ZaF59xLt9lIoHwBFSSMwVLBOCqEkeuywfqBdCoP8/ajAWtojqO8tAtMa1743
	3gejMxWw==;
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3qMw-0000000H3s7-3F6v;
	Tue, 08 Sep 2026 07:35:52 +0000
Date: Tue, 8 Sep 2026 09:35:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788852947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=;
	b=sF40x1TnpsNhyt0sI38rIHaeAvtNg/EM8w3EtHzsFSvvVwHHMnTzo9ND4gwdFmZKWgwiQI
	zIUqZO38xf+hqbFqpxnJEf22XYPf5rduERB4k6rIc5UkCj8/unJYgFDyl/VlE7G+EFDI03
	CNmgd/Vj1Q3c/q3Ydr3Q/DKOj3v431wlaOso4rjeyTahr+hMGIpBnsAkCalXgeDSgVmwoT
	fSwtBw7bhzCeC4FkKyNmCXzfRLo7mT4mBMZCZPU/i5SaXQchJvrd+z5JqASF5WVbgiH5G4
	it4ju8Bz/fYLxG5O3MBiu0Nd1yKjfxaEDd33C3bFc0Qo3/mwB0s4uDaabhB7ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788852947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=;
	b=t4GN1DhfMH6AgNQoFSHKMaImcdOBofdEStAoUz2uy11ao2hSCXVnSiB6G9+q7fkA3MPgYT
	C9GJghb2CAl+FqDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
	Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Message-ID: <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_083550_983738_A6B4EC65 
X-CRM114-Status: GOOD (  23.82  )
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

On Tue, Sep 08, 2026 at 09:19:11AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> > All vDSO code needs to be completely position independent. Symbol
> > references are marked as hidden so the compiler emits PC-relative
> > relocations. However there are cases where the compiler may still
> > emit absolute relocations, as they are valid in regular PIC DSO code.
> > These would be resolved by the linker and will break at runtime.
> > This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> > Work around invalid absolute relocations from GCC")
> > 
> > Introduce a tool to check for absolute relocations during the build,
> > as the current inline-shell logic is not expressive enough.
> > The check is done on the object files as the relocations will not exist
> > anymore in the final DSO. As there is no extension point for the
> > compilation of each object file, perform the validation in vdso_check.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  Makefile                    |  19 ++
> >  lib/vdso/Kconfig            |   5 +
> >  lib/vdso/Makefile           |   2 +
> >  lib/vdso/Makefile.include   |  14 ++
> >  lib/vdso/check/.gitignore   |   3 +
> >  lib/vdso/check/Makefile     |  34 +++
> >  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
> >  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
> >  8 files changed, 729 insertions(+)
> 
> Urgh, does this mean I have to have rust installed just to build a
> kernel now?

No.

If you don't have rust installed the build will instead use the existing shell
script for a less thorough check. We only need one build machine at some point
to have rust installed to report issues and this check to be useful.


Thomas

