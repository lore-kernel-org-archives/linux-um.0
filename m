Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCjf0-0000de-Fg
 for linux-um@lists.infradead.org; Tue, 24 Sep 2019 12:11:16 +0000
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x8OCAXFB021398
 for <linux-um@lists.infradead.org>; Tue, 24 Sep 2019 21:10:33 +0900
Received: by mail-ua1-f54.google.com with SMTP id r19so460953uap.9
 for <linux-um@lists.infradead.org>; Tue, 24 Sep 2019 05:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <c8cbee753dc0306fd7597f43a45e05d99d404b29.camel@sipsolutions.net>
In-Reply-To: <c8cbee753dc0306fd7597f43a45e05d99d404b29.camel@sipsolutions.net>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 24 Sep 2019 21:09:56 +0900
Message-ID: <CAK7LNATkejPwwsfJoR4veX+pvCnoK4Seg-ZOcDrZgeTaJTfp0w@mail.gmail.com>
Subject: Re: static EXPORT_SYMBOL checker causes false positives on ARCH=um
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Emil Velikov <emil.l.velikov@gmail.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

Hi Johannes,

On Tue, Sep 24, 2019 at 5:17 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi,
>
> With the new commit 15bfc2348d54 ("modpost: check for static
> EXPORT_SYMBOL* functions") we get a lot of warnings on ARCH=um builds:
>
> WARNING: "rename" [vmlinux] is a static EXPORT_SYMBOL
> WARNING: "lseek" [vmlinux] is a static EXPORT_SYMBOL
> WARNING: "ftruncate64" [vmlinux] is a static EXPORT_SYMBOL
> [...]
> see https://p.sipsolutions.net/7232995f34907b9d.txt

Thanks for the report.

I think this should work:
https://lore.kernel.org/patchwork/patch/1131017/

It fixes "__guard" and "__stack_smash_handler" too.


Thanks.



>
>
> This hack fixes *most* of them:
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 820eed87fb43..3e443563ebea 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1931,12 +1931,18 @@ static void check_sec_ref(struct module *mod, const char *modname,
>  static char *remove_dot(char *s)
>  {
>         size_t n = strcspn(s, ".");
> +       char *at;
>
>         if (n && s[n]) {
>                 size_t m = strspn(s + n + 1, "0123456789");
>                 if (m && (s[n + m] == '.' || s[n + m] == 0))
>                         s[n] = 0;
>         }
> +
> +       at = strchr(s, '@');
> +       if (at)
> +               *at = 0;
> +
>         return s;
>  }
>
>
> (but obviously just serves to give you an idea of what's going on).
>
>
> With that, only two remain for me:
>
> WARNING: "__guard" [vmlinux] is a static EXPORT_SYMBOL
> WARNING: "__stack_smash_handler" [vmlinux] is a static EXPORT_SYMBOL
>
> and I think that's because they don't even exist at all, so arguably the
> code shouldn't export them, but I didn't find a way to detect at build
> time if -fstack-protector was enabled or not?
>
> Any thoughts?
>
> Thanks,
> johannes
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

