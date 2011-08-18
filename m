Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7x5-0007pt-Co
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:08:27 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7x4-0002T4-JD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:08:27 +0000
Date: Thu, 18 Aug 2011 20:08:19 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7wx-0007rd-Og@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 56/91] um: take register_winch_irq()
 into the caller of is_skas_winch()
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/drivers/chan_user.c     |    7 ++++++-
 arch/um/os-Linux/skas/process.c |    6 +-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 7ed06a7..f180813 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -281,7 +281,12 @@ void register_winch(int fd, struct tty_struct *tty)
 		return;
 
 	pid = tcgetpgrp(fd);
-	if (!is_skas_winch(pid, fd, tty) && (pid == -1)) {
+	if (is_skas_winch(pid, fd, tty)) {
+		register_winch_irq(-1, fd, -1, tty, 0);
+		return;
+	}
+
+	if (pid == -1) {
 		thread = winch_tramp(fd, tty, &thread_fd, &stack);
 		if (thread < 0)
 			return;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 514683f..3fdac54 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -26,11 +26,7 @@
 
 int is_skas_winch(int pid, int fd, void *data)
 {
-	if (pid != getpgrp())
-		return 0;
-
-	register_winch_irq(-1, fd, -1, data, 0);
-	return 1;
+	return pid == getpgrp();
 }
 
 static int ptrace_dump_regs(int pid)
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

