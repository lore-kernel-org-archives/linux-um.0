Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWa7z-0005Jm-Sy for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 08:32:00 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWa7x-0001EG-4n
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 08:31:59 -0700
Date: Wed, 28 Mar 2007 11:28:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070328152848.GA6345@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/4] UML - Replace one-element array with
	zero-element array
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
To: Andrew Morton <akpm@osdl.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
  
To look at users I did:
$ find arch/um/ include/asm-um -name '*.[ch]'|xargs grep -r 'net_kern\.h'
+-l|xargs grep '\<user\>'

Most users just cast user to the appropriate pointer, the remaining ones are
fixed here. In net_kern.c, I'm almost sure that save trick is not needed
anymore, but I've not verified it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/net_kern.c |   14 +++-----------
 arch/um/include/net_kern.h |    2 +-
 2 files changed, 4 insertions(+), 12 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/net_kern.c	2007-03-21 13:43:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/net_kern.c	2007-03-21 13:43:48.000000000 -0400
@@ -347,10 +347,9 @@ static void eth_configure(int n, void *i
 	struct uml_net *device;
 	struct net_device *dev;
 	struct uml_net_private *lp;
-	int save, err, size;
+	int err, size;
 
-	size = transport->private_size + sizeof(struct uml_net_private) +
-		sizeof(((struct uml_net_private *) 0)->user);
+	size = transport->private_size + sizeof(struct uml_net_private);
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL) {
@@ -409,12 +408,6 @@ static void eth_configure(int n, void *i
 	 */
 	(*transport->kern->init)(dev, init);
 
-	/* lp.user is the first four bytes of the transport data, which
-	 * has already been initialized.  This structure assignment will
-	 * overwrite that, so we make sure that .user gets overwritten with
-	 * what it already has.
-	 */
-	save = lp->user[0];
 	*lp = ((struct uml_net_private)
 		{ .list  		= LIST_HEAD_INIT(lp->list),
 		  .dev 			= dev,
@@ -428,8 +421,7 @@ static void eth_configure(int n, void *i
 		  .write 		= transport->kern->write,
 		  .add_address 		= transport->user->add_address,
 		  .delete_address  	= transport->user->delete_address,
-		  .set_mtu 		= transport->user->set_mtu,
-		  .user  		= { save } });
+		  .set_mtu 		= transport->user->set_mtu });
 
 	init_timer(&lp->tl);
 	spin_lock_init(&lp->lock);
Index: linux-2.6.21-mm/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/net_kern.h	2007-03-20 15:41:35.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/net_kern.h	2007-03-21 13:43:48.000000000 -0400
@@ -40,7 +40,7 @@ struct uml_net_private {
 	void (*add_address)(unsigned char *, unsigned char *, void *);
 	void (*delete_address)(unsigned char *, unsigned char *, void *);
 	int (*set_mtu)(int mtu, void *);
-	int user[1];
+	char user[0];
 };
 
 struct net_kern_info {

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
