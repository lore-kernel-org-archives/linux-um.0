Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1TCt-0005oQ-7M for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:27 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1TCs-0008Uk-OU
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:27 -0800
Message-Id: <200701011947.l01JlFBY020781@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 01 Jan 2007 14:47:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/8] UML - Kill a compilation warning
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

Kill a compilation warning.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/exec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-mm/arch/um/kernel/exec.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/exec.c	2007-01-01 11:32:22.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/exec.c	2007-01-01 11:45:15.000000000 -0500
@@ -39,9 +39,9 @@ static long execve1(char *file, char __u
 		    char __user *__user *env)
 {
         long error;
+#ifdef CONFIG_TTY_LOG
 	struct tty_struct *tty;
 
-#ifdef CONFIG_TTY_LOG
 	mutex_lock(&tty_mutex);
 	tty = get_current_tty();
 	if (tty)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
