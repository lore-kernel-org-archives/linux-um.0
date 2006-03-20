Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FLHVP-0003ck-9L for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Mar 2006 02:20:55 -0800
Received: from host.almesberger.net ([204.10.140.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FLHVM-0005K8-Vu
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Mar 2006 02:20:55 -0800
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060320072039.A18029@almesberger.net>
References: <200603111301.42195.rob@landley.net>
	<20060314202249.GB22286@ccure.user-mode-linux.org>
	<20060316112251.A17140@almesberger.net>
	<200603172036.59218.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603172036.59218.blaisorblade@yahoo.it>;
	from blaisorblade@yahoo.it on Fri, Mar 17, 2006 at 08:36:58PM
	+0100
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
Date: Mon, 20 Mar 2006 07:20:40 -0300
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>

Blaisorblade wrote:
> 2) write_sigio_thread should do a "down" on a semaphore/mutex and the first 
> update_thread should "up" it. As usually, this semaphore would be indeed 
> implemented as a pipe.

Be the way, in case a proper fix is too involved for 2.6.16.x,
here's a quick and dirty work-around that should have no ill
side-effects:

This hack works around a race condition that can make UML hang
on startup. If the race condition is encountered, this change
limits the time of the hang to one second. Besides that, it can
cause a small performance penalty by waking up an otherwise
idle "poll" every second.

This is intended purely as a readily applicable band aid and 
should not be considered a long-term fix.

- Werner

---------------------------------- cut here -----------------------------------

Signed-off-by: Werner Almesberger <werner@almesberger.net>

--- linux-2.6.16.orig/arch/um/kernel/sigio_user.c	2006-03-20 02:53:29.%N -0300
+++ linux-2.6.16/arch/um/kernel/sigio_user.c	2006-03-20 06:27:11.%N -0300
@@ -184,7 +184,7 @@
         signal(SIGWINCH, SIG_IGN);
 	fds = &current_poll;
 	while(1){
-		n = poll(fds->poll, fds->used, -1);
+		n = poll(fds->poll, fds->used, 1000);
 		if(n < 0){
 			if(errno == EINTR) continue;
 			printk("write_sigio_thread : poll returned %d, "

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
