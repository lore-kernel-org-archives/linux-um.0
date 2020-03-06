Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA1Rx-0008Mh-SF
 for linux-um@lists.infradead.org; Fri, 06 Mar 2020 01:06:51 +0000
From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/7] ethtool: consolidate irq coalescing - other
 drivers
Date: Thu,  5 Mar 2020 17:05:55 -0800
Message-Id: <20200306010602.1620354-1-kuba@kernel.org>
MIME-Version: 1.0
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
To: davem@davemloft.net
Cc: mkubecek@suse.cz, doshir@vmware.com, pv-drivers@vmware.com, jasowang@redhat.com, edumazet@google.com, anton.ivanov@cambridgegreys.com, merez@codeaurora.org, leon@kernel.org, linux-rdma@vger.kernel.org, richard@nod.at, jgg@ziepe.ca, dledford@redhat.com, Jakub Kicinski <kuba@kernel.org>, hayeswang@realtek.com, jdike@addtoit.com, linux-um@lists.infradead.org, kvalo@codeaurora.org, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, gregkh@linuxfoundation.org

Hi!

Convert more drivers following the groundwork laid in a recent
patch set [1]. The aim of the effort is to consolidate irq
coalescing parameter validation in the core.

This set converts all the drivers outside of drivers/net/ethernet.

Only vmxnet3 them was checking unsupported parameters.

The aim is to merge this via the net-next tree so we can
convert all drivers and make the checking mandatory.

[1] https://lore.kernel.org/netdev/20200305051542.991898-1-kuba@kernel.org/

Jakub Kicinski (7):
  um: reject unsupported coalescing params
  RDMA/ipoib: reject unsupported coalescing params
  tun: reject unsupported coalescing params
  r8152: reject unsupported coalescing params
  vmxnet3: let core reject the unsupported coalescing parameters
  staging: qlge: reject unsupported coalescing params
  wil6210: reject unsupported coalescing params

 arch/um/drivers/vector_kern.c                |  1 +
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c |  2 ++
 drivers/net/tun.c                            |  1 +
 drivers/net/usb/r8152.c                      |  1 +
 drivers/net/vmxnet3/vmxnet3_ethtool.c        | 24 +++-----------------
 drivers/net/wireless/ath/wil6210/ethtool.c   |  1 +
 drivers/staging/qlge/qlge_ethtool.c          |  2 ++
 7 files changed, 11 insertions(+), 21 deletions(-)

-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

