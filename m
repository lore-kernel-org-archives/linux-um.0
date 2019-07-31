Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hsvmv-0003BS-LU
 for linux-um@lists.infradead.org; Wed, 31 Jul 2019 21:05:34 +0000
Message-ID: <629ab0852570a591be87d854a557145cda47a96c.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] um: drivers: Add virtio vhost-user driver
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 31 Jul 2019 23:05:27 +0200
In-Reply-To: <d38496f6-5bce-806f-00a3-f2e054a8693b@cambridgegreys.com>
References: <20190731202942.29630-1-johannes@sipsolutions.net>
 <20190731202942.29630-2-johannes@sipsolutions.net>
 <d38496f6-5bce-806f-00a3-f2e054a8693b@cambridgegreys.com>
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

On Wed, 2019-07-31 at 21:50 +0100, Anton Ivanov wrote:

> Cool. I can have a look at it early next week.

Sounds good :-)

I'll be on vacation next week and the week after, but Erel can answer
questions better anyway since he wrote it :-)

Oh, not sure if you know, but qemu has a bunch of vhost-user device
implementations:
https://github.com/qemu/qemu/tree/master/contrib

I think Erel said he tested snabb (formerly snabbswitch?) and the qemu
vhost-user-blk, maybe vhost-user-input? Drivers are in the kernel
already, of course.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

