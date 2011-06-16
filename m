Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <randy.dunlap@oracle.com>) id 1QXILL-0006Bz-T0
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2011 19:35:07 +0000
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QXILK-0005MP-TO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2011 19:35:07 +0000
Date: Thu, 16 Jun 2011 12:27:38 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Message-Id: <20110616122738.697a7c12.randy.dunlap@oracle.com>
In-Reply-To: <1308250867-12497-1-git-send-email-richard@nod.at>
References: <1308250867-12497-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] [PATCH] um: Clean up vm-flags.h
To: Richard Weinberger <richard@nod.at>
Cc: randy.dunlap@oracle.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, mhocko@suse.cz, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Thu, 16 Jun 2011 21:01:07 +0200 Richard Weinberger wrote:

> There is no need to define VM_{STACK,DATA}_DEFAULT_FLAGS as
> variable.
> It's also useless to test for TIF_IA32 as 64bit UML has no
> IA32 emulation.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> CC: randy.dunlap@oracle.com

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

Thanks.

> CC: mhocko@suse.cz
> CC: torvalds@linux-foundation.org
> ---
>  arch/um/sys-x86_64/Makefile                 |    2 +-
>  arch/um/sys-x86_64/mem.c                    |   16 ----------------
>  arch/um/sys-x86_64/shared/sysdep/vm-flags.h |   26 ++++----------------------
>  3 files changed, 5 insertions(+), 39 deletions(-)
>  delete mode 100644 arch/um/sys-x86_64/mem.c
> 
> diff --git a/arch/um/sys-x86_64/Makefile b/arch/um/sys-x86_64/Makefile
> index c1ea9eb..63fe0d2 100644
> --- a/arch/um/sys-x86_64/Makefile
> +++ b/arch/um/sys-x86_64/Makefile
> @@ -4,7 +4,7 @@
>  # Licensed under the GPL
>  #
>  
> -obj-y = bug.o bugs.o delay.o fault.o ldt.o mem.o ptrace.o ptrace_user.o \
> +obj-y = bug.o bugs.o delay.o fault.o ldt.o ptrace.o ptrace_user.o \
>  	setjmp.o signal.o stub.o stub_segv.o syscalls.o syscall_table.o \
>  	sysrq.o ksyms.o tls.o
>  
> diff --git a/arch/um/sys-x86_64/mem.c b/arch/um/sys-x86_64/mem.c
> deleted file mode 100644
> index 3f8df8a..0000000
> --- a/arch/um/sys-x86_64/mem.c
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/*
> - * Copyright 2003 PathScale, Inc.
> - *
> - * Licensed under the GPL
> - */
> -
> -#include "linux/mm.h"
> -#include "asm/page.h"
> -#include "asm/mman.h"
> -
> -unsigned long vm_stack_flags = __VM_STACK_FLAGS;
> -unsigned long vm_stack_flags32 = __VM_STACK_FLAGS;
> -unsigned long vm_data_default_flags = __VM_DATA_DEFAULT_FLAGS;
> -unsigned long vm_data_default_flags32 = __VM_DATA_DEFAULT_FLAGS;
> -unsigned long vm_force_exec32 = PROT_EXEC;
> -
> diff --git a/arch/um/sys-x86_64/shared/sysdep/vm-flags.h b/arch/um/sys-x86_64/shared/sysdep/vm-flags.h
> index 3213edf..3978e55 100644
> --- a/arch/um/sys-x86_64/shared/sysdep/vm-flags.h
> +++ b/arch/um/sys-x86_64/shared/sysdep/vm-flags.h
> @@ -7,27 +7,9 @@
>  #ifndef __VM_FLAGS_X86_64_H
>  #define __VM_FLAGS_X86_64_H
>  
> -#define __VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
> -				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> -#define __VM_STACK_FLAGS 	(VM_GROWSDOWN | VM_READ | VM_WRITE | \
> -				 VM_EXEC | VM_MAYREAD | VM_MAYWRITE | \
> -				 VM_MAYEXEC)
> -
> -extern unsigned long vm_stack_flags, vm_stack_flags32;
> -extern unsigned long vm_data_default_flags, vm_data_default_flags32;
> -extern unsigned long vm_force_exec32;
> -
> -#ifdef TIF_IA32
> -#define VM_DATA_DEFAULT_FLAGS \
> -	(test_thread_flag(TIF_IA32) ? vm_data_default_flags32 : \
> -	  vm_data_default_flags)
> -
> -#define VM_STACK_DEFAULT_FLAGS \
> -	(test_thread_flag(TIF_IA32) ? vm_stack_flags32 : vm_stack_flags)
> -#endif
> -
> -#define VM_DATA_DEFAULT_FLAGS vm_data_default_flags
> -
> -#define VM_STACK_DEFAULT_FLAGS vm_stack_flags
> +#define VM_DATA_DEFAULT_FLAGS (VM_READ | VM_WRITE | VM_EXEC | \
> +	VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> +#define VM_STACK_DEFAULT_FLAGS (VM_GROWSDOWN | VM_READ | VM_WRITE | \
> +	VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>  
>  #endif
> -- 


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

