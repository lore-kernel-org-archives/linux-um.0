Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maF3v-00CRJp-Cl
 for linux-um@lists.infradead.org; Tue, 12 Oct 2021 10:31:12 +0000
Received: by mail-pg1-x534.google.com with SMTP id g184so13472159pgc.6
 for <linux-um@lists.infradead.org>; Tue, 12 Oct 2021 03:31:10 -0700 (PDT)
From: davidcomponentone@gmail.com
Subject: [PATCH v3] Fix application of sizeof to pointer
Date: Tue, 12 Oct 2021 18:30:54 +0800
Message-Id: <ba5d88fd5470e6c72bbb70a34068b9662a72d418.1634024019.git.davidcomponentone@gmail.com>
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
To: jdike@addtoit.com
Cc: joe@perches.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, davidcomponentone@gmail.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./arch/um/drivers/virt-pci.c:192:20-26:
ERROR: application of sizeof to pointer"
Using the "sizeof(buf->data)" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 arch/um/drivers/virt-pci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c08066633023..148fa7a15ee0 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -180,16 +180,14 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	};
 	/* buf->data is maximum size - we may only use parts of it */
 	struct um_pci_message_buffer *buf;
-	u8 *data;
 	unsigned long ret = ~0ULL;
 
 	if (!dev)
 		return ~0ULL;
 
 	buf = get_cpu_var(um_pci_msg_bufs);
-	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(buf->data, 0xff, sizeof(buf->data));
 
 	switch (size) {
 	case 1:
@@ -204,22 +202,22 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		goto out;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buf->data, 8))
 		goto out;
 
 	switch (size) {
 	case 1:
-		ret = data[0];
+		ret = buf->data[0];
 		break;
 	case 2:
-		ret = le16_to_cpup((void *)data);
+		ret = le16_to_cpup((void *)buf->data);
 		break;
 	case 4:
-		ret = le32_to_cpup((void *)data);
+		ret = le32_to_cpup((void *)buf->data);
 		break;
 #ifdef CONFIG_64BIT
 	case 8:
-		ret = le64_to_cpup((void *)data);
+		ret = le64_to_cpup((void *)buf->data);
 		break;
 #endif
 	default:
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

