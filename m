Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX0w4-00041h-2h
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 08:23:36 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AX0w3-0004Nu-Ep
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 08:23:35 -0800
Message-ID: <04cc01c3c583$eafe5530$0200000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.58.0312171735540.8123@earth> <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312181036220.31295@earth> <Pine.LNX.4.58.0312181122070.32554@earth> <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181253460.2378@earth> <Pine.LNX.4.58.0312181514140.7622@earth>
Subject: Re: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 17:27:34 +0100
To: Ingo Molnar <mingo@elte.hu>, UML devel list <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>

hi!
i need the following additional patch (see below) to sucessfully compile uml on a suse9 box.
another candidate for your patchset, ingo? 
(or should we blame gcc 3.1.1 ?)

regards
roland


>with mode=tt the kernel runs. Then i tried another kernel from
>kernels.usermodelinux.org:
>linux-2.4.23-rc3-djc3-6um (nomods)
>and: it works.
>I talked to david and he said the kernel builds without problems
>which is not the case on my host. I get this error:
>bugs.c: In function `disable_lcall':
>bugs.c:111: error: storage size of `ldt' isn't known
>bugs.c:118: warning: implicit declaration of function `modify_ldt'
>bugs.c:111: warning: unused variable `ldt'
>
>which is fixed with a patch from:
>http://people.0x63.nu/~andersg/uml-minor-fixes.diff
>
>so, for now, i don't have more ideas to solve this Problem. If someone
>of you has an idea or fix, please commit ;)



----- Original Message ----- 
From: "Ingo Molnar" <mingo@elte.hu>
To: "UML devel list" <user-mode-linux-devel@lists.sourceforge.net>
Cc: "Jeff Dike" <jdike@addtoit.com>
Sent: Thursday, December 18, 2003 3:24 PM
Subject: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0


> 
> the attached patch makes the combo 2.6.0 patch compile for the
> !CONFIG_PROC_MM case. (necessary if forcing TT mode by disabling skas.)
> 
> This is also a small cleanup as it moves the architecture-independent
> ptrace functions into the generic kernel/ptrace.c file.
> 
> i've also uploaded a new combo patch with the alignment fix plus these
> changes included:
> 
>     redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A2
> 
> Ingo
> 
> --- linux/arch/i386/kernel/ptrace.c.orig 
> +++ linux/arch/i386/kernel/ptrace.c 
> @@ -521,12 +521,6 @@ asmlinkage int sys_ptrace(long request, 
>   break;
>   }
>  
> - case PTRACE_SIGPENDING:
> - ret = copy_to_user((unsigned long *) data, 
> -    &child->pending.signal,
> -    sizeof(child->pending.signal));
> - break;
> -
>   case PTRACE_LDT: {
>   struct ptrace_ldt ldt;
>  
> @@ -539,23 +533,6 @@ asmlinkage int sys_ptrace(long request, 
>   break;
>   }
>  
> - case PTRACE_SWITCH_MM: {
> - struct mm_struct *old = child->mm;
> - struct mm_struct *new = proc_mm_get_mm(data);
> -
> - if(IS_ERR(new)){
> - ret = PTR_ERR(new);
> - break;
> - }
> -
> - atomic_inc(&new->mm_users);
> - child->mm = new;
> - child->active_mm = new;
> - mmput(old);
> - ret = 0;
> - break;
> - }
> -
>   default:
>   ret = ptrace_request(child, request, addr, data);
>   break;
> --- linux/kernel/ptrace.c.orig 
> +++ linux/kernel/ptrace.c 
> @@ -316,6 +316,32 @@ int ptrace_request(struct task_struct *c
>   case PTRACE_SETSIGINFO:
>   ret = ptrace_setsiginfo(child, (siginfo_t __user *) data);
>   break;
> + case PTRACE_SIGPENDING:
> + ret = copy_to_user((unsigned long *) data, 
> +    &child->pending.signal,
> +    sizeof(child->pending.signal));
> + break;
> +
> +#ifdef CONFIG_PROC_MM
> + case PTRACE_SWITCH_MM:
> + {
> + struct mm_struct *old = child->mm;
> + struct mm_struct *new = proc_mm_get_mm(data);
> +
> + if (IS_ERR(new)) {
> + ret = PTR_ERR(new);
> + break;
> + }
> +
> + atomic_inc(&new->mm_users);
> + child->mm = new;
> + child->active_mm = new;
> + mmput(old);
> + ret = 0;
> + break;
> + }
> +#endif
> +
>   default:
>   break;
>   }
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
