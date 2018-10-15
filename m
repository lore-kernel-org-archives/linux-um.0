Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gByWd-0003Qx-IR
 for linux-um@lists.infradead.org; Mon, 15 Oct 2018 08:46:57 +0000
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
References: <20181015065637.1860-1-hch@lst.de> <4055590.4i3nx3fRmo@blindfold>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <933e2a33-1bad-f68b-ac52-485f80f3562e@cambridgegreys.com>
Date: Mon, 15 Oct 2018 09:46:40 +0100
MIME-Version: 1.0
In-Reply-To: <4055590.4i3nx3fRmo@blindfold>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-um@lists.infradead.org

On 10/15/18 9:40 AM, Richard Weinberger wrote:
> Christoph,
>
> [CC'ing also Anton, he improved the old driver a lot.]

I was just about to start testing it :)

>
> Anton, this patch is based on:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/?h=mq-conversions
Thanks. I remember an RFC patch going across the mailing list during the 
summer, but did not know where did this work get to.
>
> Am Montag, 15. Oktober 2018, 08:56:37 CEST schrieb Christoph Hellwig:
>> There is no good reason to create a scatterlist in the ubd driver,
>> it can just iterate the request directly.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>
>> Now that we have the blk-mq conversion something like the patch below
>> should help to simplify the driver even further.
> hm, this breaks UML.
> Every filesystem fails to mount.
>
> I did some very rough tests, it seems that the driver fails to read
> data correctly as soon the upper layer tries to get more than 4096 bytes
> at once out of the block device.
>
> IOW:
> dd if=/dev/ubda bs=4096 count=1 skip=0 2>/dev/null| md5sum -
> is good.
> As soon I set bs to something greater it returns garbage.
>
> Later this day I might have some cycles left to debug further.
I will have some time to look into this in the afternoon, but I have to 
have a look at the mq-conversions first.
> Thanks,
> //richard
>
>
>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

