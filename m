Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMUo0-0003hx-2s for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 10:45:08 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMUny-0000Gt-Lc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 10:45:08 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060323184551.GA5398@ccure.user-mode-linux.org>
References: <200603111301.42195.rob@landley.net>
	<200603172036.59218.blaisorblade@yahoo.it>
	<20060321010025.GC7860@ccure.user-mode-linux.org>
	<200603210221.41654.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603210221.41654.blaisorblade@yahoo.it>
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
Date: Thu, 23 Mar 2006 13:45:51 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Werner Almesberger <wa@almesberger.net>, Rob Landley <rob@landley.net>

On Tue, Mar 21, 2006 at 02:21:40AM +0100, Blaisorblade wrote:
> However, while I overlooked this, you overlooked what I did:
> *) you must also move the setting of write_sigio_fds and sigio_private above,
> or we'll get the same problem again in different places of 
> write_sigio_thread.

Fixed.

> *) you must update the exit path. I've taken care so that only if everything 
> succeed the result is stored, and to hold the lock for the minimum time 
> needed (particularly not while doing any allocation). I'm not sure whether 
> the first property is needed, but it would be conservative to do so to 
> preserve coherence of data structures.
> 
> In particular: if we store an fd != -1, some function may later close it (say 
> when the console is closed); if we closed it in the exit path, then we're 
> closing an unrelated fd and getting a bug.
> 
> So, if the thread startup fails, you _must_ clear again current_poll, 
> write_sigio_fds and sigio_private.

OK, this is all done, I think.

What do you think about this?

Index: linux-2.6.15/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sigio.c	2006-03-23 12:55:27.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/sigio.c	2006-03-23 13:41:11.000000000 -0500
@@ -269,42 +269,41 @@ void write_sigio_workaround(void)
 	/* Did we race? Don't try to optimize this, please, it's not so likely
 	 * to happen, and no more than once at the boot. */
 	if(write_sigio_pid != -1)
-		goto out_unlock;
+		goto out_free;
 
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
-					    CLONE_FILES | CLONE_VM, &stack, 0);
-
-	if (write_sigio_pid < 0)
-		goto out_clear;
+	current_poll = ((struct pollfds) { .poll 	= p,
+					   .used 	= 1,
+					   .size 	= 1 });
 
 	if (write_sigio_irq(l_write_sigio_fds[0]))
-		goto out_kill;
+		goto out_free;
 
-	/* Success, finally. */
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
 
-	current_poll = ((struct pollfds) { .poll 	= p,
-					   .used 	= 1,
-					   .size 	= 1 });
+	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
+					    CLONE_FILES | CLONE_VM, &stack, 0);
 
-	sigio_unlock();
-	return;
+	if (write_sigio_pid < 0)
+		goto out_clear;
 
- out_kill:
-	l_write_sigio_pid = write_sigio_pid;
-	write_sigio_pid = -1;
 	sigio_unlock();
-	/* Going to call waitpid, avoid holding the lock. */
-	os_kill_process(l_write_sigio_pid, 1);
-	goto out_free;
+	return;
 
  out_clear:
 	write_sigio_pid = -1;
- out_unlock:
-	sigio_unlock();
+	current_poll = ((struct pollfds) { .poll	= NULL,
+					   .size	= 0,
+					   .used	= 0 });
+	write_sigio_fds[0] = -1;
+	write_sigio_fds[1] = -1;
+
+	sigio_private[0] = -1;
+	sigio_private[1] = -1;
+				
  out_free:
 	kfree(p);
+	sigio_unlock();
  out_close2:
 	close(l_sigio_private[0]);
 	close(l_sigio_private[1]);


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
