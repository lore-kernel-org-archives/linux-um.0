Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXD7q-00Fc5W-Tf
	for linux-um@lists.infradead.org; Sun, 11 Sep 2022 02:55:16 +0000
From: Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH -next] um: virt-pci: add __init/__exit annotations to module init/exit funcs
Date: Sun, 11 Sep 2022 10:51:40 +0800
Message-ID: <20220911025140.22193-1-xiujianfeng@huawei.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, mst@redhat.com, vincent.whitchurch@axis.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 arch/um/drivers/virt-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 027847023184..acb55b302b14 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -857,7 +857,7 @@ void *pci_root_bus_fwnode(struct pci_bus *bus)
 	return um_pci_fwnode;
 }
 
-static int um_pci_init(void)
+static int __init um_pci_init(void)
 {
 	int err, i;
 
@@ -940,7 +940,7 @@ static int um_pci_init(void)
 }
 module_init(um_pci_init);
 
-static void um_pci_exit(void)
+static void __exit um_pci_exit(void)
 {
 	unregister_virtio_driver(&um_pci_virtio_driver);
 	irq_domain_remove(um_pci_msi_domain);
-- 
2.17.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

