Return-Path: <SRS0=oEXL=U5=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220419111650.1582274-1-Jason@zx2c4.com> <20220419111650.1582274-8-Jason@zx2c4.com>
 <Yl78gLLcSb3EHv0B@zn.tnic>
In-Reply-To: <Yl78gLLcSb3EHv0B@zn.tnic>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 19 Apr 2022 20:38:41 +0200
Message-ID: <CAHmME9q03Je-ROzzHCgZC0vy1n=y8bsGBOAs8U_K_r3ebLNHbw@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] x86: use fallback for random_get_entropy()
 instead of zero
Content-Type: text/plain; charset="UTF-8"
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Borislav,

On Tue, Apr 19, 2022 at 8:16 PM Borislav Petkov <bp@alien8.de> wrote:
> > +static inline unsigned long random_get_entropy(void)
> > +{
> > +#ifndef CONFIG_X86_TSC
> > +     if (!boot_cpu_has(X86_FEATURE_TSC))
>
> cpu_feature_enabled() pls.

This function began as a carbon copy of get_cycles(), which reads:

static inline cycles_t get_cycles(void)
{
#ifndef CONFIG_X86_TSC
       if (!boot_cpu_has(X86_FEATURE_TSC))
               return 0;
#endif

       return rdtsc();
}

As you see, random_get_entropy() is the same function, but with that
zero replaced with the fallback. (Using the fallback in get_cycles()
wouldn't be appropriate.)

So, your options are:
a) We keep this patch as-is, using boot_cpu_has(); or
b) I make an unrelated change inside of this same patch to change
get_cycles() to use cpu_feature_enabled() (in addition to the new
random_get_entropy()).

I think I prefer doing (a), and leaving (b) for another time when you
or another x86 maintainer can do so. But I'll do whichever you say.
Which would you like?

Jason

