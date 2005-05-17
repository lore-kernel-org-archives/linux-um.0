Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXz5k-0000Rz-Ec	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 03:14:24 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DXz5j-0006pI-KP	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 03:14:24 -0700
Message-ID: <4289C3F9.9020105@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [patch 1/1] uml: replace pause with sigsuspend
References: <20050516180143.95BDB1993E0@zion.home.lan>
In-Reply-To: <20050516180143.95BDB1993E0@zion.home.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 17 May 2005 12:14:17 +0200
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

I didn't have the time to test the patch, but I guess, it won't work.

Maybe, the man pages for sigsuspend are somewhat missleading, saying:

        The sigsuspend call temporarily replaces the signal mask for
        the process with that given by mask and then suspends the
        process until a signal is received.

Reading the code of sys_sigsuspend() in arch/i386/kernel/signal.c,
you'll find that it will return to user only, if do_signal() returns 1.
This will happen, if there was a signal to deliver. Ignored signals
will not be delivered, so sys_sigsupend will not return on SIGWINCH,
if SIGWINCH handler is set to SIG_IGN.

So, for UML's winch_handler, there is no difference between pause()
and sigsuspend(), because sigsuspend's feature of accepting a sigmask
for use while waiting, in fact isn't needed here as the same mask is
set already before with sigprocmask().

	Bodo

blaisorblade@yahoo.it wrote:
> Replace pause with sigsuspend, to avoid needing to set an empty handler for SIGWINCH.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  linux-2.6.git-paolo/arch/um/drivers/chan_user.c |   15 ++++-----------
>  1 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff -puN arch/um/drivers/chan_user.c~uml-replace-pause-with-sigsuspend arch/um/drivers/chan_user.c
> --- linux-2.6.git/arch/um/drivers/chan_user.c~uml-replace-pause-with-sigsuspend	2005-05-16 08:07:30.000000000 +0200
> +++ linux-2.6.git-paolo/arch/um/drivers/chan_user.c	2005-05-16 08:08:10.000000000 +0200
> @@ -67,10 +67,6 @@ error:
>   * it (see below for how we make sure to exit only on SIGWINCH).
>   */
>  
> -static void winch_handler(int sig)
> -{
> -}
> -
>  struct winch_data {
>  	int pty_fd;
>  	int pipe_fd;
> @@ -93,14 +89,11 @@ static int winch_thread(void *arg)
>  		printk("winch_thread : failed to write synchronization "
>  		       "byte, err = %d\n", -count);
>  
> -	/* We are not using SIG_IGN on purpose, so don't fix it as I thought to
> -	 * do! If using SIG_IGN, the pause() call below would not stop on
> -	 * SIGWINCH. */
> -
> -	signal(SIGWINCH, winch_handler);
>  	sigfillset(&sigs);
>  	sigdelset(&sigs, SIGWINCH);
> -	/* Block anything else than SIGWINCH. */
> +	/* Block anything else than SIGWINCH. XXX: Actually, this may be removed
> +	 * maybe, due to sigsuspend below, which replaces the signal mask, but
> +	 * let's keep it.*/
>  	if(sigprocmask(SIG_SETMASK, &sigs, NULL) < 0){
>  		printk("winch_thread : sigprocmask failed, errno = %d\n", 
>  		       errno);
> @@ -130,7 +123,7 @@ static int winch_thread(void *arg)
>  	while(1){
>  		/* This will be interrupted by SIGWINCH only, since other signals
>  		 * are blocked.*/
> -		pause();
> +		sigsuspend(&sigs);
>  
>  		count = os_write_file(pipe_fd, &c, sizeof(c));
>  		if(count != sizeof(c))
> _
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
