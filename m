Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D94FA-0003hO-0z for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 08:41:08 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D94F5-0002w8-8C for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 08:41:07 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050309094234.8FC0C6477@zion>
Subject: [uml-devel] [patch 1/1] unified spinlock initialization
	arch/um/drivers/port_kern.c
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
Date: Wed, 09 Mar 2005 10:42:33 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net


From: <domen@coderock.org>
Cc: <user-mode-linux-devel@lists.sourceforge.net>, <domen@coderock.org>, <amitg@calsoftinc.com>, <gud@eth.net>

Unify the spinlock initialization as far as possible.

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/port_kern.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/drivers/port_kern.c~uml-switch-spinlock-init arch/um/drivers/port_kern.c
--- linux-2.6.11/arch/um/drivers/port_kern.c~uml-switch-spinlock-init	2005-03-09 10:35:28.786848080 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/port_kern.c	2005-03-09 10:35:28.789847624 +0100
@@ -185,11 +185,11 @@ void *port_data(int port_num)
 		  .has_connection 	= 0,
 		  .sem 			= __SEMAPHORE_INITIALIZER(port->sem, 
 								  0),
-		  .lock 		= SPIN_LOCK_UNLOCKED,
 		  .port 	 	= port_num,
 		  .fd  			= fd,
 		  .pending 		= LIST_HEAD_INIT(port->pending),
 		  .connections 		= LIST_HEAD_INIT(port->connections) });
+	spin_lock_init(&port->lock);
 	list_add(&port->list, &ports);
 
  found:
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
