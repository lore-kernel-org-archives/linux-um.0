Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ynIx-00043Q-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 23:57:47 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ynIw-0003Jg-PQ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 23:57:46 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: <200309131854.h8DIsEe4006813@ccure.karaya.com>
Message-ID: <Pine.GSO.4.21.0309150853020.3191-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 15 Sep 2003 08:57:42 +0200 (MEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Sat, 13 Sep 2003, Jeff Dike wrote:
> geert@linux-m68k.org said:
> > First step: libpthread redefines sigaction to install its own signal
> > handler around the signal.
> 
> Gawd, that's unpleasant.  What does its signal handler do?

For reference, here's the code (from Debian glibc_2.3.1-16):

| /* The wrapper around sigaction.  Install our own signal handler
|    around the signal. */
| int __sigaction(int sig, const struct sigaction * act,
|               struct sigaction * oact)
| {
|   struct sigaction newact;
|   struct sigaction *newactp;
| 
|   if (sig == __pthread_sig_restart ||
|       sig == __pthread_sig_cancel ||
|       (sig == __pthread_sig_debug && __pthread_sig_debug > 0))
|     {
|       __set_errno (EINVAL);
|       return -1;
|     }
|   if (act)
|     {
|       newact = *act;
|       if (act->sa_handler != SIG_IGN && act->sa_handler != SIG_DFL
|           && sig > 0 && sig < NSIG)
|         {
|           if (act->sa_flags & SA_SIGINFO)
|             newact.sa_handler = (__sighandler_t) __pthread_sighandler_rt;
|           else
|             newact.sa_handler = (__sighandler_t) __pthread_sighandler;
|         }
|       newactp = &newact;
|     }
|   else
|     newactp = NULL;
|   if (__libc_sigaction(sig, newactp, oact) == -1)
|     return -1;
|   if (sig > 0 && sig < NSIG)
|     {
|       if (oact != NULL
|           /* We may have inherited SIG_IGN from the parent, so return the
|              kernel's idea of the signal handler the first time
|              through.  */
|           && (__sighandler_t) __sighandler[sig].old != SIG_ERR)
|         oact->sa_handler = (__sighandler_t) __sighandler[sig].old;
|       if (act)
|         /* For the assignment it does not matter whether it's a normal
|            or real-time signal.  */
|         __sighandler[sig].old = (arch_sighandler_t) act->sa_handler;
|     }
|   return 0;
| }
| #if 0 // FIXME UML sigaction
|     // FIXME: causes problems with UML
|     //   Checking for the skas3 patch in the host...found
|     //   Checking for /proc/mm...found
|     //   capture_stack : Expected SIGSTOP, got status = 0xb7f
| 
| strong_alias(__sigaction, sigaction)
| #endif // FIXME UML

As you can see, I have to uncomment the strong_alias(...) to make UML boot.

> > and quits without any further messages. If I try to run it under gdb,
> > gdb crashes immediately with a segmentation fault. 
> 
> Try stracing it.  You can tell a lot about its progress by looking at its 
> system calls.

Didn't help much neither...

I removed all libpthread overridings of symbols that are used by UML
(intersection of 'U' symbols of vmlinux and 'T' and 'W' symbols of libpthread),
and now UML boots. I'll try to find out which one is the bad guy...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
