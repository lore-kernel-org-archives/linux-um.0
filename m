Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRoA-0002LP-0c
 for linux-um@lists.infradead.org; Fri, 15 Feb 2019 00:56:51 +0000
Received: by mail-ot1-x342.google.com with SMTP id i20so13944563otl.0
 for <linux-um@lists.infradead.org>; Thu, 14 Feb 2019 16:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-19-brendanhiggins@google.com>
 <990bfc7d-dc5e-d8d3-c151-9b321ff2ac10@gmail.com>
 <CAFd5g45tOGgf_sKGYRC=fpnTBKGaG=8frbQdgZ3ZTkQFyTfP5A@mail.gmail.com>
 <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com>
In-Reply-To: <88fe0546-7850-5bb4-9673-b1aef2dccb3e@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 14 Feb 2019 16:56:34 -0800
Message-ID: <CAFd5g444f-FBq4x3U7BL-EY+bFxP0rsJhJ14=mjOi89PhMkURg@mail.gmail.com>
Subject: Re: [RFC v3 18/19] of: unittest: split out a couple of test cases
 from unittest
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
To: Frank Rowand <frowand.list@gmail.com>
Cc: brakmo@fb.com, dri-devel <dri-devel@lists.freedesktop.org>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>, "Bird," Timothy" <Tim.Bird@sony.com>, Kees Cook <keescook@google.com>," linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Feb 14, 2019 at 3:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 12/5/18 3:54 PM, Brendan Higgins wrote:
> > On Tue, Dec 4, 2018 at 2:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> Hi Brendan,
> >>
> >> On 11/28/18 11:36 AM, Brendan Higgins wrote:
> >>> Split out a couple of test cases that these features in base.c from the
> >>> unittest.c monolith. The intention is that we will eventually split out
> >>> all test cases and group them together based on what portion of device
> >>> tree they test.
> >>
> >> Why does splitting this file apart improve the implementation?
> >
> > This is in preparation for patch 19/19 and other hypothetical future
> > patches where test cases are split up and grouped together by what
> > portion of DT they test (for example the parsing tests and the
> > platform/device tests would probably go separate files as well). This
> > patch by itself does not do anything useful, but I figured it made
> > patch 19/19 (and, if you like what I am doing, subsequent patches)
> > easier to review.
>
> I do not see any value in splitting the devicetree tests into
> multiple files.
>
> Please help me understand what the benefits of such a split are.

Sorry, I thought it made sense in context of what I am doing in the
following patch. All I am trying to do is to provide an effective way
of grouping test cases. To be clear, the idea, assuming you agree, is
that we would follow up with several other patches like this one and
the subsequent patch, one which would pull out a couple test
functions, as I have done here, and another that splits those
functions up into a bunch of proper test cases.

I thought that having that many unrelated test cases in a single file
would just be a pain to sort through deal with, review, whatever.

This is not something I feel particularly strongly about, it is just
pretty atypical from my experience to have so many unrelated test
cases in a single file.

Maybe you would prefer that I break up the test cases first, and then
we split up the file as appropriate?

I just assumed that we would agree it would be way too much stuff for
a single file, so I went ahead and broke it up first, because I
thought it would make it easier to review in that order rather than
the other way around.

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

