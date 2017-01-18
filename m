Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 4/5] um: ubd: Move two assignments for the variable "err" in
 ubd_remove()
References: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <be4864d2-53be-f8b9-52a0-17a3e0837910@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:59:23 +0100
MIME-Version: 1.0
In-Reply-To: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jeff Dike <jdike@addtoit.com>, Jens Axboe <axboe@fb.com>, Richard Weinberger <richard@nod.at>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:23:18 +0100

A local variable was set to an error code in two cases before a concrete
error situation was detected. Thus move the corresponding assignments into
if branches to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/ubd_kern.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 85410279beab..6d686f735538 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1049,19 +1049,21 @@ static int ubd_remove(int n, char **error_out)
 {
 	struct gendisk *disk = ubd_gendisk[n];
 	struct ubd *ubd_dev;
-	int err = -ENODEV;
+	int err;
 
 	mutex_lock(&ubd_lock);
 
 	ubd_dev = &ubd_devs[n];
-
-	if(ubd_dev->file == NULL)
+	if (!ubd_dev->file) {
+		err = -ENODEV;
 		goto out;
+	}
 
 	/* you cannot remove a open disk */
-	err = -EBUSY;
-	if(ubd_dev->count > 0)
+	if (ubd_dev->count > 0) {
+		err = -EBUSY;
 		goto out;
+	}
 
 	ubd_gendisk[n] = NULL;
 	if(disk != NULL){
-- 
2.11.0


