Return-Path: <SRS0=N99Z=VB=zx2c4.com=Jason@kernel.org>
Date: Sat, 23 Apr 2022 12:00:33 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v5 11/11] random: insist on random_get_entropy() existing
 in order to simplify
Message-ID: <YmPOQS9GvdiM2brX@zx2c4.com>
References: <20220419111650.1582274-1-Jason@zx2c4.com>
 <20220419111650.1582274-12-Jason@zx2c4.com>
 <CACXcFmksd3cw+xa-c2gEdd4=96PO8GCCMF6q2d6JHnJum2LjiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACXcFmksd3cw+xa-c2gEdd4=96PO8GCCMF6q2d6JHnJum2LjiA@mail.gmail.com>
To: Sandy Harris <sandyinchina@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Sandy,

On Sat, Apr 23, 2022 at 10:24:07AM +0800, Sandy Harris wrote:
> On Sat, Apr 23, 2022 at 6:37 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > All platforms are now guaranteed to provide some value for
> > random_get_entropy(). In case some bug leads to this not being so, we
> > print a warning, ...
> 
> Would it make sense to test at compile time? If there is no hardware
> RNG nor a cycle counter, then the kernel should be compiled with
> the gcc latent entropy plugin. Generate a warning suggesting that,
> or even an error insisting on it.

Unfortunately, as a last ditch warning safeguard against bugs, I don't
think that's something we can determine at build time. A lot of this
machinery is dynamic. Fortunately a single check at init time brings
with it zero appreciable overhead.

Jason

