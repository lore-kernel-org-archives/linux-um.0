Return-Path: <mcgrof@infradead.org>
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 7/9] um/drivers/ubd_kern: add error handling support for add_disk()
Date: Fri, 15 Oct 2021 16:30:26 -0700
Message-Id: <20211015233028.2167651-8-mcgrof@kernel.org>
In-Reply-To: <20211015233028.2167651-1-mcgrof@kernel.org>
References: <20211015233028.2167651-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, agk@redhat.com, snitzer@redhat.com, colyli@suse.de, kent.overstreet@gmail.com, boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org, roger.pau@citrix.com, geert@linux-m68k.org, ulf.hansson@linaro.org, tj@kernel.org, hare@suse.de, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, krisman@collabora.com, chris.obbard@collabora.com, thehajime@gmail.com, zhuyifei1999@gmail.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com, miquel.raynal@bootlin.com, vigneshr@ti.com, linux-mtd@lists.infradead.org
Cc: linux-scsi@vger.kernel.org, dm-devel@redhat.com, linux-bcache@vger.kernel.org, xen-devel@lists.xenproject.org, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
List-ID: <linux-um.lists.infradead.org>

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

ubd_disk_register() never returned an error, so just fix
that now and let the caller handle the error condition.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/um/drivers/ubd_kern.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index fefd343412c7..69d2d0049a61 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -855,8 +855,8 @@ static const struct attribute_group *ubd_attr_groups[] = {
 	NULL,
 };
 
-static void ubd_disk_register(int major, u64 size, int unit,
-			      struct gendisk *disk)
+static int ubd_disk_register(int major, u64 size, int unit,
+			     struct gendisk *disk)
 {
 	disk->major = major;
 	disk->first_minor = unit << UBD_SHIFT;
@@ -873,7 +873,7 @@ static void ubd_disk_register(int major, u64 size, int unit,
 
 	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_devs[unit].queue;
-	device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
+	return device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
 }
 
 #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
@@ -920,10 +920,15 @@ static int ubd_add(int n, char **error_out)
 	blk_queue_write_cache(ubd_dev->queue, true, false);
 	blk_queue_max_segments(ubd_dev->queue, MAX_SG);
 	blk_queue_segment_boundary(ubd_dev->queue, PAGE_SIZE - 1);
-	ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
+	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
+	if (err)
+		goto out_cleanup_disk;
+
 	ubd_gendisk[n] = disk;
 	return 0;
 
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
 out:
-- 
2.30.2


