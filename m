Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzm40-008TMS-Mb
 for linux-um@lists.infradead.org; Tue, 21 Dec 2021 20:48:50 +0000
Message-ID: <5f104044649ec60ba93648e68c3df2183e032072.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virtio_uml: allow probing from devicetree
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 21 Dec 2021 21:48:26 +0100
In-Reply-To: <20211221090447.1567-1-vincent.whitchurch@axis.com>
References: <20211221090447.1567-1-vincent.whitchurch@axis.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Rob Herring <robh+dt@kernel.org>
Cc: kernel@axis.com, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, 2021-12-21 at 10:04 +0100, Vincent Whitchurch wrote:
> Allow the virtio_uml device to be probed from the devicetree so that
> sub-devices can be specified using the standard virtio bindings, for
> example:
> 
>   virtio@1 {
>     compatible = "virtio,uml";
>     socket-path = "i2c.sock";
>     virtio-device-id = <0x22>;
> 

Given this, maybe it should modify
Documentation/devicetree/bindings/virtio/virtio-device.yaml? Or actually
add a new Documentation/devicetree/bindings/virtio/uml.yaml I guess?

+Rob, because I'm not really into any of this.

Also, I'm not even sure we should/need to document the DT bits that are
basically only used for testing in the first place?

Code looks good to me.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

