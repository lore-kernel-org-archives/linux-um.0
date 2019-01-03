Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1getKg-0007MR-7e
 for linux-um@lists.infradead.org; Thu, 03 Jan 2019 03:06:07 +0000
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] um: Remove duplicated include from vector_user.c
Date: Thu, 3 Jan 2019 03:12:41 +0000
Message-ID: <1546485161-142907-1-git-send-email-yuehaibing@huawei.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, YueHaibing <yuehaibing@huawei.com>
Cc: kernel-janitors@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/um/drivers/vector_user.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index d2c17dd..b3f7b3c 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -16,14 +16,12 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <sys/types.h>
 #include <sys/socket.h>
 #include <net/ethernet.h>
 #include <netinet/ip.h>
 #include <netinet/ether.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
-#include <sys/socket.h>
 #include <sys/wait.h>
 #include <sys/uio.h>
 #include <linux/virtio_net.h>
@@ -31,7 +29,6 @@
 #include <stdlib.h>
 #include <os.h>
 #include <um_malloc.h>
-#include <sys/uio.h>
 #include "vector_user.h"
 
 #define ID_GRE 0






_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

