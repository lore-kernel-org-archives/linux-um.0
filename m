Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAwes-0003yr-5B for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:10 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CAwep-0008Gc-TN
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 13:27:09 -0700
Message-Id: <200409242132.i8OLWRZX003935@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Minor problems with interrupted systemcalls 
In-Reply-To: Your message of "Wed, 22 Sep 2004 19:12:37 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C38@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C38@ABGEX01E.abg.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 24 Sep 2004 17:32:27 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Change the valid system call numbers to reflect the possibility that we could
have __NR_restart_syscall.

Index: 2.6.9-rc/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/skas/process.c	2004-09-24 16:04:02.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/skas/process.c	2004-09-24 16:04:16.000000000 -0400
@@ -64,7 +64,7 @@
 
 	syscall_nr = PT_SYSCALL_NR(regs->skas.regs);
 	UPT_SYSCALL_NR(regs) = syscall_nr;
-	if(syscall_nr < 1){
+	if(syscall_nr < 0){
 		relay_signal(SIGTRAP, regs);
 		return;
 	}
Index: 2.6.9-rc/arch/um/kernel/tt/syscall_user.c
===================================================================
--- 2.6.9-rc.orig/arch/um/kernel/tt/syscall_user.c	2004-09-24 16:04:02.000000000 -0400
+++ 2.6.9-rc/arch/um/kernel/tt/syscall_user.c	2004-09-24 16:04:49.000000000 -0400
@@ -56,7 +56,8 @@
 	regs = TASK_REGS(task);
 	UPT_SYSCALL_NR(regs) = syscall;
 
-	if(syscall < 1) return(0);
+	if(syscall < 0)
+		return(0);
 
 	if((syscall != __NR_sigreturn) &&
 	   ((unsigned long *) PT_IP(proc_regs) >= &_stext) && 



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
