Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvcp5-0007nf-4H
 for linux-um@lists.infradead.org; Thu, 08 Aug 2019 07:26:56 +0000
Message-ID: <1e988e1583b94761ba876827af24eede0c46ccf4.camel@sipsolutions.net>
Subject: Re: [RFC] um: virtio: Workaround for using virtio_net with snabb
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 08 Aug 2019 09:26:43 +0200
In-Reply-To: <394f11ad-88e3-1d1f-8b8e-51fdc14aea8d@cambridgegreys.com>
References: <20190731203030.29821-1-johannes@sipsolutions.net>
 <394f11ad-88e3-1d1f-8b8e-51fdc14aea8d@cambridgegreys.com>
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

On Wed, 2019-08-07 at 17:14 +0100, Anton Ivanov wrote:
  
> > +	/* TODO workaround for some implementations */
> > +	if (vu_dev->vdev.id.device == VIRTIO_ID_NET)
> > +		vu_dev->features &= ~BIT_ULL(VIRTIO_NET_F_CTRL_VQ) &
> > +				~BIT_ULL(VIRTIO_NET_F_MQ);
> 
> If it is needed only for some implementations, then it should be an option.

Yeah, I guess it should be. Then again, will anyone really even want to
use snabb? I don't know, perhaps, but perhaps it should just be fixed on
the snabb side? It stands to reason that regardless of what we do here,
it shouldn't just crash.

> Have you tried it vs let's say dpdk (IIRC it supports vhost_user as an 
> interface).

No, and we probably won't, we're not really particularly interested in
the network aspect of it. Trying it out here with existing device
implementations was really just for development, ultimately our plan is
to have our own device implementation(s) and driver(s). I'm hoping to
publish and upstream something that will let you run multiple UML
machines in "synchronized time travel" mode over vhost-user though.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

