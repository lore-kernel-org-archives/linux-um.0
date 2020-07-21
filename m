Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jy26U-0001av-G9
 for linux-um@lists.infradead.org; Tue, 21 Jul 2020 23:55:23 +0000
Received: by mail-pj1-x1041.google.com with SMTP id 8so213138pjj.1
 for <linux-um@lists.infradead.org>; Tue, 21 Jul 2020 16:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200721054528.2556267-1-davidgow@google.com>
In-Reply-To: <20200721054528.2556267-1-davidgow@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 21 Jul 2020 16:55:06 -0700
Message-ID: <CAFd5g46ughJzQCH_mh897NYovVuryvM1_Xi-9YfP6nsUHZsT4g@mail.gmail.com>
Subject: Re: [RFC PATCH] platform: ioremap: Build iomap functions even without
 HAS_IOMEM
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
To: David Gow <davidgow@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Logan Gunthorpe <logang@deltatee.com>, KUnit Development <kunit-dev@googlegroups.com>

On Mon, Jul 20, 2020 at 10:45 PM David Gow <davidgow@google.com> wrote:
>
> A number of drivers use devm_platform_ioremap_resource(), but do not (or
> did not) explicitly depend on IOMEM[1,2]. Given that the only platform
> without HAS_IOMEM seems to be UML, and it has sufficient stubs for
> devm_platform_ioremap_resource() and its dependencies to build, we can
> remove the HAS_IOMEM requirement here, rather than playing whack-a-mole
> with different drivers which don't try to build against ARCH=um.
>
> The reason this works at the moment is that stub ioremap and iounmap
> functions were added to UML to support this sort-of thing[3]. This
> particular change doesn't require adding any additional stubs, but there
> is possibly room in the future to stub out the remaining iomem functions
> (or to provide mock implementations for testing), and get rid of
> HAS_IOMEM entirely.
>
> [1]: https://lkml.org/lkml/2020/6/30/176
> [2]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e7468bd9d30a21e059af477106dc5588ae52dff
> [3]:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1405627.html
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

