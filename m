Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1Ao-0007KW-Kz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:38 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez1Ao-0005Bz-3z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:38 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118001931.14622.17211.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 4/9] uml: fix spinlock recursion and
	sleep-inside-spinlock in error path
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 18 Jan 2006 01:19:33 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In this error path, when the interface has had a problem, we call dev_close(),
which is disallowed for two reasons:

*) takes again the UML internal spinlock, inside the ->stop method of this
   device
*) can be called in process context only, while we're in interrupt context.

I've also thought that calling dev_close() may be a wrong policy to follow, but
it's not up to me to decide that.

However, we may end up with multiple dev_close() queued on the same device.
But the initial test for (dev->flags & IFF_UP) makes this harmless, though -
and dev_close() is supposed to care about races with itself. So there's no harm
in delaying the shutdown, IMHO.

Something to mark the interface as "going to shutdown" would be appreciated, but
dev_deactivate has the same problems as dev_close(), so we can't use it either.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 98350bb..178f68b 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -68,6 +68,11 @@ static int uml_net_rx(struct net_device 
 	return pkt_len;
 }
 
+static void uml_dev_close(void* dev)
+{
+	dev_close( (struct net_device *) dev);
+}
+
 irqreturn_t uml_net_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_id;
@@ -80,15 +85,21 @@ irqreturn_t uml_net_interrupt(int irq, v
 	spin_lock(&lp->lock);
 	while((err = uml_net_rx(dev)) > 0) ;
 	if(err < 0) {
+		DECLARE_WORK(close_work, uml_dev_close, dev);
 		printk(KERN_ERR 
 		       "Device '%s' read returned %d, shutting it down\n", 
 		       dev->name, err);
-		dev_close(dev);
+		/* dev_close can't be called in interrupt context, and takes
+		 * again lp->lock.
+		 * And dev_close() can be safely called multiple times on the
+		 * same device, since it tests for (dev->flags & IFF_UP). So
+		 * there's no harm in delaying the device shutdown. */
+		schedule_work(&close_work);
 		goto out;
 	}
 	reactivate_fd(lp->fd, UM_ETH_IRQ);
 
- out:
+out:
 	spin_unlock(&lp->lock);
 	return(IRQ_HANDLED);
 }



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
