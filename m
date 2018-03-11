Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 6/9] um/drivers/vector_user: Less checks in
 user_init_socket_fds() after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <a47f1d9b-f917-bb98-9872-fcae70e67ac3@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:21:44 +0100
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
Date: Sun, 11 Mar 2018 14:56:38 +0100

Two checks could be repeated by the user_init_socket_fds() function
during error handling even if the relevant properties can be determined
for the involved variables before by source code analysis.

* Adjust jump targets.

* Delete two sanity checks and a call of the function "kfree"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 2dee1e183387..4c265262a369 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -375,13 +375,13 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 			"socket_open : could not open socket, error = %d",
 			-errno
 		);
-		goto cleanup;
+		goto free_info;
 	}
 	if (bind(fd,
 		(struct sockaddr *) gairesult->ai_addr,
 		gairesult->ai_addrlen)) {
 		printk(UM_KERN_ERR L2TPV3_BIND_FAIL, errno);
-		goto cleanup;
+		goto close_file;
 	}
 
 	freeaddrinfo(gairesult);
@@ -403,7 +403,8 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 		result->remote_addr = uml_kmalloc(
 			gairesult->ai_addrlen, UM_GFP_KERNEL);
 		if (result->remote_addr == NULL)
-			goto cleanup;
+			goto free_result;
+
 		result->remote_addr_size = gairesult->ai_addrlen;
 		memcpy(
 			result->remote_addr,
@@ -413,16 +414,13 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 	}
 	freeaddrinfo(gairesult);
 	return result;
-cleanup:
-	freeaddrinfo(gairesult);
-
-	if (fd >= 0)
-		os_close_file(fd);
-	if (result != NULL) {
-		kfree(result->remote_addr);
-		kfree(result);
-	}
 
+free_result:
+	kfree(result);
+close_file:
+	os_close_file(fd);
+free_info:
+	freeaddrinfo(gairesult);
 	printk(UM_KERN_ERR "%s: init failed: %d", __func__, -ENOMEM);
 	return NULL;
 }
-- 
2.16.2


