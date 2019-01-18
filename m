Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVbS-0004i5-3F
 for linux-um@lists.infradead.org; Fri, 18 Jan 2019 14:58:39 +0000
Received: by mail-pg1-x542.google.com with SMTP id n2so6178812pgm.3
 for <linux-um@lists.infradead.org>; Fri, 18 Jan 2019 06:58:37 -0800 (PST)
Message-ID: <5c41e99b.1c69fb81.f240b.506a@mx.google.com>
Date: Fri, 18 Jan 2019 20:28:31 +0530
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Subject: [PATCH] um: Remove duplicate headers
MIME-Version: 1.0
Content-Disposition: inline
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, yuehaibing@huawei.com
Cc: brajeswar.linux@gmail.com, linux-um@lists.infradead.org, jrdr.linux@gmail.com, linux-kernel@vger.kernel.org

Remove sys/socket.h and sys/uio.h which are included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/um/drivers/vector_user.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index d2c17dd..c863921 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -23,7 +23,6 @@
 #include <netinet/ether.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
-#include <sys/socket.h>
 #include <sys/wait.h>
 #include <sys/uio.h>
 #include <linux/virtio_net.h>
@@ -31,7 +30,6 @@
 #include <stdlib.h>
 #include <os.h>
 #include <um_malloc.h>
-#include <sys/uio.h>
 #include "vector_user.h"
 
 #define ID_GRE 0
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

