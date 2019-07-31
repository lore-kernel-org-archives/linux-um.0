Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hsw49-0008Kf-IE
 for linux-um@lists.infradead.org; Wed, 31 Jul 2019 21:23:23 +0000
Subject: Re: [PATCH 2/2] um: drivers: Add virtio vhost-user driver
References: <20190731202942.29630-1-johannes@sipsolutions.net>
 <20190731202942.29630-2-johannes@sipsolutions.net>
 <d38496f6-5bce-806f-00a3-f2e054a8693b@cambridgegreys.com>
 <629ab0852570a591be87d854a557145cda47a96c.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <8b865316-76cc-bfe5-fef8-e0beb62851a0@cambridgegreys.com>
Date: Wed, 31 Jul 2019 22:23:11 +0100
MIME-Version: 1.0
In-Reply-To: <629ab0852570a591be87d854a557145cda47a96c.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Erel Geron <erelx.geron@intel.com>



On 31/07/2019 22:05, Johannes Berg wrote:
> On Wed, 2019-07-31 at 21:50 +0100, Anton Ivanov wrote:
> 
>> Cool. I can have a look at it early next week.
> 
> Sounds good :-)
> 
> I'll be on vacation next week and the week after, but Erel can answer
> questions better anyway since he wrote it :-)
> 
> Oh, not sure if you know, but qemu has a bunch of vhost-user device
> implementations:
> https://github.com/qemu/qemu/tree/master/contrib

I am familiar. I was looking at it as one of the "common IO" options 
early on, but decided to go for sendmmsg/recvmmsg vector IO instead.

> 
> I think Erel said he tested snabb (formerly snabbswitch?) and the qemu
> vhost-user-blk, maybe vhost-user-input? Drivers are in the kernel
> already, of course.

Cool.

> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

