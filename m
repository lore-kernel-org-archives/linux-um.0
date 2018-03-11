Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 3/9] um/drivers/vector_user: Adjust an error message in
 user_init_socket_fds()
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <0ba0e9fa-9987-055a-c065-3f36a06d045d@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:18:08 +0100
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 13:53:08 +0100

* Adjust an error message at the end of this function.

* Delete the local variable "err" which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 037cd85ee424..9cc4651990e3 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -305,7 +305,6 @@ bool uml_tap_enable_vnet_headers(int fd)
 
 static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 {
-	int err = -ENOMEM;
 	int fd = -1, gairet;
 	struct addrinfo srchints;
 	struct addrinfo dsthints;
@@ -419,7 +418,7 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 cleanup:
 	if (gairesult != NULL)
 		freeaddrinfo(gairesult);
-	printk(UM_KERN_ERR "user_init_socket: init failed, error %d", err);
+
 	if (fd >= 0)
 		os_close_file(fd);
 	if (result != NULL) {
@@ -427,6 +426,8 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 			kfree(result->remote_addr);
 		kfree(result);
 	}
+
+	printk(UM_KERN_ERR "%s: init failed: %d", __func__, -ENOMEM);
 	return NULL;
 }
 
-- 
2.16.2


