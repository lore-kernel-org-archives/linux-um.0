Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXVyn-0001Zs-1P for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 18:37:01 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CXVym-000098-9J for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Nov 2004 18:37:00 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [Patch 1/1] uml: fix uml-use-sysemu-for-tt.patch
References: <4194C43D.6030107@fujitsu-siemens.com>
	<200411130854.51896.blaisorblade_spam@yahoo.it>
	<4198FDD7.4090804@fujitsu-siemens.com>
In-Reply-To: <4198FDD7.4090804@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411260339.41831.blaisorblade_spam@yahoo.it>
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
Date: Fri, 26 Nov 2004 03:39:41 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

OK, now finally I went studying the patch.

On Monday 15 November 2004 20:04, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Friday 12 November 2004 15:10, Bodo Stroesser wrote:
> >>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> >>
> >>The patch needs some small corrections:
> >>1) local_using_sysemu must be sampled *before* the next
> >>    ptrace(PTRACE_SYSEMU/SYSCALL) and must stay the same until
> >> do_syscall() has been done. Currently it is sampled before do_syscall()
> >> and is used after this for ptrace(PTRACE_SYSEMU/SYSCALL).

Ok, now I went analizing the code and what you say is correct. In fact, when 
merging this I just threw in Jeff Dike's incremental. However, to be correct, 
I must say that in his tree /proc/sysemu was never introduced, so his tree 
was correct.

> >> Even if no 
> >> problem is visible to the UML user, a single syscall could be executed
> >> on the host when switching on sysemu. The result of this then is
> >> overwritten by the syscall execution in UML.

> >>    Since the first event the tracer has to handle is not a syscall, it's
> >>    enough to initialize local_using_sysemu to 0;
> >
> > Sorry, what happens if the first signal it gets is a SIGTRAP, and so
> > local_using_sysemu is not yet set? If this is impossible, please add a
> > comment in the code for this. However, it seems that it can get to the
> > SIGTRAP case with tracing == 1. When beginning the procedure, it is 0,
> > but it can be changed with the value from is_tracing(task). I've not
> > checked if that is zeroed on process creation (i.e. by do_fork() calling
> > copy_thread()), but just note that in the code.

> OK: Let's summarize:
> 1) tracer() is started exactly once.
> 2) The first this it does, is starting the first ptraced-process via
> clone(). 3) Then it waits until the new process stops.
> 4) Since the process will run start_kernel() in kernel space, it is resumed
>     with PTRACE_CONT.

And it has its is_tracing() set to 0 when it is in kernel mode.
> Thus,
(I've filled in the actual reasoning below).
> before having any syscall interception,
it needs to get is_tracing() set to 1, so
> the process has to stop  
> itself with a SIGUSR1, giving the tracer an OP_TRACE_OP request.
Ok.

> After this 
> local_using_sysemu will be set and the process will be resumed with
> PTRACE_SYSCALL or PTRACE_SYSEMU.

So, agreed. Yet, for now I'm still disabling TT SYSEMU in the -bb tree, just 
in case anything else comes up (it does not give a big advantage anyway).

I'm also going to merge this in 2.4-bs
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
