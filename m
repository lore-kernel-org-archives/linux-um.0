MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1426506079-26183-8-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
	<1426506079-26183-8-git-send-email-richard@nod.at>
Date: Mon, 16 Mar 2015 13:03:03 +0100
Message-ID: <CAMuHMdXpkyvoTRYZ5X4dVNKoHA=seiYpS7pFSZc+fzxFRM=r2Q@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 07/15] hostfs: Remove open coded strcpy()
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Mar 16, 2015 at 12:41 PM, Richard Weinberger <richard@nod.at> wrote:
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -105,11 +105,10 @@ static char *__dentry_name(struct dentry *dentry, char *name)

This code looks fishy to me...

First we have:

    len = strlen(root);
    strlcpy(name, root, PATH_MAX);

(I notice the code used strncpy() before. One difference with strlcpy()
 is that strncpy() fills the remaining of the destination buffer with zeroes.)

Then:

>                 __putname(name);
>                 return NULL;
>         }
> -       if (p > name + len) {
> -               char *s = name + len;

Unless strlcpy() truncated the string (which is unlikely, as root
cannot be longer
than PATH_MAX?), s = name + len now points to the zero terminator.
So the below would copy just one single byte:

> -               while ((*s++ = *p++) != '\0')
> -                       ;
> -       }
> +
> +       if (p > name + len)
> +               strcpy(name + len, p);
> +

What is this code really supposed to do?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

