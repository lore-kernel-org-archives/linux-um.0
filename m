Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyRgC-0004mZ-FM
 for linux-um@lists.infradead.org; Thu, 23 Jul 2020 03:13:57 +0000
From: Li Heng <liheng40@huawei.com>
Subject: [PATCH -next] um: Remove redundant NULL check
Date: Thu, 23 Jul 2020 11:15:16 +0800
Message-ID: <1595474116-3305-1-git-send-email-liheng40@huawei.com>
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
To: jdike@addtoit.com, richard@nod.at
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./arch/um/drivers/vector_user.c:403:2-7: WARNING: NULL check before some freeing functions is not needed.

Fixes: bc8f8e4e6e7a ("um: Add a generic "fd" vector transport")
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 arch/um/drivers/vector_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c4a0f26..e836d49 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -399,8 +399,7 @@ static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
 fd_cleanup:
 	if (fd >= 0)
 		os_close_file(fd);
-	if (result != NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }
 
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

