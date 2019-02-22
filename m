Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAS9-000685-6p
 for linux-um@lists.infradead.org; Fri, 22 Feb 2019 13:01:28 +0000
Subject: Re: [bug report] um: Convert ubd driver to blk-mq
References: <20190222111100.GA19880@kadam>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <c2bc44f1-3a00-307b-4b21-3d08c788e4f7@cambridgegreys.com>
Date: Fri, 22 Feb 2019 12:31:50 +0000
MIME-Version: 1.0
In-Reply-To: <20190222111100.GA19880@kadam>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Dan Carpenter <dan.carpenter@oracle.com>, richard@nod.at
Cc: linux-um@lists.infradead.org

On 22/02/2019 11:11, Dan Carpenter wrote:
> Hello Richard Weinberger,
>
> The patch 4e6da0fe8058: "um: Convert ubd driver to blk-mq" from Nov
> 26, 2017, leads to the following static checker warning:
>
> 	arch/um/drivers/ubd_kern.c:972 ubd_add()
> 	error: 'ubd_dev->queue' dereferencing possible ERR_PTR()
>
> arch/um/drivers/ubd_kern.c
>      911 static int ubd_add(int n, char **error_out)
>      912 {
>      913 	struct ubd *ubd_dev = &ubd_devs[n];
>      914 	int err = 0;
>      915
>      916 	if(ubd_dev->file == NULL)
>      917 		goto out;
>      918
>      919 	err = ubd_file_size(ubd_dev, &ubd_dev->size);
>      920 	if(err < 0){
>      921 		*error_out = "Couldn't determine size of device's file";
>      922 		goto out;
>      923 	}
>      924
>      925 	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
>      926
>      927 	ubd_dev->tag_set.ops = &ubd_mq_ops;
>      928 	ubd_dev->tag_set.queue_depth = 64;
>      929 	ubd_dev->tag_set.numa_node = NUMA_NO_NODE;
>      930 	ubd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>      931 	ubd_dev->tag_set.driver_data = ubd_dev;
>      932 	ubd_dev->tag_set.nr_hw_queues = 1;
>      933
>      934 	err = blk_mq_alloc_tag_set(&ubd_dev->tag_set);
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We do want to clean up this allocation.
>
>      935 	if (err)
>      936 		goto out;
>      937
>      938 	ubd_dev->queue = blk_mq_init_queue(&ubd_dev->tag_set);
>      939 	if (IS_ERR(ubd_dev->queue)) {
>      940 		err = PTR_ERR(ubd_dev->queue);
>      941 		goto out_cleanup;
>                          ^^^^^^^^^^^^^^^^
> But this goto will Oops.
>
>      942 	}
>      943
>      944 	ubd_dev->queue->queuedata = ubd_dev;
>      945 	blk_queue_write_cache(ubd_dev->queue, true, false);
>      946
>      947 	blk_queue_max_segments(ubd_dev->queue, MAX_SG);
>      948 	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, &ubd_gendisk[n]);
>      949 	if(err){
>      950 		*error_out = "Failed to register device";
>      951 		goto out_cleanup_tags;
>      952 	}
>      953
>      954 	if (fake_major != UBD_MAJOR)
>      955 		ubd_disk_register(fake_major, ubd_dev->size, n,
>      956 				  &fake_gendisk[n]);
>      957
>      958 	/*
>      959 	 * Perhaps this should also be under the "if (fake_major)" above
>      960 	 * using the fake_disk->disk_name
>      961 	 */
>      962 	if (fake_ide)
>      963 		make_ide_entries(ubd_gendisk[n]->disk_name);
>      964
>      965 	err = 0;
>      966 out:
>      967 	return err;
>      968
>      969 out_cleanup_tags:
>      970 	blk_mq_free_tag_set(&ubd_dev->tag_set);
>      971 out_cleanup:
> --> 972 	blk_cleanup_queue(ubd_dev->queue);
>                                    ^^^^^^^^^^^^^^
>
>      973 	goto out;
>      974 }
>
> regards,
> dan carpenter
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>
Thanks Dan, will look into it today.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

