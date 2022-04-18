Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 18 Apr 2022 09:10:05 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
Message-ID: <20220418071005.GA4075@alpha.franken.de>
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-5-Jason@zx2c4.com>
 <20220413122546.GA11860@alpha.franken.de>
 <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
 <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk>
 <YlfoeGRM6w2O+eXA@zx2c4.com>
 <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org

On Fri, Apr 15, 2022 at 01:26:48PM +0100, Maciej W. Rozycki wrote:
> Hi Jason,
> 
> > >  It depends on the exact system.  Some have a 32-bit high-resolution 
> > > counter in the chipset (arch/mips/kernel/csrc-ioasic.c) giving like 25MHz 
> > > resolution, some have nothing but jiffies.
> > 
> > Alright, so there _are_ machines with no c0 cycles but with a good
> > clock. Yet, 25MHz is still less than the cpu cycle, so this c0 random
> > ORing trick remains useful perhaps.
> 
>  It's not much less than the CPU cycle really, given that the R3k CPUs are 
> clocked at up to 40MHz in the systems concerned and likewise the buggy R4k 
> CPUs run at up to 60MHz (and mind that their CP0 Count register increments 
> at half the clock rate, so the rate is up to 30MHz anyway).  The overhead 
> of the calculation is more than that, let alone the latency and issue rate 
> of an uncached MMIO access to the chipset register.
> 
>  Also the systems I have in mind and that lack a counter in the chipset 
> actually can make use of the buggy CP0 timer, because it's only when CP0 
> timer interrupts are used that the erratum matters, but they use a DS1287 
> RTC interrupt instead unconditionally as the clock event (see the comment 
> at the bottom of arch/mips/dec/time.c).  But this has not been factored in 
> with `can_use_mips_counter' (should it just check for `mips_hpt_frequency' 
> being zero perhaps, meaning the timer interrupt not being used?).
> 
>  Thomas, do you happen to know if any of the SGI systems that we support 
> had buggy early R4k chips?

IP22 has probably seen all buggy MIPS chips produced, so yes I even own
Indy/Indigo2 CPU boards with early R4k chips.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

