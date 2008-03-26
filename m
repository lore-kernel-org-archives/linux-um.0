Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JeOT9-0008Sl-1x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Mar 2008 22:46:39 -0700
Received: from viefep18-int.chello.at ([213.46.255.22]
	helo=viefep14-int.chello.at)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JeOT7-0008NN-F0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Mar 2008 22:46:39 -0700
Message-ID: <47E9E331.1010105@trash.net>
Date: Wed, 26 Mar 2008 06:46:25 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010603000107020409050200"
Subject: [uml-devel] [UML]: uml-net: don't set IFF_ALLMULTI in
	set_multicast_list
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: Linux Netdev List <netdev@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010603000107020409050200
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit


--------------010603000107020409050200
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

commit 00237037726efc587d55d65d6fd5357106ae7071
Author: Patrick McHardy <kaber@trash.net>
Date:   Wed Mar 26 06:41:22 2008 +0100

    [UML]: uml-net: don't set IFF_ALLMULTI in set_multicast_list
    
    IFF_ALLMULTI is an indication from the network stack to the driver
    to disable multicast filters, drivers should never set it directly.
    
    Since the UML networking device doesn't have any filtering capabilites,
    it doesn't the set_multicast_list function at all, it is kept so userspace
    can still issue SIOCADDMULTI/SIOCDELMULTI ioctls however.
    
    Signed-off-by: Patrick McHardy <kaber@trash.net>

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 1e8f41a..1d43bdf 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -256,11 +256,7 @@ static struct net_device_stats *uml_net_get_stats(struct net_device *dev)
 
 static void uml_net_set_multicast_list(struct net_device *dev)
 {
-	if (dev->flags & IFF_PROMISC)
-		return;
-	else if (dev->mc_count)
-		dev->flags |= IFF_ALLMULTI;
-	else dev->flags &= ~IFF_ALLMULTI;
+	return;
 }
 
 static void uml_net_tx_timeout(struct net_device *dev)

--------------010603000107020409050200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--------------010603000107020409050200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------010603000107020409050200--

