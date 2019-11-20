Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXRKB-0002MV-2S
 for linux-um@lists.infradead.org; Wed, 20 Nov 2019 14:51:20 +0000
Subject: Re: [PATCH] um: Fix Kconfig indentation
References: <20191120133654.11838-1-krzk@kernel.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <0c2c2d49-563d-d7bd-bb01-26156ef8f398@cambridgegreys.com>
Date: Wed, 20 Nov 2019 14:23:49 +0000
MIME-Version: 1.0
In-Reply-To: <20191120133654.11838-1-krzk@kernel.org>
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
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org



On 20/11/2019 13:36, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/um/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index fec6b4ca2b6e..2a6d04fcb3e9 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -153,7 +153,7 @@ config KERNEL_STACK_ORDER
>   	  It is possible to reduce the stack to 1 for 64BIT and 0 for 32BIT on
>   	  older (pre-2017) CPUs. It is not recommended on newer CPUs due to the
>   	  increase in the size of the state which needs to be saved when handling
> -          signals.
> +	  signals.
>   
>   config MMAPPER
>   	tristate "iomem emulation driver"
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

