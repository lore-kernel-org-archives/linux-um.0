Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc5Ob-006CUD-Dl
 for linux-um@lists.infradead.org; Wed, 06 Apr 2022 13:08:27 +0000
Date: Wed, 6 Apr 2022 14:08:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: Re: [RFC v1 08/10] iio: light: vcnl4000: add roadtest
Message-ID: <20220406140816.000038ce@Huawei.com>
In-Reply-To: <20220405134805.GA28574@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-9-vincent.whitchurch@axis.com>
 <20220320170253.5b946c84@jic23-huawei>
 <20220405134805.GA28574@axis.com>
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
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "shuah@kernel.org" <shuah@kernel.org>, "brendanhiggins@google.com" <brendanhiggins@google.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Tue, 5 Apr 2022 15:48:05 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> On Sun, Mar 20, 2022 at 06:02:53PM +0100, Jonathan Cameron wrote:
> > Very interesting bit of work. My current approach for similar testing
> > is to write a qemu model for the hardware, but that currently
> > requires carefully crafted tests. Most of the time I'm only doing
> > that to verify refactoring of existing drivers.   
> 
> Thank you for taking a look!
> 
> > One thing that makes me nervous here is the python element though
> > as I've not written significant python in about 20 years.
> > That is going to be a burden for kernel developers and maintainers...
> > Nothing quite like badly written tests to make for a mess in the long run
> > and I suspect my python for example would be very very badly written :)  
> 
> There's a bunch of static checkers to ensure that the code follows some
> basic guidelines, and CI can check that the tests work consistently, and
> also calculate metrics such as test execution time and code coverage, so
> even non-idiomatic Python in the tests wouldn't be entirely broken.
> 
> And unlike driver code, if the tests for a particular driver later do
> turn out to be bad (in what way?), we could just throw those particular
> tests out without breaking anybody's system.

True.  Though CI test triage folk may disagree ;)

> 
> > Cut and paste will of course get us a long way...  
> 
> Isn't some amount of copy/paste followed by modification to be expected
> even if the framework is written in say C (just as there's already
> copy/paste + modification involved when writing drivers)?
> 
> As for the core logic of individual driver tests excluding the framework
> bits, I have a hard time imagining what Python syntax looks like to
> someone with no knowledge of Python, so yes, I guess it's going to be
> harder to review.

I messed around the other day with writing tests for
drivers/staging/iio/cdc/ad7746.c and wasn't "too bad" and was useful for
verifying some refactoring (and identified a possible precision problem
in some integer approximation of floating point calcs)
I'll try and find time to flesh that test set out more in the near future and
post it so you can see how bad my python is. It amused my wife if nothing
else :)

However a future project is to see if I can use this to hook up the SPDM
attestation stack via mctp over i2c - just because I like to live dangerously :)

For IIO use more generally we need a sensible path to SPI (and also platform
drivers).  For my day job I'd like to mess around with doing PCI devices
as well.  The PCI DOE support for example would be nice to run against a
test set that doesn't involve spinning up QEMU.
DOE driver support:
https://lore.kernel.org/all/20220330235920.2800929-1-ira.weiny@intel.com/

Effort wise, it's similar effort to hacking equivalent in QEMU but with the
obvious advantage of being in tree and simpler for CI systems etc to use.

It would be nice to only have to use QEMU for complex system CI tests
like the ones we are doing for CXL.

> 
> > I dream of a world where every driver is testable by people with out hardware
> > but I fear it may be a while yet.  Hopefully this will get us a little
> > closer!
> > 
> > I more or less follow what is going on here (good docs btw in the earlier
> > patch definitely helped).
> > 
> > So far I'm thoroughly in favour of road test subject to actually being
> > able to review the tests or getting sufficient support to do so.
> > It's a 'how to scale it' question really...  
> 
> Would rewriting the framework in C and forcing tests to be written in
> that language mean that maintainers would be able to review tests
> without external support?

I was wondering that.  If we stayed in python I think we'd definitely want
someone to be the 'roadtester/tests' maintainer (or group of maintainers) 
and their Ack to be expected for all tests we upstream.  Idea being they'd
sanity check correct use of framework and just how bad the python code
us C developers are writing is ;)

However, we'd still need a good chunk of that 'framework' use review even
if doing this in C.

Anyhow, very promising bit of work.

Thanks,

Jonathan





_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

