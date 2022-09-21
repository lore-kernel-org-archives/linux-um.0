MIME-Version: 1.0
Date: Wed, 21 Sep 2022 12:16:48 +0200
References: <20220921092944.230413-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220921092944.230413-1-ye.xingchen@zte.com.cn>
Message-ID: <CAMuHMdUtXQJDBMDBROHa0md5eFvnjtLNNBVvWjLKEPRxFzgg2g@mail.gmail.com>
Subject: Re: [PATCH linux-next] um: use strscpy() is more robust and safer
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: cgel.zte@gmail.com
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, baihaowen@meizu.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
List-ID: <linux-um.lists.infradead.org>

Hi Ye,

On Wed, Sep 21, 2022 at 11:45 AM <cgel.zte@gmail.com> wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
>
> That's now the recommended way to copy NUL terminated strings.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Thanks for your patch!

> --- a/arch/um/os-Linux/umid.c
> +++ b/arch/um/os-Linux/umid.c
> @@ -262,7 +262,7 @@ static int __init make_umid(void)
>         make_uml_dir();
>
>         if (*umid == '\0') {
> -               strlcpy(tmp, uml_dir, sizeof(tmp));
> +               strscpy(tmp, uml_dir, sizeof(tmp));
>                 strlcat(tmp, "XXXXXX", sizeof(tmp));

Do we need strscat(), too? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

