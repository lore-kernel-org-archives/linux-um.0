Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jL0m3-0006Yf-Qi
 for linux-um@lists.infradead.org; Sun, 05 Apr 2020 08:37:01 +0000
Received: by mail-pg1-x544.google.com with SMTP id m13so1984533pgd.8
 for <linux-um@lists.infradead.org>; Sun, 05 Apr 2020 01:36:59 -0700 (PDT)
From: Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] um: delete an unnecessary check before the kfree
Date: Sun,  5 Apr 2020 16:36:52 +0800
Message-Id: <20200405083652.29462-1-hqjagain@gmail.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: daniel@iogearbox.net, netdev@vger.kernel.org, linux-um@lists.infradead.org, ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>

NULL check before kfree is unnecessary so remove it.

This issue was detected by using the Coccinelle software.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
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
2.17.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

