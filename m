Return-Path: <jcmvbkbc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53ECE9DD.80004@gmail.com>
References: <53ECE9DD.80004@gmail.com>
Date: Fri, 15 Aug 2014 05:47:15 +0400
Message-ID: <CAMo8BfLuXZ8zyEoKdo8yb6nd+pZUnx0YEL9nqHx98kt76ezfYg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, starvik@axis.com, jesper.nilsson@axis.com, David Howells <dhowells@redhat.com>, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, yasutake.koichi@jp.panasonic.com, Jonas Bonn <jonas@southpole.se>, jejb@parisc-linux.org, deller@gmx.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, heiko.carstens@de.ibm.com, Liqin Chen <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, linux390@de.ibm.com, x86@kernel.org, linux-alpha@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Linux/MIPS Mailing List <linux-mips@linux-mips.org>, linux-am33-list@redhat.com, linux@lists.openrisc.net, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Chen,

On Thu, Aug 14, 2014 at 8:54 PM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
> Normal architectures:
>
>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
>
>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>                   score, unicore32, x86
>
>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
>
> Special architectures:
>
>  - Deside by compiler: microblaze, tile, xtensa.
>
>  - Deside by building host: um
>
>  - Next, need improve Kbuild to probe endian to deside whether need mark
>    __BUILDING_TIME_BIG_ENDIAN__ before real config.

[...]

> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 3a617af..a3e8f7e 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -22,6 +22,8 @@ config XTENSA
>         select HAVE_IRQ_TIME_ACCOUNTING
>         select HAVE_PERF_EVENTS
>         select COMMON_CLK
> +       select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
> +       select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>         help
>           Xtensa processors are 32-bit RISC machines designed by Tensilica
>           primarily for embedded systems.  These processors are both

I've tested this part and it doesn't select neither CPU_BIG_ENDIAN,
nor CPU_LITTLE_ENDIAN. And looking into the Kconfig/Kbuild I cound't
find anything related to __BUILDING_TIME_BIG_ENDIAN__. Am I missing
something?

-- 
Thanks.
-- Max

