Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjhZn-0001qb-SY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 08:21:03 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjhZn-0002vl-8w for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 08:21:03 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040122162139.GA28167@elte.hu>
References: <20040120191706.GA32711@elte.hu> <20040120194328.GA1518@elte.hu>
	<20040120200105.GA2289@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120200105.GA2289@elte.hu>
Subject: [uml-devel] [patch] uml fixes, 2.6.1-mm5-A2
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
Date: Thu, 22 Jan 2004 17:21:39 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


the patch below fixes a bug in UML that i've reproduced under 2.6.1-mm5. 

The bug hits in the following race scenario: if userspace() is just
about to handle a SIGTRAP signal that it wants to relay_signal(), and
SIGVTALRM hits the context before this happens but after is_user is set
to 1 in userspace(), then we get a kernelspace-signal panic. Ought to be
rare but definitely triggerable.

	Ingo

--- linux/arch/um/kernel/skas/trap_user.c.orig	
+++ linux/arch/um/kernel/skas/trap_user.c	
@@ -19,8 +19,10 @@ void sig_handler_common_skas(int sig, vo
 	struct skas_regs *r;
 	struct signal_info *info;
 	int save_errno = errno;
+	int save_user;
 
 	r = &TASK_REGS(get_current())->skas;
+	save_user = r->is_user;
 	r->is_user = 0;
 	r->fault_addr = SC_FAULT_ADDR(sc);
 	r->fault_type = SC_FAULT_TYPE(sc);
@@ -32,6 +34,7 @@ void sig_handler_common_skas(int sig, vo
 
 	(*info->handler)(sig, (union uml_pt_regs *) r);
 
+	r->is_user = save_user;
 	errno = save_errno;
 }
 


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
