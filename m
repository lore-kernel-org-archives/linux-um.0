Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iulEZ-0006Sl-IB
 for linux-um@lists.infradead.org; Thu, 23 Jan 2020 22:45:56 +0000
Received: by mail-pj1-x1042.google.com with SMTP id r67so142035pjb.0
 for <linux-um@lists.infradead.org>; Thu, 23 Jan 2020 14:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-5-brendanhiggins@google.com>
 <20191217075836.C76942072D@mail.kernel.org>
In-Reply-To: <20191217075836.C76942072D@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 23 Jan 2020 14:45:43 -0800
Message-ID: <CAFd5g47=FxbKtm9rA3zKvnipdTdP_VR8zJ3pad-QukL5Ottrjw@mail.gmail.com>
Subject: Re: [RFC v1 4/6] init: main: add KUnit to kernel init
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
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Knut Omang <knut.omang@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, rppt@linux.ibm.com, linux-um <linux-um@lists.infradead.org>, Logan Gunthorpe <logang@deltatee.com>, KUnit Development <kunit-dev@googlegroups.com>, David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Iurii Zaikin <yzaikin@google.com>, Alan Maguire <alan.maguire@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Sorry for the late reply. I sent this thinking I would check in over
vacation, and then didn't.

On Mon, Dec 16, 2019 at 11:58 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-12-16 14:05:53)
> > Remove KUnit from init calls entirely, instead call directly from
> > kernel_init().
>
> Yes, but why? Is it desired to run the unit tests earlier than opening
> the console or something?

I want to make sure it is called after late_init is done (so that you
can test things initialized in late_init). And I want to make sure it
runs before init*fs is loaded so that there is a mechanism to run
tests without having to put a userland together.

> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 978086cfd257d..ca880224c0bab 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
> >         return !has_test_failed;
> >  }
> >
> > -static int kunit_executor_init(void)
> > +int kunit_executor_init(void)
>
> Should be marked __init? Even before this patch presumably.

Just this function? No strong opinion.

If by "before this patch" you mean other stuff in this patchset?

> >  {
> >         if (kunit_run_all_tests())
> >                 return 0;
> >         else
> >                 return -EFAULT;
> >  }
> > -
> > -late_initcall(kunit_executor_init);

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

