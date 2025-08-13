Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AF5C87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vgBW8b/WLrVQq0BHMU+zEk/Lyyfrm6a/mGbcYhX7PWw=; b=isjnlLsg65BpzgKO3Oxx3wyCb6
	8lG8GnmcKS0MqfyJFlILriMCJHbJH3THbgSwcKsG0yZJKCLBpb888MvJW6bPf4wH/ecGXDlk0isGC
	5NBIb2cswy8HcNzjrNpInjolhNl9xj0NUB0QSHxEGKRox8ZUPOpkHJseiWF0nrYYo3I/q5MjXC25Z
	coaCWfhrmtEifbnFYqx2Kz+mY4SjHW4UieDshygzD0BAiYSurZxPjFD1ZSaqo5MevlQNQZ9wW2M/E
	eF/V4zOYKQqb9Iw9JV7kSo29ceNk3+mF6SKLlOSqlJHy7orWzxCGgmIxY7IZXu25M6SfVVT7txvl+
	+oLXPJXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6gp-0000000D4IS-2EwZ;
	Wed, 13 Aug 2025 08:18:31 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6eY-0000000D3lA-2VRK;
	Wed, 13 Aug 2025 08:16:13 +0000
Date: Wed, 13 Aug 2025 10:16:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755072965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgBW8b/WLrVQq0BHMU+zEk/Lyyfrm6a/mGbcYhX7PWw=;
	b=t3ZaanvFJHTW1l1H2nSwoa1VFh8EVFo/BJn0UMRG7bq78PXYOpzqMO9UGefI5UiLZP7nNe
	J1FX1/E5cqcFOVpKvUjolk1j8zY71ykS0B7X6UJ1jM73mZGhOMT+2RFDhdp4Y1WmHG3lB8
	fhvgGlk/PFabS5Cn+w3uMjkgmqVzkQuRRvX4xJrjg/8hJ+0j7jOT/qLXJIWkp6a9jfxObj
	LUOs4JziO5PF87uDbwzJHBzRMHIM1CkGRGPGIwWfVdP7ckTLMMlHtUDzc+O5vxoBEjlmG7
	1skI/bKKNj/R2CTmQujVy01wAp2WhS97QfxNvozWzsRXygdxqvZz7+ZCEZyixQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755072965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgBW8b/WLrVQq0BHMU+zEk/Lyyfrm6a/mGbcYhX7PWw=;
	b=E1zvWv48KJJ+SOu4RstGU/Hts0jpCLaRVEpYFntAu8DSCAbOKCuCF3vYrHswu5Uo/Nk8OK
	GMt5eI9bpKssCIDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 00/24] vdso: Reject absolute relocations during build
Message-ID: <20250813101305-04911850-2375-4be5-9a06-ced21de3ca22@linutronix.de>
References: <20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de>
 <CANiq72nV62c8cVBzke73OH-sfLdgerDBGrLKTmT83+OQtK6PjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nV62c8cVBzke73OH-sfLdgerDBGrLKTmT83+OQtK6PjA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_011610_785478_D5DC9FC3 
X-CRM114-Status: GOOD (  15.92  )
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

On Tue, Aug 12, 2025 at 01:07:34PM +0200, Miguel Ojeda wrote:
> On Tue, Aug 12, 2025 at 7:44 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Kbuild and Rust folks: This contains custom definitions of hostprog
> > bindgen and rust library commands.
> > These are currently only defined inside the subsystem directory.
> > Let me know if they should go into scripts/Makefile.host.
> 
> Glad to see more Rust host progs :)
> 
> Keeping them local may be a bit easier initially to land, I guess
> (e.g. no docs), and then we can generalize when needed later.

I'm happy to do the docs etc. I only wanted to avoid doing all that work,
only for it to stay a subsystem-local solution.

Also it would be nice to have a Kconfig symbol, RUSTC_CAN_LINK or similar,
which indicates that the rust compiler can build host programs.

> By the way, for consistency with elsewhere, probably we want
> `HOSTRUSTLIB` -> `HOSTRUSTC L`. Though I am thinking to remove the `L`
> anyway since eventually a lot of code will be "lib".

Ack.

