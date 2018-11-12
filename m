Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x130.google.com ([2607:f8b0:4864:20::130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMHqw-0002uu-3s
 for linux-um@lists.infradead.org; Mon, 12 Nov 2018 19:26:31 +0000
Received: by mail-it1-x130.google.com with SMTP id w7-v6so14907006itd.1
 for <linux-um@lists.infradead.org>; Mon, 12 Nov 2018 11:26:18 -0800 (PST)
Subject: Re: New Patch series for the UBD Driver
From: Jens Axboe <axboe@kernel.dk>
References: <20181112174201.12290-1-anton.ivanov@cambridgegreys.com>
 <62f14981-9804-8fac-c3ec-b544a90751c3@kernel.dk>
 <58614d39-8c3b-4e8e-7b41-633bb52b533e@cambridgegreys.com>
 <880075e6-1032-fe4f-0001-085d7409eb54@kernel.dk>
 <b332d9d1-a5ee-c69f-fa3b-f5e0703c1153@cambridgegreys.com>
 <2b318d17-7fde-991b-fda4-271fde2a7db9@kernel.dk>
 <0e31d0a6-64f0-208e-bfc8-acd05db432f1@cambridgegreys.com>
 <b50be83c-8309-5068-b5bb-8dad89f24913@kernel.dk>
 <1d334c50-0f89-70e7-b6c7-fe0d719ed5df@cambridgegreys.com>
 <1e27868d-974b-9554-1010-a7e28a238479@kernel.dk>
Message-ID: <17fab2bf-416b-3c61-e5c6-d315fb9105b3@kernel.dk>
Date: Mon, 12 Nov 2018 12:26:15 -0700
MIME-Version: 1.0
In-Reply-To: <1e27868d-974b-9554-1010-a7e28a238479@kernel.dk>
Content-Language: en-US
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at, hch@lst.de

On 11/12/18 12:11 PM, Jens Axboe wrote:
> On 11/12/18 11:41 AM, Anton Ivanov wrote:
>>>> And hang. Let me try a few more times to see if I can get the spinlock
>>>> recursion and/or abort instead of hang case (they are more difficult to
>>>> reproduce).
>>> This shows exactly what I was talking about, you are trying to
>>> issue IO from irq/non-blocking context. If you look up the warning,
>>> that's exactly what it is telling you.
>>
>>
>> So why does this happen only in the case of an error? Why nothing is 
>> triggered in the OK path?
>>
>> After adding this flag I no longer get the  block/blk.h:439 The spinlock 
>> recursion and the other barfs are alive and well.
>>
>> Back to "what is that" - can I execute blk_update_request, 
>> __blk_mq_end_request, blk_mq_end_request out of an interrupt context?
>>
>> It seems that I can when error is BLK_STS_OK, but not when it is not.
> 
> Post a new stack trace with BLOCKING set. Of course you can call the end
> request functions from irq context, most drivers end up doing that. For
> OK and error.
> 
> There's something fundamentally wrong with your case, it might be reuse
> or something like that.

Took a quick look at your code, and a quick guess would be that your
discard completions are bad. For discard, initialize io_req->length
with -bio->bi_size >> 9. I think this is preventing your discard
completion from ended properly.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

