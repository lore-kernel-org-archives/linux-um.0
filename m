Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JphEG-00040f-0x for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Apr 2008 03:02:00 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JphEE-0006Ss-NF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Apr 2008 03:01:59 -0700
Received: by wa-out-1112.google.com with SMTP id k22so7684529waf.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 26 Apr 2008 03:01:58 -0700 (PDT)
Date: Sat, 26 Apr 2008 18:01:12 +0800 (CST)
Message-Id: <20080426.180112.184545994.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
In-Reply-To: <20080425175606.GA11174@c2.user-mode-linux.org>
References: <20080425175606.GA11174@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/19] UML - Tidy stub management code
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Jeff Dike <jdike@addtoit.com>
Date: Fri, 25 Apr 2008 13:56:06 -0400
> Restructure the stub management code to make it simpler.
> 
> syscall_stub_done is extracted from do_syscall_stub.
> 
> The counters are gone since I never looked at them.
> 
> The common code in run_syscall_stub and syscall_stub_data is extracted
> into flush_syscalls.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> ---
>  arch/um/os-Linux/skas/mem.c |  162 +++++++++++++++++++++++---------------------
>  1 file changed, 85 insertions(+), 77 deletions(-)
> 
> Index: linux-2.6-git/arch/um/os-Linux/skas/mem.c
> ===================================================================
> --- linux-2.6-git.orig/arch/um/os-Linux/skas/mem.c	2008-04-25 11:36:59.000000000 -0400
> +++ linux-2.6-git/arch/um/os-Linux/skas/mem.c	2008-04-25 11:39:07.000000000 -0400
> @@ -40,35 +40,69 @@ static unsigned long syscall_regs[MAX_RE
>  
>  static int __init init_syscall_regs(void)
>  {
> +	unsigned long *stub_entry;
> +
>  	get_safe_registers(syscall_regs);
> +	stub_entry = &batch_syscall_stub;
> +
>  	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
> -		((unsigned long) &batch_syscall_stub -
> +		((unsigned long) stub_entry -
>  		 (unsigned long) &__syscall_stub_start);
>  	return 0;
>  }
>  
>  __initcall(init_syscall_regs);
>  
> -extern int proc_mm;
> +static int syscall_stub_done(unsigned long stack)
> +{
> +	unsigned long *syscall, *data, offset;
> +	int ret, n;
> +
> +	/*
> +	 * When the stub stops, we find the following values on the
> +	 * beginning of the stack:
> +	 * (long) return_value
> +	 * (long) offset to failed sycall data (0 if no error)
> +	 */
> +	ret = *((unsigned long *) stack);


I am afraid the value will be truncated on 64bit machine, since
'ret' is 'int' while 'stack' points to an 'unsigned long'.

Is this expected?

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
