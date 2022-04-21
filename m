Return-Path: <jcmvbkbc@gmail.com>
MIME-Version: 1.0
References: <20220419111650.1582274-1-Jason@zx2c4.com> <20220419111650.1582274-11-Jason@zx2c4.com>
In-Reply-To: <20220419111650.1582274-11-Jason@zx2c4.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 21 Apr 2022 01:00:36 -0700
Message-ID: <CAMo8Bf+ox2MQRkqsTaOOXOchOWpb+7P8GQ1c-TjwSpDgttXoFA@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] xtensa: use fallback for random_get_entropy()
 instead of zero
Content-Type: text/plain; charset="UTF-8"
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel@lists.infradead.org, "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>
List-ID: <linux-um.lists.infradead.org>

On Tue, Apr 19, 2022 at 4:18 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
>
> This is accomplished by just including the asm-generic code like on
> other architectures, which means we can get rid of the empty stub
> function here.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/xtensa/include/asm/timex.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

