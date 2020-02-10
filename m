Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1AF1-0005vC-Nd
 for linux-um@lists.infradead.org; Mon, 10 Feb 2020 14:40:53 +0000
Subject: Re: [PATCH] um: configs: Cleanup CONFIG_IOSCHED_CFQ
References: <20200130192226.2776-1-krzk@kernel.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <6e686a54-2e1c-b690-d465-369e0d712bba@cambridgegreys.com>
Date: Mon, 10 Feb 2020 14:40:45 +0000
MIME-Version: 1.0
In-Reply-To: <20200130192226.2776-1-krzk@kernel.org>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org



On 30/01/2020 19:22, Krzysztof Kozlowski wrote:
> CONFIG_IOSCHED_CFQ is since commit f382fb0bcef4 ("block: remove legacy
> IO schedulers").
> 
> The IOSCHED_BFQ seems to replace IOSCHED_CFQ so select it in configs
> previously choosing the latter.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/um/configs/i386_defconfig   | 2 +-
>   arch/um/configs/x86_64_defconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> index 73e98bb57bf5..fb51bd206dbe 100644
> --- a/arch/um/configs/i386_defconfig
> +++ b/arch/um/configs/i386_defconfig
> @@ -26,7 +26,7 @@ CONFIG_SLAB=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
> -CONFIG_IOSCHED_CFQ=m
> +CONFIG_IOSCHED_BFQ=m
>   CONFIG_SSL=y
>   CONFIG_NULL_CHAN=y
>   CONFIG_PORT_CHAN=y
> diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> index 3281d7600225..477b87317424 100644
> --- a/arch/um/configs/x86_64_defconfig
> +++ b/arch/um/configs/x86_64_defconfig
> @@ -24,7 +24,7 @@ CONFIG_SLAB=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
>   # CONFIG_BLK_DEV_BSG is not set
> -CONFIG_IOSCHED_CFQ=m
> +CONFIG_IOSCHED_BFQ=m
>   CONFIG_SSL=y
>   CONFIG_NULL_CHAN=y
>   CONFIG_PORT_CHAN=y
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

