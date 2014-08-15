Return-Path: <gang.chen.5i5j@gmail.com>
Message-ID: <53EDCC60.5040608@gmail.com>
Date: Fri, 15 Aug 2014 17:01:20 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
References: <53ECE9DD.80004@gmail.com> <20140814180418.GA20777@linux-mips.org> <53ED34CE.3040001@gmail.com>
In-Reply-To: <53ED34CE.3040001@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, james.hogan@imgtec.com, Michal Simek <monstr@monstr.eu>, yasutake.koichi@jp.panasonic.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, mpe@ellerman.id.au, Martin Schwidefsky <schwidefsky@de.ibm.com>, heiko.carstens@de.ibm.com, Liqin Chen <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, "David S. Miller" <davem@davemloft.net>, cmetcalf@tilera.com, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, linux390@de.ibm.com, x86@kernel.org, linux-alpha@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux@openrisc.net, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



On 8/15/14 6:14, Chen Gang wrote:
> On 08/15/2014 02:04 AM, Ralf Baechle wrote:
>>
> 
> OK, thanks, I assumes when support both endian, the default choice is
> CPU_BIG_ENDIAN, although no default value for choice (originally, I did
> worry about it).
> 
>> So I think you can just drop the MIPS segment from your patch.
>>
> 
> If what I assumes is correct, what you said sounds reasonable to me.
> 
> 

So for me, it is harmless to add CPU_*_ENDIAN explicitly, and can let
other members don't need think of.

By the way, for sh, it is almost the same case, except it contents the
default value, for me, it is clear enough, so I skip sh architecture in
this patch.


Thanks
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed

