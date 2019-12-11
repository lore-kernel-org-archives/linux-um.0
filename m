MIME-Version: 1.0
Date: Wed, 11 Dec 2019 09:39:41 +0100
References: <20191210212108.222514-1-brendanhiggins@google.com>
In-Reply-To: <20191210212108.222514-1-brendanhiggins@google.com>
Message-ID: <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Johannes Berg <johannes.berg@intel.com>
List-ID: <linux-um.lists.infradead.org>

Hi Brendan,

On Tue, Dec 10, 2019 at 10:21 PM Brendan Higgins
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
>  arch/um/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 2a6d04fcb3e91..1ddc8745123f2 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -63,6 +63,7 @@ source "arch/$(HEADER_ARCH)/um/Kconfig"
>
>  config STATIC_LINK
>         bool "Force a static link"
> +       depends on !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP

"depends on !FORBID_STATIC_LINK"?

Then all the drivers that are incompatible with static linking can just
select FORBID_STATIC_LINK in their own Kconfig block.

>         default n
>         help
>           This option gives you the ability to force a static link of UML.
> @@ -72,6 +73,9 @@ config STATIC_LINK
>           Additionally, this option enables using higher memory spaces (up to
>           2.75G) for UML.
>
> +         NOTE: This option is incompatible with some networking features which
> +         depend on features that require being dynamically loaded (like NSS).
> +
>  config LD_SCRIPT_STATIC
>         bool
>         default y
> --
> 2.24.0.525.g8f36a354ae-goog

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

