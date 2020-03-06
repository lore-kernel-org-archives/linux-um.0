Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jABn9-0007jU-Hp
 for linux-um@lists.infradead.org; Fri, 06 Mar 2020 12:09:24 +0000
Date: Fri, 6 Mar 2020 14:09:18 +0200
From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next 2/7] RDMA/ipoib: reject unsupported coalescing
 params
Message-ID: <20200306120918.GQ184088@unreal>
References: <20200306010602.1620354-1-kuba@kernel.org>
 <20200306010602.1620354-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200306010602.1620354-3-kuba@kernel.org>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, merez@codeaurora.org, pv-drivers@vmware.com, GR-Linux-NIC-Dev@marvell.com, doshir@vmware.com, manishc@marvell.com, linux-rdma@vger.kernel.org, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, edumazet@google.com, jasowang@redhat.com, jgg@ziepe.ca, dledford@redhat.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org, hayeswang@realtek.com, davem@davemloft.net, kvalo@codeaurora.org, anton.ivanov@cambridgegreys.com

On Thu, Mar 05, 2020 at 05:05:57PM -0800, Jakub Kicinski wrote:
> Set ethtool_ops->supported_coalesce_params to let
> the core reject unsupported coalescing parameters.
>
> This driver did not previously reject unsupported parameters.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

