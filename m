Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjztA-0004LT-Tb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 03:54:16 -0800
Received: from house1.arach.net.au ([203.30.44.84] helo=house.arach.net.au)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ajzt9-0006ho-JP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 03:54:15 -0800
Received: from unknown (HELO wrath.worlds.end) (202.89.175.107)
	by house1.arach.net.au with SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	23 Jan 2004 12:06:56 -0000
From: nsb034@lostrealm.com
Subject: Re: [uml-devel] [patch] uml fixes, 2.6.1-mm5-A2
Message-ID: <20040123061842.GA5292@localhost>
References: <20040120191706.GA32711@elte.hu> <20040120194328.GA1518@elte.hu>
	<20040120200105.GA2289@elte.hu> <20040122162139.GA28167@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122162139.GA28167@elte.hu>
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
Date: Fri, 23 Jan 2004 14:18:42 +0800
To: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 22, 2004 at 05:21:39PM +0100, Ingo Molnar wrote:
> 
> the patch below fixes a bug in UML that i've reproduced under 2.6.1-mm5. 

This fixes the bug "skas mode panic - ltrace strace" that occurs in 
uml-patch-2.4.23-2 and below.  Could this patch please be applied to the
2.4.x kernels as well?

Thanks,

Dion.

> --- linux/arch/um/kernel/skas/trap_user.c.orig	
> +++ linux/arch/um/kernel/skas/trap_user.c	
> @@ -19,8 +19,10 @@ void sig_handler_common_skas(int sig, vo
>  	struct skas_regs *r;
>  	struct signal_info *info;
>  	int save_errno = errno;
> +	int save_user;
>  
>  	r = &TASK_REGS(get_current())->skas;
> +	save_user = r->is_user;
>  	r->is_user = 0;
>  	r->fault_addr = SC_FAULT_ADDR(sc);
>  	r->fault_type = SC_FAULT_TYPE(sc);
> @@ -32,6 +34,7 @@ void sig_handler_common_skas(int sig, vo
>  
>  	(*info->handler)(sig, (union uml_pt_regs *) r);
>  
> +	r->is_user = save_user;
>  	errno = save_errno;
>  }
>  


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
