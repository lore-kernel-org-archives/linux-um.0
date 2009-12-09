Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <friedman.barry@gmail.com>) id 1NIS0K-0003FU-Da
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Dec 2009 19:15:16 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NIS0C-0004MJ-Lz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Dec 2009 19:15:16 +0000
Received: by yxe40 with SMTP id 40so3168329yxe.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 09 Dec 2009 11:15:03 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 9 Dec 2009 11:15:03 -0800
Message-ID: <8f0a67b0912091115h1906412fp932fed338b6278a@mail.gmail.com>
From: Barry Friedman <friedman.barry@gmail.com>
Subject: [uml-devel] Bug in x86_64 ptrace?
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
To: user-mode-linux-devel@lists.sourceforge.net

I was trying to run gdbserver in a UML instance and got "Couldn't
write debug register" after setting a breakpoint and continuing after
attaching from a remote gdb on the host. This is on an AMD x86_64
machine. The error message was resulting from getting EIO error  when
making a PTRACE_POKEUSER call. I debugged the ptrace call handling on
the kernel side and found that the poke_user() and peek_user() calls
in arch/um/sys-x86_64/ptrace.c assume that long is 4 bytes instead of
8. With the patch below, I found that gdbserver works fine.

Thanks,
Barry

*** linux-2.6.32/arch/um/sys-x86_64/ptrace.c	Wed Dec  2 19:51:21 2009
--- ../linux-2.6.32/arch/um/sys-x86_64/ptrace.c	Wed Dec  9 10:54:36 2009
*************** int poke_user(struct task_struct *child,
*** 67,77 ****
  	if (addr < MAX_REG_OFFSET)
  		return putreg(child, addr, data);
  	else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
  		(addr <= offsetof(struct user, u_debugreg[7]))) {
  		addr -= offsetof(struct user, u_debugreg[0]);
! 		addr = addr >> 2;
  		if ((addr == 4) || (addr == 5))
  			return -EIO;
  		child->thread.arch.debugregs[addr] = data;
  		return 0;
  	}
--- 67,77 ----
  	if (addr < MAX_REG_OFFSET)
  		return putreg(child, addr, data);
  	else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
  		(addr <= offsetof(struct user, u_debugreg[7]))) {
  		addr -= offsetof(struct user, u_debugreg[0]);
!                 addr = addr >> 3;  // long is 8 bytes on x86_64
  		if ((addr == 4) || (addr == 5))
  			return -EIO;
  		child->thread.arch.debugregs[addr] = data;
  		return 0;
  	}
*************** int peek_user(struct task_struct *child,
*** 112,122 ****
  	if (addr < MAX_REG_OFFSET)
  		tmp = getreg(child, addr);
  	else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
  		(addr <= offsetof(struct user, u_debugreg[7]))) {
  		addr -= offsetof(struct user, u_debugreg[0]);
! 		addr = addr >> 2;
  		tmp = child->thread.arch.debugregs[addr];
  	}
  	return put_user(tmp, (unsigned long *) data);
  }

--- 112,122 ----
  	if (addr < MAX_REG_OFFSET)
  		tmp = getreg(child, addr);
  	else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
  		(addr <= offsetof(struct user, u_debugreg[7]))) {
  		addr -= offsetof(struct user, u_debugreg[0]);
!                 addr = addr >> 3;  // long is 8 bytes on x86_64
  		tmp = child->thread.arch.debugregs[addr];
  	}
  	return put_user(tmp, (unsigned long *) data);
  }

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

