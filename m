Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKKjS-00082M-UW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Oct 2004 10:58:42 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CKKjR-0003Mf-32 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Oct 2004 10:58:42 -0700
Message-ID: <4176A85F.3000007@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Error in audit syscalls ?
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
Date: Wed, 20 Oct 2004 20:03:11 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Searching the bugs in sysemu I think I've found another little error.
Compared to i386 it should be wrong, but I don't know much about
syscall auditing. So can anyone test this?

Bodo


---

--- a/arch/um/kernel/tt/syscall_user.c	2004-10-20 19:50:06.946514414 +0200
+++ b/arch/um/kernel/tt/syscall_user.c	2004-10-20 19:50:36.562620180 +0200
@@ -29,7 +29,7 @@ void syscall_handler_tt(int sig, union u
  	SC_START_SYSCALL(sc);

  	index = record_syscall_start(syscall);
-	syscall_trace(regs, 1);
+	syscall_trace(regs, 0);
  	result = execute_syscall(regs);

  	/* regs->sc may have changed while the system call ran (there may
@@ -39,7 +39,7 @@ void syscall_handler_tt(int sig, union u

  	SC_SET_SYSCALL_RETURN(sc, result);

-	syscall_trace(regs, 0);
+	syscall_trace(regs, 1);
  	record_syscall_end(index, result);
  }

--- a/arch/um/kernel/skas/syscall_user.c	2004-10-20 19:50:19.568428569 +0200
+++ b/arch/um/kernel/skas/syscall_user.c	2004-10-20 19:50:43.568462424 +0200
@@ -18,12 +18,12 @@ void handle_syscall(union uml_pt_regs *r

  	index = record_syscall_start(UPT_SYSCALL_NR(regs));

-	syscall_trace(regs, 1);
+	syscall_trace(regs, 0);
  	result = execute_syscall(regs);

  	REGS_SET_SYSCALL_RETURN(regs->skas.regs, result);

-	syscall_trace(regs, 0);
+	syscall_trace(regs, 1);
  	record_syscall_end(index, result);
  }



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
