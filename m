Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFFFo-0005qD-VT
 for linux-um@lists.infradead.org; Wed, 24 Oct 2018 09:15:08 +0000
Received: by mail-ed1-x542.google.com with SMTP id e5-v6so4318419eds.6
 for <linux-um@lists.infradead.org>; Wed, 24 Oct 2018 02:14:53 -0700 (PDT)
Date: Wed, 24 Oct 2018 11:14:49 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20181024091449.GL324@phenom.ffwll.local>
References: <20181023235750.103146-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, linux-nvdimm@lists.01.org, richard@nod.at, kieran.bingham@ideasonboard.com, joel@jms.id.au, jdike@addtoit.com, Tim.Bird@sony.com, keescook@google.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Tue, Oct 23, 2018 at 04:57:36PM -0700, Brendan Higgins wrote:
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
> 
> ## Changes Since Last Version
> 
>  - Updated patchset to apply cleanly on 4.19.
>  - Stripped down patchset to focus on just the core features (I dropped
>    mocking, spying, and the MMIO stuff for now; you can find these
>    patches here: https://kunit-review.googlesource.com/c/linux/+/1132),
>    as suggested by Rob.
>  - Cleaned up some of the commit messages and tweaked commit order a
>    bit based on suggestions.

Do you have some example unit tests somewhere? The docs are all neat, but
real example helps a lot with the tried&true art of copypasting :-)

I'd like to give this a test spin with some of the unit tests we already
have in drm. And especially figuring out how we could integrate this with
our existing infrastructure.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

