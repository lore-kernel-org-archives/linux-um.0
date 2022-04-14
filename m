Return-Path: <SRS0=AuuY=UY=zx2c4.com=Jason@kernel.org>
Date: Thu, 14 Apr 2022 11:27:22 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
Message-ID: <YlfoeGRM6w2O+eXA@zx2c4.com>
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-5-Jason@zx2c4.com>
 <20220413122546.GA11860@alpha.franken.de>
 <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
 <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Maciej,

On Thu, Apr 14, 2022 at 02:16:18AM +0100, Maciej W. Rozycki wrote:
>  Yes, for the relevant CPUs the range is 63-8 << 8 for R3k machines and 
> 47-0 (the lower bound can be higher if wired entries are used, which I 
> think we occasionally do) for R4k machines with a buggy CP0 counter.  So 
> there are either 56 or up to 48 distinct CP0 Random register values.

Ahh interesting, so it varies a bit, but it remains rather small.

>  It depends on the exact system.  Some have a 32-bit high-resolution 
> counter in the chipset (arch/mips/kernel/csrc-ioasic.c) giving like 25MHz 
> resolution, some have nothing but jiffies.

Alright, so there _are_ machines with no c0 cycles but with a good
clock. Yet, 25MHz is still less than the cpu cycle, so this c0 random
ORing trick remains useful perhaps.

>  It seems like a reasonable idea to me, but the details would have to be 
> sorted out, because where a chipset high-resolution counter is available 
> we want to factor it in, and otherwise we need to extract the right bits 
> from the CP0 Random register, either 13:8 for the R3k or 5:0 for the R4k.

One thing we could do here that would seemingly cover all the cases
without losing _that_ much would be:

    return (random_get_entropy_fallback() << 13) | ((1<<13) - read_c0_random());

Or in case the 13 turns out to be wrong on some hardware, we could
mitigate the effect with:

    return (random_get_entropy_fallback() << 13) ^ ((1<<13) - read_c0_random());

As mentioned in the 1/xx patch of this series,
random_get_entropy_fallback() should call the highest resolution thing.
We then shave off the least-changing bits and stuff in the
faster-changing bits from read_c0_random(). Then, in order to keep it
counting up instead of down, we do the subtraction there.

What do you think of this plan?

Jason

