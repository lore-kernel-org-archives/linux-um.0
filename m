MIME-Version: 1.0
Date: Wed, 1 Sep 2021 15:41:47 +0200
References: <20210830221000.179369-1-mcgrof@kernel.org>
	<20210830221000.179369-2-mcgrof@kernel.org>
In-Reply-To: <20210830221000.179369-2-mcgrof@kernel.org>
Message-ID: <CAMuHMdUUrp-ktVmOPRs7KinykrVKEMx-dG42RapPc-egxODNnQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] z2ram: add error handling support for add_disk()
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, justin@coraid.com, Ulf Hansson <ulf.hansson@linaro.org>, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes.berg@intel.com>, chris.obbard@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>, YiFei Zhu <zhuyifei1999@gmail.com>, thehajime@gmail.com, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Tim Waugh <tim@cyberelk.net>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, linux-um <linux-um@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Lars Ellenberg <drbd-dev@lists.linbit.com>, linux-block@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi Luis,

On Tue, Aug 31, 2021 at 12:10 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling. Only the disk is cleaned up inside
> z2ram_register_disk() as the caller deals with the rest.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for your patch!

> --- a/drivers/block/z2ram.c
> +++ b/drivers/block/z2ram.c
> @@ -318,6 +318,7 @@ static const struct blk_mq_ops z2_mq_ops = {
>  static int z2ram_register_disk(int minor)
>  {
>         struct gendisk *disk;
> +       int err;
>
>         disk = blk_mq_alloc_disk(&tag_set, NULL);
>         if (IS_ERR(disk))
> @@ -333,8 +334,10 @@ static int z2ram_register_disk(int minor)
>                 sprintf(disk->disk_name, "z2ram");
>
>         z2ram_gendisk[minor] = disk;
> -       add_disk(disk);
> -       return 0;
> +       err = add_disk(disk);
> +       if (err)
> +               blk_cleaup_disk(disk);

blk_cleanup_disk()?

Seems like lkp already detected this back in July...

> +       return err;
>  }
>
>  static int __init z2_init(void)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

