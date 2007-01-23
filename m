Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9RPJ-0003Ts-O1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:13 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H9RPE-0005hM-Vv
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:10 -0800
Message-Id: <200701231927.l0NJRhZ8005353@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 23 Jan 2007 14:27:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/7] UML - locking comments in startup code
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Add a couple of comments about some non-locked data.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/os-Linux/start_up.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.18-mm/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/start_up.c	2007-01-13 17:50:31.000000000 +1100
+++ linux-2.6.18-mm/arch/um/os-Linux/start_up.c	2007-01-17 12:29:59.000000000 +1100
@@ -133,6 +133,7 @@ static int stop_ptraced_child(int pid, v
 	return ret;
 }
 
+/* Changed only during early boot */
 int ptrace_faultinfo = 1;
 int ptrace_ldt = 1;
 int proc_mm = 1;
@@ -160,6 +161,7 @@ __uml_setup("mode=skas0", mode_skas0_cmd
 		"    specify mode=tt. Note that this was recently added - on \n"
 		"    older kernels you must use simply \"skas0\".\n\n");
 
+/* Changed only during early boot */
 static int force_sysemu_disabled = 0;
 
 static int __init nosysemu_cmd_param(char *str, int* add)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
