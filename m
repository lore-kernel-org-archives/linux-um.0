Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPJcX-0003OC-MM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 03:48:09 -0800
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPJcV-0007tv-2P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 03:48:09 -0800
From: Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <20041103113736.GA23041@taniwha.stupidest.org>
References: <20041103113736.GA23041@taniwha.stupidest.org>
Content-Type: text/plain
Message-Id: <1099482457.16445.1.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to
	kill host-OS processes
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
Date: Wed, 03 Nov 2004 11:47:38 +0000
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>

On Wed, 2004-11-03 at 11:37, Chris Wedgwood wrote:
> kill(..., SIGKILL) doesn't work to kill host-OS processes created in
> the exec path in TT mode --- for this we need PTRACE_KILL (it did work
> in previous kernels, but not by design).  Without this process will
> accumulate on the host-OS (although the won't be visible inside UML).
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> ---
> 
> Yes, there are other fixes along these lines which are needed but one
> at a time as we test these...
> 
> Index: cw-current/arch/um/kernel/tt/exec_user.c
> ===================================================================
> --- cw-current.orig/arch/um/kernel/tt/exec_user.c	2004-11-03 02:10:18.064830204 -0800
> +++ cw-current/arch/um/kernel/tt/exec_user.c	2004-11-03 02:12:10.447716745 -0800
> @@ -35,7 +35,8 @@
>  		tracer_panic("do_exec failed to get registers - errno = %d",
>  			     errno);
>  
> -	kill(old_pid, SIGKILL);
> +	if (ptrace(PTRACE_KILL, old_pid, NULL, NULL))
> +		printk("Warning: ptrace(PTRACE_KILL, %d, ...) saw %d\n", errno);

You have two %d but only one argument.  You seem to have forgotten an
"old_pid, " in there.

>  
>  	if(ptrace_setregs(new_pid, regs) < 0)
>  		tracer_panic("do_exec failed to start new proc - errno = %d",

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
