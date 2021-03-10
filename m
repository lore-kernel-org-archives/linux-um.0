Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJuWs-006LgO-6b
 for linux-um@lists.infradead.org; Wed, 10 Mar 2021 08:49:22 +0000
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] uml: remove unneeded variable 'ret'
Date: Wed, 10 Mar 2021 16:49:08 +0800
Message-Id: <1615366148-5357-1-git-send-email-yang.lee@linux.alibaba.com>
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
To: jdike@addtoit.com
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>

Fix the following coccicheck warning:
./arch/um/drivers/hostaudio_kern.c:125:10-14: Unneeded variable: "mask".
Return "0" on line 131

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/drivers/hostaudio_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index d35d3f3..5b064d3 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -122,13 +122,11 @@ static ssize_t hostaudio_write(struct file *file, const char __user *buffer,
 static __poll_t hostaudio_poll(struct file *file,
 				struct poll_table_struct *wait)
 {
-	__poll_t mask = 0;
-
 #ifdef DEBUG
 	printk(KERN_DEBUG "hostaudio: poll called (unimplemented)\n");
 #endif
 
-	return mask;
+	return 0;
 }
 
 static long hostaudio_ioctl(struct file *file,
-- 
1.8.3.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

