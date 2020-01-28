Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwLFM-0006sR-AR
 for linux-um@lists.infradead.org; Tue, 28 Jan 2020 07:25:21 +0000
Received: by mail-pf1-x442.google.com with SMTP id 185so2396352pfv.3
 for <linux-um@lists.infradead.org>; Mon, 27 Jan 2020 23:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20200127193549.187419-1-brendanhiggins@google.com>
 <20200127193549.187419-2-brendanhiggins@google.com>
 <CAK7LNASR13WjasKPmq-8gURhNUpOsrsCN2ODUh56fpM9DKWq7A@mail.gmail.com>
In-Reply-To: <CAK7LNASR13WjasKPmq-8gURhNUpOsrsCN2ODUh56fpM9DKWq7A@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 27 Jan 2020 23:25:03 -0800
Message-ID: <CAFd5g47EOrbMdPFa2QO-5dEWZBq_N_MK5g4G2p3E8kEMmAECVw@mail.gmail.com>
Subject: Re: [RFC v1 1/2] kbuild: add arch specific dependency for BTF support
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
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Heidi Fahim <heidifahim@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Randy Dunlap <rdunlap@infradead.org>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@intel.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Mon, Jan 27, 2020 at 7:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi.
>
> On Tue, Jan 28, 2020 at 4:36 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Some archs (like UM) do not build with CONFIG_DEBUG_INFO_BTF=y, so add
> > an options for archs to select to opt-in or out of BTF typeinfo support.
>
>
> Could you use a different subject prefix (e.g. "btf:") ?
>
> This is unrelated to kbuild.

Sure. My apologies, I just used the kbuild subject prefix because
that's what the previous commit that touched BTF used. Will fix in
next revision.

Thanks!

> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  lib/Kconfig.debug | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index e4676b992eae9..f5bcb391f1b7d 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -238,9 +238,12 @@ config DEBUG_INFO_DWARF4
> >           But it significantly improves the success of resolving
> >           variables in gdb on optimized code.
> >
> > +config ARCH_NO_BTF_TYPEINFO
> > +       bool
> > +
> >  config DEBUG_INFO_BTF
> >         bool "Generate BTF typeinfo"
> > -       depends on DEBUG_INFO
> > +       depends on DEBUG_INFO && !ARCH_NO_BTF_TYPEINFO
> >         help
> >           Generate deduplicated BTF type information from DWARF debug info.
> >           Turning this on expects presence of pahole tool, which will convert
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

