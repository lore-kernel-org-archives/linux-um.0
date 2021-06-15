Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: cleanup ubd gendisk registration
References: <20210614060759.3965724-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <920a6605-f920-ef10-55a0-733219abee6b@kernel.dk>
Date: Tue, 15 Jun 2021 15:57:35 -0600
MIME-Version: 1.0
In-Reply-To: <20210614060759.3965724-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On 6/14/21 12:07 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series sits on top of Jens' for-5.14/block branch and tries to
> convert ubd to the new gendisk and request_queue registration helpers.
> As part of that I found that the ide emulation code currently registers
> two gendisk for a request_queue which leads to a bunch of problems we've
> avoided in other drivers (only the mmc subsystem has a similar issue).
> Given that the legacy IDE driver isn't practically used any more and
> modern userspace doesn't hard code specific block drivers, so I think
> we can just drop it.  Let me know if this is ok.

Applied, thanks.

-- 
Jens Axboe


