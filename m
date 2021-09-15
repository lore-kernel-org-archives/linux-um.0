Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQZg3-009iGt-PR
 for linux-um@lists.infradead.org; Wed, 15 Sep 2021 18:30:37 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 1/3] um: virt-pci: fix 32-bit compile
Date: Wed, 15 Sep 2021 20:30:20 +0200
Message-Id: <20210915203021.1454bd968b28.I160cb938058758bba3cb1968419314dbeb9dc004@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>, Al Viro <viro@zeniv.linux.org.uk>

From: Johannes Berg <johannes.berg@intel.com>

There were a few 32-bit compile warnings that of course
turned into errors with -Werror, fix the 32-bit build.

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virt-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c08066633023..0ab58016db22 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -181,15 +181,15 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	/* buf->data is maximum size - we may only use parts of it */
 	struct um_pci_message_buffer *buf;
 	u8 *data;
-	unsigned long ret = ~0ULL;
+	unsigned long ret = ULONG_MAX;
 
 	if (!dev)
-		return ~0ULL;
+		return ULONG_MAX;
 
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(buf->data, 0xff, sizeof(buf->data));
 
 	switch (size) {
 	case 1:
@@ -304,7 +304,7 @@ static unsigned long um_pci_bar_read(void *priv, unsigned int offset,
 	/* buf->data is maximum size - we may only use parts of it */
 	struct um_pci_message_buffer *buf;
 	u8 *data;
-	unsigned long ret = ~0ULL;
+	unsigned long ret = ULONG_MAX;
 
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

