Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbjlH-001HqW-Id
 for linux-um@lists.infradead.org; Tue, 05 Apr 2022 14:02:25 +0000
Date: Tue, 5 Apr 2022 16:02:21 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [RFC v1 09/10] regulator: tps62864: add roadtest
Message-ID: <20220405140221.GC28574@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
 <20220311162445.346685-10-vincent.whitchurch@axis.com>
 <YiuPvkQroV/WdFpx@sirena.org.uk> <20220317151326.GA7832@axis.com>
 <YjN1ksNGujV611Ka@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YjN1ksNGujV611Ka@sirena.org.uk>
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

On Thu, Mar 17, 2022 at 05:53:22PM +0000, Mark Brown wrote:
> On Thu, Mar 17, 2022 at 04:13:26PM +0100, Vincent Whitchurch wrote:
> > On Fri, Mar 11, 2022 at 06:06:54PM +0000, Mark Brown wrote:
> 
> > > > +    @classmethod
> > > > +    def setUpClass(cls) -> None:
> > > > +        insmod("tps6286x-regulator")
> 
> > > Shouldn't this get figured out when the device gets created in DT (if it
> > > doesn't I guess the tests found a bug...)?
> 
> > The system isn't set up to load modules automatically.  The reason for
> > this is to give the test cases full control of when the module is loaded
> > and unload, since the tests could want to load the module with specific
> > options.
> 
> That seems like the uncommon case which could remove the module if it
> explicitly needed it.

Another reason was to get the tests to test module unloading since I've
seen a lot of especially new driver writers forget to test that, but I
realise that for most normal drivers that should be mostly covered by
the fact that we test device unbinding.

So I went ahead and implemented this and it seems to work.  As you
hinted earlier, this also means that the modalias stuff gets tested, and
as we know that's been broken in the recent past for a bunch of drivers,
so that's another advantage to automatic module loading, besides the
boilerplate reduction in the tests.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

