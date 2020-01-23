Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iukl6-0005Kl-HD
 for linux-um@lists.infradead.org; Thu, 23 Jan 2020 22:15:29 +0000
Received: by mail-pg1-x544.google.com with SMTP id l24so2096366pgk.2
 for <linux-um@lists.infradead.org>; Thu, 23 Jan 2020 14:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-2-brendanhiggins@google.com>
 <CACRpkdaTJej2zFX0y7mAYymBdGNvHpp3VyU0kOd=ScA_gMAf-A@mail.gmail.com>
In-Reply-To: <CACRpkdaTJej2zFX0y7mAYymBdGNvHpp3VyU0kOd=ScA_gMAf-A@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 23 Jan 2020 14:15:13 -0800
Message-ID: <CAFd5g44herz1-S-48NB=oKuTFhotHNodi7=S0Z-ffkPcqq08vQ@mail.gmail.com>
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Sorry for not getting to this before I went on vacation.

On Mon, Dec 16, 2019 at 2:39 AM Linus Walleij <linus.walleij@linaro.org> wrote:
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
> Patch applied but I augmented it with the recently added
> OF dependency so it now says:
> depends on OF && HAS_IOMEM

Probably too late now to be helpful, but I can confirm that OF does
NOT depend on HAS_IOMEM, so this patch was still needed.

Thanks regardless!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

