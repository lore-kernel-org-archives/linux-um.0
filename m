Return-Path: <linux-gpio-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161110015638.GA51357@juliacomputing.com>
References: <20161110015638.GA51357@juliacomputing.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Nov 2016 10:10:53 +0100
Message-ID: <CACRpkdZ00bkzWOad520398gNELPhN3zqwMke6bwH+Cwb5FS8JQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Guard devm_* functions behind CONFIG_GPIO_DEVRES
 not CONFIG_GPIOLIB
Content-Type: text/plain; charset=UTF-8
Sender: linux-gpio-owner@vger.kernel.org
To: Keno Fischer <keno@juliacomputing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Nov 10, 2016 at 2:56 AM, Keno Fischer <keno@juliacomputing.com> wrote:

> These functions are defined in devres.c, which only gets compiled with
> CONFIG_GPIO_DEVRES (in addition to CONFIG_GPIOLIB). However, in the
> header files, the difference between the declaration and the inline
> stub was only guarded by CONFIG_GPIOLIB, not CONFIG_GPIO_DEVRES,
> causing undefined symbol problems in modpost.
>
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>
> I encountered this while trying to build uml in an attempt to debug some kernel
> behavior I don't understand. To be as close to my actual kernel as possible,
> I used the same .config, which of course tried to build a bunch of drivers.
> Arguably I should just not build those, but this seems correct nonetheless
> and allows the build to go through.

Ha! Good point. But it's the wrong solution.

The culprit is this:

if GPIOLIB

config GPIO_DEVRES
        def_bool y
        depends on HAS_IOMEM

But devres has no dependency on HAS_IOMEM whatsoever.

And certainly UML should have access to the devres variants
of the calls.

The proper patch is to remove the Kconfig option GPIO_DEVRES
altogether, make it compulsory, and remove *all* ifdefs for
CONFIG_GPIO_DEVRES and alter the Makefile so that it
is compiled-in for CONFIG_GPIOLIB.

Do you wanna take a stab at patching this or should I do it?

Yours,
Linus Walleij
