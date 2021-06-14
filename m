Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsjDf-00DRSE-OG
 for linux-um@lists.infradead.org; Mon, 14 Jun 2021 09:49:25 +0000
Date: Mon, 14 Jun 2021 11:49:19 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] ubd: use blk_mq_alloc_disk and blk_cleanup_disk
Message-ID: <20210614094919.GA9501@lst.de>
References: <20210614060759.3965724-1-hch@lst.de>
 <20210614060759.3965724-3-hch@lst.de>
 <847f7608-1d11-1410-5394-b5aa5de9f45e@cambridgegreys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <847f7608-1d11-1410-5394-b5aa5de9f45e@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Christoph Hellwig <hch@lst.de>, Richard Weinberger <richard@nod.at>, Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org

On Mon, Jun 14, 2021 at 09:26:58AM +0100, Anton Ivanov wrote:
> This does not build for me when applied to master:

Yes, as mentioned in the cover letter it needs for-5.14/block branch
from here:

   git://git.kernel.dk/linux-block for-5.14/block

Gitweb:

   https://git.kernel.dk/cgit/linux-block/log/?h=for-5.14/block

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

