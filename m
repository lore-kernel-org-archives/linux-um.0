Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-vk1-xa49.google.com ([2607:f8b0:4864:20::a49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guOiC-00024C-Kz
 for linux-um@lists.infradead.org; Thu, 14 Feb 2019 21:38:30 +0000
Received: by mail-vk1-xa49.google.com with SMTP id z135so3040318vkd.12
 for <linux-um@lists.infradead.org>; Thu, 14 Feb 2019 13:38:27 -0800 (PST)
Date: Thu, 14 Feb 2019 13:37:12 -0800
Message-Id: <20190214213729.21702-1-brendanhiggins@google.com>
Mime-Version: 1.0
Subject: [RFC v4 00/17] kunit: introduce KUnit,
 the Linux kernel unit testing framework
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
To: keescook@google.com, mcgrof@kernel.org, shuah@kernel.org, robh@kernel.org, kieran.bingham@ideasonboard.com, frowand.list@gmail.com
Cc: brakmo@fb.com, pmladek@suse.com, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

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
https://kunit.googlesource.com/linux/+/kunit/rfc/5.0-rc5/v4
The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/5.0-rc5/v4 branch.

## Changes Since Last Version

 - Got KUnit working on (hypothetically) all architectures (tested on
   x86), as per Rob's (and other's) request
 - Punting all KUnit features/patches depending on UML for now.
 - Broke out UML specific support into arch/um/* as per "[RFC v3 01/19]
   kunit: test: add KUnit test runner core", as requested by Luis.
 - Added support to kunit_tool to allow it to build kernels in external
   directories, as suggested by Kieran.
 - Added a UML defconfig, and a config fragment for KUnit as suggested
   by Kieran and Luis.
 - Cleaned up, and reformatted a bunch of stuff.

-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

