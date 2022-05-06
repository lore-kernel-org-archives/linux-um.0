Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nn1Qt-004TXN-EL
 for linux-um@lists.infradead.org; Fri, 06 May 2022 17:08:00 +0000
From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/6] um: vector: switch to netif_napi_add_weight()
Date: Fri,  6 May 2022 10:07:46 -0700
Message-Id: <20220506170751.822862-2-kuba@kernel.org>
In-Reply-To: <20220506170751.822862-1-kuba@kernel.org>
References: <20220506170751.822862-1-kuba@kernel.org>
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
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, Jakub Kicinski <kuba@kernel.org>, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org

UM's netdev driver uses a custom napi weight, switch to the new
API for setting custom weight.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: richard@nod.at
CC: anton.ivanov@cambridgegreys.com
CC: johannes@sipsolutions.net
CC: linux-um@lists.infradead.org
---
 arch/um/drivers/vector_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 1d6f6a66766c..548265312743 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1255,7 +1255,8 @@ static int vector_net_open(struct net_device *dev)
 			goto out_close;
 	}
 
-	netif_napi_add(vp->dev, &vp->napi, vector_poll, get_depth(vp->parsed));
+	netif_napi_add_weight(vp->dev, &vp->napi, vector_poll,
+			      get_depth(vp->parsed));
 	napi_enable(&vp->napi);
 
 	/* READ IRQ */
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

