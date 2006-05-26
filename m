Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjTR1-0001iG-Sy for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 May 2006 20:56:23 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FjTDD-00050e-Fu for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 May 2006 20:42:07 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FjSvy-0008UN-5d
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 May 2006 20:24:20 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060526032424.GA8283@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [RFC] [PATCH] Double syscall exit traces on x86_64
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
Date: Thu, 25 May 2006 23:24:24 -0400
To: discuss@x86-64.org, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, User-mode-linux-devel@lists.sourceforge.net, Steven James <pyro@linuxlabs.com>, Roland McGrath <roland@redhat.com>, Blaisorblade <blaisorblade@yahoo.it>

We are seeing double ptrace notifications of system call returns on recent
x86_64 kernels.  This breaks UML and at least one other app.

The patch below appears to fix the problem.  The bug is caused by both
syscall_trace and int_very_careful both calling syscall_trace_leave,
and the system call tracing path going through int_very_careful.

I would have liked to get rid of one or the other call to
syscall_trace_leave.  However, the syscall_trace path looks like it
can exit to userspace without going through int_very_careful, and
int_very_careful does things other than system call tracing.

So, instead, I took _TIF_SYSCALL_TRACE and _TIF_SYSCALL_AUDIT out of
the flags test on the grounds that they had already been checked in
syscall_trace.  There is possibly a preemption and call to schedule
between syscall_trace and int_very_careful, so if it can be attached
at that point, then the first return will be missed.  However, I think
that ptrace attachment requires a stopped child, not just one that has
been preempted.

I don't see signal delivery between syscall_trace and
int_very_careful, so I don't see that there can be a ptrace attach
followed by int_very_careful missing the first return.

This is an RFC - if it turns out to be actually correct, some comments
need fixing before this goes anywhere.

UML works with this applied, and it doesn't seem to break
singlestepping, either on normal instructions or across system calls,
which looks like the next most vulnerable thing.

				Jeff


Index: linux-2.6.16.x86_64/arch/x86_64/kernel/entry.S
===================================================================
--- linux-2.6.16.x86_64.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.16.x86_64/arch/x86_64/kernel/entry.S
@@ -345,7 +345,7 @@ int_very_careful:
 	sti
 	SAVE_REST
 	/* Check for syscall exit trace */	
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edx
+	testl $(_TIF_SINGLESTEP),%edx
 	jz int_signal
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
@@ -353,7 +353,7 @@ int_very_careful:
 	call syscall_trace_leave
 	popq %rdi
 	CFI_ADJUST_CFA_OFFSET -8
-	andl $~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
+	andl $~(_TIF_SINGLESTEP),%edi
 	cli
 	jmp int_restore_rest
 	


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
