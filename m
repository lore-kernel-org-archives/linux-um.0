Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FLVEt-00062P-IX for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Mar 2006 17:00:47 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FLVEt-00015K-8q
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Mar 2006 17:00:47 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060321010025.GC7860@ccure.user-mode-linux.org>
References: <200603111301.42195.rob@landley.net>
	<20060314202249.GB22286@ccure.user-mode-linux.org>
	<20060316112251.A17140@almesberger.net>
	<200603172036.59218.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603172036.59218.blaisorblade@yahoo.it>
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
Date: Mon, 20 Mar 2006 20:00:25 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Werner Almesberger <wa@almesberger.net>, Rob Landley <rob@landley.net>

On Fri, Mar 17, 2006 at 08:36:58PM +0100, Blaisorblade wrote:
> 2) write_sigio_thread should do a "down" on a semaphore/mutex and the first 
> update_thread should "up" it. As usually, this semaphore would be indeed 
> implemented as a pipe.

Is there anything wrong with this:

Index: linux-2.6.15/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sigio.c	2006-03-20 19:48:51.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/sigio.c	2006-03-20 19:49:55.000000000 -0500
@@ -271,6 +271,10 @@ void write_sigio_workaround(void)
 	if(write_sigio_pid != -1)
 		goto out_unlock;
 
+	current_poll = ((struct pollfds) { .poll 	= p,
+					   .used 	= 1,
+					   .size 	= 1 });
+
 	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
 					    CLONE_FILES | CLONE_VM, &stack, 0);
 
@@ -284,10 +288,6 @@ void write_sigio_workaround(void)
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
 
-	current_poll = ((struct pollfds) { .poll 	= p,
-					   .used 	= 1,
-					   .size 	= 1 });
-
 	sigio_unlock();
 	return;
 
That seems to me to fix the basic problem - the thread is using data
that hasn't been set up yet, and I don't see that moving it up breaks
anything.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
