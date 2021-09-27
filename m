Return-Path: <mcgrof@infradead.org>
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 15/15] pd: add error handling support for add_disk()
Date: Mon, 27 Sep 2021 15:01:10 -0700
Message-Id: <20210927220110.1066271-16-mcgrof@kernel.org>
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
 drivers/block/paride/pd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 500b89a4bdaf..e59759bcf416 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -938,8 +938,12 @@ static int pd_probe_drive(struct pd_unit *disk, int autoprobe, int port,
 	if (ret)
 		goto put_disk;
 	set_capacity(disk->gd, disk->capacity);
-	add_disk(disk->gd);
+	ret = add_disk(disk->gd);
+	if (ret)
+		goto cleanup_disk;
 	return 0;
+cleanup_disk:
+	blk_cleanup_disk(disk->gd);
 put_disk:
 	put_disk(p);
 	disk->gd = NULL;
-- 
2.30.2


