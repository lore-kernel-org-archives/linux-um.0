Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9L4m-00040N-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 03:07:16 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1C9L4l-000347-FB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 03:07:16 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Minor problems with interrupted systemcalls
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C35@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Mon, 20 Sep 2004 12:06:45 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Before commenting the patch in detail, let me try to explain, what I
found out about interrupted systemcalls. I didn't find any
documentation, so my knowledge comes from mailing lists and kernel code
(I evaluated i386 and s390 too). In case I've missed some facts, please
correct me!

Linux 2.6 syscall-handler use the results -ERESTARTSYS, -ERESTARTNOHAND,
ERESTARTNOINTR and -ERESTART_RESTARTBLOCK to tell do_signal(), that a
systemcall has been interrupted. The user never should see these codes,
because they are replaced by -EINTR, when the appropriate action has
been taken by do_signal(). Depending on the result and the disposition
for the signal which interrupted the systemcall, the systemcall restart
should be done or not.
If no signal handler has to be started for a signal (or no unblocked
signal is pending), get_signal_to deliver() will return 0, otherwise it
will return the number of the signal, for which a handler must be
started.
A systemcall restart should be done for
-ERESTARTSYS, if no handler has to be started or SA_RESTART is set in
the signal disposition
-ERESTARTNOHAND, if no handler has to be started
-ERESTARTNOINTR, always
-ERESTART_RESTARTBLOCK, if no handler has to be started, but with a
different systemcall number (__NR_restart_syscall). Special parameters
for that call are stored in the task's restartblock by the interrupted
systemcall handler.
If no systemcall restart is performed, the result has to be set to
-EINTR.

Further comments see below.

-----Original Message-----
> From: BlaisorBlade [mailto:blaisorblade_spam@yahoo.it] 
> Sent: Saturday, September 18, 2004 6:17 PM
> To: user-mode-linux-devel@lists.sourceforge.net; Jeff Dike
> Cc: Stroesser, Bodo
> Subject: Re: [uml-devel] Minor problems with interrupted systemcalls
> 
> On Friday 17 September 2004 19:46, Stroesser, Bodo wrote:
> > If a program is traced or debugged, in 2.6.x interrupted systemcalls
> > with the results -ERESTARTxxxxxxx are not handled correctly, no
> > systemcall restart is done.
> >
> > Here is a patch that should fix the problem. The patch is tested on
> > 2.6.6 in tt and skas modes. It applies to 2.6.8.1, but I've not
tested
> > yet.
> >
> > Hope, this helps.
> 
> I read the patch a bit and I understand and agree on most changes;
nice job, 
> mostly. However, I don't like at all the changes to 
> arch/um/kernel/signal_kern.c.
> 
> Could you explain them in more detail, and clean up this part of the
patch? 
> Comments come below.
> 
> > --- uml_orig/arch/um/kernel/signal_kern.c 2004-08-05
18:36:24.000000000 +0200
> > +++ uml/arch/um/kernel/signal_kern.c      2004-09-17
15:03:30.441065600 +0200
> > @@ -132,19 +132,18 @@
> >  {
> >       siginfo_t info;
> >       struct k_sigaction *ka;
> > -     int err, sig;
> > +     int sig;
> > 
> >       if (!oldset)
> >             oldset = &current->blocked;
> > 
> >       sig = get_signal_to_deliver(&info, regs, NULL);
> > -     if(sig == 0)
> > -           return(0);
This return skips the handling of systemcall restarts if no signal
handler is needed

> 
> Could you explain why the sig == 0 check must be dropped? I went
reading 
> get_signal_to_deliver and sig == 0 seems to mean that no signal is
available. 
> (But I don't understand what "current->notifier" is, but it does not
seem 
> related to syscall restarting).
> 
> > -
> > -     /* Whee!  Actually deliver the signal.  */
> > -     ka = &current->sighand->action[sig -1 ];
> > -     err = handle_signal(regs, sig, ka, &info, oldset, error);
> 
> Why do you drop the handling of errors from handle_signal()? If you do
this to 
> workaround handle_signal() bugs in handling -ERESTART*, fix
handle_signal(); 
> there are other errors that it can return, and that you must handle.
> 
> > -     if(!err) return(1);
> > +     if(sig > 0) {
> > +           /* Whee!  Actually deliver the signal.  */
> > +           ka = &current->sighand->action[sig -1 ];
> > +           handle_signal(regs, sig, ka, &info, oldset, error);
> > +           return(1);
> > +     }
If a handler is needed, handle_signal() is called. It contains the code
to process systemcall restarting for this case. Without a handler, the
existing code behind the patch is processed (has been skipped in almost
all cases without the patch).
But what about bad return from handle_signal()? As I could see, the only
reason for handle_signal() to return error is a SEGV, while writing to
process's stack. The handler thus could not be started. It's not a good
idea to continue with syscall restart processing, written for the case
of no signal handler...
If a SEGV occurs, force_segv() is called to deliver SIGSEGV, and that's
all we have to do. (One fact is outstanding: I believe the signal will
not be delivered on this, but on the next return from kernel to user. I
will try to write a small test for this. But if it is wrong, it's wrong
in i386 and s390 too!)
> > 
> >       /* Did we come from a system call? */
> >       if(PT_REGS_SYSCALL_NR(regs) >= 0){
> 
> -- 
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729

If you compare the patched code to i386, you will see it's *very*
similar. And it should behave very similar to i386 (that is, what it
should be - isn't it?)

Greets
Bodo


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
