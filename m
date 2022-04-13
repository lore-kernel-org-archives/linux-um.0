Return-Path: <SRS0=VN1/=UX=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-4-Jason@zx2c4.com>
 <CAL_JsqJ86vZKZQO+9_Kva-EbZrRPMbcgDm+UvjJdnR=GL-qHSw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ86vZKZQO+9_Kva-EbZrRPMbcgDm+UvjJdnR=GL-qHSw@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 14 Apr 2022 00:40:19 +0200
Message-ID: <CAHmME9qGzW1+dWLvObjQ4ofGcCU1tOwTB+qJTVs2ufEmAEhbrA@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] riscv: use fallback for random_get_entropy()
 instead of zero
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Rob,

On Wed, Apr 13, 2022 at 4:40 PM Rob Herring <robh@kernel.org> wrote:
> Moving this check to get_cycles() implementation would eliminate the
> RiscV implementation of random_get_entropy() if you follow my other
> suggestion.

Not an option. random_get_entropy() != get_cycles(). Sometimes these
are different functions. Returning random_get_entropy_fallback() from
get_cycles(), for example, wouldn't make any sense.

Jason

