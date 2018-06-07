Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQtKR-0000eS-Eb
 for linux-um@lists.infradead.org; Thu, 07 Jun 2018 11:43:53 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] Fix the RAW interface options for UML
Date: Thu,  7 Jun 2018 12:43:15 +0100
Message-Id: <20180607114315.8103-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard.weinberger@gmail.com, dan.carpenter@oracle.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Raw interface initialization needs QDISC_BYPASS. Otherwise
it sees its own packets when transmitting.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 8b852928959b..cf9bf9b43ec3 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -188,7 +188,7 @@ static int get_transport_options(struct arglist *def)
 	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
 		return (vec_rx | VECTOR_BPF);
 	if (strncmp(transport, TRANS_RAW, TRANS_RAW_LEN) == 0)
-		return (vec_rx | vec_tx);
+		return (vec_rx | vec_tx | VECTOR_QDISC_BYPASS);
 	return (vec_rx | vec_tx);
 }
 
@@ -1241,9 +1241,8 @@ static int vector_net_open(struct net_device *dev)
 
 	if ((vp->options & VECTOR_QDISC_BYPASS) != 0) {
 		if (!uml_raw_enable_qdisc_bypass(vp->fds->rx_fd))
-			vp->options = vp->options | VECTOR_BPF;
+			vp->options |= VECTOR_BPF;
 	}
-
 	if ((vp->options & VECTOR_BPF) != 0)
 		vp->bpf = uml_vector_default_bpf(vp->fds->rx_fd, dev->dev_addr);
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

