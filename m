MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20140827152832.7767.53131.stgit@alan.etchedpixels.co.uk>
References: <20140827152832.7767.53131.stgit@alan.etchedpixels.co.uk>
Date: Wed, 27 Aug 2014 20:14:48 +0200
Message-ID: <CAMuHMdV-GbO1eaEKTMhjhRexzUA8Gzt0ZcjstUN3v9W78V+Dvw@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um,ethertap: use strncpy
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Aug 27, 2014 at 5:28 PM, Alan <gnomes@lxorguk.ukuu.org.uk> wrote:
> I can't prove the case pointed out in
> https://bugzilla.kernel.org/show_bug.cgi?id=82341
> is correct so let us play safe.
>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>  arch/um/os-Linux/drivers/ethertap_user.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
> index b39b669..6d49182 100644
> --- a/arch/um/os-Linux/drivers/ethertap_user.c
> +++ b/arch/um/os-Linux/drivers/ethertap_user.c
> @@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
>         sprintf(data_fd_buf, "%d", data_remote);
>         sprintf(version_buf, "%d", UML_NET_VERSION);
>         if (gate != NULL) {
> -               strcpy(gate_buf, gate);
> +               strncpy(gate_buf, gate, 15);

This will copy at most 15 bytes.
If "gate" contains 15 or more characters, gate_buf[] won't be
zero-terminated.
I think you better use strlcpy(), unless the remaining of the buffer
must be filled with zeroes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

