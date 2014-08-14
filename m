Return-Path: <gang.chen.5i5j@gmail.com>
Message-ID: <53ED34CE.3040001@gmail.com>
Date: Fri, 15 Aug 2014 06:14:38 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
References: <53ECE9DD.80004@gmail.com> <20140814180418.GA20777@linux-mips.org>
In-Reply-To: <20140814180418.GA20777@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, james.hogan@imgtec.com, Michal Simek <monstr@monstr.eu>, yasutake.koichi@jp.panasonic.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, mpe@ellerman.id.au, Martin Schwidefsky <schwidefsky@de.ibm.com>, heiko.carstens@de.ibm.com, Liqin Chen <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, "David S. Miller" <davem@davemloft.net>, cmetcalf@tilera.com, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, linux390@de.ibm.com, x86@kernel.org, linux-alpha@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux@openrisc.net, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 08/15/2014 02:04 AM, Ralf Baechle wrote:
> On Fri, Aug 15, 2014 at 12:54:53AM +0800, Chen Gang wrote:
> 
>> Normal architectures:
>>
>>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
>>
>>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>>                   score, unicore32, x86
>>
>>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
> 
> Nak for MIPS.  On MIPS Kconfig already always sets one of CPU_BIG_ENDIAN
> and CPU_LITTLE_ENDIAN depending on platforms and where both endianess are
> supported by a platform, user choice:
> 
> config FOO
> 	bool "foo"
> 	select SYS_SUPPORTS_LITTLE_ENDIAN
> 
> config FOO
> 	bool "foo"
> 	select SYS_SUPPORTS_BIG_ENDIAN
> 	select SYS_SUPPORTS_LITTLE_ENDIAN
> [...]
> choice
>         prompt "Endianess selection"
>         help
>           Some MIPS machines can be configured for either little or big endian
>           byte order. These modes require different kernels and a different
>           Linux distribution.  In general there is one preferred byteorder for a
>           particular system but some systems are just as commonly used in the
>           one or the other endianness.
> 
> config CPU_BIG_ENDIAN
>         bool "Big endian"
>         depends on SYS_SUPPORTS_BIG_ENDIAN
> 
> config CPU_LITTLE_ENDIAN
>         bool "Little endian"
>         depends on SYS_SUPPORTS_LITTLE_ENDIAN
>         help
> 
> endchoice
> 

OK, thanks, I assumes when support both endian, the default choice is
CPU_BIG_ENDIAN, although no default value for choice (originally, I did
worry about it).

> So I think you can just drop the MIPS segment from your patch.
> 

If what I assumes is correct, what you said sounds reasonable to me.


Thanks.
-- 
Chen Gang

Open share and attitude like air water and life which God blessed

