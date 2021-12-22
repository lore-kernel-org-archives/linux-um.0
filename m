Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzywu-009zIM-5i
 for linux-um@lists.infradead.org; Wed, 22 Dec 2021 10:34:22 +0000
Date: Wed, 22 Dec 2021 11:34:17 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] um: virtio_uml: allow probing from devicetree
Message-ID: <20211222103417.GB25135@axis.com>
References: <20211221090447.1567-1-vincent.whitchurch@axis.com>
 <5f104044649ec60ba93648e68c3df2183e032072.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5f104044649ec60ba93648e68c3df2183e032072.camel@sipsolutions.net>
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
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Rob Herring <robh+dt@kernel.org>, kernel <kernel@axis.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Dec 21, 2021 at 09:48:26PM +0100, Johannes Berg wrote:
> On Tue, 2021-12-21 at 10:04 +0100, Vincent Whitchurch wrote:
> > Allow the virtio_uml device to be probed from the devicetree so that
> > sub-devices can be specified using the standard virtio bindings, for
> > example:
> > 
> >   virtio@1 {
> >     compatible = "virtio,uml";
> >     socket-path = "i2c.sock";
> >     virtio-device-id = <0x22>;
> > 
> 
> Given this, maybe it should modify
> Documentation/devicetree/bindings/virtio/virtio-device.yaml? Or actually
> add a new Documentation/devicetree/bindings/virtio/uml.yaml I guess?
> 
> +Rob, because I'm not really into any of this.
> 
> Also, I'm not even sure we should/need to document the DT bits that are
> basically only used for testing in the first place?

I wasn't sure either, but Rob was OK with not documenting some other
bindings which are only used for testing[0], so I assumed that that
applied here too:

 [0] https://lore.kernel.org/all/5baa1ae6.1c69fb81.847f2.3ab1@mx.google.com/ 

Also, DT bindings are supposed to be generic and based on what the
hardware has, but here we have no hardware and something very Linux and
UML-specific.

> Code looks good to me.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

