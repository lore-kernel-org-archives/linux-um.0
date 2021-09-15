MIME-Version: 1.0
Date: Wed, 15 Sep 2021 20:42:08 +0200
References: <20210915203021.1454bd968b28.I160cb938058758bba3cb1968419314dbeb9dc004@changeid>
In-Reply-To: <20210915203021.1454bd968b28.I160cb938058758bba3cb1968419314dbeb9dc004@changeid>
Message-ID: <CAMuHMdVykBS3CU7OaxuUxiW=UGL06AX+OO91ntZ8SPj=882qSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] um: virt-pci: fix 32-bit compile
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes.berg@intel.com>, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <linux-um.lists.infradead.org>

Hi Johannes,

On Wed, Sep 15, 2021 at 8:30 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> There were a few 32-bit compile warnings that of course
> turned into errors with -Werror, fix the 32-bit build.
>
> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks for your patch!

> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -181,15 +181,15 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
>         /* buf->data is maximum size - we may only use parts of it */
>         struct um_pci_message_buffer *buf;
>         u8 *data;
> -       unsigned long ret = ~0ULL;
> +       unsigned long ret = ULONG_MAX;

Why not just drop the last "L"? ;-)

>
>         if (!dev)
> -               return ~0ULL;
> +               return ULONG_MAX;
>
>         buf = get_cpu_var(um_pci_msg_bufs);
>         data = buf->data;
>
> -       memset(data, 0xff, sizeof(data));
> +       memset(buf->data, 0xff, sizeof(buf->data));

The first change is not needed.
The second change is a genuine bug fix, also on 64-bit, which should be
submitted separately, and backported to stable.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

