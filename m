Return-Path: <brendanhiggins@google.com>
MIME-Version: 1.0
References: <20200124221401.210449-1-brendanhiggins@google.com>
In-Reply-To: <20200124221401.210449-1-brendanhiggins@google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 7 Feb 2020 17:07:54 -0800
Message-ID: <CAFd5g44eznV-9cPf4JVpsJo93+R8YCqUwBqRf+PbjaRMizy1aQ@mail.gmail.com>
Subject: Re: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static
Content-Type: text/plain; charset="UTF-8"
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James McMechan <james_mcmechan@hotmail.com>
Cc: linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Gow <davidgow@google.com>
List-ID: <linux-um.lists.infradead.org>

On Fri, Jan 24, 2020 at 2:14 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> UML_NET_PCAP; this is because glibc tries to load NSS which does not
> support being statically linked. So make CONFIG_STATIC_LINK depend on
> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
>
> Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Ping.

>  arch/um/Kconfig         | 8 +++++++-
>  arch/um/drivers/Kconfig | 3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c285..28d62151fb2ed 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -62,9 +62,12 @@ config NR_CPUS
>
>  source "arch/$(HEADER_ARCH)/um/Kconfig"
>
> +config FORBID_STATIC_LINK
> +       bool
> +
>  config STATIC_LINK
>         bool "Force a static link"
> -       default n
> +       depends on !FORBID_STATIC_LINK
>         help
>           This option gives you the ability to force a static link of UML.
>           Normally, UML is linked as a shared binary.  This is inconvenient for
> @@ -73,6 +76,9 @@ config STATIC_LINK
>           Additionally, this option enables using higher memory spaces (up to
>           2.75G) for UML.
>
> +         NOTE: This option is incompatible with some networking features which
> +         depend on features that require being dynamically loaded (like NSS).
> +
>  config LD_SCRIPT_STATIC
>         bool
>         default y
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 72d4170557820..9160ead56e33c 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -234,6 +234,7 @@ config UML_NET_DAEMON
>  config UML_NET_VECTOR
>         bool "Vector I/O high performance network devices"
>         depends on UML_NET
> +       select FORBID_STATIC_LINK
>         help
>         This User-Mode Linux network driver uses multi-message send
>         and receive functions. The host running the UML guest must have
> @@ -245,6 +246,7 @@ config UML_NET_VECTOR
>  config UML_NET_VDE
>         bool "VDE transport (obsolete)"
>         depends on UML_NET
> +       select FORBID_STATIC_LINK
>         help
>         This User-Mode Linux network transport allows one or more running
>         UMLs on a single host to communicate with each other and also
> @@ -292,6 +294,7 @@ config UML_NET_MCAST
>  config UML_NET_PCAP
>         bool "pcap transport (obsolete)"
>         depends on UML_NET
> +       select FORBID_STATIC_LINK
>         help
>         The pcap transport makes a pcap packet stream on the host look
>         like an ethernet device inside UML.  This is useful for making
> --
> 2.25.0.341.g760bfbb309-goog
>

