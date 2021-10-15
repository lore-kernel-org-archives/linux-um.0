Return-Path: <mcgrof@infradead.org>
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/9] dm: add add_disk() error handling
Date: Fri, 15 Oct 2021 16:30:22 -0700
Message-Id: <20211015233028.2167651-4-mcgrof@kernel.org>
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

There are two calls to dm_setup_md_queue() which can fail then,
one on dm_early_create() and we can easily see that the error path
there calls dm_destroy in the error path. The other use case is on
the ioctl table_load case. If that fails userspace needs to call
the DM_DEV_REMOVE_CMD to cleanup the state - similar to any other
failure.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 245fa4153306..6d3265ed37c0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2086,7 +2086,9 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	if (r)
 		return r;
 
-	add_disk(md->disk);
+	r = add_disk(md->disk);
+	if (r)
+		return r;
 
 	r = dm_sysfs_init(md);
 	if (r) {
-- 
2.30.2


