Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6IV8-0003qB-7j for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:42 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6IV6-000467-Py
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:42 -0800
Message-Id: <200602070224.k172O384009674@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/8] UML - Block SIGWINCH in ptrace tester child
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
Date: Mon, 06 Feb 2006 21:24:03 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The process that UML uses to probe the host's ptrace capabilities can (rarely)
receive a SIGWINCH, confusing the parent.  This fixes that by blocking 
SIGWINCH.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/start_up.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/start_up.c	2006-02-06 17:36:29.000000000 -0500
@@ -49,6 +49,7 @@ static int ptrace_child(void *arg)
 	int pid = os_getpid(), ppid = getppid();
 	int sc_result;
 
+	change_sig(SIGWINCH, 0);
 	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
 		perror("ptrace");
 		os_kill_process(pid, 0);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
