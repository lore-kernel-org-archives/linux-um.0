Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYlCK-0005HW-C4	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 06:36:24 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DYlCH-0000H8-J1	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 06:36:24 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch 1/1] uml: replace pause with sigsuspend
References: <20050516180143.95BDB1993E0@zion.home.lan>
	<200505181718.18455.blaisorblade@yahoo.it>
	<428B9544.60902@fujitsu-siemens.com>
In-Reply-To: <428B9544.60902@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505191535.51279.blaisorblade@yahoo.it>
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
Date: Thu, 19 May 2005 15:35:50 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, jdike@addtoit.com

On Wednesday 18 May 2005 21:19, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Tuesday 17 May 2005 12:14, Bodo Stroesser wrote:
> >>I didn't have the time to test the patch, but I guess, it won't work.
> >>
> >>Maybe, the man pages for sigsuspend are somewhat missleading, saying:
> >>
> >>        The sigsuspend call temporarily replaces the signal mask for
> >>        the process with that given by mask and then suspends the
> >>        process until a signal is received.
> >
> > In fact, I assumed that was correct...
> >
> >>Reading the code of sys_sigsuspend() in arch/i386/kernel/signal.c,
> >>you'll find that it will return to user only, if do_signal() returns 1.
> >>This will happen, if there was a signal to deliver. Ignored signals
> >>will not be delivered, so sys_sigsupend will not return on SIGWINCH,
> >>if SIGWINCH handler is set to SIG_IGN.
> >
> > Doh! You're right, actually.
> >
> >>So, for UML's winch_handler, there is no difference between pause()
> >>and sigsuspend(), because sigsuspend's feature of accepting a sigmask
> >>for use while waiting, in fact isn't needed here as the same mask is
> >>set already before with sigprocmask().
> >
> > Ok, seems like I'll drop this patch. Thanks for the review.

> Maybe, we really should use sigsuspend() instead of pause(), but the
> reason for this isn't to remove the winch_handler.
> The current loop in winch_thread() might miss a SIGWINCH, if a SIGWINCH
> comes in while winch_thread() isn't waiting in wait().

wait()? You mean the pause()/sigsuspend() call, right? Then I probably agree.

> So I think, winch_thread() should block all signals including SIGWINCH.
> In its loop it should call sigsuspend() with a mask as argument, that
> unblocks SIGWINCH while sigsuspend() waits.
>
> I've attached a patch (tested a bit only).
>
> 	Bodo

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
