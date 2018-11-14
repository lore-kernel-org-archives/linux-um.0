Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMyXP-0005oa-TE
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 17:01:13 +0000
Received: by mail-it1-x142.google.com with SMTP id p11-v6so16665572itf.0
 for <linux-um@lists.infradead.org>; Wed, 14 Nov 2018 09:01:00 -0800 (PST)
Subject: Re: [PATCH 1/4] um: Switch to block-mq constants in the UML UBD driver
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-2-anton.ivanov@cambridgegreys.com>
 <20181114153237.GA28669@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <13420f0a-c4f7-d332-dc8d-fc498e737508@kernel.dk>
Date: Wed, 14 Nov 2018 10:00:57 -0700
MIME-Version: 1.0
In-Reply-To: <20181114153237.GA28669@lst.de>
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
To: Christoph Hellwig <hch@lst.de>, anton.ivanov@cambridgegreys.com
Cc: richard@nod.at, linux-um@lists.infradead.org

On 11/14/18 8:32 AM, Christoph Hellwig wrote:
>> +#define UBD_SECTOR_SIZE (1 << 9)
> 
> This can just use SECTOR_SIZE I guess.
> 
>> +			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
>> +				__blk_mq_end_request(io_req->req, io_req->error);
> 
> The driver reall should be using blk_mq_end_request instead of playing
> games with blk_update_request and __blk_mq_end_request.

It's doing partial completions though, so it can't use blk_mq_end_request()
directly. I guess it could sum it up and skip it in the loop, but honestly
I think this is cleaner then.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

