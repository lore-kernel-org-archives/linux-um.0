Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 5/5] um: ubd: Improve size determinations in do_ubd_request()
References: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <8a539d85-ff17-296c-75be-913731c2febc@users.sourceforge.net>
Date: Wed, 18 Jan 2017 23:00:08 +0100
MIME-Version: 1.0
In-Reply-To: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jeff Dike <jdike@addtoit.com>, Jens Axboe <axboe@fb.com>, Richard Weinberger <richard@nod.at>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 22:38:04 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/ubd_kern.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6d686f735538..50327d5a9a01 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1386,8 +1386,7 @@ static void do_ubd_request(struct request_queue *q)
 		req = dev->request;
 
 		if (req_op(req) == REQ_OP_FLUSH) {
-			io_req = kmalloc(sizeof(struct io_thread_req),
-					 GFP_ATOMIC);
+			io_req = kmalloc(sizeof(*io_req), GFP_ATOMIC);
 			if (io_req == NULL) {
 				if (list_empty(&dev->restart))
 					list_add(&dev->restart, &restart);
@@ -1401,8 +1400,7 @@ static void do_ubd_request(struct request_queue *q)
 		while(dev->start_sg < dev->end_sg){
 			struct scatterlist *sg = &dev->sg[dev->start_sg];
 
-			io_req = kmalloc(sizeof(struct io_thread_req),
-					 GFP_ATOMIC);
+			io_req = kmalloc(sizeof(*io_req), GFP_ATOMIC);
 			if(io_req == NULL){
 				if(list_empty(&dev->restart))
 					list_add(&dev->restart, &restart);
-- 
2.11.0


