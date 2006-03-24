Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMaJl-0002iT-CJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 16:38:17 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMaJj-00059A-Rq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 16:38:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Occasional hang starting up.
References: <200603111301.42195.rob@landley.net>
	<200603210221.41654.blaisorblade@yahoo.it>
	<20060323184551.GA5398@ccure.user-mode-linux.org>
In-Reply-To: <20060323184551.GA5398@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k9zIEZDEh8ExdMj"
Message-Id: <200603240137.56798.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 01:37:54 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Werner Almesberger <wa@almesberger.net>, Rob Landley <rob@landley.net>

--Boundary-00=_k9zIEZDEh8ExdMj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 23 March 2006 19:45, Jeff Dike wrote:
> On Tue, Mar 21, 2006 at 02:21:40AM +0100, Blaisorblade wrote:
> > However, while I overlooked this, you overlooked what I did:
> > *) you must also move the setting of write_sigio_fds and sigio_private
> > above, or we'll get the same problem again in different places of
> > write_sigio_thread.

> OK, this is all done, I think.

> What do you think about this?

Yep, it seems it looks good. But 1 bug still and two suggestions.
See also attached patch (it misses one of the suggestions because it's late 
and I'm going to sleep).

> Index: linux-2.6.15/arch/um/os-Linux/sigio.c
> ===================================================================
> --- linux-2.6.15.orig/arch/um/os-Linux/sigio.c	2006-03-23
> 12:55:27.000000000 -0500 +++
> linux-2.6.15/arch/um/os-Linux/sigio.c	2006-03-23 13:41:11.000000000 -0500
> @@ -269,42 +269,41 @@ void write_sigio_workaround(void)
>  	/* Did we race? Don't try to optimize this, please, it's not so likely
>  	 * to happen, and no more than once at the boot. */
>  	if(write_sigio_pid != -1)
> -		goto out_unlock;
> +		goto out_free;
>
> -	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
> -					    CLONE_FILES | CLONE_VM, &stack, 0);
> -
> -	if (write_sigio_pid < 0)
> -		goto out_clear;
> +	current_poll = ((struct pollfds) { .poll 	= p,
> +					   .used 	= 1,
> +					   .size 	= 1 });
>
>  	if (write_sigio_irq(l_write_sigio_fds[0]))
> -		goto out_kill;
> +		goto out_free;

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Here you're not clearing current_poll!
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

> -	/* Success, finally. */
>  	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
>  	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
>
> -	current_poll = ((struct pollfds) { .poll 	= p,
> -					   .used 	= 1,
> -					   .size 	= 1 });
> +	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
> +					    CLONE_FILES | CLONE_VM, &stack, 0);
>
> -	sigio_unlock();
> -	return;
> +	if (write_sigio_pid < 0)
> +		goto out_clear;
>
> - out_kill:
> -	l_write_sigio_pid = write_sigio_pid;
> -	write_sigio_pid = -1;
>  	sigio_unlock();
> -	/* Going to call waitpid, avoid holding the lock. */
> -	os_kill_process(l_write_sigio_pid, 1);
> -	goto out_free;
> +	return;
>
>   out_clear:
>  	write_sigio_pid = -1;
> - out_unlock:
> -	sigio_unlock();
> +	current_poll = ((struct pollfds) { .poll	= NULL,
> +					   .size	= 0,
> +					   .used	= 0 });
> +	write_sigio_fds[0] = -1;
> +	write_sigio_fds[1] = -1;
> +
> +	sigio_private[0] = -1;
> +	sigio_private[1] = -1;
> +

If possible (there should be such array constructors) this shouldn't be 
redundant / duplicated with the initial declarations.

Like write_sigio_fds = (int[]) {-1,-1} and having a common macro like 

#define SIGIO_FDS_INIT {-1,-1}

static int write_sigio_fds[2] = SIGIO_FDS_INIT;
...
write_sigio_fds = (int[]) SIGIO_FDS_INIT

(we _will_ get one copy wrong, if we can :-)).

If sending to 2.6.16 this can be kept separate or they could maybe complain 
"ah, no extra changes, just the fix!".
Btw, this one is not attached.
>   out_free:
>  	kfree(p);
> +	sigio_unlock();

p is a local variable, so sigio_unlock can be done before kfree(p).

>   out_close2:
>  	close(l_sigio_private[0]);
>  	close(l_sigio_private[1]);

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_k9zIEZDEh8ExdMj
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-fix-sigio-startup-race-hang-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-sigio-startup-race-hang-fix.patch"

Index: linux-2.6.git/arch/um/kernel/sigio_user.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/sigio_user.c
+++ linux-2.6.git/arch/um/kernel/sigio_user.c
@@ -398,7 +398,7 @@ void write_sigio_workaround(void)
 					   .size 	= 1 });
 
 	if (write_sigio_irq(l_write_sigio_fds[0]))
-		goto out_free;
+		goto out_clear_poll;
 
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
@@ -414,18 +414,20 @@ void write_sigio_workaround(void)
 
  out_clear:
 	write_sigio_pid = -1;
-	current_poll = ((struct pollfds) { .poll	= NULL,
-					   .size	= 0,
-					   .used	= 0 });
+
 	write_sigio_fds[0] = -1;
 	write_sigio_fds[1] = -1;
 
 	sigio_private[0] = -1;
 	sigio_private[1] = -1;
 
+ out_clear_poll:
+	current_poll = ((struct pollfds) { .poll	= NULL,
+					   .size	= 0,
+					   .used	= 0 });
  out_free:
-	kfree(p);
 	sigio_unlock();
+	kfree(p);
  out_close2:
 	os_close_file(l_sigio_private[0]);
 	os_close_file(l_sigio_private[1]);

--Boundary-00=_k9zIEZDEh8ExdMj--

	

	
		
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
