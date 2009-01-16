Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LNvW7-0002T5-LJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 20:42:11 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LNvW2-0002GN-NZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 20:42:11 +0000
Date: Fri, 16 Jan 2009 12:41:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20090116124158.4364e269.akpm@linux-foundation.org>
In-Reply-To: <20090115194033.GA10926@hack.private>
References: <20090115194033.GA10926@hack.private>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
To: =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, 15 Jan 2009 19:40:33 +0000
Am__rico Wang <xiyou.wangcong@gmail.com> wrote:

> 
> This patch fixes the following link error:
> 
>   LD      .tmp_vmlinux1                                             
>   arch/um/sys-i386/built-in.o: In function sys_call_table':          
>   (.rodata+0x308): undefined reference to sys_sigprocmask'           
>   collect2: ld returned 1 exit status                                 
>    KSYM    .tmp_kallsyms1.S                                          
>    nm: '.tmp_vmlinux1': No such file                                   
>    AS      .tmp_kallsyms1.o                                          
>    LD      .tmp_vmlinux2 
>    arch/um/sys-i386/built-in.o: In function sys_call_table':  
>   (.rodata+0x308): undefined reference to sys_sigprocmask'  
>   collect2: ld returned 1 exit status   
>   make[1]: *** [.tmp_vmlinux2] Error 1   
>   make: *** [sub-make] Error 2                               
> 
> 
> Signed-off-by: WANG Cong <wangcong@zeuux.org>
> Cc: Jeff Dike <jdike@addtoit.com>
> 
> ---
> diff --git a/arch/um/sys-i386/sys_call_table.S b/arch/um/sys-i386/sys_call_table.S
> index 00e5f52..04147dc 100644
> --- a/arch/um/sys-i386/sys_call_table.S
> +++ b/arch/um/sys-i386/sys_call_table.S
> @@ -6,6 +6,7 @@
>  
>  #define sys_vm86old sys_ni_syscall
>  #define sys_vm86 sys_ni_syscall
> +#define sys_sigprocmask sigprocmask
>  
>  #define old_mmap old_mmap_i386
>  

For how long has this problem been present?

Why aren't lots of other people reporting it?



------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
