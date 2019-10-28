Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iP8ov-0004Q0-75
 for linux-um@lists.infradead.org; Mon, 28 Oct 2019 17:28:47 +0000
Received: by mail-io1-xd43.google.com with SMTP id 1so11624172iou.4
 for <linux-um@lists.infradead.org>; Mon, 28 Oct 2019 10:28:43 -0700 (PDT)
Subject: Re: [PATCH] um: Entrust re-queue to the upper layers
References: <20191028170543.27591-1-anton.ivanov@cambridgegreys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cbf155ee-6dce-8895-dd09-95a5c0e0b16c@kernel.dk>
Date: Mon, 28 Oct 2019 11:28:38 -0600
MIME-Version: 1.0
In-Reply-To: <20191028170543.27591-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, rrs@researchut.com, hch@lst.de

On 10/28/19 11:05 AM, Anton Ivanov wrote:
> Fixes crashes due to ubd requeue logic conflicting with the block-mq
> one.

First of all, great work getting this far! This is surely a bug.
Probably needs a Fixes entry, and a CC stable.

There are actually two cases that'll return an error here, and one is
global and the other is per-device. If the kmalloc() fails in
ubd_queue_one_vec(), we should be returning BLK_STS_RESOURCE. Didn't
look at the -EAGAIN part, but maybe that's a global resource as well
when it fails? If so, then both should return BLK_STS_RESOURCE. If not,
then that should return BLK_STS_DEV_RESOURCE, as your change did.

Hence if both are global, just make it:

if (ret < 0)
	res = BLK_STS_DEV_RESOURCE;

and if one is a per-device thing, then I'd make ubd_queue_one_vec()
return the BLK_STS_* type and propagate that down to the caller.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

