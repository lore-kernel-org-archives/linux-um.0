Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hCAYd-0007Mz-S5
 for linux-um@lists.infradead.org; Thu, 04 Apr 2019 22:10:05 +0000
Received: by mail-qk1-x749.google.com with SMTP id i124so3438026qkf.14
 for <linux-um@lists.infradead.org>; Thu, 04 Apr 2019 15:10:03 -0700 (PDT)
Date: Thu,  4 Apr 2019 15:06:35 -0700
Message-Id: <20190404220652.19765-1-brendanhiggins@google.com>
Mime-Version: 1.0
Subject: [PATCH v1 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From: Brendan Higgins <brendanhiggins@google.com>
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
To: corbet@lwn.net, frowand.list@gmail.com, keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org, shuah@kernel.org, yamada.masahiro@socionext.com
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, richard@nod.at, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
and does not require tests to be written in userspace running on a host
kernel. Additionally, KUnit is fast: From invocation to completion KUnit
can run several dozen tests in under a second. Currently, the entire
KUnit test suite for KUnit runs in under a second from the initial
invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

## What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

## Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

## More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here:
https://google.github.io/kunit-docs/third_party/kernel/docs/
Additionally for convenience, I have applied these patches to a branch:
https://kunit.googlesource.com/linux/+/kunit/rfc/v5.1-rc2/v1
The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/v5.1-rc2/v1 branch.

## Changes Since Last Version

Last version was RFC v4. It seemed we were pretty much done with the RFC
phase, so I started the numbering over again. Sorry if anyone finds that
confusing.

 - Reduced usage of object oriented style of member functions as
   suggested by Frank.
 - Did a bunch of heavy clean up of the kunit_abort stuff as suggested
   by Frank and Stephen:
   - Biggest change was to reduce the usage of direct calls of member
     functions.
   - Added a better explanation of what abort is for and further
     explained the rationale for KUNIT_ASSERT_* vs. KUNIT_EXPECT_*
   - Dropped BUG() usage
   - Also moved try_catch interface to a new file since it seemed
     obscured by being mixed in with the code that used it.
 - Fixed some other minor issues pointed out by Stephen.
 - Updated email address of one of the contributors.
 - Dropped DT unittest port since it seemed like there was a lot more
   discussion to be had: it wasn't ready to leave the RFC phase.
   Instead, I added a KUnit test written by Iurii for PROC SYSCTL that
   was requested by Luis some time ago.

For reference, RFC v4 can be found here:
https://lkml.org/lkml/2019/2/14/1144

-- 
2.21.0.392.gf8f6787159e-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

