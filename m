Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCsfp-00078g-Et
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 20:44:10 +0000
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68ABD21479
 for <linux-um@lists.infradead.org>; Wed, 17 Oct 2018 20:43:58 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id l6-v6so30777260wrt.1
 for <linux-um@lists.infradead.org>; Wed, 17 Oct 2018 13:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 17 Oct 2018 15:43:45 -0500
Message-ID: <CABGGisyc_MnO-izpK5ANYV9HEcWCUM5XTiouZPvN8-mO977A6Q@mail.gmail.com>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
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
To: brendanhiggins@google.com
Cc: brakmo@fb.com, richard@nod.at, Michael Ellerman <mpe@ellerman.id.au>, Tim.Bird@sony.com, keescook@google.com, jdike@addtoit.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-um@lists.infradead.org, Julia Lawall <julia.lawall@lip6.fr>, mcgrof@kernel.org, joel@jms.id.au, linux-kselftest@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com

On Tue, Oct 16, 2018 at 6:53 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
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

I very much like this. The DT code too has unit tests with our own,
simple infrastructure. They too can run under UML (and every other
arch).

Rob

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

