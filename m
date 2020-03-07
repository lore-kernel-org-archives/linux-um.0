Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jATEA-0002Hf-Td
 for linux-um@lists.infradead.org; Sat, 07 Mar 2020 06:46:28 +0000
Date: Fri, 06 Mar 2020 22:46:18 -0800 (PST)
Message-Id: <20200306.224618.1734969802976525324.davem@davemloft.net>
Subject: Re: [PATCH net-next 0/7] ethtool: consolidate irq coalescing -
 other drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200306010602.1620354-1-kuba@kernel.org>
References: <20200306010602.1620354-1-kuba@kernel.org>
Mime-Version: 1.0
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
To: kuba@kernel.org
Cc: mkubecek@suse.cz, merez@codeaurora.org, pv-drivers@vmware.com, GR-Linux-NIC-Dev@marvell.com, doshir@vmware.com, leon@kernel.org, manishc@marvell.com, linux-rdma@vger.kernel.org, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, edumazet@google.com, jgg@ziepe.ca, dledford@redhat.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org, hayeswang@realtek.com, jasowang@redhat.com, kvalo@codeaurora.org, anton.ivanov@cambridgegreys.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu,  5 Mar 2020 17:05:55 -0800

> Convert more drivers following the groundwork laid in a recent
> patch set [1]. The aim of the effort is to consolidate irq
> coalescing parameter validation in the core.
> 
> This set converts all the drivers outside of drivers/net/ethernet.
> 
> Only vmxnet3 them was checking unsupported parameters.
> 
> The aim is to merge this via the net-next tree so we can
> convert all drivers and make the checking mandatory.
> 
> [1] https://lore.kernel.org/netdev/20200305051542.991898-1-kuba@kernel.org/

Series applied, thanks Jakub.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

