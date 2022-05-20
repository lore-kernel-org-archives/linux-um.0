Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns6hG-00Dyg4-Ag
 for linux-um@lists.infradead.org; Fri, 20 May 2022 17:45:55 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: chan_user: fix winch_tramp() return value
Date: Fri, 20 May 2022 19:45:36 +0200
Message-Id: <20220520194536.1acbb414a2d1.I1d71bab01d45f7f8e446df6e98547a7989338208@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>, Nathan Chancellor <nathan@kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The previous fix here was only partially correct, it did
result in returning a proper error value in case of error,
but it also clobbered the pid that we need to return from
this function (not just zero for success).

As a result, it returned 0 here, but later this is treated
as a pid and used to kill the process, but since it's now
0 we kill(0, SIGKILL), which makes UML kill itself rather
than just the helper thread.

Fix that and make it more obvious by using a separate
variable for the pid.

Fixes: ccf1236ecac4 ("um: fix error return code in winch_tramp()")
Reported-and-tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/chan_user.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 6040817c036f..25727ed648b7 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -220,7 +220,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
 		       unsigned long *stack_out)
 {
 	struct winch_data data;
-	int fds[2], n, err;
+	int fds[2], n, err, pid;
 	char c;
 
 	err = os_pipe(fds, 1, 1);
@@ -238,8 +238,9 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
 	 * problem with /dev/net/tun, which if held open by this
 	 * thread, prevents the TUN/TAP device from being reused.
 	 */
-	err = run_helper_thread(winch_thread, &data, CLONE_FILES, stack_out);
-	if (err < 0) {
+	pid = run_helper_thread(winch_thread, &data, CLONE_FILES, stack_out);
+	if (pid < 0) {
+		err = pid;
 		printk(UM_KERN_ERR "fork of winch_thread failed - errno = %d\n",
 		       -err);
 		goto out_close;
@@ -263,7 +264,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
 		goto out_close;
 	}
 
-	return err;
+	return pid;
 
  out_close:
 	close(fds[1]);
-- 
2.36.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

