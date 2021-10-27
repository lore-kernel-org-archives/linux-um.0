Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfk1m-0058Nw-SU
 for linux-um@lists.infradead.org; Wed, 27 Oct 2021 14:35:44 +0000
From: Bixuan Cui <cuibixuan@linux.alibaba.com>
Subject: [PATCH -next] um: virt-pci: Fix application of sizeof to pointer
Date: Wed, 27 Oct 2021 22:35:35 +0800
Message-Id: <1635345335-33899-1-git-send-email-cuibixuan@linux.alibaba.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cuibixuan@linux.alibaba.com, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com

Fix noderef.cocci warning:
./arch/um/drivers/virt-pci.c:192:20-26: ERROR: application of sizeof
to pointer

Fixes: 4a22c4cebd61 ("um: virt-pci: don't do DMA from stack")
Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c080666..156af2f 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -189,7 +189,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(data, 0xff, sizeof(*data));
 
 	switch (size) {
 	case 1:
-- 
1.8.3.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

