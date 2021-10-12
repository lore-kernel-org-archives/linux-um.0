Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ma8OM-00BKFL-Ct
 for linux-um@lists.infradead.org; Tue, 12 Oct 2021 03:23:51 +0000
Received: by mail-pj1-x1034.google.com with SMTP id
 lk8-20020a17090b33c800b001a0a284fcc2so862417pjb.2
 for <linux-um@lists.infradead.org>; Mon, 11 Oct 2021 20:23:49 -0700 (PDT)
From: davidcomponentone@gmail.com
Subject: [PATCH virt-pci] Fix application of sizeof to pointer
Date: Tue, 12 Oct 2021 11:23:33 +0800
Message-Id: <20211012032333.184581-1-davidcomponentone@gmail.com>
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
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, davidcomponentone@gmail.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./arch/um/drivers/virt-pci.c:192:20-26:
ERROR: application of sizeof to pointer"
Using the "sizeof(buf->data)" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c08066633023..705275c5176c 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -189,7 +189,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(data, 0xff, sizeof(buf->data));
 
 	switch (size) {
 	case 1:
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

