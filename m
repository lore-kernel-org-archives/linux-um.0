Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp6wF-0005aR-Ha for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:07 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cp6wC-0007lC-Fk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:07 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113050909.1712063255@zion>
Subject: [uml-devel] [patch 07/15] uml: fail xterm_open when we have no
	$DISPLAY
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
Date: Thu, 13 Jan 2005 06:09:08 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, cw@f00f.org


From: Chris Wedgwood <cw@f00f.org>

If UML wants to open an xterm channel and the xterm does not run properly (eg.
terminates soon after starting) we will get a hang (a comment added in the
patch explains why).

This avoids the most common cause for this and adds a comment (which long term
will go away with a rewrite of that code); the complete fix would be to catch
the xterm process dying, up(&data->sem), and -EIO all requests from that point
onwards.

That applies for some of the other channels too, so part of the code should
probably be abstracted a little and generalized.

Signed-off-by: Chris Wedgwood <cw@f00f.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/xterm.c      |    7 +++++++
 linux-2.6.11-paolo/arch/um/drivers/xterm_kern.c |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/xterm_kern.c~uml-xterm-clarify arch/um/drivers/xterm_kern.c
--- linux-2.6.11/arch/um/drivers/xterm_kern.c~uml-xterm-clarify	2005-01-13 02:02:52.984641072 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/xterm_kern.c	2005-01-13 02:02:52.988640464 +0100
@@ -46,6 +46,8 @@ int xterm_fd(int socket, int *pid_out)
 		printk(KERN_ERR "xterm_fd : failed to allocate xterm_wait\n");
 		return(-ENOMEM);
 	}
+
+	/* This is a locked semaphore... */
 	*data = ((struct xterm_wait) 
 		{ .sem  	= __SEMAPHORE_INITIALIZER(data->sem, 0),
 		  .fd 		= socket,
@@ -55,12 +57,17 @@ int xterm_fd(int socket, int *pid_out)
 	err = um_request_irq(XTERM_IRQ, socket, IRQ_READ, xterm_interrupt, 
 			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
 			     "xterm", data);
-	if(err){
+	if (err){
 		printk(KERN_ERR "xterm_fd : failed to get IRQ for xterm, "
 		       "err = %d\n",  err);
 		ret = err;
 		goto out;
 	}
+
+	/* ... so here we wait for an xterm interrupt.
+	 *
+	 * XXX Note, if the xterm doesn't work for some reason (eg. DISPLAY
+	 * isn't set) this will hang... */
 	down(&data->sem);
 
 	free_irq_by_irq_and_dev(XTERM_IRQ, data);
diff -puN arch/um/drivers/xterm.c~uml-xterm-clarify arch/um/drivers/xterm.c
--- linux-2.6.11/arch/um/drivers/xterm.c~uml-xterm-clarify	2005-01-13 02:02:52.985640920 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/xterm.c	2005-01-13 02:02:52.988640464 +0100
@@ -97,6 +97,13 @@ int xterm_open(int input, int output, in
 	if(os_access(argv[4], OS_ACC_X_OK) < 0)
 		argv[4] = "port-helper";
 
+	/* Check that DISPLAY is set, this doesn't guarantee the xterm
+	 * will work but w/o it we can be pretty sure it won't. */
+	if (!getenv("DISPLAY")) {
+		printk("xterm_open: $DISPLAY not set.\n");
+		return -ENODEV;
+	}
+
 	fd = mkstemp(file);
 	if(fd < 0){
 		printk("xterm_open : mkstemp failed, errno = %d\n", errno);
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
