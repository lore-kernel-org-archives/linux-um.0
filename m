Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G9kq8-0002pZ-U6 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 08:46:57 -0700
Received: from host17-96.pool873.interbusiness.it ([87.3.96.17]
	helo=memento.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1G9kq8-0007BQ-2t for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 08:46:56 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 06 Aug 2006 17:47:05 +0200
Message-Id: <20060806154705.536.49855.stgit@memento.home.lan>
In-Reply-To: <20060806154700.536.32978.stgit@memento.home.lan>
References: <20060806154700.536.32978.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 3/3] uml: clean our set_ether_mac
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

Clean set_ether_mac usage. Maybe could also be removed, but surely it can't be a
global function taking a void* argument.

You may want to defer this patch to next kernel release.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |   14 ++++++--------
 arch/um/include/net_user.h |    1 -
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index f5fba74..e26601a 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -31,6 +31,11 @@ #include "init.h"
 #include "irq_user.h"
 #include "irq_kern.h"
 
+static inline void set_ether_mac(struct net_device *dev, unsigned char *addr)
+{
+	memcpy(dev->dev_addr, addr, ETH_ALEN);
+}
+
 #define DRIVER_NAME "uml-netdev"
 
 static DEFINE_SPINLOCK(opened_lock);
@@ -234,7 +239,7 @@ static int uml_net_set_mac(struct net_de
 	struct sockaddr *hwaddr = addr;
 
 	spin_lock_irq(&lp->lock);
-	memcpy(dev->dev_addr, hwaddr->sa_data, ETH_ALEN);
+	set_ether_mac(dev, hwaddr->sa_data);
 	spin_unlock_irq(&lp->lock);
 
 	return(0);
@@ -788,13 +793,6 @@ void dev_ip_addr(void *d, unsigned char 
 	memcpy(bin_buf, &in->ifa_address, sizeof(in->ifa_address));
 }
 
-void set_ether_mac(void *d, unsigned char *addr)
-{
-	struct net_device *dev = d;
-
-	memcpy(dev->dev_addr, addr, ETH_ALEN);	
-}
-
 struct sk_buff *ether_adjust_skb(struct sk_buff *skb, int extra)
 {
 	if((skb != NULL) && (skb_tailroom(skb) < extra)){
diff --git a/arch/um/include/net_user.h b/arch/um/include/net_user.h
index 800c403..47ef7cb 100644
--- a/arch/um/include/net_user.h
+++ b/arch/um/include/net_user.h
@@ -26,7 +26,6 @@ struct net_user_info {
 
 extern void ether_user_init(void *data, void *dev);
 extern void dev_ip_addr(void *d, unsigned char *bin_buf);
-extern void set_ether_mac(void *d, unsigned char *addr);
 extern void iter_addresses(void *d, void (*cb)(unsigned char *, 
 					       unsigned char *, void *), 
 			   void *arg);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
