Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <barryf@google.com>) id 1O4OBJ-0003UQ-Nw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2010 00:52:45 +0000
Received: from smtp-out.google.com ([216.239.44.51])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O4Nm5-0006tn-Lp
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2010 00:26:42 +0000
Received: from kpbe15.cbf.corp.google.com (kpbe15.cbf.corp.google.com
	[172.25.105.79]) by smtp-out.google.com with ESMTP id o3L0MPYi014681
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Apr 2010 17:22:25 -0700
From: Barry Friedman <barryf@google.com>
Date: Tue, 20 Apr 2010 17:21:51 -0700
Message-Id: <1271809311-8460-1-git-send-email-barryf@google.com>
Subject: [uml-devel] [PATCH] UML: Fix gdbserver "Couldn't write debug
	register" error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Barry Friedman <barryf@google.com>

Running gdbserver in a UML instance displays "Couldn't
write debug register" after setting a breakpoint and continuing after
attaching from a remote gdb on the host. This is on an AMD x86_64
machine. The error message was resulting from getting EIO error  when
making a PTRACE_POKEUSER call. I debugged the ptrace call handling on
the kernel side and found that the poke_user() and peek_user() calls
in arch/um/sys-x86_64/ptrace.c assume that long is 4 bytes instead of
8. Fix here calculates the register index based on 8 byte long.

arch/um/sys-x86_64/ptrace.c
 - poke_user(): Fix register index calc based on 8 byte long
 - peek_user(): Fix register index calc based on 8 byte	long

---
 arch/um/sys-x86_64/ptrace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/sys-x86_64/ptrace.c b/arch/um/sys-x86_64/ptrace.c
index f3458d7..e491e48 100644
--- a/arch/um/sys-x86_64/ptrace.c
+++ b/arch/um/sys-x86_64/ptrace.c
@@ -69,7 +69,7 @@ int poke_user(struct task_struct *child, long addr, long data)
 	else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
 		(addr <= offsetof(struct user, u_debugreg[7]))) {
 		addr -= offsetof(struct user, u_debugreg[0]);
-		addr = addr >> 2;
+		addr = addr >> 3;
 		if ((addr == 4) || (addr == 5))
 			return -EIO;
 		child->thread.arch.debugregs[addr] = data;
@@ -114,7 +114,7 @@ int peek_user(struct task_struct *child, long addr, long data)
 	else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
 		(addr <= offsetof(struct user, u_debugreg[7]))) {
 		addr -= offsetof(struct user, u_debugreg[0]);
-		addr = addr >> 2;
+		addr = addr >> 3;
 		tmp = child->thread.arch.debugregs[addr];
 	}
 	return put_user(tmp, (unsigned long *) data);
-- 
1.7.0.1


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

