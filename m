Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOJIS-0003fL-TK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 09:43:00 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BOJIS-0004NO-8a
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 09:43:00 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040513162440.GA28107@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] uml network problem fix.
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
Date: Thu, 13 May 2004 18:24:40 +0200
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

I think I've found a bug in either the uml network driver or the uml
sigio/irq handling.  Not sure where exactly the bug is.  Here is the
problem:

  * the uml machine is setup with networking via switch daemon.
  * uml machine is booted, the network driver connects to the switch
    daemon and initializes the unix/dgram socket.
  * the switch daemon forwards packages to the uml machine (broadcasts,
    when running in "-hub" mode also other stuff), whereas the uml
    machine ignores these due to the interface still being down.
  * the unix socket fifo fills up, the switch daemon starts dropping
    packets due to that.
  * the uml machine tries to setup the network interface via "dhcpcd
    eth0", but failes because it doesn't receive any packets.

Further investigations shows that the uml network driver irq handler
isn't called for some reason.  Maybe because the socket fifo already
is full and only _new_ data arriving is signaled via SIGIO?

I've cured the issue with the one-liner patch below, which simply
receives any pending packets after up'ing the interface.  I'm not
sure if it is the right way to fix that through.

Comments?

  Gerd

--- a/arch/um/drivers/net_kern.c~	2004-05-13 17:21:28.604869781 +0200
+++ b/arch/um/drivers/net_kern.c	2004-05-13 17:39:12.386221066 +0200
@@ -131,6 +131,7 @@
 	list_add(&lp->list, &opened);
 	spin_unlock(&opened_lock);
 	MOD_INC_USE_COUNT;
+	while((err = uml_net_rx(dev)) > 0) ; /* clear buffer */
  out:
 	spin_unlock(&lp->lock);
 	return(err);


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
