Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1newag-0056SS-PY
 for linux-um@lists.infradead.org; Thu, 14 Apr 2022 10:20:45 +0000
Date: Thu, 14 Apr 2022 12:20:33 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [RFC v1 08/10] iio: light: vcnl4000: add roadtest
Message-ID: <20220414102033.GA13937@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-9-vincent.whitchurch@axis.com>
 <20220320170253.5b946c84@jic23-huawei>
 <20220405134805.GA28574@axis.com>
 <20220406140816.000038ce@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220406140816.000038ce@Huawei.com>
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
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "shuah@kernel.org" <shuah@kernel.org>, "brendanhiggins@google.com" <brendanhiggins@google.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Wed, Apr 06, 2022 at 03:08:16PM +0200, Jonathan Cameron wrote:
> On Tue, 5 Apr 2022 15:48:05 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> I messed around the other day with writing tests for
> drivers/staging/iio/cdc/ad7746.c and wasn't "too bad" and was useful for
> verifying some refactoring (and identified a possible precision problem
> in some integer approximation of floating point calcs)

Good to hear!

> I'll try and find time to flesh that test set out more in the near future and
> post it so you can see how bad my python is. It amused my wife if nothing
> else :)
> 
> However a future project is to see if I can use this to hook up the SPDM
> attestation stack via mctp over i2c - just because I like to live dangerously :)
> 
> For IIO use more generally we need a sensible path to SPI (and also platform
> drivers).

I have SPI working now.  I was able to do this without patching the
kernel by have the Python code emulate an SC18IS602 I2C-SPI bridge which
has an existing driver.  There is a limitation of 200 bytes per
transaction (in the SC18IS602 driver/chip) so not all SPI drivers will
work, but many will, and the underlying backend can be changed later
without having to change the test cases.  I used this to implement a
test for drivers/iio/adc/ti-adc084s021.c.

Platform devices are going to take more work.  I did do some experiments
(using arch/um/drivers/virt-pci.c) a while ago but I need to see how
well it works with the rest of the framework in place.

> For my day job I'd like to mess around with doing PCI devices
> as well.  The PCI DOE support for example would be nice to run against a
> test set that doesn't involve spinning up QEMU.
> DOE driver support:
> https://lore.kernel.org/all/20220330235920.2800929-1-ira.weiny@intel.com/
> 
> Effort wise, it's similar effort to hacking equivalent in QEMU but with the
> obvious advantage of being in tree and simpler for CI systems etc to use.
> 
> It would be nice to only have to use QEMU for complex system CI tests
> like the ones we are doing for CXL.
> 
> > 
> > > I dream of a world where every driver is testable by people with out hardware
> > > but I fear it may be a while yet.  Hopefully this will get us a little
> > > closer!
> > > 
> > > I more or less follow what is going on here (good docs btw in the earlier
> > > patch definitely helped).
> > > 
> > > So far I'm thoroughly in favour of road test subject to actually being
> > > able to review the tests or getting sufficient support to do so.
> > > It's a 'how to scale it' question really...  
> > 
> > Would rewriting the framework in C and forcing tests to be written in
> > that language mean that maintainers would be able to review tests
> > without external support?
> 
> I was wondering that.  If we stayed in python I think we'd definitely want
> someone to be the 'roadtester/tests' maintainer (or group of maintainers) 
> and their Ack to be expected for all tests we upstream.  Idea being they'd
> sanity check correct use of framework and just how bad the python code
> us C developers are writing is ;)
> 
> However, we'd still need a good chunk of that 'framework' use review even
> if doing this in C.

I think this is reasonable, especially for the first tests for each
subsystem where there will likely be support code and framework bits
missing.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

