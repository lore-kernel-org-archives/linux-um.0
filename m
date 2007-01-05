Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2u6H-0001QD-QW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:33 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2u6H-0007RB-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:33 -0800
Message-Id: <200701051842.l05IgDCN004607@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 05 Jan 2007 13:42:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/9] UML - network driver locking and code cleanup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Add some missing locking to walks of the transports and opened lists.

Delete some dead code.

Comment the lack of some locking.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/net_kern.c |   42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2007-01-01 12:18:47.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2007-01-01 12:35:12.000000000 -0500
@@ -502,7 +502,7 @@ static DEFINE_SPINLOCK(transports_lock);
 static LIST_HEAD(transports);
 
 /* Filled in during early boot */
-struct list_head eth_cmd_line = LIST_HEAD_INIT(eth_cmd_line);
+static LIST_HEAD(eth_cmd_line);
 
 static int check_transport(struct transport *transport, char *eth, int n,
 			   void **init_out, char **mac_out)
@@ -563,7 +563,9 @@ static int eth_setup_common(char *str, i
 	struct transport *transport;
 	void *init;
 	char *mac = NULL;
+	int found = 0;
 
+	spin_lock(&transports_lock);
 	list_for_each(ele, &transports){
 		transport = list_entry(ele, struct transport, list);
 	        if(!check_transport(transport, str, index, &init, &mac))
@@ -572,9 +574,12 @@ static int eth_setup_common(char *str, i
 			eth_configure(index, init, mac, transport);
 			kfree(init);
 		}
-		return 1;
+		found = 1;
+		break;
 	}
-	return 0;
+
+	spin_unlock(&transports_lock);
+	return found;
 }
 
 static int eth_setup(char *str)
@@ -610,24 +615,6 @@ __uml_help(eth_setup,
 "    Configure a network device.\n\n"
 );
 
-#if 0
-static int eth_init(void)
-{
-	struct list_head *ele, *next;
-	struct eth_init *eth;
-
-	list_for_each_safe(ele, next, &eth_cmd_line){
-		eth = list_entry(ele, struct eth_init, list);
-
-		if(eth_setup_common(eth->init, eth->index))
-			list_del(&eth->list);
-	}
-
-	return(1);
-}
-__initcall(eth_init);
-#endif
-
 static int net_config(char *str, char **error_out)
 {
 	int n, err;
@@ -729,6 +716,7 @@ static int uml_inetaddr_event(struct not
 	return NOTIFY_DONE;
 }
 
+/* uml_net_init shouldn't be called twice on two CPUs at the same time */
 struct notifier_block uml_inetaddr_notifier = {
 	.notifier_call		= uml_inetaddr_event,
 };
@@ -747,18 +735,21 @@ static int uml_net_init(void)
 	 * didn't get a chance to run for them.  This fakes it so that
 	 * addresses which have already been set up get handled properly.
 	 */
+	spin_lock(&opened_lock);
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
 		ip = lp->dev->ip_ptr;
-		if(ip == NULL) continue;
+		if(ip == NULL)
+			continue;
 		in = ip->ifa_list;
 		while(in != NULL){
 			uml_inetaddr_event(NULL, NETDEV_UP, in);
 			in = in->ifa_next;
 		}
 	}
+	spin_unlock(&opened_lock);
 
-	return(0);
+	return 0;
 }
 
 __initcall(uml_net_init);
@@ -768,13 +759,16 @@ static void close_devices(void)
 	struct list_head *ele;
 	struct uml_net_private *lp;
 
+	spin_lock(&opened_lock);
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
 		free_irq(lp->dev->irq, lp->dev);
 		if((lp->close != NULL) && (lp->fd >= 0))
 			(*lp->close)(lp->fd, &lp->user);
-		if(lp->remove != NULL) (*lp->remove)(&lp->user);
+		if(lp->remove != NULL)
+			(*lp->remove)(&lp->user);
 	}
+	spin_unlock(&opened_lock);
 }
 
 __uml_exitcall(close_devices);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
