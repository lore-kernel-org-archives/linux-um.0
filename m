Return-Path: <SRS0=AuuY=UY=zx2c4.com=Jason@kernel.org>
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-2-Jason@zx2c4.com>
 <Ylfzi1lNWTH1wjLA@shell.armlinux.org.uk>
In-Reply-To: <Ylfzi1lNWTH1wjLA@shell.armlinux.org.uk>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 14 Apr 2022 13:56:56 +0200
Message-ID: <CAHmME9q8R+uHNF_VBkJezfWn78kyw0RgGf-36JJKs6t3h3wQnA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] timekeeping: add raw clock fallback for random_get_entropy()
Content-Type: text/plain; charset="UTF-8"
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Russell,

On Thu, Apr 14, 2022 at 12:12 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> I'm surprised this didn't trigger checkpatch to warn. From
> coding-style:
>
> 6.1) Function prototypes
> Do not use the ``extern`` keyword with function declarations as this makes
> lines longer and isn't strictly necessary.

Okay, will do for v+1.

Jason

