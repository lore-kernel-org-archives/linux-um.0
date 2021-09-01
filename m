Return-Path: <mcgrof@infradead.org>
Date: Wed, 1 Sep 2021 12:41:25 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 01/15] z2ram: add error handling support for add_disk()
Message-ID: <YS/XZeu3J3nAXUll@bombadil.infradead.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
 <20210830221000.179369-2-mcgrof@kernel.org>
 <CAMuHMdUUrp-ktVmOPRs7KinykrVKEMx-dG42RapPc-egxODNnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUrp-ktVmOPRs7KinykrVKEMx-dG42RapPc-egxODNnQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, justin@coraid.com, Ulf Hansson <ulf.hansson@linaro.org>, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes.berg@intel.com>, chris.obbard@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>, YiFei Zhu <zhuyifei1999@gmail.com>, thehajime@gmail.com, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Tim Waugh <tim@cyberelk.net>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, linux-um <linux-um@lists.infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Lars Ellenberg <drbd-dev@lists.linbit.com>, linux-block@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Wed, Sep 01, 2021 at 03:41:47PM +0200, Geert Uytterhoeven wrote:
> > --- a/drivers/block/z2ram.c
> > +++ b/drivers/block/z2ram.c
> > @@ -333,8 +334,10 @@ static int z2ram_register_disk(int minor)
> >                 sprintf(disk->disk_name, "z2ram");
> >
> >         z2ram_gendisk[minor] = disk;
> > -       add_disk(disk);
> > -       return 0;
> > +       err = add_disk(disk);
> > +       if (err)
> > +               blk_cleaup_disk(disk);
> 
> blk_cleanup_disk()?

Fixed thanks.

  Luis

