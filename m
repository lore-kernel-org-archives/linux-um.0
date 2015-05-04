MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1430744021-4140-1-git-send-email-richard@nod.at>
References: <1430744021-4140-1-git-send-email-richard@nod.at>
Date: Mon, 4 May 2015 15:22:13 +0200
Message-ID: <CAMuHMdVEJPoBJmMV7EPLNBunpER86ZXKGSTfVDhR3y6GYM-xrg@mail.gmail.com>
Subject: Re: [PATCH] hostfs: Use correct mask for file mode
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, markus.stenberg@iki.fi
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, May 4, 2015 at 2:53 PM, Richard Weinberger <richard@nod.at> wrote:
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -581,7 +581,7 @@ static int hostfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>         if (name == NULL)
>                 goto out_put;
>
> -       fd = file_create(name, mode & S_IFMT);
> +       fd = file_create(name, mode & 0777);

"(S_IRWXU | S_IRWXG | S_IRWXO)"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

