Return-Path: <linux-gpio-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20210625103734.2f29630be607.Ied890c9ca650517103410e399ef509796653f5d3@changeid>
In-Reply-To: <20210625103734.2f29630be607.Ied890c9ca650517103410e399ef509796653f5d3@changeid>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 25 Jun 2021 12:16:56 +0200
Message-ID: <CAMpxmJWnh6RB98H_z5U3_x7J05GNwN8TW5=eiTj7QzPJRnuKuQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: AMD8111 and TQMX86 require HAS_IOPORT_MAP
Content-Type: text/plain; charset="UTF-8"
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-gpio <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Baryshkov <dbaryshkov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>
List-ID: <linux-um.lists.infradead.org>

On Fri, Jun 25, 2021 at 10:37 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Both of these drivers use ioport_map(), so they need to
> depend on HAS_IOPORT_MAP. Otherwise, they cannot be built
> even with COMPILE_TEST on architectures without an ioport
> implementation, such as ARCH=um.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/gpio/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 1dd0ec6727fd..3c69b785cb79 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1383,6 +1383,7 @@ config GPIO_TPS68470
>  config GPIO_TQMX86
>         tristate "TQ-Systems QTMX86 GPIO"
>         depends on MFD_TQMX86 || COMPILE_TEST
> +       depends on HAS_IOPORT_MAP
>         select GPIOLIB_IRQCHIP
>         help
>           This driver supports GPIO on the TQMX86 IO controller.
> @@ -1450,6 +1451,7 @@ menu "PCI GPIO expanders"
>  config GPIO_AMD8111
>         tristate "AMD 8111 GPIO driver"
>         depends on X86 || COMPILE_TEST
> +       depends on HAS_IOPORT_MAP
>         help
>           The AMD 8111 south bridge contains 32 GPIO pins which can be used.
>
> --
> 2.31.1
>

Applied, thanks!

Bart

