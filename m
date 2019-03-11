Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3Ogn-0003WR-0p
 for linux-um@lists.infradead.org; Mon, 11 Mar 2019 17:26:14 +0000
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x2BHPo1P005982
 for <linux-um@lists.infradead.org>; Tue, 12 Mar 2019 02:25:50 +0900
Received: by mail-vs1-f44.google.com with SMTP id w14so3218566vso.6
 for <linux-um@lists.infradead.org>; Mon, 11 Mar 2019 10:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190304165732.24043-1-ar@cs.msu.ru>
 <20190304165732.24043-3-ar@cs.msu.ru>
In-Reply-To: <20190304165732.24043-3-ar@cs.msu.ru>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 12 Mar 2019 02:25:13 +0900
Message-ID: <CAK7LNATzyyga_jbd_9BbEqws9PE-19L3FSxxoPwbC7ieic0yQg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: kselftest: use KCONFIG_CONFIG
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
>
> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d5713e7b1e50..4d8760166a47 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1199,9 +1199,9 @@ kselftest-clean:
>
>  PHONY += kselftest-merge
>  kselftest-merge:
> -       $(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
> +       $(if $(wildcard $(objtree)/$(KCONFIG_CONFIG)),, $(error No $(KCONFIG_CONFIG) exists, config your kernel first!))
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> -               -m $(objtree)/.config \
> +               -m $(objtree)/$(KCONFIG_CONFIG) \


You are blindly replacing .config with $(KCONFIG_CONFIG).


What kind of usage do you assume for KCONFIG_CONFIG ?

$(objtree)/$(KCONFIG_CONFIG) means
$(KCONFIG_CONFIG) never becomes an absolute path.








>                 $(srctree)/tools/testing/selftests/*/config
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
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

