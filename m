Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1WLzeg-000071-Cy
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 18:37:58 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WLzef-0003Hx-D6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 18:37:58 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri,  7 Mar 2014 18:37:46 +0000
Message-Id: <1394217468-734972-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH 1/3] BUG: Missing pipe handling
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at

From: Anton Ivanov <antivano@cisco.com>

UML does not handle sigpipe. As a result when running it under
expect or redirecting the IO from the console to an external program
it will crash if the program stops or exits.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/os-Linux/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 7a86dd5..048166d 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -149,6 +149,7 @@ int __init main(int argc, char **argv, char **envp)
 #endif
 
 	do_uml_initcalls();
+	change_sig(SIGPIPE, 0);
 	ret = linux_main(argc, argv);
 
 	/*
-- 
1.7.10.4


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

