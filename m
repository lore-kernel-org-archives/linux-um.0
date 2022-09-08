Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bg4.exmail.qq.com ([43.155.65.254])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWH3D-003Tbo-Pn
	for linux-um@lists.infradead.org; Thu, 08 Sep 2022 12:54:37 +0000
From: wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] um/kernel: fix repeated words in comments
Date: Thu,  8 Sep 2022 20:54:01 +0800
Message-Id: <20220908125401.28130-1-wangjianli@cdjrlc.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/um/kernel/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index e7c7b53a1435..91485119ae67 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -169,7 +169,7 @@ __uml_setup("iomem=", parse_iomem,
 );
 
 /*
- * This list is constructed in parse_iomem and addresses filled in in
+ * This list is constructed in parse_iomem and addresses filled in
  * setup_iomem, both of which run during early boot.  Afterwards, it's
  * unchanged.
  */
-- 
2.36.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

