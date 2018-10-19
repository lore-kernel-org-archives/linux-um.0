Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDOGP-0006f4-Ol
 for linux-um@lists.infradead.org; Fri, 19 Oct 2018 06:28:03 +0000
Received: by mail-ot1-x343.google.com with SMTP id p23so32157572otf.11
 for <linux-um@lists.infradead.org>; Thu, 18 Oct 2018 23:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <CAA9_cmeRE3mPvxb3NciGFYjNu9aMFx4iTMeUq2fC3UtsyXky2A@mail.gmail.com>
In-Reply-To: <CAA9_cmeRE3mPvxb3NciGFYjNu9aMFx4iTMeUq2fC3UtsyXky2A@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 18 Oct 2018 23:27:34 -0700
Message-ID: <CAFd5g46P8PuGH8B5B3mT=M1a4Lg7JTOdWJ8LECo8-i2a=fUZDA@mail.gmail.com>
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
To: dan.j.williams@intel.com
Cc: brakmo@fb.com, richard@nod.at, linux-nvdimm@lists.01.org, mpe@ellerman.id.au, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, jdike@addtoit.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org, linux-um@lists.infradead.org, Julia Lawall <julia.lawall@lip6.fr>, mcgrof@kernel.org, Joel Stanley <joel@jms.id.au>, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, joe@perches.com, shuah@kernel.org, khilman@baylibre.com, kunit-dev@googlegroups.com

On Wed, Oct 17, 2018 at 8:55 PM Dan Williams <dan.j.williams@intel.com> wrote:
<snip>
> > ## More information on KUnit
> >
> > There is a bunch of documentation near the end of this patch set that
> > describes how to use KUnit and best practices for writing unit tests.
> > For convenience I am hosting the compiled docs here:
> > https://google.github.io/kunit-docs/third_party/kernel/docs/
>
> Nice! I've been using mocking techniques in kernel code for the
> libnvdimm test infrastructure in tools/testing/nvdimm/. It's part unit
> test infrastructure, part emulation, and I've always had the feeling
> it's all a bit too adhoc. I'm going to take a look and see what can be
> converted to kunit. Please include linux-nvdimm@lists.01.org on future
> postings.

Great to hear!

Interesting, is this kind of like the nfsim stuff?
>
> I'll shamelessly plug my lwn article about unit testing
> https://lwn.net/Articles/654071/ because it's always good to find
> fellow co-travelers to compare notes and advocate for more test
> oriented kernel development.

Most definitely! I will take a look, and be in touch.

Cheers!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

