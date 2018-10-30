Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lilium.sigma-star.at ([109.75.188.150])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHSgP-0002et-JC
 for linux-um@lists.infradead.org; Tue, 30 Oct 2018 11:59:42 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/4] um: Include sys/uio.h to have writev()
Date: Tue, 30 Oct 2018 12:58:11 +0100
Message-Id: <20181030115812.346-3-richard@nod.at>
In-Reply-To: <20181030115812.346-1-richard@nod.at>
References: <20181030115812.346-1-richard@nod.at>
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
Cc: Richard Weinberger <richard@nod.at>

sys/uio.h gives us writev(), otherwise the build might fail on
some systems.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/vector_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 3d8cdbdb4e66..07dc8904510b 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include <os.h>
 #include <um_malloc.h>
+#include <sys/uio.h>
 #include "vector_user.h"
 
 #define ID_GRE 0
-- 
2.19.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

