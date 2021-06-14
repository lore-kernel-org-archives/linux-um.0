Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] ubd: use blk_mq_alloc_disk and blk_cleanup_disk
Date: Mon, 14 Jun 2021 08:07:59 +0200
Message-Id: <20210614060759.3965724-3-hch@lst.de>
In-Reply-To: <20210614060759.3965724-1-hch@lst.de>
References: <20210614060759.3965724-1-hch@lst.de>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org

Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 44 ++++++++++++--------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index f508d45f7a69..0b86aa1b12f1 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -825,7 +825,6 @@ static void ubd_device_release(struct device *dev)
 {
 	struct ubd *ubd_dev = dev_get_drvdata(dev);
 
-	blk_cleanup_queue(ubd_dev->queue);
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 }
@@ -865,17 +864,12 @@ static const struct attribute_group *ubd_attr_groups[] = {
 	NULL,
 };
 
-static int ubd_disk_register(int major, u64 size, int unit,
-			     struct gendisk **disk_out)
+static void ubd_disk_register(int major, u64 size, int unit,
+			      struct gendisk *disk)
 {
-	struct gendisk *disk;
-
-	disk = alloc_disk(1 << UBD_SHIFT);
-	if(disk == NULL)
-		return -ENOMEM;
-
 	disk->major = major;
 	disk->first_minor = unit << UBD_SHIFT;
+	disk->minors = 1 << UBD_SHIFT;
 	disk->fops = &ubd_blops;
 	set_capacity(disk, size / 512);
 	sprintf(disk->disk_name, "ubd%c", 'a' + unit);
@@ -889,9 +883,6 @@ static int ubd_disk_register(int major, u64 size, int unit,
 	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_devs[unit].queue;
 	device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
-
-	*disk_out = disk;
-	return 0;
 }
 
 #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
@@ -903,6 +894,7 @@ static const struct blk_mq_ops ubd_mq_ops = {
 static int ubd_add(int n, char **error_out)
 {
 	struct ubd *ubd_dev = &ubd_devs[n];
+	struct gendisk *disk;
 	int err = 0;
 
 	if(ubd_dev->file == NULL)
@@ -927,32 +919,24 @@ static int ubd_add(int n, char **error_out)
 	if (err)
 		goto out;
 
-	ubd_dev->queue = blk_mq_init_queue(&ubd_dev->tag_set);
-	if (IS_ERR(ubd_dev->queue)) {
-		err = PTR_ERR(ubd_dev->queue);
+	disk = blk_mq_alloc_disk(&ubd_dev->tag_set, ubd_dev);
+	if (IS_ERR(disk)) {
+		err = PTR_ERR(disk);
 		goto out_cleanup_tags;
 	}
+	ubd_dev->queue = disk->queue;
 
-	ubd_dev->queue->queuedata = ubd_dev;
 	blk_queue_write_cache(ubd_dev->queue, true, false);
-
 	blk_queue_max_segments(ubd_dev->queue, MAX_SG);
 	blk_queue_segment_boundary(ubd_dev->queue, PAGE_SIZE - 1);
-	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, &ubd_gendisk[n]);
-	if(err){
-		*error_out = "Failed to register device";
-		goto out_cleanup_tags;
-	}
-
-	err = 0;
-out:
-	return err;
+	ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
+	ubd_gendisk[n] = disk;
+	return 0;
 
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
-	if (!(IS_ERR(ubd_dev->queue)))
-		blk_cleanup_queue(ubd_dev->queue);
-	goto out;
+out:
+	return err;
 }
 
 static int ubd_config(char *str, char **error_out)
@@ -1055,7 +1039,7 @@ static int ubd_remove(int n, char **error_out)
 	ubd_gendisk[n] = NULL;
 	if(disk != NULL){
 		del_gendisk(disk);
-		put_disk(disk);
+		blk_cleanup_disk(disk);
 	}
 
 	err = 0;
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

