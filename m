Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon,  9 Apr 2012 16:22:46 +0200
Message-Id: <1333981366-27145-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Fix spin_lock usage in uml_net_interrupt()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use spin_lock_save/restore() in uml_net_interrupt() to
avoid recursive locking.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/net_kern.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 95f4416..5e7cf82 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -116,12 +116,13 @@ static irqreturn_t uml_net_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct uml_net_private *lp = netdev_priv(dev);
+	unsigned long flags;
 	int err;
 
 	if (!netif_running(dev))
 		return IRQ_NONE;
 
-	spin_lock(&lp->lock);
+	spin_lock_irqsave(&lp->lock, flags);
 	while ((err = uml_net_rx(dev)) > 0) ;
 	if (err < 0) {
 		printk(KERN_ERR
@@ -140,7 +141,7 @@ static irqreturn_t uml_net_interrupt(int irq, void *dev_id)
 	reactivate_fd(lp->fd, UM_ETH_IRQ);
 
 out:
-	spin_unlock(&lp->lock);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.7.3

