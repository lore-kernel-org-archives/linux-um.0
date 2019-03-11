Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3OYH-0007rV-1V
 for linux-um@lists.infradead.org; Mon, 11 Mar 2019 17:17:26 +0000
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x2BHGo7E011754
 for <linux-um@lists.infradead.org>; Tue, 12 Mar 2019 02:16:51 +0900
Received: by mail-vk1-f174.google.com with SMTP id v131so1254886vkd.3
 for <linux-um@lists.infradead.org>; Mon, 11 Mar 2019 10:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190304165732.24043-1-ar@cs.msu.ru>
 <20190304165732.24043-2-ar@cs.msu.ru>
In-Reply-To: <20190304165732.24043-2-ar@cs.msu.ru>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 12 Mar 2019 02:16:13 +0900
Message-ID: <CAK7LNARThXJ_+uL-oQN7YAL2ODpfo5kx09WwrTvxa1wdM4VV3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] kconfig/Makefile: localmodconfig: use KCONFIG_CONFIG
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
To: Arseny Maslennikov <ar@cs.msu.ru>
Cc: Michal Marek <michal.lkml@markovi.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Mar 5, 2019 at 1:58 AM Arseny Maslennikov <ar@cs.msu.ru> wrote:
>
> If the config file is reassigned through the KCONFIG_CONFIG
> makeflag/envvar, this rule still attempts to use the wrong, possibly
> nonexistent file.
> Let's fix that.


Are you just replacing .config with KCONFIG_CONFIG at random?

scripts/kconfig/streamline_config.pl
hard-codes the .config path,
so this does not work anyway.




> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---
>  scripts/kconfig/Makefile | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 1c7ac07def4d..28be91964a20 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -44,14 +44,14 @@ build_xconfig: $(obj)/qconf
>
>  localyesconfig localmodconfig: $(obj)/conf
>         $(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
> -       $(Q)if [ -f .config ]; then                                     \
> -                       cmp -s .tmp.config .config ||                   \
> -                       (mv -f .config .config.old.1;                   \
> -                        mv -f .tmp.config .config;                     \
> +       $(Q)if [ -f $(KCONFIG_CONFIG) ]; then                           \
> +                       cmp -s .tmp.config $(KCONFIG_CONFIG) ||         \
> +                       (mv -f $(KCONFIG_CONFIG) .tmp.config.old.1;     \
> +                        mv -f .tmp.config $(KCONFIG_CONFIG);           \
>                          $< $(silent) --oldconfig $(Kconfig);           \
> -                        mv -f .config.old.1 .config.old)               \
> +                        mv -f .tmp.config.old.1 $(KCONFIG_CONFIG).old) \
>         else                                                            \
> -                       mv -f .tmp.config .config;                      \
> +                       mv -f .tmp.config $(KCONFIG_CONFIG);            \
>                         $< $(silent) --oldconfig $(Kconfig);            \
>         fi
>         $(Q)rm -f .tmp.config
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

