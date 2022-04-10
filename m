Return-Path: <SRS0=O4Mn=UU=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220408182145.142506-1-Jason@zx2c4.com> <87wnfxhm3n.ffs@tglx>
 <YlLo8JVOS6FDmWUM@zx2c4.com> <877d7whd29.ffs@tglx>
In-Reply-To: <877d7whd29.ffs@tglx>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 10 Apr 2022 23:38:26 +0200
Message-ID: <CAHmME9pa+52JPuewOybZE6Q0i+RGKb6crC6_Tropc7ygff7H2g@mail.gmail.com>
Subject: Re: [PATCH RFC v1 00/10] archs/random: fallback to using
 sched_clock() if no cycle counter
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Thomas,

On Sun, Apr 10, 2022 at 10:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Not yet having too much knowledge, I'm tentatively leaning toward the
> > safe side, of just using ktime_read_raw_clock() in the current places
> > that return zero all the time -- that is, for the purpose this patchset
> > has.
>
> That's probably a good approach and it's init/runtime discoverable.

Alright then. I'll send out a v2 and we'll see how that looks.

Jason

