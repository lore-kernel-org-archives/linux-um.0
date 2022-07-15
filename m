Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from [43.155.65.254] (helo=smtpbg.qq.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDPv4-00DJZ2-3b
	for linux-um@lists.infradead.org; Mon, 18 Jul 2022 12:32:19 +0000
From: Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] um: Fix comment typo
Date: Fri, 15 Jul 2022 12:29:38 +0800
Message-Id: <20220715042938.15291-1-wangborong@cdjrlc.com>
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
To: anton.ivanov@cambridgegreys.com
Cc: richard@nod.at, johannes@sipsolutions.net, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>

The double `in' is duplicated in line 172, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

