Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg5k2-0005zY-Fx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 10:52:58 -0700
Received: from ns.sysgo.de ([213.68.67.98] helo=mailgate.sysgo.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bg5k1-0004J3-9F for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 10:52:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by mailgate.sysgo.de (Postfix) with ESMTP id 7F08647C66
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  1 Jul 2004 19:52:07 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mailgate.sysgo.de (Postfix) with ESMTP id 733B147C66
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  1 Jul 2004 19:52:07 +0200 (CEST)
Message-ID: <40E45092.7050106@sysgo.de>
From: =?ISO-8859-1?Q?Alex_Z=FCpke?= <azu@sysgo.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit
References: <40E0036D.2070108@sysgo.de>
	<200406291604.51726.blaisorblade_spam@yahoo.it>
	<40E29034.7040504@sysgo.de>
	<200406302144.32539.blaisorblade_spam@yahoo.it>
In-Reply-To: <200406302144.32539.blaisorblade_spam@yahoo.it>
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
Date: Thu, 01 Jul 2004 19:57:38 +0200
To: user-mode-linux-devel@lists.sourceforge.net


>  uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN arch/um/kernel/trap_kern.c~check_is_user_before_panic 
> arch/um/kernel/trap_kern.c
> --- uml-linux-2.6.7/arch/um/kernel/trap_kern.c~check_is_user_before_panic	
> 2004-06-30 21:27:59.640300880 +0200
> +++ uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c	2004-06-30 
> 21:28:04.043631472 +0200
> @@ -54,7 +54,7 @@ int handle_page_fault(unsigned long addr
>  	if(is_write && !(vma->vm_flags & VM_WRITE)) 
>  		goto out;
>  	page = address & PAGE_MASK;
> -	if(page == (unsigned long) current_thread + PAGE_SIZE)
> +	if(page == (unsigned long) current_thread + PAGE_SIZE && !is_user)
>  		panic("Kernel stack overflow");
>  	pgd = pgd_offset(mm, page);
>  	pmd = pmd_offset(pgd, page);
> 
> 

Hi Paolo,

checking !is_user might not help, because
skas/uaccess.c::maybe_map() calls handle_page_fault with is_user = 0
when doing copy_from/to_user stuff ...

Maybe Jeff remembers the intention of this panic,
because the whole

	if(page == (unsigned long) current + PAGE_SIZE)
		panic("Kernel stack overflow");

does not make any sense for me when checking user VMAs

On Linux 2.4.xx with 8k stacks, current+PAGE_SIZE is the upper
page of the kernel stack and always valid in kernel address space
and has nothing to do with the userspace VMAs.



-Alex




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
