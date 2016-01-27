Return-Path: <linux-pm-owner@vger.kernel.org>
Subject: Re: [PATCH 01/22] power: reset: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-2-git-send-email-richard@nod.at>
 <56A8026F.8090001@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56A879AB.2060900@nod.at>
Date: Wed, 27 Jan 2016 09:02:51 +0100
MIME-Version: 1.0
In-Reply-To: <56A8026F.8090001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Moritz Fischer <moritz.fischer@ettus.com>, Jun Nie <jun.nie@linaro.org>, linux-pm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 27.01.2016 um 00:34 schrieb Florian Fainelli:
> On 25/01/16 14:24, Richard Weinberger wrote:
>> Not every arch has io memory.
>> So, unbreak the build by fixing the dependencies.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  drivers/power/reset/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index 1131cf7..0a6408a 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -148,6 +148,7 @@ config POWER_RESET_KEYSTONE
>>  config POWER_RESET_SYSCON
>>  	bool "Generic SYSCON regmap reset driver"
>>  	depends on OF
>> +	depends on HAS_IOMEM
>>  	select MFD_SYSCON
> 
> Should this dependency go into REGMAP_MMIO instead? MFD_SYSCON in itself
> does not issue I/O accesses per-se, but does use helpers from regmap,
> which in turn do it.

Hmmm, AFAICT this would not work as REGMAP_MMIO is not user visible and directly enabled
via "select" instead of "depends on". Hence, dependencies are ignored.

Thanks,
//richard
