Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTXV4-0007QM-0Y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Nov 2004 19:25:54 -0800
Received: from pimout3-ext.prodigy.net ([207.115.63.102])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CTXV2-0004NF-SB for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Nov 2004 19:25:53 -0800
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041115032541.GA13077@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: fail xterm_open when we have no $DISPLAY
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
Date: Sun, 14 Nov 2004 19:25:41 -0800
To: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

If UML wants to open an xterm channel and the xterm does not run
properly (eg. terminates soon after starting) we will get a hang.
This avoids the most common cause for this and adds a comment (which
long term will go away with a rewrite of that code I guess?)

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

 arch/um/drivers/xterm.c      |    7 +++++++
 arch/um/drivers/xterm_kern.c |    3 +++
 2 files changed, 10 insertions(+)

Index: cw-current/arch/um/drivers/xterm.c
===================================================================
--- cw-current.orig/arch/um/drivers/xterm.c	2004-11-14 17:52:05.955194653 -0800
+++ cw-current/arch/um/drivers/xterm.c	2004-11-14 17:52:23.048945524 -0800
@@ -94,6 +94,13 @@
 			 "/usr/lib/uml/port-helper", "-uml-socket",
 			 file, NULL };
 
+	/* Check that DISPLAY is set, this doesn't guarantee the xterm
+	 * will work but w/o it we can be pretty sure it won't. */
+	if (!getenv("DISPLAY")) {
+		printk("xterm_open: $DISPLAY not set.\n");
+		return -ENODEV;
+	}
+
 	if(os_access(argv[4], OS_ACC_X_OK) < 0)
 		argv[4] = "port-helper";
 
Index: cw-current/arch/um/drivers/xterm_kern.c
===================================================================
--- cw-current.orig/arch/um/drivers/xterm_kern.c	2004-11-14 17:52:51.484194558 -0800
+++ cw-current/arch/um/drivers/xterm_kern.c	2004-11-14 17:53:09.197972625 -0800
@@ -61,6 +61,9 @@
 		ret = err;
 		goto out;
 	}
+
+	/* XXX Note, if the xterm doesn't work for some reason
+	 * (eg. DISPLAY isn't set this will hang... */
 	down(&data->sem);
 
 	free_irq_by_irq_and_dev(XTERM_IRQ, data);


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
