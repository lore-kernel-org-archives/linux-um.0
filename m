Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL5Sr-0000bi-EN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 12:52:41 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CL5Sp-0007xQ-4z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 12:52:41 -0700
Message-Id: <200410222102.i9ML2FWY005227@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Fri, 22 Oct 2004 10:12:43 +0200."
	<4178C0FB.4070108@fujitsu-siemens.com> 
References: <4177D503.2030409@fujitsu-siemens.com>
	<200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
	<4178C0FB.4070108@fujitsu-siemens.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Bad handling of invalif systemcalls
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
Date: Fri, 22 Oct 2004 17:02:15 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

bstroesser@fujitsu-siemens.com said:
> Maybe it would make sense, to change the debugger-code. It could
> accept (SIGTRAP|0x80) and give it to the real debugger as SIGTRAP
> normally. Also, it could accept a ptrace(PTRACE_SETOTIONS,,,PTRACE_O_TR
> ACESYSGOOD) and after this it could relay the (SIGTRAP|0x80) without
> change. 

Yeah, it would, but what you have now will work for the time being.

> You are right, orig_eax on the processes stack is -1. But this *has*
> to be saved in the tt-regs structure for later use. What I'm doing is
> the same that
>      UPT_SYSCALL_NR(TASK_REGS(task)) = PT_SYSCALL_NR(proc_regs); does
> in the case of a systemcall. I used "-1" instead of
> "PT_SYSCALL_NR(proc_regs)" because it *is* the same in this situation.

Right, good point.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
