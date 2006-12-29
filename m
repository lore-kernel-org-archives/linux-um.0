Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H0RQy-0002xS-ML for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H0RQy-0007gu-3K
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Message-Id: <200612292341.kBTNfVIp005549@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 29 Dec 2006 18:41:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/6] UML - Add locking to network transport
	registration
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

The registration of host network transports needed some locking.  The
transport list itself is locked, but calls to the registration
routines are not.  This is compensated for by checking that a
transport structure is not yet on any list.

I also took the opportunity to const all fields in the transport
structure except the list, which obviously can be modified.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/net_kern.c |    9 +++++----
 arch/um/include/net_kern.h |    8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-12-29 12:58:59.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-12-29 12:59:19.000000000 -0500
@@ -498,10 +498,8 @@ struct eth_init {
 	int index;
 };
 
-/* Filled in at boot time.  Will need locking if the transports become
- * modular.
- */
-struct list_head transports = LIST_HEAD_INIT(transports);
+static DEFINE_SPINLOCK(transports_lock);
+static LIST_HEAD(transports);
 
 /* Filled in during early boot */
 struct list_head eth_cmd_line = LIST_HEAD_INIT(eth_cmd_line);
@@ -540,7 +538,10 @@ void register_transport(struct transport
 	char *mac = NULL;
 	int match;
 
+	spin_lock(&transports_lock);
+	BUG_ON(!list_empty(&new->list));
 	list_add(&new->list, &transports);
+	spin_unlock(&transports_lock);
 
 	list_for_each_safe(ele, next, &eth_cmd_line){
 		eth = list_entry(ele, struct eth_init, list);
Index: linux-2.6.18-mm/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_kern.h	2006-12-29 12:23:02.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/net_kern.h	2006-12-29 12:59:19.000000000 -0500
@@ -52,12 +52,12 @@ struct net_kern_info {
 
 struct transport {
 	struct list_head list;
-	char *name;
-	int (*setup)(char *, char **, void *);
+	const char *name;
+	int (* const setup)(char *, char **, void *);
 	const struct net_user_info *user;
 	const struct net_kern_info *kern;
-	int private_size;
-	int setup_size;
+	const int private_size;
+	const int setup_size;
 };
 
 extern struct net_device *ether_init(int);


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
