Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igmjf-000406-1V
 for linux-um@lists.infradead.org; Mon, 16 Dec 2019 09:32:16 +0000
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M6UuX-1ieJkp22PJ-006vt1 for <linux-um@lists.infradead.org>; Mon, 16 Dec
 2019 10:32:10 +0100
Received: by mail-qk1-f180.google.com with SMTP id z76so1672261qka.2
 for <linux-um@lists.infradead.org>; Mon, 16 Dec 2019 01:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-2-brendanhiggins@google.com>
 <CACRpkdarwQT=6iSvjaTufSF9O7KcSkFxBwcvmchQ67xRddLs2g@mail.gmail.com>
In-Reply-To: <CACRpkdarwQT=6iSvjaTufSF9O7KcSkFxBwcvmchQ67xRddLs2g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 16 Dec 2019 10:31:53 +0100
Message-ID: <CAK8P3a1o0y5zWj3kye4o2uDVVJE6ejG0yGDJGDfZ4BK3t_rKMA@mail.gmail.com>
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
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, davidgow@google.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>, Brendan Higgins <brendanhiggins@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Mon, Dec 16, 2019 at 9:42 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Dec 11, 2019 at 8:28 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>
> > Currently CONFIG_PINCTRL_EQUILIBRIUM=y implicitly depends on
> > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > the following build error:
> >
> > ld: drivers/pinctrl/pinctrl-equilibrium.o: in function `eqbr_pinctrl_probe':
> > drivers/pinctrl/pinctrl-equilibrium.c:908: undefined reference to `devm_platform_ioremap_resource'
> > ld: drivers/pinctrl/pinctrl-equilibrium.c:223: undefined reference to `devm_ioremap_resource'
> >
> > Fix the build error by adding the CONFIG_HAS_IOMEM=y dependency.
> >
> > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> We recently fixed a compile error by adding
> depends on OF
> and I think OF implies HAS_IOMEM so this should be fixed
> now.
>
> Can you confirm?

I'm fairly sure it does not, so both patches are needed.

      Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

