Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HUqxI-0005FW-6f for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Mar 2007 14:05:48 -0700
Received: from smtp2.oregonstate.edu ([128.193.4.8] ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HUqxG-0007SF-NX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Mar 2007 14:05:48 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 23 Mar 2007 14:05:42 -0700
Message-ID: <7B4268E5ACB878429B58D4BE5B780E83012A6D1D@NWS-EXCH2.nws.oregonstate.edu>
In-Reply-To: <20070323193730.GA9519@c2.user-mode-linux.org>
References: <20070323193730.GA9519@c2.user-mode-linux.org>
From: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
Subject: Re: [uml-devel] [PATCH] UML - host VDSO fix
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Jeff,

Is this going into stable or devel? If stable, what version? Also, do
you know what version of the host kernels introduced this behavior?

Sorry for all the questions, but I believe this is the bug I've been
waiting on for a while (affecting host kernels greater than 2.6.17, or
something of that nature). Thanks!

Tony


> -----Original Message-----
> From: user-mode-linux-devel-bounces@lists.sourceforge.net 
> [mailto:user-mode-linux-devel-bounces@lists.sourceforge.net] 
> On Behalf Of Jeff Dike
> Sent: Friday, March 23, 2007 12:38 PM
> To: stable@kernel.org
> Cc: LKML; uml-devel
> Subject: [uml-devel] [PATCH] UML - host VDSO fix
> 
> This fixes a problem seen by a number of people running UML 
> on newer host
> kernels.  init would hang with an infinite segfault loop.
> 
> It turns out that the host kernel was providing a AT_SYSINFO_EHDR of
> 0xffffe000, which faked UML into believing that the host VDSO 
> page could be
> reused.  However, AT_SYSINFO pointed into the middle of the 
> address space, and
> was unmapped as a result.  Because UML was providing 
> AT_SYSINFO_EHDR and
> AT_SYSINFO to its own processes, these would branch to 
> nowhere when trying to
> use the VDSO.
> 
> The fix is to also check the location of AT_SYSINFO when 
> deciding whether to
> use the host's VDSO.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> --
>  arch/um/os-Linux/elf_aux.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6.17/arch/um/os-Linux/elf_aux.c
> ===================================================================
> --- linux-2.6.17.orig/arch/um/os-Linux/elf_aux.c	
> 2007-02-23 15:00:51.000000000 -0500
> +++ linux-2.6.17/arch/um/os-Linux/elf_aux.c	2007-02-23 
> 15:09:58.000000000 -0500
> @@ -39,6 +39,9 @@ __init void scan_elf_aux( char **envp)
>  		switch ( auxv->a_type ) {
>  			case AT_SYSINFO:
>  				__kernel_vsyscall = auxv->a_un.a_val;
> +				/* See if the page is under TASK_SIZE */
> +				if (__kernel_vsyscall < 
> (unsigned long) envp)
> +					__kernel_vsyscall = 0;
>  				break;
>  			case AT_SYSINFO_EHDR:
>  				vsyscall_ehdr = auxv->a_un.a_val;
> 
> --------------------------------------------------------------
> -----------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the 
> chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge
> &CID=DEVDEV
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
