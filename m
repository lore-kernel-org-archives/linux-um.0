Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZEFh-0002MO-SV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 12:05:33 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CZEFg-0005Q7-HM for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 12:05:33 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041130200845.2C5058BAFE@zion.localdomain>
Subject: [uml-devel] [patch 1/2] Uml - first part rework of run_helper() and
	users.
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
Date: Tue, 30 Nov 2004 21:08:44 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Fixed a file descriptor leak in the network driver when changing an IP
address.

Fixed the error handling in run_helper.


Paolo notes:

Actually, this is part one of the change, the exact one extracted from Jeff
Dike's incrementals tree before 2.6.9-rc big UML merge.

There is some changes must be done, so I'm also sending a second patch with
this one, too. Separated for tracking purposes.

Don't send this pair of ones to Linus before Jeff ACK's it - just put into -mm for now.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/drivers/net_user.c |    3 ++-
 linux-2.6.10-rc-paolo/arch/um/kernel/helper.c    |   14 +++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff -puN arch/um/drivers/net_user.c~uml-orig-helper-rework arch/um/drivers/net_user.c
--- linux-2.6.10-rc/arch/um/drivers/net_user.c~uml-orig-helper-rework	2004-11-30 20:43:45.701552240 +0100
+++ linux-2.6.10-rc-paolo/arch/um/drivers/net_user.c	2004-11-30 21:08:14.756221984 +0100
@@ -173,8 +173,9 @@ static int change_tramp(char **argv, cha
 	pe_data.stdout = fds[1];
 	pid = run_helper(change_pre_exec, &pe_data, argv, NULL);
 
-	os_close_file(fds[1]);
 	read_output(fds[0], output, output_len);
+	os_close_file(fds[0]);
+	os_close_file(fds[1]);
 
 	CATCH_EINTR(err = waitpid(pid, NULL, 0));
 	return(pid);
diff -puN arch/um/kernel/helper.c~uml-orig-helper-rework arch/um/kernel/helper.c
--- linux-2.6.10-rc/arch/um/kernel/helper.c~uml-orig-helper-rework	2004-11-30 20:43:45.703551936 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/helper.c	2004-11-30 21:08:14.755222136 +0100
@@ -94,24 +94,20 @@ int run_helper(void (*pre_exec)(void *),
 	if(n < 0){
 		printk("run_helper : read on pipe failed, err = %d\n", -n);
 		err = n;
-		goto out_kill;
+		os_kill_process(pid, 1);
 	}
 	else if(n != 0){
 		CATCH_EINTR(n = waitpid(pid, NULL, 0));
 		pid = -errno;
 	}
+	err = pid;
 
-	if(stack_out == NULL) free_stack(stack, 0);
-        else *stack_out = stack;
-	return(pid);
-
- out_kill:
-	os_kill_process(pid, 1);
  out_close:
 	os_close_file(fds[0]);
-	os_close_file(fds[1]);
  out_free:
-	free_stack(stack, 0);
+	if(stack_out == NULL)
+		free_stack(stack, 0);
+        else *stack_out = stack;
 	return(err);
 }
 
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
