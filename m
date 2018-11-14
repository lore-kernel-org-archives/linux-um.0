Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMx9u-0007DQ-RX
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 15:32:52 +0000
Date: Wed, 14 Nov 2018 16:32:37 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] um: Switch to block-mq constants in the UML UBD driver
Message-ID: <20181114153237.GA28669@lst.de>
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-2-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181113115947.19290-2-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com
Cc: axboe@kernel.dk, richard@nod.at, linux-um@lists.infradead.org, hch@lst.de

> +#define UBD_SECTOR_SIZE (1 << 9)

This can just use SECTOR_SIZE I guess.

> +			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
> +				__blk_mq_end_request(io_req->req, io_req->error);

The driver reall should be using blk_mq_end_request instead of playing
games with blk_update_request and __blk_mq_end_request.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

