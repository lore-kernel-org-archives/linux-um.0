Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gChoh-0000Cl-0s
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 09:09:46 +0000
Received: by mail-ed1-x543.google.com with SMTP id g32-v6so24079962edg.13
 for <linux-um@lists.infradead.org>; Wed, 17 Oct 2018 02:08:23 -0700 (PDT)
Date: Wed, 17 Oct 2018 11:08:19 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
Message-ID: <20181017090819.GM31561@phenom.ffwll.local>
References: <20181016235120.138227-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
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
Cc: brakmo@fb.com, IGT development <igt-dev@lists.freedesktop.org>, richard@nod.at, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, mpe@ellerman.id.au, Tim.Bird@sony.com, keescook@google.com, jdike@addtoit.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, linux-um@lists.infradead.org, julia.lawall@lip6.fr, mcgrof@kernel.org, joel@jms.id.au, linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org, joe@perches.com, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com

On Tue, Oct 16, 2018 at 04:50:49PM -0700, Brendan Higgins wrote:
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> and does not require tests to be written in userspace running on a host
> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> can run several dozen tests in under a second. Currently, the entire
> KUnit test suite for KUnit runs in under a second from the initial
> invocation (build time excluded).
> 
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.
> 
> ## What's so special about unit testing?
> 
> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.
> 
> ## Is KUnit trying to replace other testing frameworks for the kernel?
> 
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.
> 
> ## More information on KUnit
> 
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here:
> https://google.github.io/kunit-docs/third_party/kernel/docs/

We've started our own unit test framework (very early, and not any real
infrastructure yet) under drivers/gpu/drm/selftests. They're all meant to
test functions and small pieces of functionality of our libraries in
isolation, without any need for a real (or virtual) gpu driver. It kinda
integrates both with kselftests and with our graphics test suite, but
directly running tests using UML as part of the build process sounds much,
much better. Having proper and standardized infrastructure for kernel unit
tests sounds terrific.

In other words: I want.

Please keep dri-devel@lists.freedesktop.org in the loop on future
versions.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

