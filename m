Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hswUA-00026j-4k
 for linux-um@lists.infradead.org; Wed, 31 Jul 2019 21:50:15 +0000
Message-ID: <abd82ec5d08041b6b0abf0b269c75007f5350afa.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] um: drivers: Add virtio vhost-user driver
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 31 Jul 2019 23:50:07 +0200
In-Reply-To: <8b865316-76cc-bfe5-fef8-e0beb62851a0@cambridgegreys.com>
References: <20190731202942.29630-1-johannes@sipsolutions.net>
 <20190731202942.29630-2-johannes@sipsolutions.net>
 <d38496f6-5bce-806f-00a3-f2e054a8693b@cambridgegreys.com>
 <629ab0852570a591be87d854a557145cda47a96c.camel@sipsolutions.net>
 <8b865316-76cc-bfe5-fef8-e0beb62851a0@cambridgegreys.com>
MIME-Version: 1.0
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Erel Geron <erelx.geron@intel.com>

On Wed, 2019-07-31 at 22:23 +0100, Anton Ivanov wrote:
> 
> I am familiar. I was looking at it as one of the "common IO" options 
> early on, but decided to go for sendmmsg/recvmmsg vector IO instead.

Sure, the vector IO is nice for netdevs :-) But I'm looking to add some
other peripherals, some of which I won't upstream the drivers for
because it makes no sense if you don't have the device implementation,
so vhost-user made a lot of sense here, since I can use a common
mechanism for all of the stuff I want to do, and virtio_console is
probably one of the things - and already exists.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

