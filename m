Return-Path: <macro@orcam.me.uk>
Date: Thu, 21 Apr 2022 20:25:53 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v5 04/11] mips: use fallback for random_get_entropy()
 instead of just c0 random
In-Reply-To: <20220419111650.1582274-5-Jason@zx2c4.com>
Message-ID: <alpine.DEB.2.21.2204212018540.9383@angie.orcam.me.uk>
References: <20220419111650.1582274-1-Jason@zx2c4.com> <20220419111650.1582274-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Tue, 19 Apr 2022, Jason A. Donenfeld wrote:

> For situations in which we don't have a c0 counter register available,
> we've been falling back to reading the c0 "random" register, which is
> usually bounded by the amount of TLB entries and changes every other
> cycle or so. This means it wraps extremely often. We can do better by
> combining this fast-changing counter with a potentially slower-changing
> counter from random_get_entropy_fallback() in the more significant bits.
> This commit combines the two, taking into account that the changing bits
> are in a different bit position depending on the CPU model. In addition,
> we previously were falling back to 0 for ancient CPUs that Linux does
> not support anyway; remove that dead path entirely.

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

 I've pushed the algorithm through testing with a number of suitable 
systems:

- an R2000A and an R3000A with no timer of any kind, only jiffies,

- an R3400 with a chipset timer only,

- an R4400SC with a usable buggy CP0 counter and a chipset timer,

- a 5Kc with a good CP0 counter only,

with no obvious issues spotted.  Thank you for working on this!

  Maciej

