Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miklos@szeredi.hu>) id 1LoMQC-00013T-H9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Mar 2009 18:41:20 +0000
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LoMQ8-00081o-Bx
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Mar 2009 18:41:20 +0000
Message-Id: <E1LoMQ2-0007bB-By@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 Mar 2009 20:41:10 +0200
Subject: [uml-devel] [patch 1/3] uml: fix compile error from net_device_ops
	conversion
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@suse.cz>

Fix the following compile error:

arch/um/drivers/net_kern.c: In function 'uml_inetaddr_event':
arch/um/drivers/net_kern.c:760: error: 'struct net_device' has no member named 'open'

This was introduced by commit 8bb95b39, "uml: convert network device
to netdevice ops".

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
---
 arch/um/drivers/net_kern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.orig/arch/um/drivers/net_kern.c	2009-03-30 17:07:10.000000000 +0200
+++ linux-2.6/arch/um/drivers/net_kern.c	2009-03-30 19:25:30.000000000 +0200
@@ -757,7 +757,7 @@ static int uml_inetaddr_event(struct not
 	void (*proc)(unsigned char *, unsigned char *, void *);
 	unsigned char addr_buf[4], netmask_buf[4];
 
-	if (dev->open != uml_net_open)
+	if (dev->netdev_ops->ndo_open != uml_net_open)
 		return NOTIFY_DONE;
 
 	lp = netdev_priv(dev);

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

