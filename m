Return-Path: <SRS0=Zvza=U2=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-5-Jason@zx2c4.com>
 <20220413122546.GA11860@alpha.franken.de> <alpine.DEB.2.21.2204131331450.9383@angie.orcam.me.uk>
 <CAHmME9pQ4xdeTUDxAdrOu=S9NRTonYzJVk50fa0Zfz4knZt5WA@mail.gmail.com>
 <alpine.DEB.2.21.2204140014580.9383@angie.orcam.me.uk> <YlfoeGRM6w2O+eXA@zx2c4.com>
 <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204142349180.9383@angie.orcam.me.uk>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 16 Apr 2022 13:09:24 +0200
Message-ID: <CAHmME9qzkZqkGntLn--XfMKzyR=tYiCaZu1uFpoQBzAzCipZ-A@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] mips: use fallback for random_get_entropy()
 instead of zero
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Maciej,

On Fri, Apr 15, 2022 at 2:26 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote=
:
>     return (random_get_entropy_fallback() << 14) | ((1<<14) - read_c0_ran=
dom());
>
> of course, as bit 13 is still one of the active ones in the R3k CP0 Rando=
m
> register.

Ah, thanks, will do that.

>  There are two variants only of the CP0 Random register that we can ever
> encounter, as it's been de-facto standardised in early 1990s already and
> then written down in the MIPSr1 architecture specification ~2000.  So I
> think it may make sense to actually handle them both explictitly with
> individual calculations, possibly conditionalised on a CONFIG setting or
> `cpu_has_3kex', because kernels that support the two variants of the MMU
> architecture are mutually incompatible.

Okay, I can give this a shot, but this certainly isn't my fort=C3=A9. It
may ultimately wind up being simpler for you to just send some code of
what you envision for this, but if I understand your idea correctly,
what you're saying is something like:

static inline unsigned long random_get_entropy(void)
{
        unsigned int prid =3D read_c0_prid();
        unsigned int imp =3D prid & PRID_IMP_MASK;
        unsigned int c0_random;

        if (can_use_mips_counter(prid))
                return read_c0_count();

        if (cpu_has_3kex)
                c0_random =3D (read_c0_random() >> 8) & 0x3f;
        else
                c0_random =3D read_c0_random() & 0x3f;
        return (random_get_entropy_fallback() << 6) | (0x3f - c0_random);
}

What do you think of that? Some tweak I'm missing?

>  Isn't it going to be an issue for an entropy source that the distributio=
n
> of values obtained from the CP0 Random bit-field is not even, that is som=
e
> values from the 6-bit range will never appear?

It's the same situation without inverting the order: instead of some
bits on the top never happening, some bits on the bottom never happen
instead. In general, counters don't form uniform distributions anyway,
since the lower bits change faster, and neither are they independent,
since one sample in large part depends on the previous. This is just
sort of the nature of the beast, and the code that calls
random_get_entropy() deals with this appropriately (by, at the moment,
just hashing all the bits).

Jason

