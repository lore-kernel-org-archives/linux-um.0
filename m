Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1in1vx-0003VY-Ug
 for linux-um@lists.infradead.org; Thu, 02 Jan 2020 14:58:47 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 05/22] compat_ioctl: ubd, aoe: use blkdev_compat_ptr_ioctl
Date: Thu,  2 Jan 2020 15:55:23 +0100
Message-Id: <20200102145552.1853992-6-arnd@arndb.de>
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
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
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>, Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Daniel Walter <dwalter@google.com>, Alex Dewar <alex.dewar@gmx.co.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

These drivers implement the HDIO_GET_IDENTITY and CDROMVOLREAD ioctl
commands, which are compatible between 32-bit and 64-bit user space and
traditionally handled by compat_blkdev_driver_ioctl().

As a prerequisite to removing that function, make both drivers use
blkdev_compat_ptr_ioctl() as their .compat_ioctl callback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/drivers/ubd_kern.c | 1 +
 drivers/block/aoe/aoeblk.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6627d7c30f37..582eb5b1f09b 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -113,6 +113,7 @@ static const struct block_device_operations ubd_blops = {
         .open		= ubd_open,
         .release	= ubd_release,
         .ioctl		= ubd_ioctl,
+        .compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.getgeo		= ubd_getgeo,
 };
 
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index bd19f8af950b..7b32fb673375 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -329,6 +329,7 @@ static const struct block_device_operations aoe_bdops = {
 	.open = aoeblk_open,
 	.release = aoeblk_release,
 	.ioctl = aoeblk_ioctl,
+	.compat_ioctl = blkdev_compat_ptr_ioctl,
 	.getgeo = aoeblk_getgeo,
 	.owner = THIS_MODULE,
 };
-- 
2.20.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

