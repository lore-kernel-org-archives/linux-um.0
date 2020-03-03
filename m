Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j97tg-0001FV-9V
 for linux-um@lists.infradead.org; Tue, 03 Mar 2020 13:47:45 +0000
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 023DlO3g002116
 for <linux-um@lists.infradead.org>; Tue, 3 Mar 2020 22:47:25 +0900
Received: by mail-vs1-f43.google.com with SMTP id a2so2382848vso.3
 for <linux-um@lists.infradead.org>; Tue, 03 Mar 2020 05:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20200228034640.25247-1-masahiroy@kernel.org>
 <CAK7LNAS9uWyvFeVkxtbkuBrnqumYzzLfcsUrVByHHyons4m8hA@mail.gmail.com>
In-Reply-To: <CAK7LNAS9uWyvFeVkxtbkuBrnqumYzzLfcsUrVByHHyons4m8hA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 3 Mar 2020 22:46:47 +0900
Message-ID: <CAK7LNATyuyU46qXngDr80d51cs0-J=00jkgL1rdASUMfgmfKOw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use KBUILD_DEFCONFIG as the fallback for
 DEFCONFIG_LIST
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
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Feb 28, 2020 at 12:48 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Feb 28, 2020 at 12:47 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Most of the Kconfig commands (except defconfig and all*config) read
> > the .config file as a base set of CONFIG options.
> >
> > When it does not exist, the files in DEFCONFIG_LIST are searched in
> > this order and loaded if found.
> >
> > I do not see much sense in the last two lines in DEFCONFIG_LIST.
> >
> > [1] ARCH_DEFCONFIG
> >
> > The entry for DEFCONFIG_LIST is guarded by 'depends on !UML'. So, the
> > ARCH_DEFCONFIG definition in arch/x86/um/Kconfig is meaningless.
> >
> > arch/{sh,sparc,x86}/Kconfig define ARCH_DEFCONFIG depending on 32 or
> > 64 bit variant symbols. This is a little bit strange; ARCH_DEFCONFIG
> > should be a fixed string because the base config file is loaded before
> > the symbol evaluation stage.
> >
> > Using KBUILD_DEFCONFIG makes more sense because it is fixed before
> > Kconfig is invoked. Fortunately, arch/{sh,sparc,x86}/Makefile define it
> > in the same way, and it works as expected. Hence, replace ARCH_DEFCONFIG
> > with "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)".
> >
> > [2] arch/$(ARCH)/defconfig
> >
> > This file path is no longer valid. The defconfig files are always located
> > in the arch configs/ directories.
> >
> >   $ find arch -name defconfig | sort
> >   arch/alpha/configs/defconfig
> >   arch/arm64/configs/defconfig
> >   arch/csky/configs/defconfig
> >   arch/nds32/configs/defconfig
> >   arch/riscv/configs/defconfig
> >   arch/s390/configs/defconfig
> >   arch/unicore32/configs/defconfig
> >
> > The path arch/*/configs/defconfig is already covered by
> > "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)". So, this file path is
> > not necessary.
> >
> > I moved the default KBUILD_DEFCONFIG to the top Makefile. Otherwise,
> > the 7 architectures listed above would end up with endless loop of
> > syncconfig.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
> I forgot to say this.
> This is v2.
>
> Changes in v2:
>   - Move KBUILD_DEFCONFIG to fix endless loop of syncconfig
>
>

Applied to linux-kbuild.


Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

