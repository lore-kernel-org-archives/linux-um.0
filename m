Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWvBT-00044R-NG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 03:19:39 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWvBQ-0004RB-2M for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 03:19:39 -0800
Message-ID: <41A46E1D.8040909@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: The current fix-kill patch
References: <200411230550.iAN5o8mY007302@ccure.user-mode-linux.org>
	<41A352E4.5050607@fujitsu-siemens.com>
	<200411232110.51937.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411232110.51937.blaisorblade_spam@yahoo.it>
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
Date: Wed, 24 Nov 2004 12:18:53 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> On Tuesday 23 November 2004 16:10, Bodo Stroesser wrote:
> 
>>Jeff Dike wrote:
>>
>>>Here's the latest fix-kill patch in my tree.  Please test and report...
> 
> 
>>Have tested based on 2.6.9-bb3. I removed "rework-uml-hang-on-2.6.9-host",
>>added BlaisorBlade's "uml-hang-on-2.6.9-host", and adapted iand added this
>>new patch.
> 
> Btw, if you send another patch, send it relative to "uml-hang-on-2.6.9-host", 
> or to it + fix-kill from Jeff, so I can easily spot the differences.
> 
> This is a general rule, also (with a bit of taste, i.e. applies between 
> developers, not between users).
Maybe I was somewhat unclear. "this new patch" was Jeff's "current fix-kill".
So I only removed my "rework-uml-hang ..." and added your "uml-hang-..."
and Jeff's "current fix-kill" on top of it.
I just adapted current fix-kill to apply to 2.6.9, but didn't send these
trivial modifications.
> 
> 
>>The resulting UML kernel for me works fine on host 
>>2.6.7-skas3-v7 and 2.6.9-skas3-v7.
> 
> Not yet tested this Jeff Dike's one.
Yes. Exactly the test of Jeff's patch I did in the first place.
> 
> However, for me, on a 2.6.10-rc2 SKAS patched host (with the update I posted 
> here and on my site to make SKAS compile), UML hangs on shutdown in SKAS 
> mode.
> 
> Nobody else reported this with -bb3, so I suppose there is something new in 
> 2.6.10-rc2 (I didn't yet test this with 
> 
> Please let's start testing it ASAP, so that it's fixed before 2.6.10 release. 
> However, I have at least to apply the Jeff's fix before.
Maybe I could do this soon.
> 
> 
>>Next, I tested what happens if the "kill(pid, SIGKILL);" and
>>"ptrace(PTRACE_CONT, pid);" are removed from os_kill_ptraced_process(), and
>>it also worked fine.
> 
> 
>>Since PTRACE_KILL wakes up the ptraced process unconditionally, IMHO
>>"ptrace(PTRACE_CONT, pid);" has no effect here.
> 
> You reported PTRACE_KILL not to work in some Ptrace states. PTRACE_CONT is 
> intended to fix this (even if PTRACE_KILL is not needed).
No. PTRACE_CONT is not a fix for non working PTRACE_KILL.

What works and what doesn't:

The problem with PTRACE_KILL is not, that it doesn't wakeup the ptraced child,
but that it not always generates a SIGKILL for the child.
On all i386 hosts I have knowledge about (2.6.7, 2.6.9, 2.4.21) PTRACE_KILL wakes
up the ptraced child unconditionally (on 2.4 not tested, only read the code). Thus
PTRACE_CONT is not necessary after PTRCAE_KILL.
But PTRACE_KILL doesn't generate a SIGKILL for processes, that are not stopped on a
ptrace-interception. This is, because the parent doing PTRACE_KILL modifies child's
exit_code only, leaving the task of generating the signal to the child itself, which
does it in the routines that called ptrace_notify(). Why is it done that way: we
have to handle two different cases: on a "signal-received"-interception, the new
signal-number placed into child->exit_code by the parent replaces the signal being
processed by the child. On a singlestep-trap or syscall-interception, child
generates a new signal to itself, calling send_sig().
By the way: there are calls to ptrace_notify() that lack the code of
signal-generation. This at least is inconsistent. And PTRACE_KILL won't work for a
process, that is stopped on the first syscall-interception (PTRACE_SYSCALL). Since
PTRACE_KILL doesn't reset the TIF_SYSCALL_TRACE (and TIF_SYSCAL_EMU) flag, the
process will execute the current syscall and stop on the exit-interception again.
You would have to wait for that happen, and restart it again. Then the queued
SIGKILL can be processed.
Now assume a process is running in a user-space loop or is waiting in a syscall.
Then PTRACE_KILL will wake it up, but no SIGKILL is generated. For a process
waiting in a read(0,...) my test shows, that read() isn't even aborted. I guess, it
wakes up and sees no pending signal, thus it sleeps again. So, PTRACE_KILL has no
effect is cases like these, but doing a kill(SIGKILL) would work.

Considering all this, you could use ptrace(PTRACE_CONT, pid, 0, SIGKILL) instead of
ptrace(PTRACE_KILL, pid), and it would work even better, since it resets all TIF_XXX
flags! While other ptrace commands are restricted to the case, that the child is
stopped, PTRACE_KILL maybe used for a running child, but then it doesn't work.
Poor implementation!

On the other hand, kill(SIGKILL) doesn't kill a ptraced-process that is stopped on a
ptrace-interception since the new TASK_TRACED state is implemented in 2.6.9.
kill(SIGKILL) queues the signal only, after this the process must be resumed with
a PTRACE_CONT or PTRACE_KILL.

I guess, currently the best way to kill a process, not knowing it's state, is:
     kill(SIGKILL)
     ptrace(PTRACE_KILL)
     wait until process stops or exits
     if process is stopped
         ptrace(PTRACE_CONT)
But this is very expensive.

Now, let's look at UML. With Jeff's "current fix-kill", os_kill_ptraced_process()
only is called in cases, where we *know*, the ptraced child is stopped. Thus a
simple PTRACE_KILL will work. No kill(SIGKILL) and PTRACE_CONT are necessary.
On host 2.6.7 and 2.6.9
> 
> 
>>And "kill(pid, SIGKILL);" 
>>only is needed, if the ptraced process is not stopped on a
>>ptrace-interception.
> 
> Well, PTRACE_CONT is to resume if from the ptrace-interception. Let's start by 
> distinguishing bugs (i.e. reggressions in 2.6.9 behaviour vs. 2.6.8 and 
> earlier one) from strange APIs. Gdb, or any ptracer, is IMHO never supposed 
> to SIGKILL the process directly.
What does the ptracer do, if the ptraced process runs in an endlessuser-space-loop?
Maybe, it sends the process another signal (e.g. SIGTRAP) and waits for the
"signal-received"-interception. Then it successfully can do it's PTRACE_KILL.
> 
> 
>>Since os_kill_ptraced_process() is called only then, 
>>when the ptraced process is known to be on a ptrace-stop, I would like to
>>remove "kill(pid, SIGKILL);", too.
>>os_kill_ptraced_process() is called each time, a process in TT exec()s.
>>Thus avoiding unneeded calls is a little speedup.
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
