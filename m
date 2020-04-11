Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNJ1S-0004XM-Hj
 for linux-um@lists.infradead.org; Sat, 11 Apr 2020 16:30:23 +0000
Message-ID: <ba7b958fda7c42e10fded7b158e892e2dfb06494.camel@perches.com>
Subject: [trivial PATCH] um virtio: Neaten vu_err macro definition
From: Joe Perches <joe@perches.com>
Date: Sat, 11 Apr 2020 09:28:08 -0700
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
Cc: Erel Geron <erelx.geron@intel.com>, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

Defining a macro with ... and __VA_ARGS__ (without ##) can cause
compilation errors if a macro use does not have additional args.

Add ## to __VA_ARGS__ in the macro definition.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/um/drivers/virtio_uml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index be54d3..351aee5 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -74,7 +74,7 @@ struct virtio_uml_vq_info {
 
 extern unsigned long long physmem_size, highmem;
 
-#define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, __VA_ARGS__)
+#define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, ##__VA_ARGS__)
 
 /* Vhost-user protocol */
 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

