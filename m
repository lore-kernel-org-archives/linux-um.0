Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN96L-00HDLd-QY
 for linux-um@lists.infradead.org; Thu, 24 Feb 2022 08:03:51 +0000
Subject: Re: [PATCH] Input: samsung-keypad - Properly state IOMEM dependency
References: <20220224035819.1593730-1-davidgow@google.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <19c9bf24-c3e1-36a3-376e-7091cc3b3f62@cambridgegreys.com>
Date: Thu, 24 Feb 2022 08:03:40 +0000
MIME-Version: 1.0
In-Reply-To: <20220224035819.1593730-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org



On 24/02/2022 03:58, David Gow wrote:
> Make the samsung-keypad driver explicitly depend on CONFIG_IOMEM, as it
> calls devm_ioremap(). This prevents compile errors in some configs (e.g,
> allyesconfig/randconfig under UML):
> 
> /usr/bin/ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
> samsung-keypad.c:(.text+0xc60): undefined reference to `devm_ioremap'
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   drivers/input/keyboard/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 0c607da9ee10..5c98d5f996e4 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -556,7 +556,7 @@ config KEYBOARD_PMIC8XXX
>   
>   config KEYBOARD_SAMSUNG
>   	tristate "Samsung keypad support"
> -	depends on HAVE_CLK
> +	depends on IOMEM && HAVE_CLK
>   	select INPUT_MATRIXKMAP
>   	help
>   	  Say Y here if you want to use the keypad on your Samsung mobile
> 
Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

