Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZDAp-00CXkb-LH
 for linux-um@lists.infradead.org; Tue, 29 Mar 2022 14:50:21 +0000
Message-ID: <5b39d572e619c812109af7a1b8028bfb8353efda.camel@sipsolutions.net>
Subject: Re: [RFC v1 07/10] iio: light: opt3001: add roadtest
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 29 Mar 2022 16:50:09 +0200
In-Reply-To: <20220329144319.GA4474@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-8-vincent.whitchurch@axis.com>
 <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
 <20220318154927.GA32172@axis.com>
 <1e61b0f21794e67fb4e87dc41fab90829d3c7cd6.camel@sipsolutions.net>
 <20220329144319.GA4474@axis.com>
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

On Tue, 2022-03-29 at 16:43 +0200, Vincent Whitchurch wrote:
> 
> I'm aware of vhost-user, but AFAICS QEMU needs glue for each device type
> to be able to actually hook up vhost-user implementations to the devices
> it exposes to the guest via the virtio PCI device.  See e.g.
> hw/virtio/vhost-user-i2c-pci.c and hw/virtio/vhost-user-i2c.c in QEMU.

Oh, I wasn't aware of that.

> That is what I meant was missing for virtio-gpio, there seems to be an
> in-progress patch set for that here though:
>  https://lore.kernel.org/all/cover.1641987128.git.viresh.kumar@linaro.org/
> 
> Similarly, glue for something like arch/um/drivers/virt-pci.c does not
> exist in QEMU.
> 
> Or perhaps you are implying that hw/virtio/vhost-user-i2c* in QEMU are
> not strictly needed?

I _thought_ that was the case, but honestly, that was just from reading
about it, not looking at the code. Thinking about it though, I don't
need special glue in UML, just passing the device ID on the command
line? So not sure what they need the glue for. Looking at the code, it's
not really much though? Not sure, I guess you need somebody more
familiar with qemu here, sorry.

> > Wohoo! This makes me very happy, finally somebody else who uses it :-)
> 
> Yes, thanks for that feature, it works well to speed up tests and also
> has a knack for triggering race conditions (the RTC use-after-free for
> example).
> 
> Time travel however sometimes triggers some WARN_ONs from the core
> timekeeping code. I haven't seen them when running the test suites, but
> they show up if the system under UML is idle for several (wall time)
> seconds.  I haven't had a chance to investigate it further though, but I
> can dig up the splats if you are interested.

Oh, I haven't seen that, and I'm pretty sure I've had systems idle for
very long periods of time passing inside (think weeks) ...

So yeah, if you have some splats (ideally with corresponding kernel
configs), I'd be interested.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

