Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxGTd-00079M-Cu
 for linux-um@lists.infradead.org; Sun, 19 Jul 2020 21:04:06 +0000
Received: by mail-wm1-x342.google.com with SMTP id j18so20417107wmi.3
 for <linux-um@lists.infradead.org>; Sun, 19 Jul 2020 14:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200715201159.54166-1-ignat@cloudflare.com>
 <20200715201159.54166-4-ignat@cloudflare.com>
 <159691324719ca79fbb8c206da527fc1f2bbc1ed.camel@sipsolutions.net>
In-Reply-To: <159691324719ca79fbb8c206da527fc1f2bbc1ed.camel@sipsolutions.net>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Sun, 19 Jul 2020 22:03:53 +0100
Message-ID: <CALrw=nEB-ohdc-RCA=Ncv40TFg457m7gm5qWg5ahjNrpE9bDCA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] um: allow static linking for non-glibc
 implementations
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: kernel-team <kernel-team@cloudflare.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, masahiroy@kernel.org, Brendan Higgins <brendanhiggins@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Jul 16, 2020 at 10:10 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Wed, 2020-07-15 at 21:11 +0100, Ignat Korchagin wrote:
> > It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
> > UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
> > implementations, which do not rely on NSS, such as musl.
> >
> > Allow static linking in this case.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/um/Kconfig         | 5 +----
> >  arch/um/drivers/Kconfig | 3 ---
> >  2 files changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 9318dc6d1a0c..beb98b3b9f75 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -62,12 +62,9 @@ config NR_CPUS
> >
> >  source "arch/$(HEADER_ARCH)/um/Kconfig"
> >
> > -config FORBID_STATIC_LINK
> > -     bool
> > -
> >  config STATIC_LINK
> >       bool "Force a static link"
> > -     depends on !FORBID_STATIC_LINK
> > +     depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)
>
> Come to think of it, in a way "FORBID_STATIC_LINK" was nicer because
> there didn't need to be a single list of "what has dynamic dependencies"
> like here the list of UML_NET_VECTOR, UML_NET_VDE, UML_NET_PCAP.
>
> Maybe it could be
>
> config MAY_HAVE_NON_STATIC_RUNTIME_DEPS
>         bool
>
> config STATIC_LINK
>         ...
>         depends on !MAY_HAVE_NON_STATIC_RUNTIME_DEPS || CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
>
>
> and then UML_NET_VECTOR et al can
>
>         select MAY_HAVE_NON_STATIC_RUNTIME_DEPS
>
> so that the knowledge is still distributed to the corresponding options?

Yes, makes sense. I've shortened it to MAY_HAVE_RUNTIME_DEPS and
reposted the series.

> johannes
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

