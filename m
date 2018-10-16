Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCZ9e-0003uR-6g
 for linux-um@lists.infradead.org; Tue, 16 Oct 2018 23:53:39 +0000
Received: by mail-qt1-x84a.google.com with SMTP id s56-v6so26841247qtk.2
 for <linux-um@lists.infradead.org>; Tue, 16 Oct 2018 16:53:27 -0700 (PDT)
Date: Tue, 16 Oct 2018 16:50:49 -0700
Message-Id: <20181016235120.138227-1-brendanhiggins@google.com>
Mime-Version: 1.0
Subject: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
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
To: gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, Tim.Bird@sony.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, julia.lawall@lip6.fr, joel@jms.id.au, linux-kselftest@vger.kernel.org, khilman@baylibre.com, joe@perches.com, jdike@addtoit.com, Brendan Higgins <brendanhiggins@google.com>, kunit-dev@googlegroups.com

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

-- 
2.19.1.331.ge82ca0e54c-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

