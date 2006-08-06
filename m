Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G9kq7-0002pT-AM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 08:46:55 -0700
Received: from host17-96.pool873.interbusiness.it ([87.3.96.17]
	helo=memento.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1G9kq5-00011l-Uj for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 08:46:55 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 06 Aug 2006 17:47:03 +0200
Message-Id: <20060806154703.536.80128.stgit@memento.home.lan>
In-Reply-To: <20060806154700.536.32978.stgit@memento.home.lan>
References: <20060806154700.536.32978.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 2/3] uml: fix proc-vs-interrupt context spinlock
	deadlock
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This spinlock can be taken on interrupt too, so spin_lock_irq[save] must be used.

However, Documentation/networking/netdevices.txt explains we are called with
rtnl_lock() held - so we don't need to care about other concurrent opens.
Verified also in LDD3 and by direct checking. Also verified that the network
layer (through a state machine) guarantees us that nobody will close the
interface while it's being used. Please correct me if I'm wrong.

Also, we must check we don't sleep with irqs disabled!!! But anyway, this is not
news - we already can't sleep while holding a spinlock. Who says this is
guaranted really by the present code?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 6af229c..f5fba74 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -109,8 +109,6 @@ static int uml_net_open(struct net_devic
 	struct uml_net_private *lp = dev->priv;
 	int err;
 
-	spin_lock(&lp->lock);
-
 	if(lp->fd >= 0){
 		err = -ENXIO;
 		goto out;
@@ -144,8 +142,6 @@ static int uml_net_open(struct net_devic
 	 */
 	while((err = uml_net_rx(dev)) > 0) ;
 
-	spin_unlock(&lp->lock);
-
 	spin_lock(&opened_lock);
 	list_add(&lp->list, &opened);
 	spin_unlock(&opened_lock);
@@ -155,7 +151,6 @@ out_close:
 	if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
 out:
-	spin_unlock(&lp->lock);
 	return err;
 }
 
@@ -164,15 +159,12 @@ static int uml_net_close(struct net_devi
 	struct uml_net_private *lp = dev->priv;
 	
 	netif_stop_queue(dev);
-	spin_lock(&lp->lock);
 
 	free_irq(dev->irq, dev);
 	if(lp->close != NULL)
 		(*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
 
-	spin_unlock(&lp->lock);
-
 	spin_lock(&opened_lock);
 	list_del(&lp->list);
 	spin_unlock(&opened_lock);
@@ -241,9 +233,9 @@ static int uml_net_set_mac(struct net_de
 	struct uml_net_private *lp = dev->priv;
 	struct sockaddr *hwaddr = addr;
 
-	spin_lock(&lp->lock);
+	spin_lock_irq(&lp->lock);
 	memcpy(dev->dev_addr, hwaddr->sa_data, ETH_ALEN);
-	spin_unlock(&lp->lock);
+	spin_unlock_irq(&lp->lock);
 
 	return(0);
 }
@@ -253,7 +245,7 @@ static int uml_net_change_mtu(struct net
 	struct uml_net_private *lp = dev->priv;
 	int err = 0;
 
-	spin_lock(&lp->lock);
+	spin_lock_irq(&lp->lock);
 
 	new_mtu = (*lp->set_mtu)(new_mtu, &lp->user);
 	if(new_mtu < 0){
@@ -264,7 +256,7 @@ static int uml_net_change_mtu(struct net
 	dev->mtu = new_mtu;
 
  out:
-	spin_unlock(&lp->lock);
+	spin_unlock_irq(&lp->lock);
 	return err;
 }
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
