Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTb1V-001DqC-Ku
 for linux-um@lists.infradead.org; Tue, 06 Apr 2021 02:00:59 +0000
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] um: remove unused including <linux/version.h>
Date: Tue,  6 Apr 2021 10:00:50 +0800
Message-Id: <1617674450-121861-1-git-send-email-yang.lee@linux.alibaba.com>
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

Fix the following versioncheck warning:
./arch/um/drivers/vector_kern.c: 11 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/drivers/vector_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 47a02e6..d27a2a9 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2001 by various other people who didn't put their name here.
  */
 
-#include <linux/version.h>
 #include <linux/memblock.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-- 
1.8.3.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

