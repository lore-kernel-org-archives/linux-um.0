Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxtUJ-0000DB-FD
 for linux-um@lists.infradead.org; Wed, 14 Aug 2019 13:38:52 +0000
From: "Geron, ErelX" <erelx.geron@intel.com>
Subject: RE: [PATCH 2/2] um: drivers: Add virtio vhost-user driver
Date: Wed, 14 Aug 2019 13:38:45 +0000
Message-ID: <55F06090E0044C4F985D9B415677B33F4E42700B@HASMSX110.ger.corp.intel.com>
References: <20190731202942.29630-1-johannes@sipsolutions.net>
 <20190731202942.29630-2-johannes@sipsolutions.net>
 <aa0e9645-add5-0169-95d0-e11dc36dcfaa@cambridgegreys.com>
 <57a7df50-0a87-a8a6-7cd7-e4aa2ef35f1d@cambridgegreys.com>
 <3ffcf614-ce0e-949c-b0dd-49551866f7cf@cambridgegreys.com>
In-Reply-To: <3ffcf614-ce0e-949c-b0dd-49551866f7cf@cambridgegreys.com>
Content-Language: en-US
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>

Our config is based on defconfig.
Added CONFIG_VIRTIO_UML, CONFIG_VIRTIO_BLK and CONFIG_VIRTIO_NET.

Please note that we have two working examples:

One example is with qemu/contrib/vhost-user-blk:

# Prepare disk file
truncate -s 5120 my_file
# Run server
./vhost-user-blk -b my_file -s /tmp/my_blk
# Run uml
./linux ... virtio_uml.device=/tmp/my_blk:2

And another example is with snabb:

# Run server with two interconnected interfaces
# (need to add a vm2vm program, as shown at: https://github.com/snabbco/snabb/issues/1119)
./snabb vm2vm /tmp/first /tmp/second
# Run uml
./linux ... virtio_uml.device=/tmp/first:1
./linux ... virtio_uml.device=/tmp/second:1

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

