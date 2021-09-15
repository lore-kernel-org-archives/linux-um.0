Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQZg3-009iGs-Nv
 for linux-um@lists.infradead.org; Wed, 15 Sep 2021 18:30:37 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 3/3] lib/logic_iomem: fix operation on 32-bit
Date: Wed, 15 Sep 2021 20:30:22 +0200
Message-Id: <20210915203022.b920529433fd.I13337df488004ef39e0c3a13e995451391e7b4ae@changeid>
In-Reply-To: <20210915203021.1454bd968b28.I160cb938058758bba3cb1968419314dbeb9dc004@changeid>
References: <20210915203021.1454bd968b28.I160cb938058758bba3cb1968419314dbeb9dc004@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

On 32-bit, the first entry might be at 0/NULL, but that's
strange and leads to issues, e.g. where we check "if (ret)".
Use a IOREMAP_BIAS/IOREMAP_MASK of 0x80000000UL to avoid
this. This then requires reducing the number of areas (via
MAX_AREAS), but we still have 128 areas, which is enough.

Fixes: ca2e334232b6 ("lib: add iomem emulation (logic_iomem)")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 lib/logic_iomem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/logic_iomem.c b/lib/logic_iomem.c
index 54fa601f3300..549b22d4bcde 100644
--- a/lib/logic_iomem.c
+++ b/lib/logic_iomem.c
@@ -21,15 +21,15 @@ struct logic_iomem_area {
 
 #define AREA_SHIFT	24
 #define MAX_AREA_SIZE	(1 << AREA_SHIFT)
-#define MAX_AREAS	((1ULL<<32) / MAX_AREA_SIZE)
+#define MAX_AREAS	((1U << 31) / MAX_AREA_SIZE)
 #define AREA_BITS	((MAX_AREAS - 1) << AREA_SHIFT)
 #define AREA_MASK	(MAX_AREA_SIZE - 1)
 #ifdef CONFIG_64BIT
 #define IOREMAP_BIAS	0xDEAD000000000000UL
 #define IOREMAP_MASK	0xFFFFFFFF00000000UL
 #else
-#define IOREMAP_BIAS	0
-#define IOREMAP_MASK	0
+#define IOREMAP_BIAS	0x80000000UL
+#define IOREMAP_MASK	0x80000000UL
 #endif
 
 static DEFINE_MUTEX(regions_mtx);
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

