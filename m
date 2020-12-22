Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krhnS-0000pd-Vt
 for linux-um@lists.infradead.org; Tue, 22 Dec 2020 13:33:51 +0000
Date: Tue, 22 Dec 2020 15:34:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: kunit stopped working
Message-ID: <20201222133446.GG4077@smile.fi.intel.com>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <CABVgOSnGnFf_LUhcbPxDYYq8q1f3aC228k2kas8=uXMvwVORLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABVgOSnGnFf_LUhcbPxDYYq8q1f3aC228k2kas8=uXMvwVORLQ@mail.gmail.com>
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
To: David Gow <davidgow@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-um <linux-um@lists.infradead.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Johannes Berg <johannes@sipsolutions.net>, Guenter Roeck <linux@roeck-us.net>, KUnit Development <kunit-dev@googlegroups.com>

On Tue, Dec 22, 2020 at 03:26:24PM +0800, David Gow wrote:
> On Tue, Dec 22, 2020 at 9:43 AM David Gow <davidgow@google.com> wrote:
> > On Tue, Dec 22, 2020 at 4:02 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Dec 21, 2020 at 09:40:08PM +0200, Andy Shevchenko wrote:

...

> > > Guys, revert helps. I am open to test any solution you may propose, thanks!

...

> I'll send this out properly as a patch to kunit_tool: while I still
> think that the default console on UML shouldn't change, it probably
> makes sense for KUnit to not rely on the default.

Thanks for fast response. I have tested and answered to the patch.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

