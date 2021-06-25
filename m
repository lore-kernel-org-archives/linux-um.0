Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwhIV-000OHf-Bo
 for linux-um@lists.infradead.org; Fri, 25 Jun 2021 08:34:48 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/4] um: virtio_uml: include linux/virtio-uml.h
Date: Fri, 25 Jun 2021 10:34:36 +0200
Message-Id: <20210625103437.d8dde80ec4c4.Icb63afa98dd3949f29f53325e9e1f2eb132749ae@changeid>
In-Reply-To: <20210625103436.900a9e962c32.Id45a0d2d0167dd9b6a067b42d791523896574064@changeid>
References: <20210625103436.900a9e962c32.Id45a0d2d0167dd9b6a067b42d791523896574064@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This fixes a sparse warning, since the function defined
here should have a declaration (or be static).

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 43c590cb8666 ("um: virtio/pci: enable suspend/resume")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 4412d6febade..cb79fe33d84e 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -27,6 +27,7 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
 #include <linux/time-internal.h>
+#include <linux/virtio-uml.h>
 #include <shared/as-layout.h>
 #include <irq_kern.h>
 #include <init.h>
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

