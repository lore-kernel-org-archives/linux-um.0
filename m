Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maBcF-00BiNY-VT
 for linux-um@lists.infradead.org; Tue, 12 Oct 2021 06:50:25 +0000
Received: by mail-pj1-x1035.google.com with SMTP id oa4so14271467pjb.2
 for <linux-um@lists.infradead.org>; Mon, 11 Oct 2021 23:50:23 -0700 (PDT)
From: davidcomponentone@gmail.com
Subject: [PATCH v2] Fix application of sizeof to pointer
Date: Tue, 12 Oct 2021 14:50:06 +0800
Message-Id: <17910246df3f6ea3b2ae790af543eefbcefe49a5.1634021064.git.davidcomponentone@gmail.com>
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
 arch/um/drivers/virt-pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c08066633023..9333edd71604 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -187,9 +187,8 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		return ~0ULL;
 
 	buf = get_cpu_var(um_pci_msg_bufs);
-	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(buf->data, 0xff, sizeof(buf->data));
 
 	switch (size) {
 	case 1:
@@ -204,22 +203,22 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
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

