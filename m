Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYU4u-0002kE-UJ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 12:19:36 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYU4u-0007BO-8B	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 12:19:36 -0700
Message-ID: <428B9544.60902@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [patch 1/1] uml: replace pause with sigsuspend
References: <20050516180143.95BDB1993E0@zion.home.lan>
	<4289C3F9.9020105@fujitsu-siemens.com>
	<200505181718.18455.blaisorblade@yahoo.it>
In-Reply-To: <200505181718.18455.blaisorblade@yahoo.it>
Content-Type: multipart/mixed;
 boundary="------------050407040501000203040404"
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
Date: Wed, 18 May 2005 21:19:32 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

This is a multi-part message in MIME format.
--------------050407040501000203040404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Blaisorblade wrote:
> On Tuesday 17 May 2005 12:14, Bodo Stroesser wrote:
> 
>>I didn't have the time to test the patch, but I guess, it won't work.
>>
>>Maybe, the man pages for sigsuspend are somewhat missleading, saying:
>>
>>        The sigsuspend call temporarily replaces the signal mask for
>>        the process with that given by mask and then suspends the
>>        process until a signal is received.
> 
> In fact, I assumed that was correct...
> 
>>Reading the code of sys_sigsuspend() in arch/i386/kernel/signal.c,
>>you'll find that it will return to user only, if do_signal() returns 1.
>>This will happen, if there was a signal to deliver. Ignored signals
>>will not be delivered, so sys_sigsupend will not return on SIGWINCH,
>>if SIGWINCH handler is set to SIG_IGN.
> 
> Doh! You're right, actually.
> 
>>So, for UML's winch_handler, there is no difference between pause()
>>and sigsuspend(), because sigsuspend's feature of accepting a sigmask
>>for use while waiting, in fact isn't needed here as the same mask is
>>set already before with sigprocmask().
> 
> Ok, seems like I'll drop this patch. Thanks for the review.

Maybe, we really should use sigsuspend() instead of pause(), but the
reason for this isn't to remove the winch_handler.
The current loop in winch_thread() might miss a SIGWINCH, if a SIGWINCH
comes in while winch_thread() isn't waiting in wait().
So I think, winch_thread() should block all signals including SIGWINCH.
In its loop it should call sigsuspend() with a mask as argument, that
unblocks SIGWINCH while sigsuspend() waits.

I've attached a patch (tested a bit only).

	Bodo




--------------050407040501000203040404
Content-Type: text/x-diff;
 name="fix-winch_thread.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-winch_thread.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

If a SIGWINCH comes in, while winch_thread() isn't waiting
in wait(), winch_thread could miss signals.
It isn't very probable, that anyone will see this causing
trouble, as it would need a very special timing, that a
missed SIGWINCH results in a wrong window size.

So, this is a minor problem. But why not fix, as it can
be done so easy?

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/drivers/chan_user.c~fix-winch_thread arch/um/drivers/chan_user.c
--- linux-2.6.12-rc4/arch/um/drivers/chan_user.c~fix-winch_thread	2005-05-18 20:53:32.000000000 +0200
+++ linux-2.6.12-rc4-root/arch/um/drivers/chan_user.c	2005-05-18 21:16:55.000000000 +0200
@@ -98,13 +98,14 @@ static int winch_thread(void *arg)
 
 	signal(SIGWINCH, winch_handler);
 	sigfillset(&sigs);
-	sigdelset(&sigs, SIGWINCH);
-	/* Block anything else than SIGWINCH. */
+	/* Block all signals possible. */
 	if(sigprocmask(SIG_SETMASK, &sigs, NULL) < 0){
 		printk("winch_thread : sigprocmask failed, errno = %d\n", 
 		       errno);
 		exit(1);
 	}
+	/* In sigsuspend(), block anything else than SIGWINCH. */
+	sigdelset(&sigs, SIGWINCH);
 
 	if(setsid() < 0){
 		printk("winch_thread : setsid failed, errno = %d\n", errno);
@@ -129,7 +130,7 @@ static int winch_thread(void *arg)
 	while(1){
 		/* This will be interrupted by SIGWINCH only, since other signals
 		 * are blocked.*/
-		pause();
+		sigsuspend(&sigs);
 
 		count = os_write_file(pipe_fd, &c, sizeof(c));
 		if(count != sizeof(c))
_

--------------050407040501000203040404--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
