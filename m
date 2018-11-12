Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMGMf-0003vM-Vv
 for linux-um@lists.infradead.org; Mon, 12 Nov 2018 17:51:11 +0000
Received: by mail-pl1-x636.google.com with SMTP id x21-v6so1962748pln.9
 for <linux-um@lists.infradead.org>; Mon, 12 Nov 2018 09:50:59 -0800 (PST)
Subject: Re: New Patch series for the UBD Driver
References: <20181112174201.12290-1-anton.ivanov@cambridgegreys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <62f14981-9804-8fac-c3ec-b544a90751c3@kernel.dk>
Date: Mon, 12 Nov 2018 10:50:56 -0700
MIME-Version: 1.0
In-Reply-To: <20181112174201.12290-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at, hch@lst.de

On 11/12/18 10:41 AM, anton.ivanov@cambridgegreys.com wrote:
> This is the revised patchset for the ubd driver. Known issues:
> 
> 1. If an error is returned to an operation different from READ/WRITE/SYNC
> the block subsystem goes south finishing with a crash. I have tried everything
> I can think of and whatever I could lift out of the loop and nbd driver. I do
> not think that the problem is in the ubd driver. I am lost here, Jens can you
> please give me a hand in handling the case when ubd_handler() gets an error in
> reply to a discard.

It would help if you showed a crash from doing that, and an example of
how you are doing that.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

