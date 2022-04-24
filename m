Return-Path: <macro@orcam.me.uk>
Date: Sun, 24 Apr 2022 11:51:38 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
In-Reply-To: <YmUHBKPC0bAbs4Vj@zx2c4.com>
Message-ID: <alpine.DEB.2.21.2204241140290.9383@angie.orcam.me.uk>
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com> <20220413122546.GA11860@alpha.franken.de> <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk> <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk> <YlfoeGRM6w2O+eXA@zx2c4.com> <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk> <20220418071005.GA4075@alpha.franken.de> <alpine.DEB.2.21.2204220029590.9383@angie.orcam.me.uk>
 <YmUHBKPC0bAbs4Vj@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Sun, 24 Apr 2022, Jason A. Donenfeld wrote:

> > unconditionally.  I think this discovery asks for code optimisation, which 
> > I'll try to cook up sometime.
> 
> At some point too, by the way, we might also consider putting that into
> a .c file rather than a static inline in the .h, since that function is
> starting to get sort of big.

 This code is supposed to produce one to a couple of machine instructions 
for the majority of configurations.  This is because the conditionals used 
are usually compile-time constants.  Therefore I think it will be good to 
continue having it as `static inline' functions.  Cf. the analysis in 
commit 06947aaaf9bf ("MIPS: Implement random_get_entropy with CP0 
Random").

 If this code does expand to a longer sequence for some platforms, then 
either they need to be verified whether they can be optimised (just as I 
note here for the DEC systems) or we can consider making these functions 
`extern inline' instead, with out-of-line code available from a .a file in 
case the compiler decides the code is too large for inlining to be worth 
doing after all.  Though I don't expect the latter case to be required 
really.

  Maciej

