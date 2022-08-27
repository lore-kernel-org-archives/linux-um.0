Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bg4.exmail.qq.com ([43.155.65.254] helo=bg5.exmail.qq.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRyfw-00DMVk-67
	for linux-um@lists.infradead.org; Sat, 27 Aug 2022 16:28:50 +0000
From: Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] uml: Remove the initialization of statics to 0
Date: Sat, 27 Aug 2022 12:26:31 -0400
Message-Id: <20220827162631.20822-1-dengshaomin@cdjrlc.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org
Cc: Shaomin Deng <dengshaomin@cdjrlc.com>

It is always unnecessary to initialise statics to 0.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/um/kernel/umid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/umid.c b/arch/um/kernel/umid.c
index 8031a038eb58..72bc60ade347 100644
--- a/arch/um/kernel/umid.c
+++ b/arch/um/kernel/umid.c
@@ -9,7 +9,7 @@
 #include <os.h>
 
 /* Changed by set_umid_arg */
-static int umid_inited = 0;
+static int umid_inited;
 
 static int __init set_umid_arg(char *name, int *add)
 {
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

