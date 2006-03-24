Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMvmY-0004XV-Ty for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 15:33:26 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMvmV-00052V-CL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 15:33:27 -0800
Content-Disposition: inline
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603250033.15923.blaisorblade@yahoo.it>
Subject: [uml-devel] Fwd: Why uml-add-tls-support-debug-check-never-works is
	needed (was: Re: Fwd: Proposed additions to the ptrace(2)
	manpage, take 2)
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
Date: Sat, 25 Mar 2006 00:33:15 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Had sent it to the wrong address, resending.

----------  Forwarded Message  ----------

Subject: Why uml-add-tls-support-debug-check-never-works is needed (was: Re: 
Fwd: Proposed additions to the ptrace(2) manpage, take 2)
Date: Saturday 25 March 2006 00:28
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@projects.sourceforge.net

On Friday 24 March 2006 18:17, Jeff Dike wrote:
> On Fri, Mar 24, 2006 at 03:39:02PM +0100, Blaisorblade wrote:
> > Can you retest with my -bb6 tree? It should work, and it couldn't work in
> > you previous codebase. See below.
>
> Woohoo, it works.  The auditd crash is gone, too.
>
> > The special treatment of -EINVAL was bogus; for the call, I thought it
> > wasn't needed, but I tested removing that call on top of -bb6 and
> > everything thread-based stopped working in a _consistent_ way.
> >
> > So I'd like assurance that the bug was only that one, which would be a
> > welcome news.
>
> All of the failure cases I have are now fixed.

Ok, now I have the key: I have understood why this patch works and is needed
(and I hadn't when I wrote it!).

Time ago, in my mind was born the question: can a newly forked process start
running before that schedule does a switch_to() to it? I asked that because I
saw in debugging signs of this happening often; this meant that TLS weren't
flushed for newly born processes.

My answer was no. Your answer was no. It couldn't make sense. We even looked
at schedule() code! Well, we both were wrong.

The reasoning below shows detailedly why we were; however, the code is so
difficult that I thought I had understood why, then said "but no", then find
an even littler detail explaining the situations.

And as you noted, the TLS code failed on cases where (with CLONE_SETTLS) the
child is born with a TLS and it's immediately used - the TLS set inside UML
stays unflushed (i.e. not set on the host) only until the first schedule,
i.e. only for the 1st timeslice.

If a call to set_thread_area is done that's applied on the host immediately,
so that's not a problem.

Now, why were we wrong? It's because our copy_thread is very strange (wrt.
other archs).

Path:
(arch-independent) do_fork() -> copy_thread()->copy_thread_skas() ->
new_thread (..., fork_handler) ->

if (setjmp() == 0) new_thread_proc(..., fork_handler) else return
//At first time, this will return 0, letting us proceed into
 new_thread_proc()

finally new_thread_proc() calls fork_handler(), which will call userspace()
 on the new stack.

However, before calling userspace(), this threads suspends itself in
thread_wait; it will be resumed by a longjmp() to the switch_buf of the new
thread, i.e. by a switch_to! So, one thinks that the switch_to is called. But
it's called by the old thread! The new thread won't execute it, until the end
of its timeslice.

A normal ctx switch executes switch_threads() from the old thread and changes
EIP and ESP (and the rest) to point to the call to switch_threads() inside
switch_to_skas() in the new thread (it's well explained in the comment of
switch_to_tt(), even if the details of ctx switch are different).

At this point, the new thread continues executing switch_to_skas(). And calls
arch_switch_to_skas() and loads its TLS.

BUT, this context switch at the thread born is special: the thread being
switched away switches to a new thread not in the body of the new thread's
call to switch_to_skas->switch_threads(), but in the body of thread_wait()!
At that point, we lose the call to arch_switch_to_skas()!

Questions and notes:

*) Why does arch/um/os-Linux/skas/process.c has still one siglongjmp() call
and sigjmp_buf vars, and that has no comments?

*) Also, why thread_wait and thread_switch are almost identical, yet they're
two different functions?

*) Btw, the naming sucks - if I find better names for new_thread,
new_thread_proc and such, would they be accepted?

*) The same bug happens in TT mode fork_tramp()->finish_fork_handler():
suspend_new_thread waits with SIGSTOP (to wait for the debugger resuming it)
and on os_read_file on switch_pipe, like in switch_to_tt; but we don't do the
things we do in switch_to_tt (like killing it if dead - schedule_tail is not
the same thing).
--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
