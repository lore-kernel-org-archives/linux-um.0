Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D84GK-00075M-SK for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2005 14:30:12 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D84GK-0005Xb-9f for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2005 14:30:12 -0800
From: domen@coderock.org
Message-Id: <20050306223003.CF1461EC90@trashy.coderock.org>
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
Date: Sun, 06 Mar 2005 23:30:03 +0100
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net



Unify the spinlock initialization as far as possible.

Do consider applying.

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/um/drivers/port_kern.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/drivers/port_kern.c~spin_lock_init-arch_um_drivers_port_kern arch/um/drivers/port_kern.c
--- kj/arch/um/drivers/port_kern.c~spin_lock_init-arch_um_drivers_port_kern	2005-03-05 16:11:13.000000000 +0100
+++ kj-domen/arch/um/drivers/port_kern.c	2005-03-05 16:11:13.000000000 +0100
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
