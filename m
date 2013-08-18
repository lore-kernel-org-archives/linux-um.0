Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VB1Bk-0003T7-PG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Aug 2013 11:30:28 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VB1Bj-0002gx-6T for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Aug 2013 11:30:28 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 18 Aug 2013 13:30:09 +0200
Message-Id: <1376825409-18570-4-git-send-email-richard@nod.at>
In-Reply-To: <1376825409-18570-1-git-send-email-richard@nod.at>
References: <1376825409-18570-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 4/4] um: Run UML in it's own session.
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

If UML is not run by a shell it can happen that UML
will kill unrelated proceses upon a fatal exit because
it issues a kill(0, ...).
To prevent such oddities we create a new session in main().

Cc: rjones@redhat.com
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 749c96d..e1704ff 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -123,6 +123,8 @@ int __init main(int argc, char **argv, char **envp)
 
 	setup_env_path();
 
+	setsid();
+
 	new_argv = malloc((argc + 1) * sizeof(char *));
 	if (new_argv == NULL) {
 		perror("Mallocing argv");
-- 
1.8.3.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

