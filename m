Return-Path: <linux-kernel-owner@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] um: Use common error handling code in port_listen_fd()
Message-ID: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
Date: Fri, 20 Oct 2017 19:29:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Oct 2017 19:24:39 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/port_user.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 9a8e1b64c22e..8d95fa5641af 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -118,29 +118,24 @@ int port_listen_fd(int port)
 		return -errno;
 
 	arg = 1;
-	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &arg, sizeof(arg)) < 0) {
-		err = -errno;
-		goto out;
-	}
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &arg, sizeof(arg)) < 0)
+		goto failure_indication;
 
 	addr.sin_family = AF_INET;
 	addr.sin_port = htons(port);
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
-	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = -errno;
-		goto out;
-	}
-
-	if (listen(fd, 1) < 0) {
-		err = -errno;
-		goto out;
-	}
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0 ||
+	    listen(fd, 1) < 0)
+		goto failure_indication;
 
 	err = os_set_fd_block(fd, 0);
 	if (err < 0)
 		goto out;
 
 	return fd;
+
+ failure_indication:
+	err = -errno;
  out:
 	close(fd);
 	return err;
-- 
2.14.2


