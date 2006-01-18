Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1As-0007Ke-JN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:42 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez1As-0000vB-3E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:42 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118001928.14622.13478.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 3/9] uml: networking - clear transport-specific
	structure
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
Date: Wed, 18 Jan 2006 01:19:29 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Pre-clear transport-specific private structure before passing it down.

In fact, I just got a slab corruption and kernel panic on exit because kfree()
was called on a pointer which probably was never allocated, BUT hadn't been set
to NULL by the driver.

As the code is full of such errors, I've decided for now to go the safe way
(we're talking about drivers), and to do the simple thing. I'm also starting to
fix drivers, and already sent a patch for the daemon transport.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 5b8c64e..98350bb 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -322,6 +322,11 @@ static int eth_configure(int n, void *in
 		return 1;
 	}
 
+	lp = dev->priv;
+	/* This points to the transport private data. It's still clear, but we
+	 * must memset it to 0 *now*. Let's help the drivers. */
+	memset(lp, 0, size);
+
 	/* sysfs register */
 	if (!driver_registered) {
 		platform_driver_register(&uml_net_driver);
@@ -364,7 +369,6 @@ static int eth_configure(int n, void *in
 		free_netdev(dev);
 		return 1;
 	}
-	lp = dev->priv;
 
 	/* lp.user is the first four bytes of the transport data, which
 	 * has already been initialized.  This structure assignment will



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
