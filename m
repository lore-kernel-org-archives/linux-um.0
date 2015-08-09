Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZOWly-0007ix-FN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 20:00:46 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZOWlv-000441-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 20:00:46 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun,  9 Aug 2015 22:00:28 +0200
Message-Id: <1439150428-3709-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH] um: Fix waitpid() usage in helper code
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, thomas@m3y3r.de

If UML is executing a helper program it is using
waitpid() with the __WCLONE flag to wait for the program
as the helper is executed from a clone()'ed thread.
While using __WCLONE is perfectly fine for clone()'ed
childs it won't detect terminated childs if the helper
has issued an execve().

We have to use __WALL to wait for both clone()'ed and
regular childs to detect the termination before and
after an execve().

Reported-and-tested-by: Thomas Meyer <thomas@m3y3r.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index e3ee4a5..3f02d42 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -96,7 +96,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 			       "ret = %d\n", -n);
 			ret = n;
 		}
-		CATCH_EINTR(waitpid(pid, NULL, __WCLONE));
+		CATCH_EINTR(waitpid(pid, NULL, __WALL));
 	}
 
 out_free2:
@@ -129,7 +129,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 		return err;
 	}
 	if (stack_out == NULL) {
-		CATCH_EINTR(pid = waitpid(pid, &status, __WCLONE));
+		CATCH_EINTR(pid = waitpid(pid, &status, __WALL));
 		if (pid < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "run_helper_thread - wait failed, "
@@ -148,7 +148,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 int helper_wait(int pid)
 {
 	int ret, status;
-	int wflags = __WCLONE;
+	int wflags = __WALL;
 
 	CATCH_EINTR(ret = waitpid(pid, &status, wflags));
 	if (ret < 0) {
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

