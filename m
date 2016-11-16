Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161115223902.GA8347@juliacomputing.com>
References: <20161115223902.GA8347@juliacomputing.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Nov 2016 20:49:45 +0100
Message-ID: <CACRpkdZQ+XnX7bYDbBpixzDE2Hnv68snp42XO-T=nFN+k6BQzw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Remove GPIO_DEVRES option
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Keno Fischer <keno@juliacomputing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Shawn Guo <shawn.guo@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Nov 15, 2016 at 11:39 PM, Keno Fischer <keno@juliacomputing.com> wrote:

> This option was added in 6a89a314ab107a12af08c71420c19a37a30fc2d3 to allow use
> of the devm_gpio_* functions without CONFIG_GPIOLIB. However, only a few months
> later in b69ac52449c658b7ac40034dc3c5f5f4a71a723d, CONFIG_GPIOLIB, was added
> as a dependency, defeating the original purpose of this option. Instead of
> that patch, the original commit could have just been reverted (and in fact
> was partially so in 403c1d0be5ccbd750d25c59d8358843a81e52e3b). Further,
> since this option has a dependency on HAS_IOMEM, even though it does not
> require it, it causes build failures when !HAS_IOMEM (e.g. in a uml build).
> Fix that by completely removing the option, in essence completing the
> reversion of the original commit.

I split up this terse commit message a bit and added your
Signed-off-by and applied for fixes.

Yours,
Linus Walleij

