Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxxF1-0093bQ-CL
 for linux-um@lists.infradead.org; Mon, 28 Jun 2021 19:48:24 +0000
Received: by mail-il1-x131.google.com with SMTP id s19so18590846ilj.1
 for <linux-um@lists.infradead.org>; Mon, 28 Jun 2021 12:48:21 -0700 (PDT)
Subject: Re: [PATCH] ubd: remove dead code in ubd_setup_common
References: <20210628093937.1325608-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <59dff238-e9aa-4de3-fa00-08d376f443a6@kernel.dk>
Date: Mon, 28 Jun 2021 13:48:22 -0600
MIME-Version: 1.0
In-Reply-To: <20210628093937.1325608-1-hch@lst.de>
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
To: Christoph Hellwig <hch@lst.de>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-block@vger.kernel.org

On 6/28/21 3:39 AM, Christoph Hellwig wrote:
> Remove some leftovers of the fake major number parsing that cause
> complains from some compilers.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

