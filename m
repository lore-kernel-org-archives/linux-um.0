Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUuJY-00Gwwg-9B
 for linux-um@lists.infradead.org; Thu, 17 Mar 2022 17:53:34 +0000
Date: Thu, 17 Mar 2022 17:53:22 +0000
From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v1 09/10] regulator: tps62864: add roadtest
Message-ID: <YjN1ksNGujV611Ka@sirena.org.uk>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-10-vincent.whitchurch@axis.com>
 <YiuPvkQroV/WdFpx@sirena.org.uk> <20220317151326.GA7832@axis.com>
MIME-Version: 1.0
In-Reply-To: <20220317151326.GA7832@axis.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4730764275514576613=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-kernel@vger.kernel.org, kernel@axis.com, devicetree@vger.kernel.org, linux-um@lists.infradead.org, shuah@kernel.org, brendanhiggins@google.com, linux-kselftest@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org


--===============4730764275514576613==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3BInDUkmR9BH6QDl"
Content-Disposition: inline


--3BInDUkmR9BH6QDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2022 at 04:13:26PM +0100, Vincent Whitchurch wrote:
> On Fri, Mar 11, 2022 at 06:06:54PM +0000, Mark Brown wrote:

> > > +    @classmethod
> > > +    def setUpClass(cls) -> None:
> > > +        insmod("tps6286x-regulator")

> > Shouldn't this get figured out when the device gets created in DT (if it
> > doesn't I guess the tests found a bug...)?

> The system isn't set up to load modules automatically.  The reason for
> this is to give the test cases full control of when the module is loaded
> and unload, since the tests could want to load the module with specific
> options.

That seems like the uncommon case which could remove the module if it
explicitly needed it.

> Also, the framework splits up logs and shows errors that occurs during
> each specific test if the tests fail, and this would become less useful
> if all modules for all the devices in the devicetree get loaded on
> startup when the devicetree is parsed and one of the modules failed to
> load or crashed when loaded.

That sounds like stuff that would be covered already by normal boot
testing?

> > > +                write_int(minfile, voltage)
> > > +                mock = self.hw.update_mock()
> > > +                mock.assert_reg_write_once(self, REG_VOUT1, val)
> > > +                mock.reset_mock()

> > For covering regulators in general (especially those like this that use
> > the generic helpers) I'd be inclined to go through every single voltage
> > that can be set which isn't so interesting for this driver with it's
> > linear voltage control but more interesting for something that's not
> > continuous.

> That could be useful in some cases, but if going through all the
> voltages in a loop requires that the test implement the exact same
> voltage-to-bitfield conversion function as the driver, then the benefit
> of that part of the test is unclear.  That's the reason why for example
> the OPT3001 test uses known values from the datasheet rather than just
> copying the conversion function in the driver to Python.

That's just a generic problem with mocking though - ultimately you have
to type the same values into the mock and the driver somehow, it's just
a question of if you type in all the values or some of the values and if
you use the same format to type them in.  My inclination is to get
better coverage since it makes it more likely that the interesting cases
will be picked up, and you can make tests that do things like combine
multiple settings which might turn something up.

> > This all feels like it could readily be factored out into a generic
> > helper, much as the actual drivers are especially when they're more data
> > driven.  Ideally with the ability to override the default I/O operations
> > for things with sequences that need to be followed instead of just a
> > bitfield to update.  Callbacks to validate enable state, voltage, mode
> > and so on in the hardware.  If we did that then rather than open coding
> > every single test for every single device we could approach things at
> > the framework level and give people working on a given device a pile of
> > off the shelf tests which are more likely to catch things that an
> > individual driver author might've missed, it also avoids the test
> > coverage being more laborious than writing the actual driver.

> Things could certainly be factored out in the future, but I'm a bit wary
> of attempting to do that when we have a test for only one regulator
> driver, and a very minimal regulator driver at that.

My thinking here is that since the driver is so minimal and data driven
it's clear that any tests for it can also be generalised to cover at the
very least all similarly data driven drivers.

> > This does raise the questions I mentioned about how useful the testing
> > really is of course, even more so when someone works out how to generate
> > the data tables for the test and the driver from the same source, but
> > that's just generally an issue for mocked tests at the conceptual level
> > and clearly it's an approach that's fairly widely used and people get
> > value from.

> For the regulator drivers which are purely-data driven such as the ones
> mostly implemented by setting the various fields in struct
> regulator_desc along with the helpers in the framework, it could perhaps
> be useful to implement kunit tests in the regulator subsystem which test
> that using the various fields actually results in the expected
> consumer-visible behaviour with the regulator API.

> Then, for the indivudal drivers themselves, roadtests could cover things
> like probe handling, functions implemented without using helpers, checks
> that the correct variant's registers are used in drivers supporting
> multiple variants, custom devicetree properties, interrupt handling, and
> the like.

That would be the more obvious approach than roadtest, but that's what's
there in the patch I was reviewing so...  There is also the fact that
the external pattern for the operations is the same no matter if they're
for a simple data driven driver or one using custom ops so you should
really be able to get the core coverage for every driver set up in a way
that lets you plug in a model of how the I/O performing each operation
is expected to work and then have the framework crunch through
combinations of actions to make sure that all the corner cases check out.

--3BInDUkmR9BH6QDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIzdZEACgkQJNaLcl1U
h9B4rAf/ZpllSWKucbyOqwVRoPGzNotZ9RmGuzBTvHuM047iZNtftHLSpZBvc/tJ
aisx5jUAVHZjAUDPBcoboPOu2KBTUU+irzH6Kab2394Wp62uPH/FZ74fTTWCW6Po
KThSSPxuV6DZ/LeNXZFyVGAvR7++odTcXrUfWtbBpm1jut29th0on3LoHbh+QNrO
/YmSFNJRfgaD5PMyrteebEOn7ZRZT4W/dLLeV0oJUiEb1vv6h47H3yJiSOET3v2P
YU/J5eQwdovc6iiPkiXcrhdsf7pdpcLDlxertBVzqdJLrD26eMmOn9cSZfiTGwC4
ADj2eVE8IYCqR7V4BGqbRlircjsd4A==
=bHyi
-----END PGP SIGNATURE-----

--3BInDUkmR9BH6QDl--


--===============4730764275514576613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4730764275514576613==--


