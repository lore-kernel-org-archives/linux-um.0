Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9pbJ-0002Sv-6i for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 11:42:53 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C9pbI-0001qu-7X for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 11:42:53 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Minor problems with interrupted systemcalls
References: <8B6FF516CBA0194AB0996705076B02520F7C35@ABGEX01E.abg.fsc.net>
In-Reply-To: <8B6FF516CBA0194AB0996705076B02520F7C35@ABGEX01E.abg.fsc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409211931.24984.blaisorblade_spam@yahoo.it>
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
Date: Tue, 21 Sep 2004 19:31:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Monday 20 September 2004 12:06, Stroesser, Bodo wrote:
> Before commenting the patch in detail, let me try to explain, what I
> found out about interrupted systemcalls. I didn't find any
> documentation, so my knowledge comes from mailing lists and kernel code
> (I evaluated i386 and s390 too). In case I've missed some facts, please
> correct me!

> Linux 2.6 syscall-handler use the results -ERESTARTSYS, -ERESTARTNOHAND,
> ERESTARTNOINTR and -ERESTART_RESTARTBLOCK to tell do_signal(), that a
> systemcall has been interrupted. The user never should see these codes,
> because they are replaced by -EINTR, when the appropriate action has
> been taken by do_signal(). Depending on the result and the disposition
> for the signal which interrupted the systemcall, the systemcall restart
> should be done or not.

> If no signal handler has to be started for a signal (or no unblocked
> signal is pending), get_signal_to deliver() will return 0, 

Yes, I missed that last time - I saw the "no-unblocked signal" case, but I 
didn't see that it returns only signal that have a signal handler installed 
(I completely skipped reading the code after the "dequeue_signal" call).

> otherwise it 
> will return the number of the signal, for which a handler must be
> started.
Ok.
> A systemcall restart should be done for

> -ERESTARTSYS, if no handler has to be started or SA_RESTART is set in
> the signal disposition
> -ERESTARTNOHAND, if no handler has to be started
> -ERESTARTNOINTR, always
> -ERESTART_RESTARTBLOCK, if no handler has to be started, but with a
> different systemcall number (__NR_restart_syscall). Special parameters
> for that call are stored in the task's restartblock by the interrupted
> systemcall handler.
> If no systemcall restart is performed, the result has to be set to
> -EINTR.

> Further comments see below.

> > Could you explain them in more detail, and clean up this part of the
>
> patch?

> 15:03:30.441065600 +0200
>
> > > @@ -132,19 +132,18 @@
> > >  {
> > >       siginfo_t info;
> > >       struct k_sigaction *ka;
> > > -     int err, sig;
> > > +     int sig;
> > >
> > >       if (!oldset)
> > >             oldset = &current->blocked;
> > >
> > >       sig = get_signal_to_deliver(&info, regs, NULL);
> > > -     if(sig == 0)
> > > -           return(0);

> This return skips the handling of systemcall restarts if no signal
> handler is needed
Well, sounds reasonable; even a signal without a userspace handler can 
interrupt a syscall, but in that case, even if sig == 0, we must check if we 
mus 

> > get_signal_to_deliver and sig == 0 seems to mean that no signal is
> > available.
I was wrong.

> > > -
> > > -     /* Whee!  Actually deliver the signal.  */
> > > -     ka = &current->sighand->action[sig -1 ];
> > > -     err = handle_signal(regs, sig, ka, &info, oldset, error);
> >
> > Why do you drop the handling of errors from handle_signal()? If you do
> > this to 
> > workaround handle_signal() bugs in handling -ERESTART*, fix
> > handle_signal(); 

> > there are other errors that it can return, and that you must handle.
> >
> > > -     if(!err) return(1);
> > > +     if(sig > 0) {
> > > +           /* Whee!  Actually deliver the signal.  */
> > > +           ka = &current->sighand->action[sig -1 ];
> > > +           handle_signal(regs, sig, ka, &info, oldset, error);
> > > +           return(1);
> > > +     }

> If a handler is needed, handle_signal() is called. It contains the code
> to process systemcall restarting for this case. Without a handler, the
> existing code behind the patch is processed (has been skipped in almost
> all cases without the patch).

> But what about bad return from handle_signal()? As I could see, the only
> reason for handle_signal() to return error is a SEGV, while writing to
> process's stack. The handler thus could not be started.

Ignoring a return value for a good reason should always be documented in the 
code as you did here - also, the i386 handle_signal() returns a void, while 
here we must understand just how to handle this - should kern_do_signal 
return 0 or 1?

Actually, do_signal is not standard among archs, and its return value it's 
either ignored or used as whether the syscall is interrupted or not (for 
sigsuspend and such, below).

> It's not a good 
> idea to continue with syscall restart processing, written for the case
> of no signal handler...
Obviously not.

> If a SEGV occurs, force_segv() is called to deliver SIGSEGV, and that's
> all we have to do. (One fact is outstanding: I believe the signal will
> not be delivered on this, but on the next return from kernel to user. I
> will try to write a small test for this. But if it is wrong, it's wrong
> in i386 and s390 too!)

> > >       /* Did we come from a system call? */
> > >       if(PT_REGS_SYSCALL_NR(regs) >= 0){
> >

> If you compare the patched code to i386, you will see it's *very*
> similar. And it should behave very similar to i386 (that is, what it
> should be - isn't it?)

Yes, I agree they should be similar. Er, shouldn't the check "Did we come from 
a syscall" be added like in i386 to handle_signal too? The "ERESTART_*" 
handling in handle_signal is at least useless in case we are not handling a 
syscall, and may cause bugs (I'm not sure here, but why bother?).

Since we have anyway to change this, I think, please repost the updated patch 
to Andrew Morton, and CC it to LKML, me and Jeff, so that it can get reviewed 
- I agree to what you say but I prefer to have it reviewed in mainline, since 
I'm not able to review it well. Before posting the patch, read 
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
for the format to name that or people could complain. "Minor problems with 
interrupted syscall" is not the title you'll use.

And compliments for this catch!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
