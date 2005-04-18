Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DNTuP-0005Qu-NH for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Apr 2005 03:55:17 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DNTuO-0004tI-LJ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Apr 2005 03:55:17 -0700
Message-ID: <426391FB.5020303@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<200504080322.50532.blaisorblade@yahoo.it>
	<42562EC4.7040903@fujitsu-siemens.com>
	<200504171937.05846.blaisorblade@yahoo.it>
In-Reply-To: <200504171937.05846.blaisorblade@yahoo.it>
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
Date: Mon, 18 Apr 2005 12:54:51 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Friday 08 April 2005 09:12, Bodo Stroesser wrote:
> 
>>Blaisorblade wrote:
>>
>>>On Wednesday 06 April 2005 15:27, Bodo Stroesser wrote:
>>>
>>>>s390 implementation is *not* included in tarball, this will
>>>>be posted later, when thing are more stable.
>>
>>Thank you for all your comments!
>>
>>I don't wan't to give to the wide world, before it is more stable.
>>But maybe this can answer some of your questions / remarks.
> 
> I assume you already sent it to Jeff, so I'm not forwarding it.
> 
> Now, some more little issues:
> 
> * arch_fixup() should be implemented but cannot cause problems currently. UML 
> currently does not use the .fixup mechanism (which requires using some asm() 
> inserts - maybe that can be limited to gas pseudo-instruction without real 
> code), but only the fault_catcher and fault_address one, which is an inferior 
> design (some runtime cost). Last time I looked there were some difficulties 
> about 
Yes. I saw arch_fixup() being unused, so I decided not to implement it on s390,
currently.

> 
> * ARCH_SIGHDLR_PARAM works like I feared - you'd probably need {} (or do {} 
> while (0)) around the ARCH_GET_SIGCONTEXT because you declare a var at the 
> beginning... and that function will likely break if not commented (because who 
> patches the code won't go checking what actually happens).
There is a reason for my decision, not to use "{}" here.

s390 doesn't have fields for error-address and trap_no in its sigcontext. Because
of alignment, there is an empty area in the sigcontext, that is big enough to hold
an additional pointer. But there isn't enough place for error-address and trap_no.
So I create a local struct faultinfo, write error-address and trap_no to it and add
its address to the sigcontext. Now the sigcontext containing all info can be passed
to the routine, which has to handle the signal.

If the additional struct faultinfo would be declared inside of a "{}", I guess
there would be no guarantee, that this structure still is valid outside the "{}".
But it needs to be valid at the same level, from where sigcontext is passed to
the called handler.

The current solution should be used immediately after definition of local variables.
Maybe, this should be commented, too.
> 
> I also understand why you can't use the trick used elsewhere... I have no 
> better solution than long comments.
> 
> * About ptrace_faultinfo: Jeff said that S390 "has complex fault 
> informations", while they seem not very complicate inside the S390 patch (I 
> was asking about the generalization of the "is_write" fault info). I want to 
> know this for the purpose of working on a mergeable version of 
> PTRACE_FAULTINFO (which will probably be an extension of PTRACE_SIGINFO)
> 
> Probably struct thread_struct has a more correct definition of those info... 
> and arch/s390/mm/fault.c:do_exception even more. However, only some of that 
> will be needed; we only need, in practise, the write/read (and maybe exec) 
> type of the exception. 
s390 fault information is complex to handle only regarding sighandlers / sigcontext.
Else it is even more simple than i386, as i386 has address, fault_type and trap,
while s390 has address and trap_no only.
What is the faultinfo used for in UML? First, it is used to handle pagefaults.
Second, it is used to give error-information to sighandlers of UML-user-programs.
So, PTRACE_FAULTINFO should give the caller *all* information, that a sighandler
would get. All this info should be stored in thread_struct.
Then, UML internally uses arch-specific macros to extract "is_write" and to see,
if segment violation might be fixable.
PTRACE_FAULTINFO on i386 unfortunately doesn't give UML all info. This should be
fixed in a mainline solution, as the current implementation can't distinguish
between a page-fault and a segment-fault. So a user-program in SKAS3 might loop
on a segment-fault instead of being interrupted by SIGSEGV. (See use of
PTRACE_FULL_FAULTINFO in arch/um/kernel/skas/process.c)

> 
> Also, I've given a look and it wouldn't be difficult making PTRACE_SIGPENDING, 
> just a bit long: update asm-generic/siginfo.h: struct siginfo : _sigfault 
> (maybe depending on the arch), and all the callers.
PTRACE_SIGPENDING currently is unused. I don't know, if there will be need for
it in future. IMHO, this should be removed.

> 
> * for glibc-bug.c, you might as well use an "alias, weak" attribute - see the 
> below from asm-i386/unistd.h:
> 
> /*
>  * "Conditional" syscalls
>  *
>  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
>  * but it doesn't work on all toolchains, so we just do it by hand
>  */
> #ifndef cond_syscall
> #define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
> #endif
> 
> Note that the asm code only contains pseudo-op so it should work as-is on 
> s390, right?
I've experimented with __attribute__((weak)) in C-code and had no success.
IIRC, the "weak" simply was ignored. So I decided to go forward and make s390
run, before clearing those "minor" problems.

> 
> Other issues follow, which refer to copied code going out-of-date wrt. my 
> local tree (which I have snapshotted some time ago, after I started writing 
> this mail). This is the problem with copying code - and you're starting 
> experiencing it!
> 
> * important changes for TLS support, clone(), and so on.
I've seen, that I'll have to implement the small support of TLS in s390. That's
on my todo

> 
> * add a CHOOSE_MODE to arch_switch (since the current code is used only in TT 
> mode) - I'm going to start calling it from SKAS mode and actually needing it 
> for TLS support. Some changes to ptrace_user.c will also happen.
Great. I also want to have arch_switch for skas, as I would like to have full
debugging support in skas.

> 
> * CONFIG_64_BIT must become CONFIG_64BIT, as I'm doing for the other UML 
> subarchs (the '_' is bogus, by comparison with other 64-bit archs). Also I'll 
> have to clean up the Makefiles (USER_OBJS got fixed finally - they got 
> dependency tracking, and the common boilerplate code is now in 
> arch/um/scripts/Makefile.rules - more stuff has shifted there since when you 
> did the patch). And there's no need to readd the end "Emacs" comments, we are 
> gradually getting rid of them. However, I'll take care myself of all these 
> trivial QA (quality assurance) issues.
Your help is very welcome. I also have to scan all the new file to add some
correct Copyright comments. This is a further reason for not publishing s390
yet.

		Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
