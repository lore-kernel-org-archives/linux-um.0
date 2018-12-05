Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUgK5-0003ZZ-Qu
 for linux-um@lists.infradead.org; Wed, 05 Dec 2018 23:11:19 +0000
Received: by mail-oi1-x242.google.com with SMTP id t204so19091113oie.7
 for <linux-um@lists.infradead.org>; Wed, 05 Dec 2018 15:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <f34ee937-83d6-3ff6-12b3-c6cd9acbfc38@gmail.com>
 <CAL_JsqL0t_p8=Ueq4mHS5i2YEQdc7S7AtPWfkcOsj1g2SixUkA@mail.gmail.com>
In-Reply-To: <CAL_JsqL0t_p8=Ueq4mHS5i2YEQdc7S7AtPWfkcOsj1g2SixUkA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 5 Dec 2018 15:10:50 -0800
Message-ID: <CAFd5g47cDKSdXGAL8pbDxEU2O8A-9Ajq1wCM+PtPF40T4wYKow@mail.gmail.com>
Subject: Re: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mcgrof@kernel.org, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Tue, Dec 4, 2018 at 5:49 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 5:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > Hi Brendan, Rob,
> >
> > Pulling a comment from way back in the v1 patch thread:
> >
> > On 10/17/18 3:22 PM, Brendan Higgins wrote:
> > > On Wed, Oct 17, 2018 at 10:49 AM <Tim.Bird@sony.com> wrote:
> >
> > < snip >
> >
> > > The test and the code under test are linked together in the same
> > > binary and are compiled under Kbuild. Right now I am linking
> > > everything into a UML kernel, but I would ultimately like to make
> > > tests compile into completely independent test binaries. So each test
> > > file would get compiled into its own test binary and would link
> > > against only the code needed to run the test, but we are a bit of a
> > > ways off from that.
> >
> > I have never used UML, so you should expect naive questions from me,
> > exhibiting my lack of understanding.
> >
> > Does this mean that I have to build a UML architecture kernel to run
> > the KUnit tests?
>
> In this version of the patch series, yes.
>
> > *** Rob, if the answer is yes, then it seems like for my workflow,
> > which is to build for real ARM hardware, my work is doubled (or
> > worse), because for every patch/commit that I apply, I not only have
> > to build the ARM kernel and boot on the real hardware to test, I also
> > have to build the UML kernel and boot in UML.  If that is correct
> > then I see this as a major problem for me.
>
> I've already raised this issue elsewhere in the series. Restricting
> the DT tests to UML is a non-starter.

I have already stated my position elsewhere on the matter, but in
summary: Ensuring most tests can run without external dependencies
(hardware, VM, etc) has a lot of benefits and should be supported in
nearly all cases, but such tests should also work when compiled to run
on real hardware/VM; the tooling might not be as good in the latter
case, but I understand that there are good reasons to support it
nonetheless.

So I am going to try to add basic support for running tests on other
architectures in the next version or two.

>
> > Brenden, in the above quote you said that in the future you would
> > like to make the "tests compile into completely independent test
> > binaries".  I am assuming those are intended to run as standalone
> > user space programs instead of inside UML.  Is that correct?  If
> > so, how will KUnit tests be able to test code that uses locking
> > mechanisms that require instructions that are not available to
> > user space execution?  (I _think_ that such instructions may be
> > present, depending on which locking mechanism, but I might be
> > mistaken.)
>
> I think he means as kernel modules as kunit is for testing internal
> kernel interfaces. kselftest is userspace level tests.

Frank is right: my long term goal is to make it so unit tests can run
as stand alone user space programs.

>
> If this were true about locking, then UML itself would not be viable.
>
> > Another possible concern that I have for removing the devicetree
> > unit tests from my normal kernel build process is that I think
> > that the ability to use sparse to analyze the source in the
> > unit tests is removed.  Please correct me if I misunderstand
> > that.
> >
> > Another issue is that the devicetree unit tests will no longer
> > be cross compiled with my ARM compiler, so I lose a small
> > amount of testing for compiler related issues.
>
> 0-day does that for you. :)
>
> > Overall, I'm still trying to learn enough to determine whether
> > the gains from moving to KUnit outweigh the losses.

Of course.

From what I have seen so far, the DT unittests seem like a pretty good
use case for KUnit. If you don't mind, what frustrates you most about
the tests you have now?

What are the most common breakages you see?

When do they get caught?

My initial reaction when I looked at the tests was that it seemed like
it would be hard to understand what caused a failure and it seemed
non-obvious where a test for a new feature should go.

To me, the thing that seemed like it needed the most work was
refactoring the tests to make them easier to understand. For example,
one thing I found when I started breaking the tests apart I found some
cases that I really had to stare at (or run diff on them) to figure
out what they did differently.

Looking forward to get your thoughts.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

