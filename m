Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjZgU-0002u6-Ft for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 May 2006 03:36:46 -0700
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FjZgT-0005un-7r
	for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 May 2006 03:36:46 -0700
From: Andi Kleen <ak@suse.de>
References: <20060526032424.GA8283@ccure.user-mode-linux.org>
In-Reply-To: <20060526032424.GA8283@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261236.26814.ak@suse.de>
Subject: [uml-devel] Re: [discuss] [RFC] [PATCH] Double syscall exit traces on
	x86_64
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
Date: Fri, 26 May 2006 12:36:26 +0200
To: discuss@x86-64.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, User-mode-linux-devel@lists.sourceforge.net, Steven James <pyro@linuxlabs.com>, Roland McGrath <roland@redhat.com>, Blaisorblade <blaisorblade@yahoo.it>

On Friday 26 May 2006 05:24, Jeff Dike wrote:
> We are seeing double ptrace notifications of system call returns on recent
> x86_64 kernels.  This breaks UML and at least one other app.

I believe this patch is the correct fix. Can you confirm it works for you? 

-Andi

Don't do syscall exit tracing twice

int_ret_from_syscall already does syscall exit tracing, so 
no need to do it again in the caller.

This caused problems for UML and some other special programs doing
syscall interception.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -282,12 +282,7 @@ tracesys:			 
 	ja  1f
 	movq %r10,%rcx	/* fixup for C */
 	call *sys_call_table(,%rax,8)
-	movq %rax,RAX-ARGOFFSET(%rsp)
-1:	SAVE_REST
-	movq %rsp,%rdi
-	call syscall_trace_leave
-	RESTORE_TOP_OF_STACK %rbx
-	RESTORE_REST
+1:	movq %rax,RAX-ARGOFFSET(%rsp)
 	/* Use IRET because user could have changed frame */
 	jmp int_ret_from_sys_call
 	CFI_ENDPROC


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
