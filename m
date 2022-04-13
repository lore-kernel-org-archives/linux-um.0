Return-Path: <SRS0=VN1/=UX=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com>
 <20220413122546.GA11860@alpha.franken.de> <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 14 Apr 2022 00:35:49 +0200
Message-ID: <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
Content-Type: text/plain; charset="UTF-8"
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Maciej,

On Wed, Apr 13, 2022 at 2:46 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Wed, 13 Apr 2022, Thomas Bogendoerfer wrote:
>
> > > diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
> > > index b05bb70a2e46..abc60a6395e3 100644
> > > --- a/arch/mips/include/asm/timex.h
> > > +++ b/arch/mips/include/asm/timex.h
> > > @@ -94,7 +94,7 @@ static inline unsigned long random_get_entropy(void)
> > >     else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
> > >             return read_c0_random();
> > >     else
> > > -           return 0;       /* no usable register */
> > > +           return random_get_entropy_fallback();   /* no usable register */
> > >  }
> > >  #define random_get_entropy random_get_entropy
> > >
> > > --
> > > 2.35.1
> >
> > Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>
>  Or we could drop the PRID_IMP_R6000/A check and the final `else' clause
> entirely, as we don't even pretend to support the R6k at all anymore, and
> this is the final reference remaining.  For one we no longer handle the
> CPU in `cpu_probe_legacy' so any attempt to boot on such a CPU would
> inevitably fail as no CPU options would be set (we probably should have a
> `panic' or suchlike as the default case for the switch statement there).
>
>  Therefore I'm all for removing this piece instead, complementing commit
> 3b2db173f012 ("MIPS: Remove unused R6000 support"), where it should have
> really happened.

That's fine with me, if that's what Thomas wants to do, and I can
submit a v5 with that in it. Indeed, from our previous conversations,
I'm aware that the `else` there is probably never hit.

However, one thing that I've been thinking about is that the c0 random
register is actually kind of garbage. In my fuzzy decade-old memory of
MIPS, I believe the c0 random register starts at the maximum number of
TLB entries (16?), and then counts down cyclically, decrementing once
per CPU cycle. Is that right?

If it is, there are some real pros and cons here to consider:
- Pro: decrementing each CPU cycle means pretty good granularity
- Con: wrapping at, like, 16 or something really is very limited, to
the point of being almost bad

Meanwhile, on systems without the c0 cycles counter, what is the
actual resolution of random_get_entropy_fallback()? Is this just
falling back to jiffies?

IF (a) the fallback is jiffies AND (b) c0 wraps at 16, then actually,
what would be really nice would be something like:

    return (jiffies << 4) | read_c0_random();

It seems like that would give us something somewhat more ideal than
the status quo. Still crap, of course, but undoubtedly better.

Unfortunately, I don't know enough about whether assumptions (a) and
(b) hold for all hardware that doesn't have the c0 cycle counter. Can
you or Thomas confirm/deny this? And if it is more nuanced than my
optimistic assumption above, can we think of some scheme together that
nicely combines jiffies or the fallback function with the c0 random
register that would be sensible?

Jason

