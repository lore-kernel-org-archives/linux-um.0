Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 23 Jan 2014 08:40:01 +0100
From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Message-ID: <20140123074001.GA3080@samfundet.no>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
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
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-mips@linux-mips.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux@lists.openrisc.net, Sekhar Nori <nsekhar@ti.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>, Jonas Bonn <jonas@southpole.se>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>, linux-arm-msm@vger.kernel.org, David Brown <davidb@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>, user-mode-linux-devel@lists.sourceforge.net, Nicolas Ferre <nicolas.ferre@atmel.com>, Jeff Dike <jdike@addtoit.com>, Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org, John Stultz <john.stultz@linaro.org>, user-mode-linux-user@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, Michal Simek <monstr@monstr.eu>, Jim Cromie <jim.cromie@gmail.com>, microblaze-uclinux@itee.uq.edu.au, Hanjun Guo <guohanjun@huawei.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Bryan Huntsman <bryanh@codeaurora.org>, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Around Thu 23 Jan 2014 15:12:46 +0800 or thereabout, Yijing Wang wrote:
> Currently, clocksource_register() and __clocksource_register_scale()
> functions always return 0, it's pointless, make functions void.
> And remove the dead code that check the clocksource_register_hz()
> return value.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

For the avr32 related change

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/arm/mach-davinci/time.c                    |    5 ++---
>  arch/arm/mach-msm/timer.c                       |    4 +---
>  arch/arm/mach-omap2/timer.c                     |    8 +++-----
>  arch/avr32/kernel/time.c                        |    4 +---
>  arch/blackfin/kernel/time-ts.c                  |    6 ++----
>  arch/microblaze/kernel/timer.c                  |    3 +--
>  arch/mips/jz4740/time.c                         |    6 +-----
>  arch/mips/loongson/common/cs5536/cs5536_mfgpt.c |    3 ++-
>  arch/openrisc/kernel/time.c                     |    3 +--
>  arch/powerpc/kernel/time.c                      |    6 +-----
>  arch/um/kernel/time.c                           |    6 +-----
>  arch/x86/platform/uv/uv_time.c                  |   14 ++++++--------
>  drivers/clocksource/acpi_pm.c                   |    3 ++-
>  drivers/clocksource/cadence_ttc_timer.c         |    6 +-----
>  drivers/clocksource/exynos_mct.c                |    4 +---
>  drivers/clocksource/i8253.c                     |    3 ++-
>  drivers/clocksource/mmio.c                      |    3 ++-
>  drivers/clocksource/samsung_pwm_timer.c         |    5 +----
>  drivers/clocksource/scx200_hrt.c                |    3 ++-
>  drivers/clocksource/tcb_clksrc.c                |    8 +-------
>  drivers/clocksource/timer-marco.c               |    2 +-
>  drivers/clocksource/timer-prima2.c              |    2 +-
>  drivers/clocksource/vt8500_timer.c              |    4 +---
>  include/linux/clocksource.h                     |    8 ++++----
>  kernel/time/clocksource.c                       |    6 ++----
>  kernel/time/jiffies.c                           |    3 ++-
>  26 files changed, 45 insertions(+), 83 deletions(-)

<snipp diffs>

-- 
HcE

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

