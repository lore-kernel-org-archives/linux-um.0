Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0OGT-00GjcT-Mr
	for linux-um@lists.infradead.org; Sun, 12 Jun 2022 14:08:31 +0000
Received: by mail-wr1-f71.google.com with SMTP id n5-20020adf8b05000000b00219ece7272bso399483wra.8
        for <linux-um@lists.infradead.org>; Sun, 12 Jun 2022 07:08:24 -0700 (PDT)
Date: Sun, 12 Jun 2022 10:08:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220612065324-mutt-send-email-mst@kernel.org>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
 <20220610203029-mutt-send-email-mst@kernel.org>
 <726db8fdf6c7fc271a825badbf1b07a5eebe6d36.camel@sipsolutions.net>
MIME-Version: 1.0
In-Reply-To: <726db8fdf6c7fc271a825badbf1b07a5eebe6d36.camel@sipsolutions.net>
Content-Disposition: inline
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, kernel@axis.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 10:58:20AM +0200, Johannes Berg wrote:
> On Fri, 2022-06-10 at 20:34 -0400, Michael S. Tsirkin wrote:
> > 
> > Also fixes this commit:
> > 
> > commit 68f5d3f3b6543266b29e047cfaf9842333019b4c
> > Author: Johannes Berg <johannes.berg@intel.com>
> > Date:   Fri Mar 5 13:19:58 2021 +0100
> > 
> >     um: add PCI over virtio emulation driver
> 
> Hm, why? It worked before the harden change.

Worked on a specific hypervisor. It was out of spec though.

> > BTW Johannes I think you need to spec this device and get
> > an ID - what's the plan for that? Current hack of punting
> > this to userspace isn't really any good long term.
> 
> Yeah, agree, it dropped off my radar (and the process is a bit
> cumbersome IMHO).

Hmm.

So right the recommended way is:
post patch
open github issue
send an email requesting vote

I guess we can switch request for vote to the github issue
to streamline this a bit - do you think that will help?




> But I'm not quite sure what you mean wrt. "punting to userspace", here
> in the virt-pci code I'm punting to the Kconfig :-)
> 
> Did you just mix that up, or was there some additional userspace thing
> you're thinking of?

Right, I meant "punting it to the user".

> The only userspace thing I can think of it is in virtio_uml where you
> have the ID on the command-line, but that's because it implements the
> virtio device bus over vhost-user which doesn't have ID discoverability
> in the protocol. That could also be fixed I guess, but it's a bit of a
> chicken & egg problem, if you don't have the ID and discovering it were
> not supported, you'd end up with an unusable device unless you specified
> the ID, in which case you don't need to discover it...
> 
> johannes


So, please start by reserving an id.

-- 
MST


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

