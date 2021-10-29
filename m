Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgLld-009z1z-SX
 for linux-um@lists.infradead.org; Fri, 29 Oct 2021 06:53:35 +0000
Subject: Re: [PATCH net-next 2/3] net: um: use eth_hw_addr_set()
References: <20211029024707.316066-1-kuba@kernel.org>
 <20211029024707.316066-3-kuba@kernel.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <359d5737-2ac9-12aa-cca8-1b0c52def83e@cambridgegreys.com>
Date: Fri, 29 Oct 2021 07:37:08 +0100
MIME-Version: 1.0
In-Reply-To: <20211029024707.316066-3-kuba@kernel.org>
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
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, jdike@addtoit.com, richard@nod.at, johannes.berg@intel.com, linux-um@lists.infradead.org

On 29/10/2021 03:47, Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it go through appropriate helpers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jdike@addtoit.com
> CC: richard@nod.at
> CC: anton.ivanov@cambridgegreys.com
> CC: johannes.berg@intel.com
> CC: linux-um@lists.infradead.org
> ---
>   arch/um/drivers/net_kern.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
> index 2fc0b038ff8a..59331384c2d3 100644
> --- a/arch/um/drivers/net_kern.c
> +++ b/arch/um/drivers/net_kern.c
> @@ -276,7 +276,7 @@ static const struct ethtool_ops uml_net_ethtool_ops = {
>   
>   void uml_net_setup_etheraddr(struct net_device *dev, char *str)
>   {
> -	unsigned char *addr = dev->dev_addr;
> +	u8 addr[ETH_ALEN];
>   	char *end;
>   	int i;
>   
> @@ -316,6 +316,7 @@ void uml_net_setup_etheraddr(struct net_device *dev, char *str)
>   		       addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
>   		       addr[5]);
>   	}
> +	eth_hw_addr_set(dev, addr);
>   	return;
>   
>   random:
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

