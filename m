Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA7II-004aDw-JC
 for linux-um@lists.infradead.org; Wed, 19 Jan 2022 09:30:20 +0000
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] um: Fix order of dtb unflatten/early init
Date: Wed, 19 Jan 2022 10:29:34 +0100
Message-ID: <20220119092934.5285-1-vincent.whitchurch@axis.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: kernel@axis.com, devicetree@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh@kernel.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Scan the tree for reserved memory before unflattening it.  As Rob
Herring said:
| These should be reversed. early_init_fdt_scan_reserved_mem() works on
| the flat tree. Reserved memory needs to be reserved before
| unflatten_device_tree() starts allocating memory. Though I imagine that
| doesn't really matter for UML.

Suggested-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/lkml/YeF%2FVbxo6fAt0WLp@robh.at.kernel.org/
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/kernel/dtb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index ca69d72025f3..484141b06938 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -25,8 +25,8 @@ void uml_dtb_init(void)
 		return;
 	}
 
-	unflatten_device_tree();
 	early_init_fdt_scan_reserved_mem();
+	unflatten_device_tree();
 }
 
 static int __init uml_dtb_setup(char *line, int *add)
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

