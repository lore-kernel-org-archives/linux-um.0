Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8tQ5-0001XY-U9
 for linux-um@lists.infradead.org; Mon, 02 Mar 2020 22:20:15 +0000
Received: by mail-pj1-x1044.google.com with SMTP id f2so359273pjq.1
 for <linux-um@lists.infradead.org>; Mon, 02 Mar 2020 14:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200302200337.GH11244@42.do-not-panic.com>
 <20200302211640.GA8364@roeck-us.net>
In-Reply-To: <20200302211640.GA8364@roeck-us.net>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 2 Mar 2020 14:19:57 -0800
Message-ID: <CAFd5g452oaKojBZfvTYw-L14wTFqsjDeX4mtYDM=kv6xhcTnig@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
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
To: Guenter Roeck <linux@roeck-us.net>, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Frank Rowand <frowand.list@gmail.com>, rppt@linux.ibm.com, Logan Gunthorpe <logang@deltatee.com>, KUnit Development <kunit-dev@googlegroups.com>, David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Iurii Zaikin <yzaikin@google.com>, Alan Maguire <alan.maguire@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Mon, Mar 2, 2020 at 1:16 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Mar 02, 2020 at 08:03:37PM +0000, Luis Chamberlain wrote:
> > Guenter,
> >
> > are you still running your cross-architecture tests? If so any chance
>
> Yes
>
> > you can try this for your build tests?
> >
>
> I didn't have KUNIT_TEST enabled to start with. I did that now, and
> started a test run on mainline a minute ago. We'll see how that goes.

FYI, kbuild already found some architectures for which this change doesn't work.

So far, I need to fix:
- arm64 (32 bit seems to work fine)
- i386 in some cases.

> Afterwards, sure, I can run the series in a test branch. It would be great
> if I can pick it up from a repository somewhere.

Cool, I will post my next revision to a branch somewhere.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

