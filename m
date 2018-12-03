Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTxx8-0005So-DU
 for linux-um@lists.infradead.org; Mon, 03 Dec 2018 23:48:39 +0000
Received: by mail-oi1-x241.google.com with SMTP id i6so12648064oia.6
 for <linux-um@lists.infradead.org>; Mon, 03 Dec 2018 15:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
In-Reply-To: <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 3 Dec 2018 15:48:15 -0800
Message-ID: <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
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
To: kieran.bingham@ideasonboard.com
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, Felix Guo <felixguoxiuping@gmail.com>, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mcgrof@kernel.org, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Thu, Nov 29, 2018 at 5:54 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Brendan,
>
> Thanks again for this series!
>
> On 28/11/2018 19:36, Brendan Higgins wrote:
> > The ultimate goal is to create minimal isolated test binaries; in the
> > meantime we are using UML to provide the infrastructure to run tests, so
> > define an abstract way to configure and run tests that allow us to
> > change the context in which tests are built without affecting the user.
> > This also makes pretty and dynamic error reporting, and a lot of other
> > nice features easier.
>
>
> I wonder if we could somehow generate a shared library object
> 'libkernel' or 'libumlinux' from a UM configured set of headers and
> objects so that we could create binary targets directly ?

That's an interesting idea. I think it would be difficult to figure
out exactly where to draw the line of what goes in there and what
needs to be built specific to a test a priori. Of course, that leads
into the biggest problem in general, needed to know what I need to
build to test the thing that I want to test.

Nevertheless, I could definitely imagine that being useful in a lot of cases.

> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > new file mode 100644
> > index 0000000000000..bba7ea7ca1869
> > --- /dev/null
> > +++ b/tools/testing/kunit/kunit_kernel.py
...
> > +     def make(self, jobs):
> > +             try:
> > +                     subprocess.check_output([
> > +                                     'make',
> > +                                     'ARCH=um',
> > +                                     '--jobs=' + str(jobs)])
>
> Perhaps as a future extension:
>
> It would be nice if we could set an O= here to keep the source tree
> pristine.
>
> In fact I might even suggest that this should always be set so that the
> unittesting could live along side an existing kernel build? :
>
>  O ?= $KBUILD_SRC/
>  O := $(O)/kunittest/$(ARCH)/build

I agree with that. It would be pretty annoying to run a unit test and
have it mess up your .config and force you to rebuild everything else.
(I have actually done this to myself a couple of times...)

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

