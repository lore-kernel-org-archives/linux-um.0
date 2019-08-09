Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvzBa-0000hX-5i
 for linux-um@lists.infradead.org; Fri, 09 Aug 2019 07:19:39 +0000
Message-ID: <1db90d466d11b5cb8b379c05efb885e0816195dc.camel@sipsolutions.net>
Subject: Re: [RFC] um: virtio: Workaround for using virtio_net with snabb
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 09 Aug 2019 09:19:27 +0200
In-Reply-To: <36928187-8013-9e25-3ff8-a7a0962c8274@cambridgegreys.com>
References: <20190731203030.29821-1-johannes@sipsolutions.net>
 <394f11ad-88e3-1d1f-8b8e-51fdc14aea8d@cambridgegreys.com>
 <1e988e1583b94761ba876827af24eede0c46ccf4.camel@sipsolutions.net>
 <36928187-8013-9e25-3ff8-a7a0962c8274@cambridgegreys.com>
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

On Thu, 2019-08-08 at 08:56 +0100, Anton Ivanov wrote:

> However, a cursory search shows these being turned off in a few other 
> cases as well including vs some DPDK based software.
> 
> So snabb is not alone having issues with MQ and VQ flags.

Oh. I hadn't really researched it much more.

> > > Have you tried it vs let's say dpdk (IIRC it supports vhost_user as an
> > > interface).
> > 
> > No, and we probably won't, we're not really particularly interested in
> > the network aspect of it. Trying it out here with existing device
> > implementations was really just for development, ultimately our plan is
> > to have our own device implementation(s) and driver(s). 
> 
> Understood, however for it to be upstreamed it should work with 
> something else which is publicly available. That is why I am going to 
> try it vs Bess/DPDK (it is also lowest effort for me as I already have 
> that set-up).

True. Erel tried some of the samples from qemu contrib as well as snabb.
But if you have a DPDK setup then that's certainly an interesting option
to try, one that would likely also be useful for others to use this
with.

If needed, we can respin this as a real patch to add options to the
command line, I suppose.

> > I'm hoping to
> > publish and upstream something that will let you run multiple UML
> > machines in "synchronized time travel" mode over vhost-user though.
> 
> vhost-user clock? Interesting idea.

I'm on vacation right now, but once I'm back I'll start looking into
that. Not sure how to really tie that in though since it needs the idle
hook too, and that's arch specific. So I guess it just has to be
integrated with all the time-travel mode code, rather than being more
generic/separate.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

