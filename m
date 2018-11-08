Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH] Fix breakage from switching to MQ BLK framework
References: <20181108130723.12101-1-anton.ivanov@cambridgegreys.com>
 <CAMuHMdXYOwiUP9L9WdrFKoiUisowOjwL0jDDZ6o_M-PTzXHjhg@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <b818bcc1-3c05-c124-4325-f7a74e5c5f80@cambridgegreys.com>
Date: Thu, 8 Nov 2018 13:24:28 +0000
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXYOwiUP9L9WdrFKoiUisowOjwL0jDDZ6o_M-PTzXHjhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-um.lists.infradead.org>


On 11/8/18 1:15 PM, Geert Uytterhoeven wrote:
> Hi Anton,
>
> On Thu, Nov 8, 2018 at 2:08 PM <anton.ivanov@cambridgegreys.com> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Initial version by Jens Axboe <axboe@kernel.dk>
>>
>> 1. Fix use of use unititalized req->error for SYNC commands
>> 2. Guard the request submission by a spinlock
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> ---
>>   arch/um/drivers/ubd_kern.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
>> index 74c002ddc0ce..e3d587d9eff6 100644
>> --- a/arch/um/drivers/ubd_kern.c
>> +++ b/arch/um/drivers/ubd_kern.c
>> @@ -1305,6 +1305,7 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>>                  io_req->fds[0] = dev->cow.fd;
>>          else
>>                  io_req->fds[0] = dev->fd;
>> +       io_req->error = 0;
> Perhaps it's safer to just use kzalloc() instead of kmalloc()?

That is one clear case where we would have never noticed the bug if we 
were using it :)

There are quite a few things set to zero by default so it may be worth it.

>
>>          if (req_op(req) == REQ_OP_FLUSH) {
>>                  io_req->op = UBD_FLUSH;
>> @@ -1313,9 +1314,7 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>>                  io_req->cow_offset = -1;
>>                  io_req->offset = off;
>>                  io_req->length = bvec->bv_len;
>> -               io_req->error = 0;
>>                  io_req->sector_mask = 0;
>> -
>>                  io_req->op = rq_data_dir(req) == READ ? UBD_READ : UBD_WRITE;
>>                  io_req->offsets[0] = 0;
>>                  io_req->offsets[1] = dev->cow.data_offset;
> Gr{oetje,eeting}s,
>
>                          Geert
>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


