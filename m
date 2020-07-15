Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvd1i-000110-Jh
 for linux-um@lists.infradead.org; Wed, 15 Jul 2020 08:44:31 +0000
Received: by mail-pj1-x1042.google.com with SMTP id ls15so2748870pjb.1
 for <linux-um@lists.infradead.org>; Wed, 15 Jul 2020 01:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com>
 <20200704085213.444645-4-ignat@cloudflare.com>
In-Reply-To: <20200704085213.444645-4-ignat@cloudflare.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 15 Jul 2020 01:44:17 -0700
Message-ID: <CAFd5g44Hxhxjqb6WkfaMtaTDKVhs0onnkRaQ0Aq55z6oYTbJbA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] um: allow static linking for non-glibc
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
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: kernel-team@cloudflare.com, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, Jul 4, 2020 at 1:52 AM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
> UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
> implementations, which do not rely on NSS, such as musl.
>
> Allow static linking in this case.
>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

One minor issue below. Other than that:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  arch/um/Kconfig         | 2 +-
>  arch/um/drivers/Kconfig | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 9318dc6d1a0c..af7ed63f9c74 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -67,7 +67,7 @@ config FORBID_STATIC_LINK

Doesn't look like FORBID_STATIC_LINK is used anymore, so you should
probably drop it as well.

With the preceding changes, in this patchset, you can revert my patch
like you did in the RFC - or not, your choice. I am not offended by
people reverting my commits. I just don't like it when people break
allyesconfig. :-)

>  config STATIC_LINK
>         bool "Force a static link"
> -       depends on !FORBID_STATIC_LINK
> +       depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)
>         help
>           This option gives you the ability to force a static link of UML.
>           Normally, UML is linked as a shared binary.  This is inconvenient for
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 9160ead56e33..72d417055782 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -234,7 +234,6 @@ config UML_NET_DAEMON
>  config UML_NET_VECTOR
>         bool "Vector I/O high performance network devices"
>         depends on UML_NET
> -       select FORBID_STATIC_LINK
>         help
>         This User-Mode Linux network driver uses multi-message send
>         and receive functions. The host running the UML guest must have
> @@ -246,7 +245,6 @@ config UML_NET_VECTOR
>  config UML_NET_VDE
>         bool "VDE transport (obsolete)"
>         depends on UML_NET
> -       select FORBID_STATIC_LINK
>         help
>         This User-Mode Linux network transport allows one or more running
>         UMLs on a single host to communicate with each other and also
> @@ -294,7 +292,6 @@ config UML_NET_MCAST
>  config UML_NET_PCAP
>         bool "pcap transport (obsolete)"
>         depends on UML_NET
> -       select FORBID_STATIC_LINK
>         help
>         The pcap transport makes a pcap packet stream on the host look
>         like an ethernet device inside UML.  This is useful for making
> --
> 2.20.1
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

