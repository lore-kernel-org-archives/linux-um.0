Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C379C3271E
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2t2yDxzMQcoSNEiPYw3CIahCNNHQx8kDeHbINc/XIo=; b=FDRbbyYH7BVVpIxzZghN6hG7fE
	rOeizKuK/CdigCiqiXnh0RzHmL4GBYi9r4k7of7XXmF36J0Xb5f4TEccx2IveWgzmSwyAyZD9fY5F
	D4nvDedJ4LmruBSTFpAjFH20IbSA7I/HUuKn24ZAoocH9IZgjajLPxoXANUBF9yxpZXXNLXMuhSfc
	/sb1PIvXLx7Q6iXSg8nWIra167PfUrotdUbKYB2olmBYkj+5rF3Z22eNl8knCgTDN6nLKq8JjXIvK
	EvE9mE1ugXqj4fmXUIJMMwwKCByoMfk0/tDFDRmyvPynBYmOkgdNqC+y+SpkKBpxucoXzJX06otYn
	OLkgcXPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOhC9-00000007V0h-0Ga2;
	Tue, 02 Jul 2024 17:21:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOhC2-00000007Uxx-41vT
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 17:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+2t2yDxzMQcoSNEiPYw3CIahCNNHQx8kDeHbINc/XIo=;
	t=1719940884; x=1721150484; b=wjce9XrNrqgAFX+hIkapLdNGqSqElSo7pVt4Qf7z56vwAYA
	zme9M5QxGkFdKOG34ASqsTUAhAI0BjtNaKyOLKSlIoeBvsdDkGJD+U9hUUtq43NSSrh6mZlc7W5jn
	o5OImcyveJMz9HeFj62F/FLylGk16kvapdo9hajG4eoJbWrUjLrnUZWy6l3lWDwDii0eWy20GnrK6
	PnF5jPFWlcXovJfTtReqBsOOtMCEBgaIi33hf2O5evW9/b4zOijH9PQNwHyyaLNvhQaQYWWTfIx9B
	FrL6Ix5J+vHUnL0a95otPUH7KR+hITKTE/WQg0un8MjtxhZ1lo/qzvPVgxZ9m4EA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOhBx-000000069u7-1hQi;
	Tue, 02 Jul 2024 19:21:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 2/4] um: generalize os_rcv_fd
Date: Tue,  2 Jul 2024 19:21:19 +0200
Message-ID: <20240702192118.40b78b2bfe4e.Ic6ec12d72630e5bcae1e597d6bd5c6f29f441563@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702192118.c4093bc5b15e.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
References: <20240702192118.c4093bc5b15e.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_102127_016840_561D55EF 
X-CRM114-Status: GOOD (  17.87  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

Change os_rcv_fd() to os_rcv_fd_msg() that can more generally
receive any number of FDs in any kind of message.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v3: fix print format
---
 arch/um/drivers/port_kern.c  | 14 +++++----
 arch/um/drivers/xterm.c      |  2 +-
 arch/um/drivers/xterm_kern.c | 13 ++++++--
 arch/um/include/shared/os.h  |  3 +-
 arch/um/kernel/ksyms.c       |  2 +-
 arch/um/os-Linux/file.c      | 61 +++++++++++++++++++-----------------
 6 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index c52b3ff3c092..a4508470df78 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -45,15 +45,17 @@ struct connection {
 static irqreturn_t pipe_interrupt(int irq, void *data)
 {
 	struct connection *conn = data;
-	int fd;
+	int n_fds = 1, fd = -1;
+	ssize_t ret;
 
-	fd = os_rcv_fd(conn->socket[0], &conn->helper_pid);
-	if (fd < 0) {
-		if (fd == -EAGAIN)
+	ret = os_rcv_fd_msg(conn->socket[0], &fd, n_fds, &conn->helper_pid,
+			    sizeof(conn->helper_pid));
+	if (ret != sizeof(conn->helper_pid)) {
+		if (ret == -EAGAIN)
 			return IRQ_NONE;
 
-		printk(KERN_ERR "pipe_interrupt : os_rcv_fd returned %d\n",
-		       -fd);
+		printk(KERN_ERR "pipe_interrupt : os_rcv_fd_msg returned %zd\n",
+		       ret);
 		os_close_file(conn->fd);
 	}
 
diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index 6918de5e2956..e4316c7981e8 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -156,7 +156,7 @@ static int xterm_open(int input, int output, int primary, void *d,
 	new = xterm_fd(fd, &data->helper_pid);
 	if (new < 0) {
 		err = new;
-		printk(UM_KERN_ERR "xterm_open : os_rcv_fd failed, err = %d\n",
+		printk(UM_KERN_ERR "xterm_open : xterm_fd failed, err = %d\n",
 		       -err);
 		goto out_kill;
 	}
diff --git a/arch/um/drivers/xterm_kern.c b/arch/um/drivers/xterm_kern.c
index 8011e51993d5..3971252cb1a6 100644
--- a/arch/um/drivers/xterm_kern.c
+++ b/arch/um/drivers/xterm_kern.c
@@ -21,12 +21,19 @@ struct xterm_wait {
 static irqreturn_t xterm_interrupt(int irq, void *data)
 {
 	struct xterm_wait *xterm = data;
-	int fd;
+	int fd = -1, n_fds = 1;
+	ssize_t ret;
 
-	fd = os_rcv_fd(xterm->fd, &xterm->pid);
-	if (fd == -EAGAIN)
+	ret = os_rcv_fd_msg(xterm->fd, &fd, n_fds,
+			    &xterm->pid, sizeof(xterm->pid));
+	if (ret == -EAGAIN)
 		return IRQ_NONE;
 
+	if (ret < 0)
+		fd = ret;
+	else if (ret != sizeof(xterm->pid))
+		fd = -EMSGSIZE;
+
 	xterm->new_fd = fd;
 	complete(&xterm->ready);
 
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 6516ff5a0ecc..fc4091c127c8 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -165,7 +165,8 @@ extern int os_create_unix_socket(const char *file, int len, int close_on_exec);
 extern int os_shutdown_socket(int fd, int r, int w);
 extern int os_dup_file(int fd);
 extern void os_close_file(int fd);
-extern int os_rcv_fd(int fd, int *helper_pid_out);
+ssize_t os_rcv_fd_msg(int fd, int *fds, unsigned int n_fds,
+		      void *data, size_t data_len);
 extern int os_connect_socket(const char *name);
 extern int os_file_type(char *file);
 extern int os_file_mode(const char *file, struct openflags *mode_out);
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index 3a85bde3e173..f2fb77da08cf 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(os_shutdown_socket);
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
 EXPORT_SYMBOL(os_accept_connection);
-EXPORT_SYMBOL(os_rcv_fd);
+EXPORT_SYMBOL(os_rcv_fd_msg);
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(os_major);
 EXPORT_SYMBOL(os_minor);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index abf8676b834c..6d3c73910946 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -512,44 +512,47 @@ int os_shutdown_socket(int fd, int r, int w)
 	return 0;
 }
 
-int os_rcv_fd(int fd, int *helper_pid_out)
+/**
+ * os_rcv_fd_msg - receive message with (optional) FDs
+ * @fd: the FD to receive from
+ * @fds: the array for FDs to write to
+ * @n_fds: number of FDs to receive (@fds array size)
+ * @data: the message buffer
+ * @data_len: the size of the message to receive
+ *
+ * Receive a message with FDs.
+ *
+ * Returns: the size of the received message, or an error code
+ */
+ssize_t os_rcv_fd_msg(int fd, int *fds, unsigned int n_fds,
+		      void *data, size_t data_len)
 {
-	int new, n;
-	char buf[CMSG_SPACE(sizeof(new))];
-	struct msghdr msg;
+	char buf[CMSG_SPACE(sizeof(*fds) * n_fds)];
 	struct cmsghdr *cmsg;
-	struct iovec iov;
-
-	msg.msg_name = NULL;
-	msg.msg_namelen = 0;
-	iov = ((struct iovec) { .iov_base  = helper_pid_out,
-				.iov_len   = sizeof(*helper_pid_out) });
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
-	msg.msg_control = buf;
-	msg.msg_controllen = sizeof(buf);
-	msg.msg_flags = 0;
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = data_len,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = buf,
+		.msg_controllen = sizeof(buf),
+	};
+	int n;
 
 	n = recvmsg(fd, &msg, 0);
 	if (n < 0)
 		return -errno;
-	else if (n != iov.iov_len)
-		*helper_pid_out = -1;
 
 	cmsg = CMSG_FIRSTHDR(&msg);
-	if (cmsg == NULL) {
-		printk(UM_KERN_ERR "rcv_fd didn't receive anything, "
-		       "error = %d\n", errno);
-		return -1;
-	}
-	if ((cmsg->cmsg_level != SOL_SOCKET) ||
-	    (cmsg->cmsg_type != SCM_RIGHTS)) {
-		printk(UM_KERN_ERR "rcv_fd didn't receive a descriptor\n");
-		return -1;
-	}
+	if (!cmsg ||
+	    cmsg->cmsg_level != SOL_SOCKET ||
+	    cmsg->cmsg_type != SCM_RIGHTS)
+		return n;
 
-	new = ((int *) CMSG_DATA(cmsg))[0];
-	return new;
+	memcpy(fds, CMSG_DATA(cmsg), cmsg->cmsg_len);
+	return n;
 }
 
 int os_create_unix_socket(const char *file, int len, int close_on_exec)
-- 
2.45.2


