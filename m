Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWniY-0008Qu-FC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 19:21:18 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CWnhG-0001WP-MJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 19:21:18 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWnHa-0001tV-Bb for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 18:53:26 -0800
Message-ID: <41A3F6F6.1040903@osdl.org>
From: "Randy.Dunlap" <rddunlap@osdl.org>
MIME-Version: 1.0
References: <20041124000715.E3A2FAB24@zion.localdomain>
In-Reply-To: <20041124000715.E3A2FAB24@zion.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/1] uml: fix some ptrace functions returns
	values
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
Date: Tue, 23 Nov 2004 18:50:30 -0800
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

blaisorblade_spam@yahoo.it wrote:
> From: Jeff Dike <jdike@addtoit.com>
> 
> This patch adds ptrace_setfpregs and makes these functions return -errno on
> failure.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
> 
>  linux-2.6.10-rc-paolo/arch/um/sys-i386/ptrace_user.c |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff -puN arch/um/sys-i386/ptrace_user.c~uml-fix-ptrace-interfaces arch/um/sys-i386/ptrace_user.c
> --- linux-2.6.10-rc/arch/um/sys-i386/ptrace_user.c~uml-fix-ptrace-interfaces	2004-11-24 01:06:35.525806848 +0100
> +++ linux-2.6.10-rc-paolo/arch/um/sys-i386/ptrace_user.c	2004-11-24 01:06:35.528806392 +0100
> @@ -17,17 +17,30 @@
>  
>  int ptrace_getregs(long pid, unsigned long *regs_out)
>  {
> -	return(ptrace(PTRACE_GETREGS, pid, 0, regs_out));
> +	if(ptrace(PTRACE_GETREGS, pid, 0, regs_out) < 0)
> +		return(-errno);
> +	return(0);
>  }
>  
>  int ptrace_setregs(long pid, unsigned long *regs)
>  {
> -	return(ptrace(PTRACE_SETREGS, pid, 0, regs));
> +	if(ptrace(PTRACE_SETREGS, pid, 0, regs) < 0)
> +		return(-errno);
> +	return(0);
>  }
>  
>  int ptrace_getfpregs(long pid, unsigned long *regs)
>  {
> -	return(ptrace(PTRACE_GETFPREGS, pid, 0, regs));
> +	if(ptrace(PTRACE_GETFPREGS, pid, 0, regs) < 0)
> +		return(-errno);
> +	return(0);
> +}
> +
> +int ptrace_setfpregs(long pid, unsigned long *regs)
> +{
> +	if(ptrace(PTRACE_SETFPREGS, pid, 0, regs) < 0)
> +		return(-errno);
> +	return(0);
>  }
>  
>  static void write_debugregs(int pid, unsigned long *regs)

Looks OK except that someone's SPACEBAR is broken (missing)
and there are (unneeded/unwanted) parens on the returns.

-- 
~Randy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
