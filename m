Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp2.axis.com ([195.60.68.18])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUroi-00Gaz5-1A
 for linux-um@lists.infradead.org; Thu, 17 Mar 2022 15:13:34 +0000
Date: Thu, 17 Mar 2022 16:13:26 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [RFC v1 09/10] regulator: tps62864: add roadtest
Message-ID: <20220317151326.GA7832@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-10-vincent.whitchurch@axis.com>
 <YiuPvkQroV/WdFpx@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiuPvkQroV/WdFpx@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel@axis.com, devicetree@vger.kernel.org, linux-um@lists.infradead.org, shuah@kernel.org, brendanhiggins@google.com, linux-kselftest@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org

On Fri, Mar 11, 2022 at 06:06:54PM +0000, Mark Brown wrote:
> On Fri, Mar 11, 2022 at 05:24:44PM +0100, Vincent Whitchurch wrote:
> This looks like it could be useful, modulo the general concerns with
> mocking stuff.  I've not looked at the broader framework stuff in any
> meanigful way.

Thank you for having a look!

Here's a bit of background story about how I used this particular test,
which hopefully shows an example of where I've seen the benefits of
mocking hardware: 

When I wrote this tps6286x driver a while ago, I tested it as one
usually does, checking with i2cdump that the correct register values are
written, measuring the voltages with a multimeter, rising and repeating
with different devicetree properties, and so on.  (This framework didn't
exist at that point.)

Later, when preparing the driver for mainline submission, I wanted a
quick way to check that any changes or cleanups that I needed to do
during that process didn't invalidate all my and others' earlier
testing.  The easiest way to do that was to ensure that the driver
continued to write the same bits in the same registers when given the
same set of inputs and devicetree properties, and that is where I found
the mocking to be useful.

In this case where there is no external input, the testing could of
course have all been done manually with the real hardware, but there was
little reason to do so when the hardware was the one factor which had
not changed.  The abilitly to create multiple devices with different
devicetree properties (such as fast mode on/off) was a real time-saver
too.

> > +    @classmethod
> > +    def setUpClass(cls) -> None:
> > +        insmod("tps6286x-regulator")
> 
> Shouldn't this get figured out when the device gets created in DT (if it
> doesn't I guess the tests found a bug...)?

The system isn't set up to load modules automatically.  The reason for
this is to give the test cases full control of when the module is loaded
and unload, since the tests could want to load the module with specific
options.

Also, the framework splits up logs and shows errors that occurs during
each specific test if the tests fail, and this would become less useful
if all modules for all the devices in the devicetree get loaded on
startup when the devicetree is parsed and one of the modules failed to
load or crashed when loaded.

> 
> > +    def setUp(self) -> None:
> > +        self.driver = I2CDriver("tps6286x")
> > +        self.hw = Hardware("i2c")
> > +        self.hw.load_model(TPS62864)
> 
> This feels like there could be some syntactic sugar to say "create this
> I2C device" in one call?  In general a lot of the frameworkish stuff
> feels verbose.

Yes, I agree this could be simplified.  I think the
update_mock/reset_mock dance could also potentially be simplified with a
with statement.

Beyond that, yes, there is some boilerplate setup for each test to bind
the devices.  This can differ between drivers and subsystems so I'm not
sure how much could be shared, but I guess some of them could be
separated out into a internal function for this particular test.

> > +    def test_voltage(self) -> None:
> > +        with (
> > +            self.driver.bind(self.dts["normal"]),
> > +            PlatformDriver("reg-virt-consumer").bind(
> > +                "tps62864_normal_consumer"
> > +            ) as consumerdev,
> > +        ):
> > +            maxfile = consumerdev.path / "max_microvolts"
> > +            minfile = consumerdev.path / "min_microvolts"
> > +
> > +            write_int(maxfile, 1675000)
> > +            write_int(minfile, 800000)
> > +
> > +            mock = self.hw.update_mock()
> > +            mock.assert_reg_write_once(self, REG_CONTROL, 1 << 5)
> > +            mock.assert_reg_write_once(self, REG_VOUT1, 0x50)
> > +            mock.reset_mock()
> 
> Some comments about the assertations here would seem to be in order.
> It's not altogether clear what this is testing - it looks to be
> verifying that the regulator is enabled with the voltage set to 800mV
> mapping to 0x50 in VOUT1 but I'm not sure that the idle reader would
> pick that up.

Yes, I will add some comments.  I also made some of the bit fields use
constants in some of the other driver, that could be done here too.

> 
> > +            mV = 1000
> > +            data = [
> > +                (400 * mV, 0x00),
> > +                (900 * mV, 0x64),
> > +                (1675 * mV, 0xFF),
> > +            ]
> > +
> > +            for voltage, val in data:
> > +                write_int(minfile, voltage)
> > +                mock = self.hw.update_mock()
> > +                mock.assert_reg_write_once(self, REG_VOUT1, val)
> > +                mock.reset_mock()
> 
> For covering regulators in general (especially those like this that use
> the generic helpers) I'd be inclined to go through every single voltage
> that can be set which isn't so interesting for this driver with it's
> linear voltage control but more interesting for something that's not
> continuous.

That could be useful in some cases, but if going through all the
voltages in a loop requires that the test implement the exact same
voltage-to-bitfield conversion function as the driver, then the benefit
of that part of the test is unclear.  That's the reason why for example
the OPT3001 test uses known values from the datasheet rather than just
copying the conversion function in the driver to Python.

> I'd also put a cross check in that the voltage and enable
> state that's reported via the read interface in sysfs is the one that we
> think we've just set, that'd validate that the framework's model of
> what's going on matches both what the driver did to the "hardware" and
> what the running kernel thinks is going on so we're joined up top to
> bottom (for the regulator framework the read values come from the
> driver so it is actually covering the driver).

Makes sense, I can add that.

> This all feels like it could readily be factored out into a generic
> helper, much as the actual drivers are especially when they're more data
> driven.  Ideally with the ability to override the default I/O operations
> for things with sequences that need to be followed instead of just a
> bitfield to update.  Callbacks to validate enable state, voltage, mode
> and so on in the hardware.  If we did that then rather than open coding
> every single test for every single device we could approach things at
> the framework level and give people working on a given device a pile of
> off the shelf tests which are more likely to catch things that an
> individual driver author might've missed, it also avoids the test
> coverage being more laborious than writing the actual driver.

Things could certainly be factored out in the future, but I'm a bit wary
of attempting to do that when we have a test for only one regulator
driver, and a very minimal regulator driver at that.

> This does raise the questions I mentioned about how useful the testing
> really is of course, even more so when someone works out how to generate
> the data tables for the test and the driver from the same source, but
> that's just generally an issue for mocked tests at the conceptual level
> and clearly it's an approach that's fairly widely used and people get
> value from.

For the regulator drivers which are purely-data driven such as the ones
mostly implemented by setting the various fields in struct
regulator_desc along with the helpers in the framework, it could perhaps
be useful to implement kunit tests in the regulator subsystem which test
that using the various fields actually results in the expected
consumer-visible behaviour with the regulator API.

Then, for the indivudal drivers themselves, roadtests could cover things
like probe handling, functions implemented without using helpers, checks
that the correct variant's registers are used in drivers supporting
multiple variants, custom devicetree properties, interrupt handling, and
the like.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

