Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B23C4167B
	for <linux-um@archiver.kernel.org>; Wed,  6 Dec 2023 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FP3DoF0lRbRHD7+p/Ffe73LO5f0g8XcMID2JVUBMxAs=; b=v3IAKdzBrWSR9FF7P1hn5SXbyj
	s0gLVIihkwUrSVWSp37mRe1WGgNWH5lnWi0h+/C8RO56eX6wcf9DTpENKP5hd1J4LdAcTEp4cWrOP
	uMISlCwDm+rpDd5cjqLZg4MHgfbET4sTsFeqi44Gwa/lkbsExKb1LKkHkfQH9cKrv2M7AdbnwnY2q
	XzXAPYWF2cICUOlvTfOEhwbGudtbDDi85B1d0Hdfgq81Ni9vDDqozTFmW/LguydNfio5zHNihoryD
	yMFnXA068QFc6EZHOL7vpfIWE2quMmzAsFxaNCBCGyadwtB6s7xH/dUYdgrfk8cEXJJ94tGYcLYgA
	HmxbBLHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAmU3-009JhB-2m;
	Wed, 06 Dec 2023 07:38:15 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAmU1-009Jge-0h
	for linux-um@lists.infradead.org;
	Wed, 06 Dec 2023 07:38:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C9BB1B81EDB;
	Wed,  6 Dec 2023 07:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DB8C433B6;
	Wed,  6 Dec 2023 07:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848290;
	bh=U/O3J9Sie7k4DGATt5KkwA0grhqAPkmoX1CjrG9lqhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZ4zfrTQpB9JgbzRNJV7L4jle3ayX5T0uV7RGNoFMcm6v76qDBwtRF+D25Ht7Gf87
	 On/lHvtFguyIxL4+OQ7Dck1eIvga2dF9qmtjfmv8PpfYDBXndX9bfFbgcJvI6qdsqv
	 Gi4IUQpe7DjrDoQ26xYZ6iK9l4+20QBrEW4BxYY5xx+lRsDRkKXTWGrKVDkvq1tF1k
	 PxgQ/yPSd8Bm4puAtoXJDkVGEk3WW8uID6+9l/vsg8JFmHST5GqgPGB8l1gbksPOsz
	 F6BX3ctIELwXaDtCWbA6G/asCOwTVVXIYGYGZZDiTP4NGs+z99pD2tZguIw271oFSD
	 9XEK6ynXsZeBg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH 26/27] tty: um: convert to u8/__u8 and size_t
Date: Wed,  6 Dec 2023 08:37:11 +0100
Message-ID: <20231206073712.17776-27-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_233813_547020_AC7B7EF6 
X-CRM114-Status: GOOD (  15.22  )
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

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Note we use __u8 in the userspace files.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
 arch/um/drivers/chan.h      | 2 +-
 arch/um/drivers/chan_kern.c | 9 ++++-----
 arch/um/drivers/chan_user.c | 4 ++--
 arch/um/drivers/chan_user.h | 9 +++++----
 arch/um/drivers/line.c      | 2 +-
 arch/um/drivers/line.h      | 6 +++---
 arch/um/drivers/null.c      | 2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/um/drivers/chan.h b/arch/um/drivers/chan.h
index 3fec3b8406e9..e14b9cdf7a33 100644
--- a/arch/um/drivers/chan.h
+++ b/arch/um/drivers/chan.h
@@ -30,7 +30,7 @@ struct chan {
 extern void chan_interrupt(struct line *line, int irq);
 extern int parse_chan_pair(char *str, struct line *line, int device,
 			   const struct chan_opts *opts, char **error_out);
-extern int write_chan(struct chan *chan, const char *buf, int len,
+extern int write_chan(struct chan *chan, const u8 *buf, size_t len,
 			     int write_irq);
 extern int console_write_chan(struct chan *chan, const char *buf, 
 			      int len);
diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 26a702a06515..37538b4168da 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -33,14 +33,14 @@ static void not_configged_close(int fd, void *data)
 	       "UML\n");
 }
 
-static int not_configged_read(int fd, char *c_out, void *data)
+static int not_configged_read(int fd, u8 *c_out, void *data)
 {
 	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return -EIO;
 }
 
-static int not_configged_write(int fd, const char *buf, int len, void *data)
+static int not_configged_write(int fd, const u8 *buf, size_t len, void *data)
 {
 	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
@@ -247,8 +247,7 @@ void deactivate_chan(struct chan *chan, int irq)
 		deactivate_fd(chan->fd, irq);
 }
 
-int write_chan(struct chan *chan, const char *buf, int len,
-	       int write_irq)
+int write_chan(struct chan *chan, const u8 *buf, size_t len, int write_irq)
 {
 	int n, ret = 0;
 
@@ -540,7 +539,7 @@ void chan_interrupt(struct line *line, int irq)
 	struct tty_port *port = &line->port;
 	struct chan *chan = line->chan_in;
 	int err;
-	char c;
+	u8 c;
 
 	if (!chan || !chan->ops->read)
 		goto out;
diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 25727ed648b7..40d98dd23c8a 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -19,7 +19,7 @@ void generic_close(int fd, void *unused)
 	close(fd);
 }
 
-int generic_read(int fd, char *c_out, void *unused)
+int generic_read(int fd, __u8 *c_out, void *unused)
 {
 	int n;
 
@@ -35,7 +35,7 @@ int generic_read(int fd, char *c_out, void *unused)
 
 /* XXX Trivial wrapper around write */
 
-int generic_write(int fd, const char *buf, int n, void *unused)
+int generic_write(int fd, const __u8 *buf, size_t n, void *unused)
 {
 	int err;
 
diff --git a/arch/um/drivers/chan_user.h b/arch/um/drivers/chan_user.h
index 4e51b85e2a23..e158e16fb3cc 100644
--- a/arch/um/drivers/chan_user.h
+++ b/arch/um/drivers/chan_user.h
@@ -7,6 +7,7 @@
 #define __CHAN_USER_H__
 
 #include <init.h>
+#include <linux/types.h>
 
 struct chan_opts {
 	void (*const announce)(char *dev_name, int dev);
@@ -19,8 +20,8 @@ struct chan_ops {
 	void *(*init)(char *, int, const struct chan_opts *);
 	int (*open)(int, int, int, void *, char **);
 	void (*close)(int, void *);
-	int (*read)(int, char *, void *);
-	int (*write)(int, const char *, int, void *);
+	int (*read)(int, __u8 *, void *);
+	int (*write)(int, const __u8 *, size_t, void *);
 	int (*console_write)(int, const char *, int);
 	int (*window_size)(int, void *, unsigned short *, unsigned short *);
 	void (*free)(void *);
@@ -31,8 +32,8 @@ extern const struct chan_ops fd_ops, null_ops, port_ops, pts_ops, pty_ops,
 	tty_ops, xterm_ops;
 
 extern void generic_close(int fd, void *unused);
-extern int generic_read(int fd, char *c_out, void *unused);
-extern int generic_write(int fd, const char *buf, int n, void *unused);
+extern int generic_read(int fd, __u8 *c_out, void *unused);
+extern int generic_write(int fd, const __u8 *buf, size_t n, void *unused);
 extern int generic_console_write(int fd, const char *buf, int n);
 extern int generic_window_size(int fd, void *unused, unsigned short *rows_out,
 			       unsigned short *cols_out);
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index b98545f3edb5..c9403629cc56 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -83,7 +83,7 @@ unsigned int line_chars_in_buffer(struct tty_struct *tty)
  *
  * Must be called while holding line->lock!
  */
-static int buffer_data(struct line *line, const char *buf, int len)
+static int buffer_data(struct line *line, const u8 *buf, size_t len)
 {
 	int end, room;
 
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index e84fb9b4165e..e8bd6f3dfb50 100644
--- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -47,9 +47,9 @@ struct line {
 	 *
 	 * buffer points to a buffer allocated on demand, of length
 	 * LINE_BUFSIZE, head to the start of the ring, tail to the end.*/
-	char *buffer;
-	char *head;
-	char *tail;
+	u8 *buffer;
+	u8 *head;
+	u8 *tail;
 
 	int sigio;
 	struct delayed_work task;
diff --git a/arch/um/drivers/null.c b/arch/um/drivers/null.c
index 87087763a417..30d59b8481b4 100644
--- a/arch/um/drivers/null.c
+++ b/arch/um/drivers/null.c
@@ -28,7 +28,7 @@ static int null_open(int input, int output, int primary, void *d,
 	return (fd < 0) ? -errno : fd;
 }
 
-static int null_read(int fd, char *c_out, void *unused)
+static int null_read(int fd, __u8 *c_out, void *unused)
 {
 	return -ENODEV;
 }
-- 
2.43.0


