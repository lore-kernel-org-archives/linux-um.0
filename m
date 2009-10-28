Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Wed, 28 Oct 2009 07:37:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091028063721.GA4513@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [patch] uml: IRQ register race condition
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, user-mode-linux-user@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>

From: Andrew Lunn <andrew@lunn.ch>

There is a race condition in um_request_irq(). The SIGIO handling is
first enabled with the call to activate_fd(). The irq handler is then
registered with request_irq(). What can happen is that directly after
activate_fd() the SIGIO goes off and the IRQ source is disabled at the
low level, the pollfd is set to -1. Since no irq handler has yet been
registered, the interrupt it left disabled at the low level. The
interrupt handler is then registered, but its too late, the interrupt
source has been disabled at the lower level and is never re-enabled.
To fix this race condition i swapped the order. First request_irq()
then activate_fd() the interrupt sources.

There is a second bug. In 2.6.31 there was a change to the way
__do_IRQ() and friends work for chained interrupt sources. The old way
was that all chained interrupt handlers were called. The new way is
that the chain is walked only until a handler returns IRQ_HANDLED or
IRQ_WAKE_THREAD. uml_net_interrupt() would always return IRQ_HANDLED,
irrespective of if the device really did receive an interrupt or
not. This mean with the new code only the first device on a chained
interrupt ever got its interrupts handled. The second/third/... device
never got any interrupts processed. I changed uml_net_interrupt() to
always return IRQ_NONE so that all handlers get called on a chained
interrupt.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 9483c19..2b0748e 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -145,7 +145,7 @@ static irqreturn_t uml_net_interrupt(int irq, void *dev_id)
 
 out:
 	spin_unlock(&lp->lock);
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int uml_net_open(struct net_device *dev)
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 454cdb4..3a31d57 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -345,13 +345,12 @@ int um_request_irq(unsigned int irq, int fd, int type,
 {
 	int err;
 
-	if (fd != -1) {
+	err = request_irq(irq, handler, irqflags, devname, dev_id);
+
+	if (!err && (fd != -1))
 		err = activate_fd(irq, fd, type, dev_id);
-		if (err)
-			return err;
-	}
 
-	return request_irq(irq, handler, irqflags, devname, dev_id);
+	return err;
 }
 
 EXPORT_SYMBOL(um_request_irq);

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

