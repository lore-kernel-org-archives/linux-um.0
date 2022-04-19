Return-Path: <SRS0=oEXL=U5=zx2c4.com=Jason@kernel.org>
Date: Tue, 19 Apr 2022 13:37:12 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v5 08/11] um: use fallback for random_get_entropy()
 instead of zero
Message-ID: <Yl6e6CRezyGsQh26@zx2c4.com>
References: <20220419111650.1582274-1-Jason@zx2c4.com>
 <20220419111650.1582274-9-Jason@zx2c4.com>
 <694c2318d98973ee8995e891f81216ad267341dc.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <694c2318d98973ee8995e891f81216ad267341dc.camel@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Johannes,

On Tue, Apr 19, 2022 at 01:33:21PM +0200, Johannes Berg wrote:
> On Tue, 2022-04-19 at 13:16 +0200, Jason A. Donenfeld wrote:
> > In the event that random_get_entropy() can't access a cycle counter or
> > similar, falling back to returning 0 is really not the best we can do.
> > Instead, at least calling random_get_entropy_fallback() would be
> > preferable, because that always needs to return _something_, even
> > falling back to jiffies eventually. It's not as though
> > random_get_entropy_fallback() is super high precision or guaranteed to
> > be entropic, but basically anything that's not zero all the time is
> > better than returning zero all the time.
> > 
> > This is accomplished by just including the asm-generic code like on
> > other architectures, which means we can get rid of the empty stub
> > function here.
> 
> 
> LGTM, actually better than before, though not even sure any drivers in
> ARCH=um have interrupts that say they can be used for this.
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> 
> I assume you're going to take this through the random tree?

Right, that's the plan (as mentioned in the cover letter). Changes to
random.c will depend on these patches being there.

Jason

