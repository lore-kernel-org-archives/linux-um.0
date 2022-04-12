Return-Path: <SRS0=cL3S=UW=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220412172754.149498-1-Jason@zx2c4.com> <20220412172754.149498-2-Jason@zx2c4.com>
 <87bkx6f29b.ffs@tglx>
In-Reply-To: <87bkx6f29b.ffs@tglx>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 12 Apr 2022 23:17:03 +0200
Message-ID: <CAHmME9pVhO24V8V3YdeHfz6q1nmSgqXocUtn=+zu5Wh-OWrSRA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] timekeeping: add raw clock fallback for random_get_entropy()
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Thomas,

On Tue, Apr 12, 2022 at 10:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Apr 12 2022 at 19:27, Jason A. Donenfeld wrote:
> > +/**
> > + * random_get_entropy_fallback - Returns the raw clock source value,
> > + * used by random.c for platforms with no valid random_get_entropy().
> > + */
> > +unsigned long random_get_entropy_fallback(void)
> > +{
> > +     return tk_clock_read(&tk_core.timekeeper.tkr_mono);
> > +}
> > +EXPORT_SYMBOL(random_get_entropy_fallback);
>
> EXPORT_SYMBOL_GPL() please.

Okay, will do.

Jason

