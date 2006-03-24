Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMc0G-0000F5-5m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 18:26:16 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMc0F-00024M-By
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 18:26:16 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060324022645.GC8104@ccure.user-mode-linux.org>
References: <200603111301.42195.rob@landley.net>
	<200603210221.41654.blaisorblade@yahoo.it>
	<20060323184551.GA5398@ccure.user-mode-linux.org>
	<200603240137.56798.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <200603240137.56798.blaisorblade@yahoo.it>
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
Date: Thu, 23 Mar 2006 21:26:45 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Werner Almesberger <wa@almesberger.net>, Rob Landley <rob@landley.net>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2006 at 01:37:54AM +0100, Blaisorblade wrote:
> Yep, it seems it looks good. But 1 bug still and two suggestions.
> See also attached patch (it misses one of the suggestions because it's late 
> and I'm going to sleep).

I merged that patch.

> If possible (there should be such array constructors) this shouldn't be 
> redundant / duplicated with the initial declarations.
> 
> Like write_sigio_fds = (int[]) {-1,-1} and having a common macro like 
> 
> #define SIGIO_FDS_INIT {-1,-1}
> 
> static int write_sigio_fds[2] = SIGIO_FDS_INIT;
> ...
> write_sigio_fds = (int[]) SIGIO_FDS_INIT

I tried this - I couldn't get anything like that to compile.  I always
got an "incompatible types in assignment" error.

Below is the latest version.

				Jeff

--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sigio-race

# This fixes a race in the starting of write_sigio_thread.
# Previously, some of the data needed by the thread was initialized
# after the clone.  If the thread ean immediately, it would see the
# uninitialized data, including an empty pollfds, which would cause it
# to hang.
# We move the data initialization to before the clone, and adjust the
# error paths and cleanup accordingly.
#
# Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/sigio.c	2006-03-23 17:30:27.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/sigio.c	2006-03-23 17:44:11.000000000 -0500
@@ -270,42 +270,40 @@ void write_sigio_workaround(void)
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
  out_free:
 	kfree(p);
+	sigio_unlock();
  out_close2:
 	close(l_sigio_private[0]);
 	close(l_sigio_private[1]);

--s/l3CgOIzMHHjg/5--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
