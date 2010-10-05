Return-Path: <htejun@gmail.com>
Message-ID: <4CAAE077.9010500@gmail.com>
Date: Tue, 05 Oct 2010 10:23:19 +0200
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] um: ubd: Fix data corruption
References: <1285710456-4435-1-git-send-email-richard@nod.at> <20100928150000.f007f43e.akpm@linux-foundation.org> <201009290013.11332.richard@nod.at> <20100928225202.GA30352@foursquare.net> <4CA275CE.6060401@fusionio.com> <20100929012945.GA3324@foursquare.net> <4CA2CCC3.8010307@fusionio.com> <20100929063452.GA13290@foursquare.net> <4CAA02D0.7040901@gmail.com> <20101004195152.GA31583@foursquare.net>
In-Reply-To: <20101004195152.GA31583@foursquare.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Chris Frey <cdfrey@foursquare.net>
Cc: Jens Axboe <jaxboe@fusionio.com>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jdike@addtoit.com" <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "janjaap@bos.nl" <janjaap@bos.nl>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "syzop@vulnscan.org" <syzop@vulnscan.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 10/04/2010 09:51 PM, Chris Frey wrote:
> On Mon, Oct 04, 2010 at 06:37:36PM +0200, Tejun Heo wrote:
>> Hello, sorry about chiming in later.  I was off last week.
> 
> No problem, I'm eager to test patches to fix this.
> 
>> I think we're on the right track.  The problem with Jens' patch was
>> that it didn't consider the fact that blk_end_request() now internally
>> updates the current position of the request, so if restart happens
>> after some of part of the request is complete it will end up adding
>> the offsets multiple times.  I think slightly modifying it to track
>> the current position instead of offset should do it.  Chris, can you
>> please try the following patch and see whether the problem goes away?
> 
> Unfortunately, this patch does not fix it for me.  I applied your patch
> to kernel 2.6.35.5, and got the usual error:
> 
> EXT3-fs error (device ubda): ext3_lookup: deleted inode referenced: 566188
> 
> Lots of them, actually.

Hmmmm, can you please give a shot at the following one?  Thank you.

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 1bcd208..0435d21 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -163,6 +163,7 @@ struct ubd {
 	struct scatterlist sg[MAX_SG];
 	struct request *request;
 	int start_sg, end_sg;
+	sector_t rq_pos;
 };

 #define DEFAULT_COW { \
@@ -187,6 +188,7 @@ struct ubd {
 	.request =		NULL, \
 	.start_sg =		0, \
 	.end_sg =		0, \
+	.rq_pos =		0, \
 }

 /* Protected by ubd_lock */
@@ -1228,7 +1230,6 @@ static void do_ubd_request(struct request_queue *q)
 {
 	struct io_thread_req *io_req;
 	struct request *req;
-	sector_t sector;
 	int n;

 	while(1){
@@ -1239,12 +1240,12 @@ static void do_ubd_request(struct request_queue *q)
 				return;

 			dev->request = req;
+			dev->rq_pos = blk_rq_pos(req);
 			dev->start_sg = 0;
 			dev->end_sg = blk_rq_map_sg(q, req, dev->sg);
 		}

 		req = dev->request;
-		sector = blk_rq_pos(req);
 		while(dev->start_sg < dev->end_sg){
 			struct scatterlist *sg = &dev->sg[dev->start_sg];

@@ -1256,10 +1257,10 @@ static void do_ubd_request(struct request_queue *q)
 				return;
 			}
 			prepare_request(req, io_req,
-					(unsigned long long)sector << 9,
+					(unsigned long long)dev->rq_pos << 9,
 					sg->offset, sg->length, sg_page(sg));

-			sector += sg->length >> 9;
+			dev->rq_pos += sg->length >> 9;
 			n = os_write_file(thread_fd, &io_req,
 					  sizeof(struct io_thread_req *));
 			if(n != sizeof(struct io_thread_req *)){

