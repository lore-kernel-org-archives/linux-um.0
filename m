Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkPG9-0007be-Ck
 for linux-um@lists.infradead.org; Mon, 08 Jul 2019 08:44:32 +0000
Subject: Re: [PATCH 3/3] um: Add checks to mtu parameter parsing
References: <20190708082925.8661-1-anton.ivanov@cambridgegreys.com>
 <20190708082925.8661-4-anton.ivanov@cambridgegreys.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <116fcb64-7bba-02b4-8ff0-8edb3205c06e@cambridgegreys.com>
Date: Mon, 8 Jul 2019 09:44:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190708082925.8661-4-anton.ivanov@cambridgegreys.com>
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
To: linux-um@lists.infradead.org
Cc: richard@nod.at



On 08/07/2019 09:29, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Adds a sanity check to the parsing of mtu command line param
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>   arch/um/drivers/vector_kern.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index e314a60cdc98..d7bb0c2788fe 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -117,13 +117,14 @@ static void vector_reset_stats(struct vector_private *vp)
>   static int get_mtu(struct arglist *def)
>   {
>   	char *mtu = uml_vector_fetch_arg(def, "mtu");
> -	long result;
> +	long result = ETH_MAX_PACKET;
>   
>   	if (mtu != NULL) {
>   		if (kstrtoul(mtu, 10, &result) == 0)
> -			return result;
> +			if (result > (1 << 16) - 1)
> +				result = ETH_MAX_PACKET;

The logic here is incorrect, I will send an amended patch.

>   	}
> -	return ETH_MAX_PACKET;
> +	return result;
>   }
>   
>   static int get_depth(struct arglist *def)
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

