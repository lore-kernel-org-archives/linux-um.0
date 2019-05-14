Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQeRG-0000QP-OH
 for linux-um@lists.infradead.org; Tue, 14 May 2019 20:54:20 +0000
Received: by mail-pg1-x542.google.com with SMTP id z16so150410pgv.11
 for <linux-um@lists.infradead.org>; Tue, 14 May 2019 13:54:18 -0700 (PDT)
Date: Tue, 14 May 2019 13:54:09 -0700
From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514205409.GA154649@google.com>
References: <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <2aed675e-0408-c812-3e1a-b90710c528f2@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2aed675e-0408-c812-3e1a-b90710c528f2@gmail.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>

On Fri, May 10, 2019 at 02:52:59PM -0700, Frank Rowand wrote:

Sorry, I forgot to get back to this thread.

> On 5/9/19 3:20 PM, Logan Gunthorpe wrote:
> > =

> > =

> > On 2019-05-09 3:42 p.m., Theodore Ts'o wrote:
> >> On Thu, May 09, 2019 at 11:12:12AM -0700, Frank Rowand wrote:
> >>>
> >>> =A0=A0=A0 "My understanding is that the intent of KUnit is to avoid b=
ooting a kernel on
> >>> =A0=A0=A0 real hardware or in a virtual machine.=A0 That seems to be =
a matter of semantics
> >>> =A0=A0=A0 to me because isn't invoking a UML Linux just running the L=
inux kernel in
> >>> =A0=A0=A0 a different form of virtualization?
> >>>
> >>> =A0=A0=A0 So I do not understand why KUnit is an improvement over kse=
lftest.
> >>>
> >>> =A0=A0  ...
> >>> =

> >>> What am I missing?"
> >> =

> >> One major difference: kselftest requires a userspace environment;
> >> it starts systemd, requires a root file system from which you can
> >> load modules, etc.  Kunit doesn't require a root file system;
> >> doesn't require that you start systemd; doesn't allow you to run
> >> arbitrary perl, python, bash, etc. scripts.  As such, it's much
> >> lighter weight than kselftest, and will have much less overhead
> >> before you can start running tests.  So it's not really the same
> >> kind of virtualization.
> =

> I'm back to reply to this subthread, after a delay, as promised.
> =

> =

> > I largely agree with everything Ted has said in this thread, but I
> > wonder if we are conflating two different ideas that is causing an
> > impasse. From what I see, Kunit actually provides two different
> > things:
> =

> > 1) An execution environment that can be run very quickly in userspace
> > on tests in the kernel source. This speeds up the tests and gives a
> > lot of benefit to developers using those tests because they can get
> > feedback on their code changes a *lot* quicker.
> =

> kselftest in-kernel tests provide exactly the same when the tests are
> configured as "built-in" code instead of as modules.
> =

> =

> > 2) A framework to write unit tests that provides a lot of the same
> > facilities as other common unit testing frameworks from userspace
> > (ie. a runner that runs a list of tests and a bunch of helpers such
> > as KUNIT_EXPECT_* to simplify test passes and failures).
> =

> > The first item from Kunit is novel and I see absolutely no overlap
> > with anything kselftest does. It's also the valuable thing I'd like
> > to see merged and grow.
> =

> The first item exists in kselftest.
> =

> =

> > The second item, arguably, does have significant overlap with
> > kselftest. Whether you are running short tests in a light weight UML
> > environment or higher level tests in an heavier VM the two could be
> > using the same framework for writing or defining in-kernel tests. It
> > *may* also be valuable for some people to be able to run all the UML
> > tests in the heavy VM environment along side other higher level
> > tests.
> > =

> > Looking at the selftests tree in the repo, we already have similar
> > items to what Kunit is adding as I described in point (2) above.
> > kselftest_harness.h contains macros like EXPECT_* and ASSERT_* with
> > very similar intentions to the new KUNIT_EXECPT_* and KUNIT_ASSERT_*
> > macros.
> =

> I might be wrong here because I have not dug deeply enough into the
> code!!!  Does this framework apply to the userspace tests, the
> in-kernel tests, or both?  My "not having dug enough GUESS" is that
> these are for the user space tests (although if so, they could be
> extended for in-kernel use also).
> =

> So I think this one maybe does not have an overlap between KUnit
> and kselftest.

You are right, Frank: the EXPECT_* and ASSERT_* in kselftest_harness.h
is for userspace only. kselftest_harness.h provides it's own main method
for running the tests[1]. It also makes assumptions around having access
to this main method[2].

There actually isn't that much infrastructure that that I can reuse
there. I can't even reuse the API definitions because they only pass the
context object (for me it is struct kunit, for them it is their fixture)
that they use to their test cases.

> > However, the number of users of this harness appears to be quite
> > small. Most of the code in the selftests tree seems to be a random
> > mismash of scripts and userspace code so it's not hard to see it as
> > something completely different from the new Kunit:
> > $ git grep --files-with-matches kselftest_harness.h *
> > Documentation/dev-tools/kselftest.rst
> > MAINTAINERS
> > tools/testing/selftests/kselftest_harness.h
> > tools/testing/selftests/net/tls.c
> > tools/testing/selftests/rtc/rtctest.c
> > tools/testing/selftests/seccomp/Makefile
> > tools/testing/selftests/seccomp/seccomp_bpf.c
> > tools/testing/selftests/uevent/Makefile
> > tools/testing/selftests/uevent/uevent_filtering.c
> =

> =

> > Thus, I can personally see a lot of value in integrating the kunit
> > test framework with this kselftest harness. There's only a small
> > number of users of the kselftest harness today, so one way or another
> > it seems like getting this integrated early would be a good idea.
> > Letting Kunit and Kselftests progress independently for a few years
> > will only make this worse and may become something we end up
> > regretting.
> =

> Yes, this I agree with.

I think I agree with this point. I cannot see any reason not to have
KUnit tests able to be run from the kselftest harness.

Conceptually, I think we are mostly in agreement that kselftest and
KUnit are distinct things. Like Shuah said, kselftest is a black box
regression test framework, KUnit is a white box unit testing framework.
So making kselftest the only interface to use KUnit would be a mistake
in my opinion (and I think others on this thread would agree).

That being said, when you go to run kselftest, I think there is an
expectation that you run all your tests. Or at least that kselftest
should make that possible. From my experience, usually when someone
wants to run all the end-to-end tests, *they really just want to run all
the tests*. This would imply that all your KUnit tests get run too.

Another added benefit of making it possible for the kselftest harness to
run KUnit tests would be that it would somewhat guarantee that the
interfaces between the two would remain compatible meaning that test
automation tools like CI and presubmit systems are more likely to be
easy to integrate in each and less likely to break for either.

Would anyone object if I explore this in a follow-up patchset? I have an
idea of how I might start, but I think it would be easiest to explore in
it's own patchset. I don't expect it to be a trivial amount of work.

Cheers!

[1] https://elixir.bootlin.com/linux/v5.1.2/source/tools/testing/selftests/=
kselftest_harness.h#L329
[2] https://elixir.bootlin.com/linux/v5.1.2/source/tools/testing/selftests/=
kselftest_harness.h#L681

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

