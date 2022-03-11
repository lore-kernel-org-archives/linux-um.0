Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSjfK-00009e-Hr
 for linux-um@lists.infradead.org; Fri, 11 Mar 2022 18:07:04 +0000
Date: Fri, 11 Mar 2022 18:06:54 +0000
From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v1 09/10] regulator: tps62864: add roadtest
Message-ID: <YiuPvkQroV/WdFpx@sirena.org.uk>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-10-vincent.whitchurch@axis.com>
MIME-Version: 1.0
In-Reply-To: <20220311162445.346685-10-vincent.whitchurch@axis.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2841672343048883425=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-kernel@vger.kernel.org, kernel@axis.com, devicetree@vger.kernel.org, linux-um@lists.infradead.org, shuah@kernel.org, brendanhiggins@google.com, linux-kselftest@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org


--===============2841672343048883425==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MolxjZU9V35M/+dw"
Content-Disposition: inline


--MolxjZU9V35M/+dw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 11, 2022 at 05:24:44PM +0100, Vincent Whitchurch wrote:

This looks like it could be useful, modulo the general concerns with
mocking stuff.  I've not looked at the broader framework stuff in any
meanigful way.

> +    @classmethod
> +    def setUpClass(cls) -> None:
> +        insmod("tps6286x-regulator")

Shouldn't this get figured out when the device gets created in DT (if it
doesn't I guess the tests found a bug...)?

> +    def setUp(self) -> None:
> +        self.driver = I2CDriver("tps6286x")
> +        self.hw = Hardware("i2c")
> +        self.hw.load_model(TPS62864)

This feels like there could be some syntactic sugar to say "create this
I2C device" in one call?  In general a lot of the frameworkish stuff
feels verbose.

> +    def test_voltage(self) -> None:
> +        with (
> +            self.driver.bind(self.dts["normal"]),
> +            PlatformDriver("reg-virt-consumer").bind(
> +                "tps62864_normal_consumer"
> +            ) as consumerdev,
> +        ):
> +            maxfile = consumerdev.path / "max_microvolts"
> +            minfile = consumerdev.path / "min_microvolts"
> +
> +            write_int(maxfile, 1675000)
> +            write_int(minfile, 800000)
> +
> +            mock = self.hw.update_mock()
> +            mock.assert_reg_write_once(self, REG_CONTROL, 1 << 5)
> +            mock.assert_reg_write_once(self, REG_VOUT1, 0x50)
> +            mock.reset_mock()

Some comments about the assertations here would seem to be in order.
It's not altogether clear what this is testing - it looks to be
verifying that the regulator is enabled with the voltage set to 800mV
mapping to 0x50 in VOUT1 but I'm not sure that the idle reader would
pick that up.

> +            mV = 1000
> +            data = [
> +                (400 * mV, 0x00),
> +                (900 * mV, 0x64),
> +                (1675 * mV, 0xFF),
> +            ]
> +
> +            for voltage, val in data:
> +                write_int(minfile, voltage)
> +                mock = self.hw.update_mock()
> +                mock.assert_reg_write_once(self, REG_VOUT1, val)
> +                mock.reset_mock()

For covering regulators in general (especially those like this that use
the generic helpers) I'd be inclined to go through every single voltage
that can be set which isn't so interesting for this driver with it's
linear voltage control but more interesting for something that's not
continuous.  I'd also put a cross check in that the voltage and enable
state that's reported via the read interface in sysfs is the one that we
think we've just set, that'd validate that the framework's model of
what's going on matches both what the driver did to the "hardware" and
what the running kernel thinks is going on so we're joined up top to
bottom (for the regulator framework the read values come from the
driver so it is actually covering the driver).

This all feels like it could readily be factored out into a generic
helper, much as the actual drivers are especially when they're more data
driven.  Ideally with the ability to override the default I/O operations
for things with sequences that need to be followed instead of just a
bitfield to update.  Callbacks to validate enable state, voltage, mode
and so on in the hardware.  If we did that then rather than open coding
every single test for every single device we could approach things at
the framework level and give people working on a given device a pile of
off the shelf tests which are more likely to catch things that an
individual driver author might've missed, it also avoids the test
coverage being more laborious than writing the actual driver.

This does raise the questions I mentioned about how useful the testing
really is of course, even more so when someone works out how to generate
the data tables for the test and the driver from the same source, but
that's just generally an issue for mocked tests at the conceptual level
and clearly it's an approach that's fairly widely used and people get
value from.

--MolxjZU9V35M/+dw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrj70ACgkQJNaLcl1U
h9D1Rgf9Ftqa1fE0HqpChhmXg9bevuB0hQF8ey0T0Ypw/UorQPenedWbtt0/waZY
K8rGaxJFPJbpC26PeXga6PnVPe7rm+uJtKQe7kICGvkvdCzVfqEH6uNxUfMwPki3
zD2nhS1EvX7bB4NUDP8a3BgrFu8KWh6Npx2yj1cUKUoKFAPBhktCFs/wP5xfhvDV
16sVYMN3QInL8IERk5F+lJSZHHOqfyt0lu7hgW70d+GoAlix/NwXL67ezPMykft/
iyATJkFPB6KoBG2IChUzCFOzMN8KVfjXMCcl5JxOgSpER4jqMeDIbjTsv4uilzFf
LUaSWbjwsd5iJoc7O2UJ+5I6S6vUDA==
=X5TK
-----END PGP SIGNATURE-----

--MolxjZU9V35M/+dw--


--===============2841672343048883425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============2841672343048883425==--


