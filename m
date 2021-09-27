Return-Path: <mcgrof@infradead.org>
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 06/15] xtensa/platforms/iss/simdisk: add error handling support for add_disk()
Date: Mon, 27 Sep 2021 15:01:01 -0700
Message-Id: <20210927220110.1066271-7-mcgrof@kernel.org>
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
To: axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org, ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, chris.obbard@collabora.com, krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com, chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc: linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
List-ID: <linux-um.lists.infradead.org>

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/xtensa/platforms/iss/simdisk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 3cdfa00738e0..ad85c554cd45 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -259,6 +259,7 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 		struct proc_dir_entry *procdir)
 {
 	char tmp[2] = { '0' + which, 0 };
+	int err = -ENOMEM;
 
 	dev->fd = -1;
 	dev->filename = NULL;
@@ -267,7 +268,7 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 
 	dev->gd = blk_alloc_disk(NUMA_NO_NODE);
 	if (!dev->gd)
-		return -ENOMEM;
+		goto out;
 	dev->gd->major = simdisk_major;
 	dev->gd->first_minor = which;
 	dev->gd->minors = SIMDISK_MINORS;
@@ -275,10 +276,18 @@ static int __init simdisk_setup(struct simdisk *dev, int which,
 	dev->gd->private_data = dev;
 	snprintf(dev->gd->disk_name, 32, "simdisk%d", which);
 	set_capacity(dev->gd, 0);
-	add_disk(dev->gd);
+	err = add_disk(dev->gd);
+	if (err)
+		goto out_cleanup_disk;
 
 	dev->procfile = proc_create_data(tmp, 0644, procdir, &simdisk_proc_ops, dev);
+
 	return 0;
+
+out_cleanup_disk:
+	blk_cleanup_disk(dev->gd);
+out:
+	return err;
 }
 
 static int __init simdisk_init(void)
-- 
2.30.2


