Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iulPD-0000vX-Ab
 for linux-um@lists.infradead.org; Thu, 23 Jan 2020 22:56:56 +0000
Received: by mail-pg1-x544.google.com with SMTP id l24so2153122pgk.2
 for <linux-um@lists.infradead.org>; Thu, 23 Jan 2020 14:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-7-brendanhiggins@google.com>
 <20191217080653.B672B2082E@mail.kernel.org>
In-Reply-To: <20191217080653.B672B2082E@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 23 Jan 2020 14:56:43 -0800
Message-ID: <CAFd5g45YJrrOu=kvSF9LhkCy_gxrAa3Sa6UJLRFGQtDtepe9xg@mail.gmail.com>
Subject: Re: [RFC v1 6/6] kunit: Add 'kunit_shutdown' option
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

On Tue, Dec 17, 2019 at 12:06 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-12-16 14:05:55)
> > From: David Gow <davidgow@google.com>
> >
> > Add a new kernel command-line option, 'kunit_shutdown', which allows the
> > user to specify that the kernel poweroff, halt, or reboot after
> > completing all KUnit tests; this is very handy for running KUnit tests
> > on UML or a VM so that the UML/VM process exits cleanly immediately
> > after running all tests without needing a special initramfs.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  lib/kunit/executor.c                | 18 ++++++++++++++++++
> >  tools/testing/kunit/kunit_kernel.py |  2 +-
> >  tools/testing/kunit/kunit_parser.py |  2 +-
> >  3 files changed, 20 insertions(+), 2 deletions(-)
>
> Can you document it in Documentation/admin-guide/kernel-parameters.txt ?

Ah, yes. That would be a good idea. Sorry, I just expected to be
shouted at loudly for doing this, and didn't want to expend the effort
until some people told me that they didn't hate the idea.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

