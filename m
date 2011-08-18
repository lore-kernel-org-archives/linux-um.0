Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7og-0006Ru-SX
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 18:59:46 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7og-0008Ph-5U
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 18:59:46 +0000
Date: Thu, 18 Aug 2011 19:59:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7oZ-0007QL-4L@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 04/91] um: winch_interrupt() can happen
	inside of free_winch()
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


... so set winch->fd to -1 before doing free_irq(), to avoid having
winch_interrupt() come from/during the latter and attempt to do
reactivate_fd() on something that's already gone.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/drivers/line.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index c5bff1d..91bf1894 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -725,6 +725,8 @@ struct winch {
 
 static void free_winch(struct winch *winch, int free_irq_ok)
 {
+	int fd = winch->fd;
+	winch->fd = -1;
 	if (free_irq_ok)
 		free_irq(WINCH_IRQ, winch);
 
@@ -732,8 +734,8 @@ static void free_winch(struct winch *winch, int free_irq_ok)
 
 	if (winch->pid != -1)
 		os_kill_process(winch->pid, 1);
-	if (winch->fd != -1)
-		os_close_file(winch->fd);
+	if (fd != -1)
+		os_close_file(fd);
 	if (winch->stack != 0)
 		free_stack(winch->stack, 0);
 	kfree(winch);
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

