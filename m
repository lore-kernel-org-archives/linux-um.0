Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfZF-0006q0-Mh
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:34:07 +0000
Received: by mail-wm1-x341.google.com with SMTP id b12so17709155wmj.3
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200130192226.2776-1-krzk@kernel.org>
 <6e686a54-2e1c-b690-d465-369e0d712bba@cambridgegreys.com>
In-Reply-To: <6e686a54-2e1c-b690-d465-369e0d712bba@cambridgegreys.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:33:51 +0200
Message-ID: <CAFLxGvyPRUPkEdntpiN34sviz4D275E_bYCqi0hkwmycZ+ZvTQ@mail.gmail.com>
Subject: Re: [PATCH] um: configs: Cleanup CONFIG_IOSCHED_CFQ
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>

On Mon, Feb 10, 2020 at 3:41 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 30/01/2020 19:22, Krzysztof Kozlowski wrote:
> > CONFIG_IOSCHED_CFQ is since commit f382fb0bcef4 ("block: remove legacy
> > IO schedulers").
> >
> > The IOSCHED_BFQ seems to replace IOSCHED_CFQ so select it in configs
> > previously choosing the latter.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   arch/um/configs/i386_defconfig   | 2 +-
> >   arch/um/configs/x86_64_defconfig | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> > index 73e98bb57bf5..fb51bd206dbe 100644
> > --- a/arch/um/configs/i386_defconfig
> > +++ b/arch/um/configs/i386_defconfig
> > @@ -26,7 +26,7 @@ CONFIG_SLAB=y
> >   CONFIG_MODULES=y
> >   CONFIG_MODULE_UNLOAD=y
> >   # CONFIG_BLK_DEV_BSG is not set
> > -CONFIG_IOSCHED_CFQ=m
> > +CONFIG_IOSCHED_BFQ=m
> >   CONFIG_SSL=y
> >   CONFIG_NULL_CHAN=y
> >   CONFIG_PORT_CHAN=y
> > diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> > index 3281d7600225..477b87317424 100644
> > --- a/arch/um/configs/x86_64_defconfig
> > +++ b/arch/um/configs/x86_64_defconfig
> > @@ -24,7 +24,7 @@ CONFIG_SLAB=y
> >   CONFIG_MODULES=y
> >   CONFIG_MODULE_UNLOAD=y
> >   # CONFIG_BLK_DEV_BSG is not set
> > -CONFIG_IOSCHED_CFQ=m
> > +CONFIG_IOSCHED_BFQ=m
> >   CONFIG_SSL=y
> >   CONFIG_NULL_CHAN=y
> >   CONFIG_PORT_CHAN=y
> >
>
> Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Applied, thanks!

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

