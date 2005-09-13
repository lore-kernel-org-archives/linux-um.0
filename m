Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFH9p-0001Ro-Rp	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 13:13:33 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFH9o-0008Pk-Sm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 13:13:33 -0700
Message-ID: <432732E5.5010303@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SYSEMU getting merged - but I'm in doubt
References: <200509041702.18506.blaisorblade@yahoo.it>
	<20050906161032.GA6157@ccure.user-mode-linux.org>
	<43270396.5050102@fujitsu-siemens.com>
	<200509132023.10959.blaisorblade@yahoo.it>
In-Reply-To: <200509132023.10959.blaisorblade@yahoo.it>
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
Date: Tue, 13 Sep 2005 22:13:25 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, "Charles P. Wright" <cwright@cs.sunysb.edu>

Blaisorblade wrote:
> On Tuesday 13 September 2005 18:51, Bodo Stroesser wrote:
> 
>>Jeff Dike wrote:
>>
>>>On Sun, Sep 04, 2005 at 05:02:18PM +0200, Blaisorblade wrote:
> 
> 
>>>I would be tempted to leave it in and fix it before 2.6.14.  We need
>>>different ptrace codes so that UML knows how to switch interception
>>>types, I take it?
> 
> Yes, that's the idea.
> 
>>>UML is the only user, so there aren't really any compatibility issues.
>>>
>>>
>>>>On the host side, instead, supporting both the broken API and the new one
>>>>is more difficult.
>>>
>>>Yeah, and it shouldn't be done.  This is one reason I'd like to use the
>>>same ptrace codes - it doesn't leave a hole in the codes that says there
>>>was a broken ABI there once.
> 
> Do you see contiguos codes? We jump from 24 to 31-32 (it was done for 
> something like having a common ABI with 2.4 and 2.6 hosts - don't ask me what 
> filled previous slots, however), so you shouldn't worry for this.
> 
> 
>>>>What's your opinion on this? The options are:
>>>>1) merge it as-is
>>>>2) take it back for now, fix it and merge it for 2.6.15.
> 
> 
>>>Merge as-is, fix it before 2.6.13, and you get the same thing, except
>>>a release earlier.  I think this shouldn't be a problem, as after the
>>>floodgates close, you still get to fix things you merged early.  This
>>>came about as a result of feedback received because after it went into
>>>-mm, and it seems to me that this is a legitimate change for 2.6.14.
> 
> 
>>>>And then
> 
> 
>>>>2a) drop the trick, and avoid changing ptrace call numbers. Old UMLs
>>>>will run fast, but crash with /proc/sysemu (only root-accessible).
> 
> 
>>>We should drop /proc/sysemu, if it's there at all, since it's only for
>>>debugging sysemu, and maintain it as a private patch.  So this doesn't
>>>seem like much of an issue.
> 
> 
>>>				Jeff
> 
> 
>>It would be enough to make /proc/sysemu readonly.
> 
> Yes, but my main concern is compatibility with existing binaries. They'll work 
> as long as nobody tries to write on /proc/sysemu if the API is changed.
> 
> However, I've put something together, so I've attached the host patch (I'm 
> also a bit ill this days, so I want to make sure there's at least the 
> possibility for anybody else to fix it).
> 
> This has not yet been tested (I'm gonna do it) - but it seems that it's little 
> enough to make the new behaviour a ptrace option, if needed.
> 
> I wouldn't like to break in *anything* behaviour of old binaries, if possible.
> 
> 
>>But we need to change check_sysemu(). The current implementation will work
>>with the old API only.
> 
> Would it refuse using sysemu or refuse to run at all? That's another 
> interesting point.

If we talk about using a new ptrace code for the new API, old UML binaries running
on a host supporting the new API will recognize that there is no SYSEMU they can
use. So /proc/sysemu will not allow to switch on or off anything (IIRC, the file
will not even be created). That means, that an old binary will run safe but slow
in this case. One could argue, that this is a changed behaviour of the old binary.

OTOH, if the new API would reuse the same ptrace code, check_sysemu of the old
binaries will fail on i386 (and I hope on x86_64, too). That means, sysemu again
will be disabled. AFAICS, it will not refuse to run at all. (Not tested, taken from
the code only)
On s390 the check even might succeed accidentally, but that's no problem, as s390
isn't mainline yet, we can change check_sysemu() to avoid problems. There will
never be an old binary for s390.

Resume: it doesn't matter if a new ptrace code is used or the old one is reused.
Usage of sysemu will be restricted to "new UML on new host" or "old UML on old host"
as long as host doesn't support _both_ APIs (selectable by two separate ptrace codes
or by a new flag to PTRACE_SETOPTIONS). AFAICS, there is no reason to change
/proc/sysemu at all, right?

	Bodo
> 
> 
> ------------------------------------------------------------------------
> 
> sysemu-new-interface
> 
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff -puN arch/i386/kernel/ptrace.c~sysemu-new-interface arch/i386/kernel/ptrace.c
> --- linux-2.6.git/arch/i386/kernel/ptrace.c~sysemu-new-interface	2005-07-27 20:38:35.000000000 +0200
> +++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-27 20:40:25.000000000 +0200
> @@ -749,7 +749,9 @@ int do_syscall_trace(struct pt_regs *reg
>  		send_sig(current->exit_code, current, 1);
>  		current->exit_code = 0;
>  	}
> -	ret = is_sysemu;
> +	/* The debugger might have changed the syscall intercepting mode. Apply
> +	 * this update now, rather than at next syscall. */
> +	ret = test_thread_flag(TIF_SYSCALL_EMU);
>   out:
>  	if (unlikely(current->audit_context) && !entryexit)
>  		audit_syscall_entry(current, AUDIT_ARCH_I386, regs->orig_eax,
> _


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
