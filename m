Return-Path: <SRS0=VN1/=UX=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-2-Jason@zx2c4.com>
 <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com>
In-Reply-To: <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 14 Apr 2022 00:38:49 +0200
Message-ID: <CAHmME9pn++c0qHzq39YWyXogcKRbn2XK=yA3kFqch0wH7qPcAg@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] timekeeping: add raw clock fallback for random_get_entropy()
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Rob,

On Wed, Apr 13, 2022 at 4:32 PM Rob Herring <robh@kernel.org> wrote:
> 'does not have a usable get_cycles(), ...' as clearly some arches have
> get_cycles() and yet still need a fallback.
>
> Why not handle the 'if get_cycles() returns 0 do the fallback' within
> a weak random_get_entropy() function? Then more arches don't need any
> random_get_entropy() implementation.

No, this doesn't really work. Actually, most archs don't need a
random_get_entropy() function, because it exists in asm-generic doing
the thing we want. So that's taken care of. But weak functions as you
suggested would be quite suboptimal, because on, e.g. x86, what we
have now gets inlined into a single rdtsc instruction. Also, the
relation between get_cycles() and random_get_entropy() doesn't always
hold; some archs may not have a working get_cycles() function but do
have a path for a random_get_entropy(). Etc, etc. So I'm pretty sure
that this commit is really the most simple and optimal thing to do. I
really don't want to go the weak functions route.

Jason

