Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1449001135-29980-1-git-send-email-geyslan@gmail.com>
References: <1449001135-29980-1-git-send-email-geyslan@gmail.com>
Date: Tue, 8 Dec 2015 22:32:41 +0100
Message-ID: <CAFLxGvxLaMtDhiHgTu8V_QpeUc4DrYd+9TbDT4dbCZj0+x46pw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: fix returns without va_end
To: "Geyslan G. Bem" <geyslan@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Hans-Werner Hilse <hwhilse@gmail.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, jg.victorino1@gmail.com, peter.senna@gmail.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Dec 1, 2015 at 9:18 PM, Geyslan G. Bem <geyslan@gmail.com> wrote:
> When using va_list ensure that va_start will be followed by va_end.
>
> Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
> ---
>  arch/um/drivers/net_user.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
> index e697a41..e9f8445 100644
> --- a/arch/um/drivers/net_user.c
> +++ b/arch/um/drivers/net_user.c
> @@ -249,21 +249,23 @@ void close_addr(unsigned char *addr, unsigned char *netmask, void *arg)
>
>  char *split_if_spec(char *str, ...)
>  {
> -       char **arg, *end;
> +       char **arg, *end, *ret = NULL;
>         va_list ap;
>
>         va_start(ap, str);
>         while ((arg = va_arg(ap, char **)) != NULL) {
>                 if (*str == '\0')
> -                       return NULL;
> +                       goto out;
>                 end = strchr(str, ',');
>                 if (end != str)
>                         *arg = str;
>                 if (end == NULL)
> -                       return NULL;
> +                       goto out;
>                 *end++ = '\0';
>                 str = end;
>         }
> +       ret = str;
> +out:
>         va_end(ap);
> -       return str;
> +       return ret;
>  }

Applied! :)

-- 
Thanks,
//richard
