Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDFc0-0005Yp-SG
 for linux-um@lists.infradead.org; Thu, 18 Oct 2018 21:13:47 +0000
Received: by mail-it1-x143.google.com with SMTP id q70-v6so2067249itb.3
 for <linux-um@lists.infradead.org>; Thu, 18 Oct 2018 14:13:34 -0700 (PDT)
Subject: Re: [PATCH v2] ubd: remove use of blk_rq_map_sg
References: <20181018205503.6206-1-richard@nod.at>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <421b4db7-b4dc-cd0d-1744-fdfad732d92c@kernel.dk>
Date: Thu, 18 Oct 2018 15:13:31 -0600
MIME-Version: 1.0
In-Reply-To: <20181018205503.6206-1-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc: bvanassche@acm.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, hare@suse.de, anton.ivanov@cambridgegreys.com, Christoph Hellwig <hch@lst.de>, keescook@chromium.org

On 10/18/18 2:55 PM, Richard Weinberger wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> There is no good reason to create a scatterlist in the ubd driver,
> it can just iterate the request directly.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

