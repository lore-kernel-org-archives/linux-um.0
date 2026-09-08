Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E73C79FA0
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMspgRwQUUIexqKss7dqowtOmwD0tLbRBkFb+1ouQnY=; b=zciajgOxnuGwzuQ0hcAU5Txt+S
	jxf5+Oy6pEEK+q+gF+EVexzu7SiWJCzkgEcjunovCCGoWumCK0X3jYw0n1+2oNR2P52kSFq/Guz5X
	Euhq412mxj2fQ74A7haHzWPwk9TBjK2lxo90Hdqs2Az9k6LNXif/PrbuuAhoL3ys7UQXG8+nZJLgm
	S3Jbx0f/yLZK3a6Jf8YWhKh16l0+bqMUPKR2mO0DqNslfiPj3HIL+n9/uyKH9xzr+LXt22Pml+DPS
	rj0LMGePu6F3K46cABZny61NztCmO+XU2BU+aiyjcFa88YBqIkjOCTmR8QwGKRZ/4UVgPNOowBxmw
	Qzd5Mhvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qOH-00000008IGC-3tla;
	Tue, 08 Sep 2026 07:37:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qOG-00000008IFA-1HVg;
	Tue, 08 Sep 2026 07:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dMspgRwQUUIexqKss7dqowtOmwD0tLbRBkFb+1ouQnY=; b=irAwsshPXpU7Uf/rfFaj3uWs6G
	difPdlK64/emyFJJjlL7wNOeoAd6Y+U30iaYxFlQNgUaXhJ5XP9GQvgT7SeejFL749VvbdmXzNQmr
	ysoKC7HRo3DXe9AyxTg6XU4ih3jJvnovv2Ujltj+xakHIL0+9ST9dekY+kWUCq6mECTuqGA167fg+
	YqFWds1pqUcKbMJUd2jIJjqcUYt3toc+D0q3aR2UwfeZbWbAc5JAxTcsD0VD8CvN28YZRwquKZu0g
	pKwTeSbCwX4MUVnlh4QxgKngIIgLaxab029w2jsxL2wYaE+8OY428gXbHH21x+RnEEnFMu/t4r9jb
	gZmtLwfw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3qOD-0000000H407-3KtV;
	Tue, 08 Sep 2026 07:37:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0348300400; Tue, 08 Sep 2026 09:37:07 +0200 (CEST)
Date: Tue, 8 Sep 2026 09:37:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-mm@kvack.org,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Message-ID: <20260908073707.GV4120091@noisy.programming.kicks-ass.net>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
 <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>
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

On Tue, Sep 08, 2026 at 09:35:46AM +0200, Thomas Weiﬂschuh wrote:
> On Tue, Sep 08, 2026 at 09:19:11AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> > > All vDSO code needs to be completely position independent. Symbol
> > > references are marked as hidden so the compiler emits PC-relative
> > > relocations. However there are cases where the compiler may still
> > > emit absolute relocations, as they are valid in regular PIC DSO code.
> > > These would be resolved by the linker and will break at runtime.
> > > This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> > > Work around invalid absolute relocations from GCC")
> > > 
> > > Introduce a tool to check for absolute relocations during the build,
> > > as the current inline-shell logic is not expressive enough.
> > > The check is done on the object files as the relocations will not exist
> > > anymore in the final DSO. As there is no extension point for the
> > > compilation of each object file, perform the validation in vdso_check.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > >  Makefile                    |  19 ++
> > >  lib/vdso/Kconfig            |   5 +
> > >  lib/vdso/Makefile           |   2 +
> > >  lib/vdso/Makefile.include   |  14 ++
> > >  lib/vdso/check/.gitignore   |   3 +
> > >  lib/vdso/check/Makefile     |  34 +++
> > >  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
> > >  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
> > >  8 files changed, 729 insertions(+)
> > 
> > Urgh, does this mean I have to have rust installed just to build a
> > kernel now?
> 
> No.
> 
> If you don't have rust installed the build will instead use the existing shell
> script for a less thorough check. We only need one build machine at some point
> to have rust installed to report issues and this check to be useful.

Ah, *phew*. Thanks!

