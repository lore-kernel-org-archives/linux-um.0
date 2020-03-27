Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.21])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHunl-0000S2-76
 for linux-um@lists.infradead.org; Fri, 27 Mar 2020 19:37:58 +0000
From: Alex Dewar <alex.dewar@gmx.co.uk>
Subject: [PATCH] um: Remove some unnecessary NULL checks in vector_user.c
Date: Fri, 27 Mar 2020 19:36:25 +0000
Message-Id: <20200327193626.82329-1-alex.dewar@gmx.co.uk>
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Alex Dewar <alex.dewar@gmx.co.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

kfree() already checks for null pointers, so additional checking is
unnecessary.

Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
---
 arch/um/drivers/vector_user.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index ddcd917be0af..aa28e9eecb7b 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -221,8 +221,7 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	return result;
 tap_cleanup:
 	printk(UM_KERN_ERR "user_init_tap: init failed, error %d", fd);
-	if (result != NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }

@@ -266,8 +265,7 @@ static struct vector_fds *user_init_hybrid_fds(struct arglist *ifspec)
 	return result;
 hybrid_cleanup:
 	printk(UM_KERN_ERR "user_init_hybrid: init failed");
-	if (result != NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }

@@ -344,10 +342,8 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
 unix_cleanup:
 	if (fd >= 0)
 		os_close_file(fd);
-	if (remote_addr != NULL)
-		kfree(remote_addr);
-	if (result != NULL)
-		kfree(result);
+	kfree(remote_addr);
+	kfree(result);
 	return NULL;
 }

@@ -382,8 +378,7 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 	return result;
 raw_cleanup:
 	printk(UM_KERN_ERR "user_init_raw: init failed, error %d", err);
-	if (result != NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }

--
2.26.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

