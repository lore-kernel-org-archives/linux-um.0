Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4hNj-0003Pu-TK
 for linux-um@lists.infradead.org; Thu, 20 Feb 2020 08:40:29 +0000
From: Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 0/2] Remove dead code and driver version
Date: Thu, 20 Feb 2020 10:40:12 +0200
Message-Id: <20200220084014.238768-1-leon@kernel.org>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Leon Romanovsky <leonro@mellanox.com>, linux-um <linux-um@lists.infradead.org>

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

This short series is an outcome of the change in ethtool [1] to provide
proper driver version that will work reliably. The second patch is
removal of useless timer setup.

Code is compile tested only.

[1] https://lore.kernel.org/linux-rdma/20200127072028.19123-1-leon@kernel.org/

Leon Romanovsky (2):
  um: Don't overwrite ethtool driver version
  um: Delete never executed timer

 arch/um/drivers/net_kern.c    | 13 -------------
 arch/um/drivers/vector_kern.c |  2 --
 2 files changed, 15 deletions(-)

--
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

