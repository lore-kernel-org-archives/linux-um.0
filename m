Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA7Hn-0001eZ-Vc
 for linux-um@lists.infradead.org; Fri, 06 Mar 2020 07:20:45 +0000
Subject: Re: [PATCH net-next 1/7] um: reject unsupported coalescing params
References: <20200306010602.1620354-1-kuba@kernel.org>
 <20200306010602.1620354-2-kuba@kernel.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <fd59e667-38cb-6b16-8a27-311c7da523d0@cambridgegreys.com>
Date: Fri, 6 Mar 2020 06:58:07 +0000
MIME-Version: 1.0
In-Reply-To: <20200306010602.1620354-2-kuba@kernel.org>
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
Cc: mkubecek@suse.cz, merez@codeaurora.org, pv-drivers@vmware.com, GR-Linux-NIC-Dev@marvell.com, doshir@vmware.com, leon@kernel.org, linux-rdma@vger.kernel.org, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, edumazet@google.com, jgg@ziepe.ca, dledford@redhat.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org, manishc@marvell.com, jasowang@redhat.com, kvalo@codeaurora.org, hayeswang@realtek.com

On 06/03/2020 01:05, Jakub Kicinski wrote:
> Set ethtool_ops->supported_coalesce_params to let
> the core reject unsupported coalescing parameters.
> 
> This driver did not previously reject unsupported parameters.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   arch/um/drivers/vector_kern.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 0ff86391f77d..e98304d0219e 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1508,6 +1508,7 @@ static int vector_set_coalesce(struct net_device *netdev,
>   }
>   
>   static const struct ethtool_ops vector_net_ethtool_ops = {
> +	.supported_coalesce_params = ETHTOOL_COALESCE_TX_USECS,
>   	.get_drvinfo	= vector_net_get_drvinfo,
>   	.get_link	= ethtool_op_get_link,
>   	.get_ts_info	= ethtool_op_get_ts_info,
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

