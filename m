Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTMNv-00080M-78	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 09:06:03 -0700
Received: from mtagate4.de.ibm.com ([195.212.29.153])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DTMNt-0003E9-ET
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 09:06:03 -0700
Received: from d12nrmr1507.megacenter.de.ibm.com
	(d12nrmr1507.megacenter.de.ibm.com [9.149.167.1])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j44G5mqF159002
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 4 May 2005 16:05:48 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])id j44G5mgY279598
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 4 May 2005 18:05:48 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	j44G5moV006928	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 4 May 2005 18:05:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20050504160437.GA573@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Re: Again: UML on s390 (31Bit)
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
Date: Wed, 4 May 2005 18:04:37 +0200
To: bstroesser@fujitsu-siemens.com
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> Yes. That's what I suggested as a "special magic number". Only if that magic
> is written as syscall number at the first interception, syscall_trace() would
> modify regs->trap to -1.
> Currently my patch uses -1 as the magic number, but there might be better
> choices.
> 
> > 3) -Eyyy, skip the system call but leave regs->trap intact so that a pending
> >    signal will restart the system call.
> Not only -Eyyy, but all values unequal to "special magic number" could leave
> regs->trap intact.
> 
> > 
> > But we really have to be very careful not to break either strace or gdb if
> > we do this change. Probably it is much easier to introduce PTRACE_SET/GET_TRAP.
> It's easier for s390-kernel, but from UML's point of view, the magic number
> solution would be better.
> Anyway, if you decide not to allow the magic number, we have to find a way
> to use PTRACE_SETTRAP in UML without having to call it too often (Performance).
> Because of UML's splitting in kernel-obj and user-obj, this might be a bit
> tricky.
> 
> BTW: I see no reason to implement PTRACE_GETTRAP, as
> PTRACE_SETOPTIONS/PTRACE_TRACESYSGOOD give us a way to distinguish between
> syscall interceptions and other SIGTRAPs.

I talked with Uli about the problem and we came up with a more
elegant solution. We already have a debugger specific code in
do_signal that sets up the registers for system call restarting
BEFORE calling the debugger. Only if the debugger did not change
the restart psw and the return value still indicates 
-ERESTARTNOHAND or -ERESTARTSYS we undo this change. In the case
that the debugger did change the psw or the return value we do
not want to restart a system call if another signal is pending.
This is in fact a bug in the signal delivery code. To fix it we
have to set regs->traps to something != __LC_SVC_OLD_PSW while
the debugger has control. regs->traps is reset to the value
indicating a system call if the system call is not restarted
after all.

Will that make UML happy?

blue skies,
  Martin.

---

Index: arch/s390/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/s390/kernel/signal.c,v
retrieving revision 1.22
diff -u -p -r1.22 signal.c
--- arch/s390/kernel/signal.c	23 Mar 2005 08:30:01 -0000	1.22
+++ arch/s390/kernel/signal.c	4 May 2005 14:51:31 -0000
@@ -482,6 +482,7 @@ int do_signal(struct pt_regs *regs, sigs
 		} else if (retval == -ERESTART_RESTARTBLOCK) {
 			regs->gprs[2] = -EINTR;
 		}
+		regs->trap = -1;
 	}
 
 	/* Get signal to deliver.  When running under ptrace, at this point
@@ -497,6 +498,7 @@ int do_signal(struct pt_regs *regs, sigs
 			      & SA_RESTART))) {
 			regs->gprs[2] = -EINTR;
 			regs->psw.addr = continue_addr;
+			regs->trap = __LC_SVC_OLD_PSW;
 		}
 	}
 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
