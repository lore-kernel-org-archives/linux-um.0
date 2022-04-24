Return-Path: <SRS0=9wPK=VC=zx2c4.com=Jason@kernel.org>
Date: Sun, 24 Apr 2022 10:15:00 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
Message-ID: <YmUHBKPC0bAbs4Vj@zx2c4.com>
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-5-Jason@zx2c4.com>
 <20220413122546.GA11860@alpha.franken.de>
 <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
 <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk>
 <YlfoeGRM6w2O+eXA@zx2c4.com>
 <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk>
 <20220418071005.GA4075@alpha.franken.de>
 <alpine.DEB.2.21.2204220029590.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204220029590.9383@angie.orcam.me.uk>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Sun, Apr 24, 2022 at 12:33:44AM +0100, Maciej W. Rozycki wrote:
> unconditionally.  I think this discovery asks for code optimisation, which 
> I'll try to cook up sometime.

At some point too, by the way, we might also consider putting that into
a .c file rather than a static inline in the .h, since that function is
starting to get sort of big.

Jason

