Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXGd2-0005Pi-Dn for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 02:13:32 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXGcz-0004pC-Dw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 02:13:32 -0800
Message-ID: <41A5B03B.8020307@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: The current fix-kill patch
References: <200411230550.iAN5o8mY007302@ccure.user-mode-linux.org>
	<200411232110.51937.blaisorblade_spam@yahoo.it>
	<41A46E1D.8040909@fujitsu-siemens.com>
	<200411250509.09827.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411250509.09827.blaisorblade_spam@yahoo.it>
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
Date: Thu, 25 Nov 2004 11:13:15 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> On Wednesday 24 November 2004 12:18, Bodo Stroesser wrote:
> 
>>Blaisorblade wrote:
>>
>>>On Tuesday 23 November 2004 16:10, Bodo Stroesser wrote:
>>>
>>>>Jeff Dike wrote:
>>>>
>>>>>Here's the latest fix-kill patch in my tree.  Please test and report...
>>>>
>>>>Have tested based on 2.6.9-bb3. I removed
>>>>"rework-uml-hang-on-2.6.9-host", added BlaisorBlade's
>>>>"uml-hang-on-2.6.9-host", and adapted iand added this new patch.
>>>
>>>Btw, if you send another patch, send it relative to
>>>"uml-hang-on-2.6.9-host", or to it + fix-kill from Jeff, so I can easily
>>>spot the differences.
>>>
>>>This is a general rule, also (with a bit of taste, i.e. applies between
>>>developers, not between users).
> 
> 
>>Maybe I was somewhat unclear. "this new patch" was Jeff's "current
>>fix-kill". So I only removed my "rework-uml-hang ..." and added your
>>"uml-hang-..." and Jeff's "current fix-kill" on top of it.
>>I just adapted current fix-kill to apply to 2.6.9, but didn't send these
>>trivial modifications.
> 
> Ok, I had this clear. I was referring exactly to your rework-uml-hang..., even 
> it was not the exact moment.
When I did my rework, I didn't know, that your patch already was included in
2.6.10 mainline. Thus, since I wanted to undo big parts of your work, I thought
I would be a good idea to have a new patch. I was in error, sorry.
> 
> 
>>>>The resulting UML kernel for me works fine on host
>>>>2.6.7-skas3-v7 and 2.6.9-skas3-v7.
>>>
>>>Not yet tested this Jeff Dike's one.
> 
> 
>>Yes. Exactly the test of Jeff's patch I did in the first place.
> 
> 
>>>However, for me, on a 2.6.10-rc2 SKAS patched host (with the update I
>>>posted here and on my site to make SKAS compile), UML hangs on shutdown
>>>in SKAS mode.
> 
> Just retested with -bb3 on 2.6.9 and the hang on shutdown does not happen - 
> 99% sure I'm using the same Uml kernel.
Yes. I also tested. And I tried to test with a 2.6.10-bkX-mmY host. (tried
2.6.9-rc1 and 2.6.9-rc2-mm5, same result).
Unfortunately this version doesn't boot on my host. It freezes while loading
the driver for my DAC960 Mylex RAID. And the root-fs resides on a logical disk
of that controller ...
> 
> About this, from patch-2.6.10-rc1-bk24.log somewhere near its -bk snapshot:
> 
> ChangeSet@1.2026.10.144, 2004-10-26 08:02:35-07:00, roland@redhat.com
>   [PATCH] Wake up signalled tasks when exiting ptrace
> 
>   In general it is not safe to do any non-ptrace wakeup of a thread in
>   TASK_TRACED, because the waking thread could race with a ptrace call
>   that could be doing things like mucking directly with its kernel stack.
> 
>   AFAIK noone has established that whatever clobberation ptrace can do to
>   a running thread is safe even if it will never return to user mode, so
>   we can't allow this even for SIGKILL.
> 
>   What we _can_ safely do is make a thread switching out of TASK_TRACED
>   resume rather than sitting in TASK_STOPPED if it has a pending SIGKILL
>   or SIGCONT.  The following patch does this.
> 
>   This should be sufficient for the shutdown case.  When killing all
>   processes, if the tracer gets killed first, the tracee goes into
>   TASK_STOPPED and will be woken and killed by the SIGKILL (same as
>   before).  If the tracee gets killed first, it gets a pending SIGKILL and
>   doesn't wake up immediately--but, now, when the tracer gets killed, the
>   tracee will then wake up to die.
> 
>   This will also fix the (same) situations that can arise now where you
>   have used gdb (or whatever ptrace caller), killed -9 the gdb and the
>   process being debugged, but still have to kill -CONT the process before
>   it goes away (now it should just go away either the first time or when
>   you kill gdb).
> 
>   Signed-off-by: Roland McGrath <roland@redhat.com>
>   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> It seems to partially improve the broken behaviour we observed in 2.6.9, so we 
> might just report to Roland the hell on ptrace implementation we are seeing.
Very interesting change. Good idea, generally!
For UML, this shouldn't make any difference. Our intention is to actively kill
all ptraced processes. Before the tracer exits, no more child should live.
If this change in the host produces a hang on UML shutdown, I guess, it's wrong.
> 
> 
>>>Nobody else reported this with -bb3, so I suppose there is something new
>>>in 2.6.10-rc2 (I didn't yet test this with
> 
> 
>>>Please let's start testing it ASAP, so that it's fixed before 2.6.10
>>>release. However, I have at least to apply the Jeff's fix before.
> 
> 
>>Maybe I could do this soon.
> 
> 
>>What works and what doesn't:
> 
> 
> 
>>Considering all this, you could use ptrace(PTRACE_CONT, pid, 0, SIGKILL)
>>instead of ptrace(PTRACE_KILL, pid), and it would work even better, since
>>it resets all TIF_XXX flags!
> 
> Sorry, so why don't we actually do this?
Because UML doesn't use ptrace(PTRACE_KILL), when the ptraced process is stopped
on the first syscall-interception. Thus no problem occurs in UML. We should use
PTRACE_KILL to have profit from all future enhancements of that function.
> 
> 
>>While other ptrace commands are restricted to 
>>the case, that the child is stopped, PTRACE_KILL maybe used for a running
>>child, but then it doesn't work. Poor implementation!
>>
>>On the other hand, kill(SIGKILL) doesn't kill a ptraced-process that is
>>stopped on a ptrace-interception since the new TASK_TRACED state is
>>implemented in 2.6.9. kill(SIGKILL) queues the signal only, after this the
>>process must be resumed with a PTRACE_CONT or PTRACE_KILL.
>>
>>I guess, currently the best way to kill a process, not knowing it's state,
>>is: kill(SIGKILL)
>>     ptrace(PTRACE_KILL)
>>     wait until process stops or exits
>>     if process is stopped
>>         ptrace(PTRACE_CONT)
>>But this is very expensive.
>>
>>Now, let's look at UML. With Jeff's "current fix-kill",
>>os_kill_ptraced_process() only is called in cases, where we *know*, the
>>ptraced child is stopped. Thus a simple PTRACE_KILL will work. No
>>kill(SIGKILL) and PTRACE_CONT are necessary. On host 2.6.7 and 2.6.9
>>
>>
>>>>And "kill(pid, SIGKILL);"
>>>>only is needed, if the ptraced process is not stopped on a
>>>>ptrace-interception.
>>>
>>>Well, PTRACE_CONT is to resume if from the ptrace-interception. Let's
>>>start by distinguishing bugs (i.e. reggressions in 2.6.9 behaviour vs.
>>>2.6.8 and earlier one) from strange APIs.
> 
> 
>>>Gdb, or any ptracer, is IMHO 
>>>never supposed to SIGKILL the process directly.
> 
> Well, I thought this, but given how counterintuitive ptrace() seems to be, 
> I'll have to verify this.
> 
>>What does the ptracer do, if the ptraced process runs in an
>>endlessuser-space-loop? Maybe, it sends the process another signal (e.g.
>>SIGTRAP) and waits for the "signal-received"-interception. Then it
>>successfully can do it's PTRACE_KILL.
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
