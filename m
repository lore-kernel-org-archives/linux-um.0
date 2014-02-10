Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <52F827D3.5080906@huawei.com>
Date: Mon, 10 Feb 2014 09:13:55 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
 <52E0C889.6000106@prisktech.co.nz>
 <063D6719AE5E284EB5DD2968C1650D6D46489C@AcuExch.aculab.com>
 <alpine.DEB.2.02.1402052139560.24986@ionos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.02.1402052139560.24986@ionos.tec.linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions void
To: Thomas Gleixner <tglx@linutronix.de>, David Laight <David.Laight@ACULAB.COM>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "x86@kernel.org" <x86@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux@lists.openrisc.net" <linux@openrisc.net>, Hanjun Guo <guohanjun@huawei.com>, Sekhar Nori <nsekhar@ti.com>, Michal Simek <monstr@monstr.eu>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>, "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>, David Brown <davidb@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Barry Song <baohua@kernel.org>, Jim Cromie <jim.cromie@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Bryan Huntsman <bryanh@codeaurora.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 2014/2/6 4:40, Thomas Gleixner wrote:
> Yijing,
> 
> On Thu, 23 Jan 2014, David Laight wrote:
> 
>> From: Linuxppc-dev Tony Prisk
>>> On 23/01/14 20:12, Yijing Wang wrote:
>>>> Currently, clocksource_register() and __clocksource_register_scale()
>>>> functions always return 0, it's pointless, make functions void.
>>>> And remove the dead code that check the clocksource_register_hz()
>>>> return value.
>>> ......
>>>> -static inline int clocksource_register_hz(struct clocksource *cs, u32 hz)
>>>> +static inline void clocksource_register_hz(struct clocksource *cs, u32 hz)
>>>>   {
>>>>   	return __clocksource_register_scale(cs, 1, hz);
>>>>   }
>>>
>>> This doesn't make sense - you are still returning a value on a function
>>> declared void, and the return is now from a function that doesn't return
>>> anything either ?!?!
>>> Doesn't this throw a compile-time warning??
>>
>> It depends on the compiler.
>> Recent gcc allow it.
>> I don't know if it is actually valid C though.
>>
>> There is no excuse for it on lines like the above though.
> 
> Can you please resend with that fixed against 3.14-rc1 ?

OK, I will resend later.

Thanks!
Yijing.


> 
> .
> 


-- 
Thanks!
Yijing


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

