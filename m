Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8Ja-00065t-3r
 for linux-um@lists.infradead.org; Tue, 04 Dec 2018 10:52:31 +0000
Received: by mail-pl1-x644.google.com with SMTP id b5so8124097plr.4
 for <linux-um@lists.infradead.org>; Tue, 04 Dec 2018 02:52:19 -0800 (PST)
Subject: Re: [RFC v3 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
References: <20181128193636.254378-1-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <8807ac55-44e7-0ab7-176d-a0f71bff07e6@gmail.com>
Date: Tue, 4 Dec 2018 02:52:11 -0800
MIME-Version: 1.0
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Content-Language: en-US
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
To: Brendan Higgins <brendanhiggins@google.com>, gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org
Cc: brakmo@fb.com, robh@kernel.org, knut.omang@oracle.com, richard@nod.at, dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org, mpe@ellerman.id.au, Tim.Bird@sony.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, kieran.bingham@ideasonboard.com, julia.lawall@lip6.fr, joel@jms.id.au, linux-kselftest@vger.kernel.org, khilman@baylibre.com, joe@perches.com, daniel@ffwll.ch, dan.j.williams@intel.com, jdike@addtoit.com, kunit-dev@googlegroups.com

On 11/28/18 11:36 AM, Brendan Higgins wrote:
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

This question might be a misunderstanding of the intent of some of the
terminology in the above paragraph, so this is mostly a request for
clarification.

With my pre-conception of what unit tests are, I read "test a single unit
of code" to mean a relatively narrow piece of a subsystem.  So if I
understand correctly, taking examples from patch 17 "of: unittest:
migrate tests to run on KUnit", each function call like
KUNIT_ASSERT_NOT_ERR_OR_NULL(), KUNIT_EXPECT_STREQ_MSG(), and
KUNIT_EXPECT_EQ_MSG() are each a separate unit test, and thus the
paragraph says that each of these function calls should have no
dependencies outside the test.  Do I understand that correctly?

< snip >

-Frank


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

