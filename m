MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1427536169.3940.31.camel@m3y3r.de>
References: <1427536169.3940.31.camel@m3y3r.de>
Date: Mon, 30 Mar 2015 09:01:56 +0200
Message-ID: <CAMuHMdWSzOAgrC7xUpV7CGGb5NegGSi2JGuj8z-H7MjkdCs04w@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Print minimum physical memory requirement
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Mar 28, 2015 at 10:49 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
>
> Print a more sensible message about the minimum physical memory
> requirement.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> index 549ecf3..a91cf05 100644
> --- a/arch/um/kernel/physmem.c
> +++ b/arch/um/kernel/physmem.c
> @@ -63,16 +63,23 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
>         unsigned long reserve = reserve_end - start;
>         int pfn = PFN_UP(__pa(reserve_end));
>         int delta = (len - reserve) >> PAGE_SHIFT;
> -       int err, offset, bootmap_size;
> +       int err, offset, bootmap_size, map_size;

I think all "int" variables in this function (except for "err") should be
"unsigned long", to avoid overflows on 64-bit systems.

> +       offset = uml_reserved - uml_physmem;
> +       map_size = len - offset;
> +       if(map_size <= 0) {
> +               printf("Too few physical memory! Needed=%d, given=%d\n",
> +                      offset, len);
> +               exit(1);
> +       }
>
>         physmem_fd = create_mem_file(len + highmem);
>
> -       offset = uml_reserved - uml_physmem;
>         err = os_map_memory((void *) uml_reserved, physmem_fd, offset,
> -                           len - offset, 1, 1, 1);
> +                           map_size, 1, 1, 1);
>         if (err < 0) {
>                 printf("setup_physmem - mapping %ld bytes of memory at 0x%p "
> -                      "failed - errno = %d\n", len - offset,
> +                      "failed - errno = %d\n", map_size,
>                        (void *) uml_reserved, err);
>                 exit(1);
>         }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

