Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX0TA-0008KX-1H for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 11:35:04 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FX0T6-0004vA-3h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 11:35:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
In-Reply-To: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604212034.53486.blaisorblade@yahoo.it>
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
Date: Fri, 21 Apr 2006 20:34:52 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Thursday 13 April 2006 19:20, Jeff Dike wrote:
> Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
> traced.  It takes a bitmask and a length.  A system call is traced
> if its bit is one.  Otherwise, it executes normally, and is
> invisible to the ptracing parent.

> This is not just useful for UML - strace -e could make good use of it as
> well.

> Index: linux-2.6.17-mm-vtime/include/asm-i386/ptrace.h
> ===================================================================
> --- linux-2.6.17-mm-vtime.orig/include/asm-i386/ptrace.h	2006-04-13
> 13:48:02.000000000 -0400 +++
> linux-2.6.17-mm-vtime/include/asm-i386/ptrace.h	2006-04-13
> 13:49:32.000000000 -0400 @@ -53,6 +53,7 @@ struct pt_regs {
>
>  #define PTRACE_GET_THREAD_AREA    25
>  #define PTRACE_SET_THREAD_AREA    26
> +#define PTRACE_SYSCALL_MASK	  27

I think there could be a reason we skipped that for SYSEMU - that's to see. 
Also, if this capability will be implemented in other archs, we should use 
the 0x4200-0x4300 range for it.

>  #define PTRACE_SYSEMU		  31
>  #define PTRACE_SYSEMU_SINGLESTEP  32

> @@ -450,6 +451,41 @@ int ptrace_traceme(void)
>  	return 0;
>  }
>
> +int set_syscall_mask(struct task_struct *child, char __user *mask,
> +		     unsigned long len)
> +{
> +	int i, n = (NR_syscalls + 7) / 8;
> +	char c;
> +
> +	if(len > n){
> +		for(i = NR_syscalls; i < len * 8; i++){
> +			get_user(c, &mask[i / 8]);

This get_user() inside a loop is poor, it could slow down a valid call. It'd 
be simpler to copy the mask from userspace in a local variable (with 400 
syscalls that's 50 bytes, i.e. fully ok), and then perform the checks, if 
wanted (I disagree with Heiko's message, this check is needed sometimes - see 
my response to that).

And only after that set all at once child->syscall_mask. You copy twice that 
little quantity of data but that's not at all time-critical, and you're 
forced to do that to avoid partial updates; btw you've saved getting twice 
the content from userspace (slow when address spaces are distinct, like for 
4G/4G or SKAS implementation of copy_from_user).

Actually we would copy the whole struct in my API proposal (as I've described 
in the other message, we need to pass another param IMHO, so we'd pack them 
in a struct and pass its address).

> +			if(!(c & (1 << (i % 8)))){
> +				printk("Out of range syscall at %d\n", i);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		len = n;
> +	}
> +
> +	if(child->syscall_mask == NULL){
> +		child->syscall_mask = kmalloc(n, GFP_KERNEL);
> +		if(child->syscall_mask == NULL)
> +			return -ENOMEM;
> +
> +		memset(child->syscall_mask, 0xff, n);
> +	}
> +
> +	/* XXX If this partially fails, we will have a partially updated
> +	 * mask.
> +	 */
> +	if(copy_from_user(child->syscall_mask, mask, len))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
