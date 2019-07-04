Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-vk1-xa49.google.com ([2607:f8b0:4864:20::a49])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hipkF-00074I-Oe
 for linux-um@lists.infradead.org; Thu, 04 Jul 2019 00:37:05 +0000
Received: by mail-vk1-xa49.google.com with SMTP id d14so449680vka.6
 for <linux-um@lists.infradead.org>; Wed, 03 Jul 2019 17:37:02 -0700 (PDT)
Date: Wed,  3 Jul 2019 17:35:57 -0700
Message-Id: <20190704003615.204860-1-brendanhiggins@google.com>
Mime-Version: 1.0
Subject: [PATCH v6 00/18] kunit: introduce KUnit, the Linux kernel unit
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
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com, richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org, logang@deltatee.com

## TL;DR

This is a pretty straightforward follow-up to Stephen and Luis' comments
on PATCH v5: There is nothing that really changes any functionality or
usage with the minor exception that I renamed `struct kunit_module` to
`struct kunit_suite`. Nevertheless, a good deal of clean ups and fixes.
See "Changes Since Last Version" section below.

As for our current status, right now we got Reviewed-bys on all patches
except:

- [PATCH v6 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list

However, it would probably be good to get reviews/acks from the
subsystem maintainers on:

- [PATCH v6 06/18] kbuild: enable building KUnit
- [PATCH v6 08/18] objtool: add kunit_try_catch_throw to the noreturn
  list
- [PATCH v6 15/18] Documentation: kunit: add documentation for KUnit
- [PATCH v6 17/18] kernel/sysctl-test: Add null pointer test for
  sysctl.c:proc_dointvec()

Other than that, I think we should be good to go.

## Background

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
(however, KUnit still allows you to run tests on test machines or in VMs
if you want[1]) and does not require tests to be written in userspace
running on a host kernel. Additionally, KUnit is fast: From invocation
to completion KUnit can run several dozen tests in about a second.
Currently, the entire KUnit test suite for KUnit runs in under a second
from the initial invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

### What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

### Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

### More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here[2].

Additionally for convenience, I have applied these patches to a
branch[3]. The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/v5.2-rc7/v6 branch.

## Changes Since Last Version

Aside from renaming `struct kunit_module` to `struct kunit_suite`, there
isn't really anything in here that changes any functionality:

- Rebased on v5.2-rc7
- Got rid of spinlocks.
  - Now update success field using WRITE_ONCE. - Suggested by Stephen
  - Other instances replaced by mutex. - Suggested by Stephen and Luis
- Renamed `struct kunit_module` to `struct kunit_suite`. - Inspired by
  Luis.
- Fixed a broken example of how to use kunit_tool. - Pointed out by Ted
- Added descriptions to unit tests. - Suggested by Luis
- Labeled unit tests which tested the API. - Suggested by Luis
- Made a number of minor cleanups. - Suggested by Luis and Stephen.

[1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/
[3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2-rc7/v6

-- 
2.22.0.410.gd8fdbe21b5-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

