Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CiGAs-0000XI-Ud for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Dec 2004 09:57:54 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CiGAs-0001S4-1L for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Dec 2004 09:57:54 -0800
From: domen@coderock.org
Message-Id: <20041225175745.718BA1ED41@trashy.coderock.org>
Subject: [uml-devel] [patch 09/13] delete unused file
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
Date: Sat, 25 Dec 2004 18:57:55 +0100
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-um/ptrace-i386.h |   46 ----------------------------------------
 1 files changed, 46 deletions(-)

diff -L include/asm-um/ptrace-i386.h -puN include/asm-um/ptrace-i386.h~remove_file-include_asm_um_ptrace_i386.h /dev/null
--- kj/include/asm-um/ptrace-i386.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,46 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __UM_PTRACE_I386_H
-#define __UM_PTRACE_I386_H
-
-#include "sysdep/ptrace.h"
-#include "asm/ptrace-generic.h"
-
-#define PT_REGS_EAX(r) UPT_EAX(&(r)->regs)
-#define PT_REGS_EBX(r) UPT_EBX(&(r)->regs)
-#define PT_REGS_ECX(r) UPT_ECX(&(r)->regs)
-#define PT_REGS_EDX(r) UPT_EDX(&(r)->regs)
-#define PT_REGS_ESI(r) UPT_ESI(&(r)->regs)
-#define PT_REGS_EDI(r) UPT_EDI(&(r)->regs)
-#define PT_REGS_EBP(r) UPT_EBP(&(r)->regs)
-
-#define PT_REGS_CS(r) UPT_CS(&(r)->regs)
-#define PT_REGS_SS(r) UPT_SS(&(r)->regs)
-#define PT_REGS_DS(r) UPT_DS(&(r)->regs)
-#define PT_REGS_ES(r) UPT_ES(&(r)->regs)
-#define PT_REGS_FS(r) UPT_FS(&(r)->regs)
-#define PT_REGS_GS(r) UPT_GS(&(r)->regs)
-
-#define PT_REGS_EFLAGS(r) UPT_EFLAGS(&(r)->regs)
-
-#define PT_REGS_ORIG_SYSCALL(r) PT_REGS_EAX(r)
-#define PT_REGS_SYSCALL_RET(r) PT_REGS_EAX(r)
-#define PT_FIX_EXEC_STACK(sp) do ; while(0)
-
-#define user_mode(r) UPT_IS_USER(&(r)->regs)
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
