MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <DUB128-W57E673D474548BF61C14F09C9C0@phx.gbl>
References: <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>
	<55A3A5E0.8030802@nod.at>
	<DUB128-W657ACA17D13F07E1D42A339C9C0@phx.gbl>
	<CAMuHMdUjwQF3Lhcyo0L_TNGECtKMbOdDp+fixiyj=Svw7XeuXg@mail.gmail.com>
	<DUB128-W57E673D474548BF61C14F09C9C0@phx.gbl>
Date: Mon, 13 Jul 2015 17:26:20 +0200
Message-ID: <CAMuHMdWNE86shNgXqs8ZWJXeUf1L8eqK41GDfYvCHdFHefz9Kw@mail.gmail.com>
Subject: Re: [uml-devel] linux-4.2-rc2/arch/um/drivers/net_user.c:258:
 possible missing call to va_end ?
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: David Binderman <dcb314@hotmail.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi David,

On Mon, Jul 13, 2015 at 4:57 PM, David Binderman <dcb314@hotmail.com> wrote:
> Hello there Geert,
>
> ----------------------------------------
>> In that case we feel obliged to guide you to a proper patch submission.
>>
>> Please give it a try. We won't bite ;-)
>
> Since you've been so nice about it, here is my umpteenth go at a
> linux kernel patch.

Thanks for your patch!

As Jeff already commented, you should include a proper patch description.

> Signed-off-by: David Binderman <dcb314@hotmail.com>
>
> --- linux-4.2-rc2/arch/um/drivers/net_user.c.sav    2015-07-13 15:41:33.2115
> 48852 +0100
> +++ linux-4.2-rc2/arch/um/drivers/net_user.c    2015-07-13 15:42:50.191786525 +0
> 100
> @@ -254,13 +254,17 @@ char *split_if_spec(char *str, ...)
>
>      va_start(ap, str);
>      while ((arg = va_arg(ap, char **)) != NULL) {
> -        if (*str == '\0')
> +        if (*str == '\0') {
> +            va_end(ap);
>              return NULL;
> +        }
>          end = strchr(str, ',');
>          if (end != str)
>              *arg = str;
> -        if (end == NULL)
> +        if (end == NULL) {
> +            va_end(ap);
>              return NULL;
> +        }
>          *end++ = '\0';
>          str = end;
>      }

Unfortunately the patch is whitespace-damaged.
Did you paste it in a web-based email client?

Do you use git?
If yes, perhaps you can use git-send-email.

Based on http://www.serversmtp.com/en/smtp-hotmail, I would try to
add the following to .gitconfig:

[sendemail]
        smtpencryption = ssl
        smtpserver = smtp.live.com
        smtpuser = your Hotmail account
        smtppass = your Hotmail password
        smtpserverport = 465

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

