Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZDCn-00CXvl-78
 for linux-um@lists.infradead.org; Tue, 29 Mar 2022 14:52:22 +0000
Message-ID: <10ef3f98ccc8d7c545fec5e8a7a832194797a3d6.camel@sipsolutions.net>
Subject: Re: [RFC v1 07/10] iio: light: opt3001: add roadtest
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 29 Mar 2022 16:52:14 +0200
In-Reply-To: <5b39d572e619c812109af7a1b8028bfb8353efda.camel@sipsolutions.net>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-8-vincent.whitchurch@axis.com>
 <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
 <20220318154927.GA32172@axis.com>
 <1e61b0f21794e67fb4e87dc41fab90829d3c7cd6.camel@sipsolutions.net>
 <20220329144319.GA4474@axis.com>
 <5b39d572e619c812109af7a1b8028bfb8353efda.camel@sipsolutions.net>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "jic23@kernel.org" <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Tue, 2022-03-29 at 16:50 +0200, Johannes Berg wrote:
> > Or perhaps you are implying that hw/virtio/vhost-user-i2c* in QEMU are
> > not strictly needed?
> 
> I _thought_ that was the case, but honestly, that was just from reading
> about it, not looking at the code. Thinking about it though, I don't
> need special glue in UML, just passing the device ID on the command
> line? So not sure what they need the glue for. Looking at the code, it's
> not really much though? Not sure, I guess you need somebody more
> familiar with qemu here, sorry.
> 

So here
https://www.qemu.org/docs/master/system/devices/vhost-user.html#vhost-user-device

the docs say:

   These are simple stub devices that ensure the VirtIO device is
   visible to the guest. The code is mostly boilerplate although each
   device has a chardev option which specifies the ID of the --chardev
   device that connects via a socket to the vhost-user daemon.

So maybe if the ID were specified via the command line too, you could
have a generic vhost-user stub in qemu?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

