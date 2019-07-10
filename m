Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hl7Mx-00053a-Tg
 for linux-um@lists.infradead.org; Wed, 10 Jul 2019 07:50:29 +0000
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x6A7o7TF011138
 for <linux-um@lists.infradead.org>; Wed, 10 Jul 2019 16:50:08 +0900
Received: by mail-vs1-f45.google.com with SMTP id r3so874985vsr.13
 for <linux-um@lists.infradead.org>; Wed, 10 Jul 2019 00:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
 <20190710071508.173491-7-brendanhiggins@google.com>
In-Reply-To: <20190710071508.173491-7-brendanhiggins@google.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 10 Jul 2019 16:49:31 +0900
Message-ID: <CAK7LNASywq+RhEisuPbqOjFoBh7WNvMEgy55iacizrgNB-uBfA@mail.gmail.com>
Subject: Re: [PATCH v8 06/18] kbuild: enable building KUnit
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
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "Cc: Shuah Khan" <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, DTML <devicetree@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Tim Bird <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Michal Marek <michal.lkml@markovi.net>, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Wed, Jul 10, 2019 at 4:16 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> KUnit is a new unit testing framework for the kernel and when used is
> built into the kernel as a part of it. Add KUnit to the root Kconfig and
> Makefile to allow it to be actually built.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Please feel free to replace this with:

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> Cc: Michal Marek <michal.lkml@markovi.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

