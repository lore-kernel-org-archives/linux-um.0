Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <indan@nul.nu>) id 1Qx07H-0003Tj-1M
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2011 17:22:51 +0000
Received: from smarthost1.greenhost.nl ([195.190.28.78])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qx07E-0004Wf-Bd
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2011 17:22:50 +0000
Message-ID: <e4fc764e169da660ae542f786ce29f78.squirrel@webmail.greenhost.nl>
Date: Fri, 26 Aug 2011 19:04:01 +0200
From: "Indan Zupancic" <indan@nul.nu>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL, ptrace and syscall restart breakages
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Borislav Petkov <bp@amd64.org>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

Hello,

On Tue, August 23, 2011 20:04, Al Viro wrote:
> On Tue, Aug 23, 2011 at 06:33:17PM +0100, Al Viro wrote:
>> 	* SYSCALL is not terminally broken wrt restarts.  My apologies for
>> misreading what was going on.
>> 	* SYSENTER with Linus' patch does work just fine wrt restarts + ptrace
>> 	* SYSCALL is losing ptrace-made changes to arguments when it restarts.
>> Might or might not be a problem for somebody.
>
> BTW, that one (irrelevant to UML even if we do end up coping with SYSCALL
> there) might be worth spelling it out:
>
> tracer:
> 	ptrace(tracee, PTRACE_SYSCALL);
> tracee:
> 	recvfrom(..., &addrlen);
> tracer:
> 	ptrace(tracee, PTRACE_POKEUSER, EBP, &len2);
> 	ptrace(tracee, PTRACE_DETACH, 0, 0);
> tracee:
> 	completes recvfrom(), using &len2 instead of the &addrlen
>
> That works just fine, regardless of the way syscall is entered; yes, including
> SYSCALL - there we take care to handle ptrace on the way in.  However, if it's
> SYSCALL and (ex-)tracee takes a restart, the second time around we'll have the
> original value of 6th argument used.  Changes made by POKEUSER are lost.
>
> It's not a problem with int 0x80 or SYSENTER (now, with int 0x80 instead of
> jmp).  It's probably not going to be a real issue for anyone, but I pity the
> poor bastard stuck with debugging that if it *does* become someone's problem.

Just to clarify, this only happens on x86 in 32 bit compat mode when changing
the 6th argument via ptrace?

If the tracer sees a repeat of the same system call then it's very unlikely
that there will be any problems, as it will usually just repeat the same
modifications. Conceptually the system call just failed and the tracee is
making a new one. This is pretty much a non-issue then. I don't think anyone
actually expects the registers to be the modified ones in the restarted case,
if the tracer sees separate syscall events for the restarted system call.
Exactly because, from a tracer's point of view, it are just two system calls.

It would only be a problem if GETREGS for the second syscall shows the modified
argument, while the restarted system call actually uses the original value. But
as long as the systemcall uses the value returned by GETREGS at the start of
the system call, everything is fine.

If the system call is silently restarted without notifying the tracer, then
the modified arguments have to be preserved of course, because the tracer
has no chance to update them for the restarted syscall. But I don't think
this happens, and it can't for signal handlers doing system calls anyway.

The case I'm interested in is:

Start syscall: Save args, perhaps modify some args.
End syscall: Restore original args, to not confuse the tracee.

Greetings,

Indan


(BTW, emails forwarded via lkml.net still have long CC's truncated.)



------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

