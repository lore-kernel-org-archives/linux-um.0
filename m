Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMxCu-0007ME-6E
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 15:35:57 +0000
Subject: Re: [PATCH 4/4] um: Add support for DISCARD in the UBD Driver
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-5-anton.ivanov@cambridgegreys.com>
 <20181114153028.GB28557@lst.de>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <2fc426a6-6bcb-b4a0-93af-ab7018669810@cambridgegreys.com>
Date: Wed, 14 Nov 2018 15:35:43 +0000
MIME-Version: 1.0
In-Reply-To: <20181114153028.GB28557@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, richard@nod.at, linux-um@lists.infradead.org

On 14/11/2018 15:30, Christoph Hellwig wrote:
> Discards are defined to be hints.  So if your fileystems return
> -EOPTNOTSUPP you just stop passing them to the file system and
> complete them from ->queue_rq.
Ack.
>
> Write Zeroes isn't.  So if you really want to support it you
> should manually write zeroes to the file as a fallback.

Hmm... Loop treats them as the same thing. I was looking at what they 
have done.

>   But do you
> have a real use case for Write Zeroes to start with?

I am not aware of.

There is a real case just for trim for now and I was using loop and nbd 
as a "guide" on what needs to be done. Loop has both DISCARD and ZERO.

Several other ops in the API looked interesting as well, but I have not 
seen them implemented anywhere so I skipped them for now.


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

