Return-Path: <krisman@collabora.com>
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH 05/15] um/drivers/ubd_kern: add error handling support
 for add_disk()
References: <20210830221000.179369-1-mcgrof@kernel.org>
	<20210830221000.179369-6-mcgrof@kernel.org>
Date: Wed, 01 Sep 2021 11:24:55 -0400
In-Reply-To: <20210830221000.179369-6-mcgrof@kernel.org> (Luis Chamberlain's
	message of "Mon, 30 Aug 2021 15:09:50 -0700")
Message-ID: <8735qotj20.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org, ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, chris.obbard@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com, chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net, linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Luis Chamberlain <mcgrof@kernel.org> writes:

> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> ubd_disk_register() never returned an error, so just fix
> that now and let the caller handle the error condition.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

> ---
>  arch/um/drivers/ubd_kern.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index cd9dc0556e91..81045c199c30 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -854,8 +854,8 @@ static const struct attribute_group *ubd_attr_groups[] = {
>  	NULL,
>  };
>  
> -static void ubd_disk_register(int major, u64 size, int unit,
> -			      struct gendisk *disk)
> +static int ubd_disk_register(int major, u64 size, int unit,
> +			     struct gendisk *disk)
>  {
>  	disk->major = major;
>  	disk->first_minor = unit << UBD_SHIFT;
> @@ -872,7 +872,7 @@ static void ubd_disk_register(int major, u64 size, int unit,
>  
>  	disk->private_data = &ubd_devs[unit];
>  	disk->queue = ubd_devs[unit].queue;
> -	device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
> +	return device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
>  }
>  
>  #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
> @@ -919,10 +919,15 @@ static int ubd_add(int n, char **error_out)
>  	blk_queue_write_cache(ubd_dev->queue, true, false);
>  	blk_queue_max_segments(ubd_dev->queue, MAX_SG);
>  	blk_queue_segment_boundary(ubd_dev->queue, PAGE_SIZE - 1);
> -	ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
> +	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
> +	if (err)
> +		goto out_cleanup_disk;
> +
>  	ubd_gendisk[n] = disk;
>  	return 0;
>  
> +out_cleanup_disk:
> +	blk_cleanup_disk(disk);
>  out_cleanup_tags:
>  	blk_mq_free_tag_set(&ubd_dev->tag_set);
>  out:

-- 
Gabriel Krisman Bertazi

