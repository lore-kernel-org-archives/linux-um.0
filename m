Return-Path: <hpa@zytor.com>
Date: Thu, 14 Apr 2022 14:49:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_01/11=5D_timekeeping=3A_add_ra?= =?US-ASCII?Q?w_clock_fallback_for_random=5Fget=5Fentropy=28=29?=
In-Reply-To: <YliHAl0XpQ57FSGy@robh.at.kernel.org>
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-2-Jason@zx2c4.com> <CAL_JsqJYq5Oe_zBbcwYNMpfpqGLGCyaSfGqOrPjZ_Pj=nF73mA@mail.gmail.com> <CAHmME9pn++c0qHzq39YWyXogcKRbn2XK=yA3kFqch0wH7qPcAg@mail.gmail.com> <YliHAl0XpQ57FSGy@robh.at.kernel.org>
Message-ID: <B465920D-5799-4799-A0AC-68837E159D66@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Rob Herring <robh@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On April 14, 2022 1:41:38 PM PDT, Rob Herring <robh@kernel=2Eorg> wrote:
>On Thu, Apr 14, 2022 at 12:38:49AM +0200, Jason A=2E Donenfeld wrote:
>> Hi Rob,
>>=20
>> On Wed, Apr 13, 2022 at 4:32 PM Rob Herring <robh@kernel=2Eorg> wrote:
>> > 'does not have a usable get_cycles(), =2E=2E=2E' as clearly some arch=
es have
>> > get_cycles() and yet still need a fallback=2E
>> >
>> > Why not handle the 'if get_cycles() returns 0 do the fallback' within
>> > a weak random_get_entropy() function? Then more arches don't need any
>> > random_get_entropy() implementation=2E
>>=20
>> No, this doesn't really work=2E Actually, most archs don't need a
>> random_get_entropy() function, because it exists in asm-generic doing
>> the thing we want=2E So that's taken care of=2E But weak functions as y=
ou
>> suggested would be quite suboptimal, because on, e=2Eg=2E x86, what we
>> have now gets inlined into a single rdtsc instruction=2E Also, the
>> relation between get_cycles() and random_get_entropy() doesn't always
>> hold; some archs may not have a working get_cycles() function but do
>> have a path for a random_get_entropy()=2E Etc, etc=2E So I'm pretty sur=
e
>> that this commit is really the most simple and optimal thing to do=2E I
>> really don't want to go the weak functions route=2E
>
>Is random_get_entropy() a hot path?
>
>
>It doesn't have to be a weak function, but look at it this way=2E We have=
=20
>the following possibilities for what random_get_entropy() does:
>
>- get_cycles()
>- get_cycles() but returns 0 sometimes
>- returns 0
>- something else
>
>You're handling the 3rd case=2E
>
>For the 2nd case, that's riscv, arm, nios2, and x86=2E That's not a lot,=
=20
>but is 2 or 3 of the most widely used architectures=2E Is it really too=
=20
>much to ask to support the 2nd case in the generic code/header?
>
>Rob

It goes into interrupts, which means it is latency critical=2E

