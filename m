Return-Path: <SRS0=Q3lN=UV=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220410214951.55294-1-Jason@zx2c4.com> <20220410214951.55294-4-Jason@zx2c4.com>
 <87sfqkf2y1.ffs@tglx>
In-Reply-To: <87sfqkf2y1.ffs@tglx>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 12 Apr 2022 00:07:58 +0200
Message-ID: <CAHmME9qU7x3=KsjfH0qDW=isdcGxTweHbssvshYxkV5iHpamGw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] m68k: use ktime_read_raw_clock() for
 random_get_entropy() instead of zero
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Thomas,

On Mon, Apr 11, 2022 at 10:18 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > diff --git a/arch/m68k/include/asm/timex.h b/arch/m68k/include/asm/timex.h
> > index 6a21d9358280..5351b10e1b18 100644
> > --- a/arch/m68k/include/asm/timex.h
> > +++ b/arch/m68k/include/asm/timex.h
> > @@ -35,7 +35,7 @@ static inline unsigned long random_get_entropy(void)
> >  {
> >       if (mach_random_get_entropy)
> >               return mach_random_get_entropy();
> > -     return 0;
> > +     return ktime_read_raw_clock();
>
> I'd rather do something like this in a common header:
>
> unsigned long random_get_entropy_fallback(void);
>
> and use random_get_entropy_fallback() in the architecture specific
> files.
>
> That way you can encapsulate the fallback implementation in the random
> code and if it turns out that ktime_read_raw_clock() is a stupid idea or
> someone has a better idea then you have to change exactly one place and
> not patch the whole tree again.

Absolutely. That's a good idea. I'll do that for v3.

Jason

