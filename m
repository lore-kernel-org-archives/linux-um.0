Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQGpF-0004Ai-Lc for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 19:01:13 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CQGpD-0003ZA-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 19:01:13 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: Synchronization primitives in UML (was: Re: [uml-devel] Re:
	[patch 09/20] uml: use SIG_IGN for empty sighandler)
Message-ID: <20041106051306.GA3038@ccure.user-mode-linux.org>
References: <200411052036.55541.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411052036.55541.blaisorblade_spam@yahoo.it>
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
Date: Sat, 6 Nov 2004 00:13:06 -0500
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, cw@f00f.org

On Fri, Nov 05, 2004 at 08:36:55PM +0100, Blaisorblade wrote:
> Also, why shouldn't sigprocmask be restartable with the -ERESTART* mechanism?

Err, that was pause, not sigprocmask.  sigprocmask just switches the signal
mask.

pause is what sits there and waits for something to happen.

> Wouldn't your kludge break?

What kludge?

> Also, a nicer way to code this could be to have an explicit sighandler setting 
> a flag (to get the syscall interrupted if the signal arrives before being 
> blocked) and to call sigpending() (to test if the signal arrived just after 
> setting it). After the syscall, that could become SIG_IGN.

You're seeing races where there aren't any.  SIGWINCH is only possible when
it gets a controlling tty, which happens after the sigprocmask.

> Also, (optional answer), why is this needed? A comment about such issues would 
> be better than an answer email.

The point of this is to handle SIGWINCH on consoles which have host ttys and
relay them inside UML to whatever might be running on the console and cares
about the window size.

So, we have a separate thread for each host tty attached to a UML device
(side-issue - I'm annoyed that one thread can't have multiple controlling
ttys for purposed of handling SIGWINCH, but I imagine there are other reasons
that doesn't make any sense).

SIGWINCH can't be received synchronously, so you have to set up to receive
it as a signal.  That being the case, if you are going to wait for it, it is
convenient to sit in a pause() and wait for the signal to bounce you out of
it.  So, you need a signal handler for the reason I mentioned before, but it's
not needed to do anything.

> Ok. However, I have a general question about all this whole code: why do you 
> use pipes as synchronization primitives? Did you avoid semaphores for 
> portability issues, or for persistency ones? Both can be solved (with the os_
> layer and the IPC_PRIVATE key).

OK, the synchronization here is due to that fact that the argument recieved
by the thread is on the stack of the parent.  The parent can't return from
its current procedure until it knows that the child has copied the data onto
its own stack.  Hence the writing of the byte after it has been copied.

A semaphore would work, and in fact that's exactly what I'm imitating here.
I've avoided SysV semaphores because of a long-standing dislike of them,
stemming mostly from their persistence, and the fact that they need to be
cleaned up manually if the process that created them didn't destroy them.

I just had a look at the man page, and I see this:

       The name choice IPC_PRIVATE was perhaps unfortunate, IPC_NEW would more
       clearly show its function.

So, IPC_PRIVATE ones would seem to be persistent, too.

A more basic issue is the interface.  What I have now is the mapping
	open <-> create
	read <-> down
	write <-> up
	close <-> destroy
which is way simpler and cleaner than semget, semop, and ??? (I can't figure
out how to destroy one of these things).

> This would especially help during context switching, I think. I have just a 
> rough idea of what switch_pipe is for, but calling the network layer (what 
> you call os_pipe() is actually socketpair(), which is very confusing) to rely 
> on the semaphores / wait queues it uses seems suboptimal and ugly.

For context switching, normal pipes (or semaphores) would be fine.  I use 
socketpairs because they support SIGIO, and pipes don't.  I stuck with 
socketpairs just because they do everything I need.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
