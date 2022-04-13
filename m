Return-Path: <macro@orcam.me.uk>
Date: Wed, 13 Apr 2022 13:46:29 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
In-Reply-To: <20220413122546.GA11860@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com> <20220413122546.GA11860@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Wed, 13 Apr 2022, Thomas Bogendoerfer wrote:

> > diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> > index b05bb70a2e46..abc60a6395e3 100644
> > --- a/arch/mips/include/asm/timex.h
> > +++ b/arch/mips/include/asm/timex.h
> > @@ -94,7 +94,7 @@ static inline unsigned long random_get_entropy(void)
> >  	else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
> >  		return read_c0_random();
> >  	else
> > -		return 0;	/* no usable register */
> > +		return random_get_entropy_fallback();	/* no usable register */
> >  }
> >  #define random_get_entropy random_get_entropy
> >  
> > -- 
> > 2.35.1
> 
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

 Or we could drop the PRID_IMP_R6000/A check and the final `else' clause 
entirely, as we don't even pretend to support the R6k at all anymore, and 
this is the final reference remaining.  For one we no longer handle the 
CPU in `cpu_probe_legacy' so any attempt to boot on such a CPU would 
inevitably fail as no CPU options would be set (we probably should have a 
`panic' or suchlike as the default case for the switch statement there).

 Therefore I'm all for removing this piece instead, complementing commit 
3b2db173f012 ("MIPS: Remove unused R6000 support"), where it should have 
really happened.

  Maciej

