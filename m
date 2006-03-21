Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FLVZN-000096-5q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Mar 2006 17:21:57 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FLVZL-0008Q5-1V
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Mar 2006 17:21:57 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Occasional hang starting up.
References: <200603111301.42195.rob@landley.net>
	<200603172036.59218.blaisorblade@yahoo.it>
	<20060321010025.GC7860@ccure.user-mode-linux.org>
In-Reply-To: <20060321010025.GC7860@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603210221.41654.blaisorblade@yahoo.it>
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
Date: Tue, 21 Mar 2006 02:21:40 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Werner Almesberger <wa@almesberger.net>, Rob Landley <rob@landley.net>

On Tuesday 21 March 2006 02:00, Jeff Dike wrote:
> On Fri, Mar 17, 2006 at 08:36:58PM +0100, Blaisorblade wrote:
> > 2) write_sigio_thread should do a "down" on a semaphore/mutex and the
> > first update_thread should "up" it. As usually, this semaphore would be
> > indeed implemented as a pipe.

> Is there anything wrong with this:

> Index: linux-2.6.15/arch/um/os-Linux/sigio.c
> ===================================================================
> --- linux-2.6.15.orig/arch/um/os-Linux/sigio.c	2006-03-20
> 19:48:51.000000000 -0500 +++
> linux-2.6.15/arch/um/os-Linux/sigio.c	2006-03-20 19:49:55.000000000 -0500
> @@ -271,6 +271,10 @@ void write_sigio_workaround(void)
>  	if(write_sigio_pid != -1)
>  		goto out_unlock;
>
> +	current_poll = ((struct pollfds) { .poll 	= p,
> +					   .used 	= 1,
> +					   .size 	= 1 });
> +
>  	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
>  					    CLONE_FILES | CLONE_VM, &stack, 0);
>
> @@ -284,10 +288,6 @@ void write_sigio_workaround(void)
>  	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
>  	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
>
> -	current_poll = ((struct pollfds) { .poll 	= p,
> -					   .used 	= 1,
> -					   .size 	= 1 });
> -
>  	sigio_unlock();
>  	return;
>
> That seems to me to fix the basic problem - the thread is using data
> that hasn't been set up yet, and I don't see that moving it up breaks
> anything.

> 				Jeff

Ok, this is conceptually correct, and looking at 2.6.14 code this bug wasn't 
there, so _I_ introduced it, while cleaning it up. Sorry. Beyond, my idea of 
adding the semaphore was incorrect (it would work only if 
write_sigio_workaround did the up()).

However, while I overlooked this, you overlooked what I did:
*) you must also move the setting of write_sigio_fds and sigio_private above, 
or we'll get the same problem again in different places of 
write_sigio_thread.

*) you must update the exit path. I've taken care so that only if everything 
succeed the result is stored, and to hold the lock for the minimum time 
needed (particularly not while doing any allocation). I'm not sure whether 
the first property is needed, but it would be conservative to do so to 
preserve coherence of data structures.

In particular: if we store an fd != -1, some function may later close it (say 
when the console is closed); if we closed it in the exit path, then we're 
closing an unrelated fd and getting a bug.

So, if the thread startup fails, you _must_ clear again current_poll, 
write_sigio_fds and sigio_private.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
