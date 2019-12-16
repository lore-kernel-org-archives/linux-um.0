Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iglxr-0001ap-LD
 for linux-um@lists.infradead.org; Mon, 16 Dec 2019 08:42:53 +0000
Received: by mail-vk1-xa41.google.com with SMTP id h13so1380951vkn.10
 for <linux-um@lists.infradead.org>; Mon, 16 Dec 2019 00:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-2-brendanhiggins@google.com>
In-Reply-To: <20191211192742.95699-2-brendanhiggins@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2019 09:42:37 +0100
Message-ID: <CACRpkdarwQT=6iSvjaTufSF9O7KcSkFxBwcvmchQ67xRddLs2g@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] pinctrl: equilibrium: add unspecified HAS_IOMEM
 dependency
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
To: Brendan Higgins <brendanhiggins@google.com>, Rahul Tanwar <rahul.tanwar@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-um@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, davidgow@google.com, anton.ivanov@cambridgegreys.com

On Wed, Dec 11, 2019 at 8:28 PM Brendan Higgins
<brendanhiggins@google.com> wrote:

> Currently CONFIG_PINCTRL_EQUILIBRIUM=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
>
> ld: drivers/pinctrl/pinctrl-equilibrium.o: in function `eqbr_pinctrl_probe':
> drivers/pinctrl/pinctrl-equilibrium.c:908: undefined reference to `devm_platform_ioremap_resource'
> ld: drivers/pinctrl/pinctrl-equilibrium.c:223: undefined reference to `devm_ioremap_resource'
>
> Fix the build error by adding the CONFIG_HAS_IOMEM=y dependency.
>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

We recently fixed a compile error by adding
depends on OF
and I think OF implies HAS_IOMEM so this should be fixed
now.

Can you confirm?

Yours,
Linus Walleij

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

