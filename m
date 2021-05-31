Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnYQs-00AZjy-Ec
 for linux-um@lists.infradead.org; Mon, 31 May 2021 03:17:40 +0000
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] um: Remove the repeated declaration
Date: Mon, 31 May 2021 11:17:07 +0800
Message-ID: <1622431027-4395-1-git-send-email-zhangshaokun@hisilicon.com>
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>

Function 'os_flush_stdout' is declared twice, so remove the
repeated declaration.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/um/include/shared/os.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 13d86f94cf0f..a3f213f729b2 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -211,7 +211,6 @@ extern int os_protect_memory(void *addr, unsigned long len,
 extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
-extern void os_flush_stdout(void);
 extern int os_mincore(void *addr, unsigned long len);
 
 /* execvp.c */
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

