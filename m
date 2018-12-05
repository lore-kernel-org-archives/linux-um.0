Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUgov-0007NI-BB
 for linux-um@lists.infradead.org; Wed, 05 Dec 2018 23:43:13 +0000
Received: by mail-ot1-x341.google.com with SMTP id f18so20347950otl.11
 for <linux-um@lists.infradead.org>; Wed, 05 Dec 2018 15:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com>
 <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
 <18814973-8f0a-4647-a097-fcc3dc0b3cd3@infradead.org>
 <CAFd5g475RK9v9X4qxmXwuHiPMOs05WrZAw6EJWNdVoAHQWguFQ@mail.gmail.com>
 <CAL_JsqL_PivQbrJFEusdKAy-2EQtKL3OHbmyYSK9bzuTOQegqA@mail.gmail.com>
In-Reply-To: <CAL_JsqL_PivQbrJFEusdKAy-2EQtKL3OHbmyYSK9bzuTOQegqA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 5 Dec 2018 15:42:46 -0800
Message-ID: <CAFd5g45-HGytAPTx7OQD8B0oAdLncDGSMMTyHCTtyobeUJ15AQ@mail.gmail.com>
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
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
To: Rob Herring <robh@kernel.org>
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mcgrof@kernel.org, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Tue, Dec 4, 2018 at 5:41 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 3, 2018 at 6:14 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 4:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > >
> > > On 11/28/18 12:56 PM, Rob Herring wrote:
> > > >> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > >> index ad3fcad4d75b8..f309399deac20 100644
> > > >> --- a/drivers/of/Kconfig
> > > >> +++ b/drivers/of/Kconfig
> > > >> @@ -15,6 +15,7 @@ if OF
> > > >>  config OF_UNITTEST
> > > >>         bool "Device Tree runtime unit tests"
> > > >>         depends on !SPARC
> > > >> +       depends on KUNIT
> > > > Unless KUNIT has depends, better to be a select here.
> > >
> > > That's just style or taste.  I would prefer to use depends
> > > instead of select, but that's also just my preference.
> >
> > I prefer depends too, but Rob is the maintainer here.
>
> Well, we should be consistent, not the follow the whims of each maintainer.

Sorry, I don't think that came out the way I meant it. I don't really
think we are consistent on this point across the kernel, and I don't
feel very strongly about the point, so I was just looking to follow
the path of least resistance. (I also just assumed Rob would keep us
consistent within drivers/of/.)

I figure if we are running unit tests from the test runner script or
from an automated system, you won't be hunting for dependencies for a
single test every time you want to run a test, so select doesn't make
it easier to configure in most imagined use cases.

KUNIT hypothetically should not depend on anything, so select should
be safe to use.

On the other hand, if we end up being wrong on this point and KUnit
gains widespread adoption, I would prefer not to be in a position
where I have to change a bunch of configs all over the kernel because
this example got copied and pasted.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

