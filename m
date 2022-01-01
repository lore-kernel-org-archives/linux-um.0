Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n3mOU-007PKg-CD
 for linux-um@lists.infradead.org; Sat, 01 Jan 2022 21:58:33 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/4] um: os_set_fd_block: Return old blocking mode
Date: Sat,  1 Jan 2022 22:58:08 +0100
Message-Id: <20220101215810.13260-3-richard@nod.at>
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
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
Cc: linux-kernel@vger.kernel.org, johannes.berg@intel.com, anton.ivanov@cambridgegreys.com, Richard Weinberger <richard@nod.at>

This will be needed when we restore the old mode upon exit.
The function now returns < 0 in case of an error, 1 if O_NONBLOCK
was set, 0 otherwise.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/chan_kern.c     | 8 ++++----
 arch/um/drivers/chan_user.c     | 2 +-
 arch/um/drivers/mconsole_kern.c | 2 +-
 arch/um/drivers/ubd_user.c      | 2 +-
 arch/um/drivers/xterm.c         | 2 +-
 arch/um/os-Linux/file.c         | 5 ++++-
 6 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 62997055c454..86be115b5890 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -83,7 +83,7 @@ static const struct chan_ops not_configged_ops = {
 
 static int open_one_chan(struct chan *chan)
 {
-	int fd, err;
+	int fd, ret;
 
 	if (chan->opened)
 		return 0;
@@ -95,10 +95,10 @@ static int open_one_chan(struct chan *chan)
 	if (fd < 0)
 		return fd;
 
-	err = os_set_fd_block(fd, 0);
-	if (err) {
+	ret = os_set_fd_block(fd, 0);
+	if (ret < 0) {
 		(*chan->ops->close)(fd, chan->data);
-		return err;
+		return ret;
 	}
 
 	chan->fd = fd;
diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 6040817c036f..b449656cd5f8 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -257,7 +257,7 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
 	}
 
 	err = os_set_fd_block(*fd_out, 0);
-	if (err) {
+	if (err < 0) {
 		printk(UM_KERN_ERR "winch_tramp: failed to set thread_fd "
 		       "non-blocking.\n");
 		goto out_close;
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 6ead1e240457..8000914f9cd4 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -732,7 +732,7 @@ static int __init mconsole_init(void)
 		printk(KERN_ERR "Failed to initialize management console\n");
 		return 1;
 	}
-	if (os_set_fd_block(sock, 0))
+	if (os_set_fd_block(sock, 0) < 0)
 		goto out;
 
 	register_reboot_notifier(&reboot_notifier);
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..a930a254826b 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -42,7 +42,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
 
 	err = os_set_fd_block(*fd_out, 0);
 	err = os_set_fd_block(kernel_fd, 0);
-	if (err) {
+	if (err < 0) {
 		printk("start_io_thread - failed to set nonblocking I/O.\n");
 		goto out_close;
 	}
diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index 87ca4a47cd66..01be81c25266 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -161,7 +161,7 @@ static int xterm_open(int input, int output, int primary, void *d,
 	}
 
 	err = os_set_fd_block(new, 0);
-	if (err) {
+	if (err < 0) {
 		printk(UM_KERN_ERR "xterm_open : failed to set xterm "
 		       "descriptor non-blocking, err = %d\n", -err);
 		goto out_close2;
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index e4421dbc4c36..af2b3cba2c93 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -445,11 +445,14 @@ int os_clear_fd_async(int fd)
 int os_set_fd_block(int fd, int blocking)
 {
 	int flags;
+	int oldmode;
 
 	flags = fcntl(fd, F_GETFL);
 	if (flags < 0)
 		return -errno;
 
+	oldmode = !!(flags & O_NONBLOCK);
+
 	if (blocking)
 		flags &= ~O_NONBLOCK;
 	else
@@ -458,7 +461,7 @@ int os_set_fd_block(int fd, int blocking)
 	if (fcntl(fd, F_SETFL, flags) < 0)
 		return -errno;
 
-	return 0;
+	return oldmode;
 }
 
 int os_accept_connection(int fd)
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

