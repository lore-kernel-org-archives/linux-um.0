MIME-Version: 1.0
Date: Fri, 24 Jan 2020 08:50:51 +0100
References: <20200123235914.223178-1-brendanhiggins@google.com>
In-Reply-To: <20200123235914.223178-1-brendanhiggins@google.com>
Message-ID: <CAMuHMdVLcMXyxnoFvoqkt3KbdmXXk+6Swveez9+A_yowFsWRAg@mail.gmail.com>
Subject: Re: [PATCH v2] uml: make CONFIG_STATIC_LINK actually static
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, James McMechan <james_mcmechan@hotmail.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>
List-ID: <linux-um.lists.infradead.org>

Hi Brendan,

On Fri, Jan 24, 2020 at 12:59 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> UML_NET_PCAP; this is because glibc tries to load NSS which does not
> support being statically linked. So make CONFIG_STATIC_LINK depend on
> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
>
> Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Changes since last revision:
>
> Incorporated Geert Uytterhoeven's suggestion of using a separate
> FORBID_STATIC_LINK config option that each driver incompatible with
> static linking selects.
> ---
>  arch/um/Kconfig         | 7 +++++++
>  arch/um/drivers/Kconfig | 3 +++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c285..27a51e7dd59c6 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -62,8 +62,12 @@ config NR_CPUS
>
>  source "arch/$(HEADER_ARCH)/um/Kconfig"
>
> +config FORBID_STATIC_LINK
> +       def_bool n

    bool

("n" is the default)

> +
>  config STATIC_LINK
>         bool "Force a static link"
> +       depends on !FORBID_STATIC_LINK
>         default n

"default n" is the default (preexisting)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

