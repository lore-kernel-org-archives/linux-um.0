Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E47CA0EE4
	for <linux-um@archiver.kernel.org>; Fri, 15 Aug 2025 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NKM6vYBTvYJgJZpC+3klg9OwyY5OfNg57KkNb0OocWg=; b=hrLnDbAZDvCsLiuc4v16tvcLCG
	leKzaXEw6uTQfUeDfvpkMlR0EOssrltaYUjTGXXZdlcYw3rmhpYgCi2vYu3oWM4OMPr009ZJQshaX
	icd5Vaz9CB/2DbZTt7f+90aroj6HkFPuQHQqqaHAfLjKfVp4yrPc10HjITeMPhoO+UHt6M1xgQ+H8
	GR4U4EyoJMbAeUKgz7TezirgSjOvHyUo6VD8XXA0ve5aZU3bEGYqXrmNvEiJ1STQvIpn/9W7DSw2e
	VQo3GaQ3lL3Pyua3dea3hp3DXYaquVgudPTtJVXIofcEKbxi3twRxcULivm3f0Y9FVqJP3LMea/H+
	FH3nnfXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umvEc-00000002h4h-3qd3;
	Fri, 15 Aug 2025 14:16:46 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umrK2-000000029up-0ReI;
	Fri, 15 Aug 2025 10:06:07 +0000
Date: Fri, 15 Aug 2025 12:06:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755252363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKM6vYBTvYJgJZpC+3klg9OwyY5OfNg57KkNb0OocWg=;
	b=aO2iazZBVl4jvGHcxioVfsh65iLR3Izq+qWPXADbutMqMavKgUaUthaDr+R6w1r6xC69M7
	pL5h2TEWtWYewAnpScYhJCkIaFAKgULbi15SjfGtKC8LJ/mZc1hQQzLg71FWu25eDTH0y1
	MdUY3+nnowrj0PdDzw1hyrQ8ozJ0BdBe+J6xfrhxUNOLMiWm7280NRlOtJuKnvCK2Hl4+R
	JjnaSPjNDatrg+pgW4dq3uCQftbz45AWPj/EWmXs4IklOD4k8lw//0rXGaZQYflfEXqJDN
	ZoNnis/wD+gc1ASC2wdlydN0BBi8bv7A4d+0Pi34HL6a8GZJXUQvVqO1fxQIkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755252363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKM6vYBTvYJgJZpC+3klg9OwyY5OfNg57KkNb0OocWg=;
	b=S6z9FpXDI0m5KmQAvWcT/IWg9tN8RVfisToJ75YI5pbqWTKx4VxzrYh7GLy6FZouW5QiYj
	9qWhB6v7+0ZZRyBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
	Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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
Message-ID: <20250815112851-e613308f-d49e-44ae-b2dd-ca7946fa1fd9@linutronix.de>
References: <20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de>
 <86186254-b2c6-4818-af0a-4eb67d90e501@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86186254-b2c6-4818-af0a-4eb67d90e501@csgroup.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_030606_283981_DC3ABB5E 
X-CRM114-Status: GOOD (  18.16  )
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

Hi Christophe,

On Thu, Aug 14, 2025 at 03:43:09PM +0200, Christophe Leroy wrote:
> Le 12/08/2025 à 07:44, Thomas Weißschuh a écrit :
> > The compiler can emit absolute relocations in vDSO code,
> > which are invalid in vDSO code.
> > Detect them at compile-time.
> 
> I'm a bit puzzled with this series.
> 
> If I understand correctly, the check will be done only when you have RUST
> available ?

Yes, this new check will only be performed if a rust toolchain is available.
CONFIG_RUST however is *not* required.

> I wouldn't expect having RUST to build a C kernel.

The build will work fine without Rust present and will fall back to the
simplistic readelf test. A single report of breakage will allow us to fix the code,
not everybody needs to run the full thing.

> By the way, aren't relocations already detected by command cmd_vdso_check in
> lib/vdso/Makefile.include , using readelf ? Why is a new tool needed

The current cmd_vdso_check only validates the final vDSO image.
However that is not sufficient, as some problematic relocations will not show
up in the final image anymore but only the intermediary object files.
And there the logic is more complex than can be reasonably expressed in inline
shell scripts, see the previous revisions of this series for the attempts.
The valid relocations depend on each architecture and the specific ELF section
they appear in.
For the real example that triggered all of this, see commit
0c314cda9325 ("arm64: vdso: Work around invalid absolute relocations from GCC")

> and why does it have to be written in RUST langage ?

There is no hard requirement for Rust. I chose it for convenience of
implementation, especially around descriptive error handling and generic
functions. tglx was fine with it.


Thomas

