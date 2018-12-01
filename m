Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSvgP-0004zh-Nu
 for linux-um@lists.infradead.org; Sat, 01 Dec 2018 03:11:07 +0000
Received: by mail-pl1-f180.google.com with SMTP id u18so3693885plq.7
 for <linux-um@lists.infradead.org>; Fri, 30 Nov 2018 19:10:55 -0800 (PST)
Date: Fri, 30 Nov 2018 19:10:49 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
Message-ID: <20181201031049.GL28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com>
 <20181130032802.GG18410@garbanzo.do-not-panic.com>
 <CAFd5g45F0RViYDQyXRwyxVPAU=CO_Goqy3yHz=BbcMeAT7o6-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g45F0RViYDQyXRwyxVPAU=CO_Goqy3yHz=BbcMeAT7o6-g@mail.gmail.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Fri, Nov 30, 2018 at 06:08:36PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > > +static void kunit_run_case_internal(struct kunit *test,
> > > +                                 struct kunit_module *module,
> > > +                                 struct kunit_case *test_case)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (module->init) {
> > > +             ret = module->init(test);
> > > +             if (ret) {
> > > +                     kunit_err(test, "failed to initialize: %d", ret);
> > > +                     kunit_set_success(test, false);
> > > +                     return;
> > > +             }
> > > +     }
> > > +
> > > +     test_case->run_case(test);
> > > +}
> >
> > <-- snip -->
> >
> > > +static bool kunit_run_case(struct kunit *test,
> > > +                        struct kunit_module *module,
> > > +                        struct kunit_case *test_case)
> > > +{
> > > +     kunit_set_success(test, true);
> > > +
> > > +     kunit_run_case_internal(test, module, test_case);
> > > +     kunit_run_case_cleanup(test, module, test_case);
> > > +
> > > +     return kunit_get_success(test);
> > > +}
> >
> > So we are running the module->init() for each test case... is that
> > correct? Shouldn't the init run once? Also, typically init calls are
> 
> Yep, it's correct. `module->init()` should run once before every test
> case, reason being that the kunit_module serves as a test fixture in
> which each test cases should be run completely independently of every
> other.

Shouldn't the init be test_case specific as well? Right now we just
past the struct kunit, but not the struct kunit_case. I though that
that the struct kunit_case was where we'd customize each specific
test case as we see fit for each test case. If not, how would we
do say, a different type of initialization for a different type of
test (for the same unit)?

> init and exit is supposed to allow code common to all test
> cases to run since it is so common to have dependencies needed for a
> test to be common to every test case.

Sure things in common make sense, however the differntiating aspects
seem important as well on init? Or should the author be doing all
custom specific initializations on run_case() instead?

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

