Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZD4C-00CWa5-UO
 for linux-um@lists.infradead.org; Tue, 29 Mar 2022 14:43:31 +0000
Date: Tue, 29 Mar 2022 16:43:19 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [RFC v1 07/10] iio: light: opt3001: add roadtest
Message-ID: <20220329144319.GA4474@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-8-vincent.whitchurch@axis.com>
 <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
 <20220318154927.GA32172@axis.com>
 <1e61b0f21794e67fb4e87dc41fab90829d3c7cd6.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e61b0f21794e67fb4e87dc41fab90829d3c7cd6.camel@sipsolutions.net>
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
Cc: Brendan Higgins <brendanhiggins@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "jic23@kernel.org" <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Fri, Mar 18, 2022 at 09:09:02PM +0100, Johannes Berg wrote:
> On Fri, 2022-03-18 at 16:49 +0100, Vincent Whitchurch wrote:
> > - We use virtio-i2c and virtio-gpio and use virtio-uml which uses the
> >   vhost-user API to communicate from UML to the backend.  The latest
> >   version of QEMU has support for vhost-user-i2c, but vhost-user-gpio
> >   doesn't seem to have been merged yet, so work is needed on the QEMU
> >   side.  This will also be true for other buses in the future, if they
> >   are implemented with new virtio devices.
> > 
> > - For MMIO, UML has virtio-mmio which allows implementing any PCIe
> >   device (and by extension any platform device) outside of UML, but last
> >   I checked, upstream QEMU did not have something similar.
> 
> I think you have this a bit fuzzy.
> 
> The virtio_uml[.c] you speak of is the "bus" driver for virtio in UML.
> Obviously, qemu has support for virtio, so you don't need those bits.
> 
> Now, virtio_uml is actually the virtio (bus) driver inside the kernel,
> like you'd have virtio-mmio/virtio-pci in qemu. However, virtio_uml
> doesn't implement the devices in the hypervisor, where most qemu devices
> are implemented, but uses vhost-user to run the device implementation in
> a separate userspace. [1]
> 
> Now we're talking about vhost-user to talk to the device, and qemu
> supports this as well, in fact the vhost-user spec is part of qemu:
> https://git.qemu.org/?p=qemu.git;a=blob;f=docs/system/devices/vhost-user.rst;h=86128114fa3788a73679f0af38e141021087c828;hb=1d60bb4b14601e38ed17384277aa4c30c57925d3
> https://www.qemu.org/docs/master/interop/vhost-user.html
> 
> The docs on how to use it are here:
> https://www.qemu.org/docs/master/system/devices/vhost-user.html
> 
> So once you have a device implementation (regardless of whether it's for
> use with any of the virtio-i2c, arch/um/drivers/virt-pci.c, virtio-gpio,
> virtio-net, ... drivers) you can actually connect it to virtual machines
> running as UML or in qemu.

I'm aware of vhost-user, but AFAICS QEMU needs glue for each device type
to be able to actually hook up vhost-user implementations to the devices
it exposes to the guest via the virtio PCI device.  See e.g.
hw/virtio/vhost-user-i2c-pci.c and hw/virtio/vhost-user-i2c.c in QEMU.

That is what I meant was missing for virtio-gpio, there seems to be an
in-progress patch set for that here though:
 https://lore.kernel.org/all/cover.1641987128.git.viresh.kumar@linaro.org/

Similarly, glue for something like arch/um/drivers/virt-pci.c does not
exist in QEMU.

Or perhaps you are implying that hw/virtio/vhost-user-i2c* in QEMU are
not strictly needed?

> (Actually, that's not strictly true today since it's
> arch/um/drivers/virt-pci.c and I didn't get a proper device ID assigned
> etc since it was for experimentation, I guess if we make this more
> commonly used then we should move it to drivers/pci/controller/virtio-
> pci.c and actually specify it in the OASIS virtio spec., at the very
> least it'd have to be possible to compile this and lib/logic_iomem.c on
> x86, but that's possible. Anyway I think PCI(e) is probably low on your
> list of things ...)

PCI is not that interesting, no, but platform devices are.  I did some
experiments early on with arch/um/drivers/virt-pci.c and a corresponding
backend along with a simple PCI driver which probes all devicetree nodes
under it, and I was able to use this to get some platform drivers
working.

> 
> >  - Also, some paths in this driver needs a modification to be tested
> >    under roadtest.  It uses wait_event_timeout() with a fixed value, but
> >    we cannot guarantee that this constraint is met in the test
> >    environment since it depends on things like CPU load on the host.
> > 
> >    (Also, we use UML's "time travel" feature which essentially
> >    fast-forwards through idle time, so the constraint can never be met
> >    in practice.)
> 
> Wohoo! This makes me very happy, finally somebody else who uses it :-)

Yes, thanks for that feature, it works well to speed up tests and also
has a knack for triggering race conditions (the RTC use-after-free for
example).

Time travel however sometimes triggers some WARN_ONs from the core
timekeeping code. I haven't seen them when running the test suites, but
they show up if the system under UML is idle for several (wall time)
seconds.  I haven't had a chance to investigate it further though, but I
can dig up the splats if you are interested.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

