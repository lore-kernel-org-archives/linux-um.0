Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCi6W-0000gN-Qe
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 09:27:02 +0000
Date: Wed, 17 Oct 2018 12:26:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] um: Convert ubd driver to blk-mq
Message-ID: <20181017092637.p77e2ien4hrys7qy@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: richard@nod.at
Cc: linux-um@lists.infradead.org

Hello Richard Weinberger,

The patch 4e6da0fe8058: "um: Convert ubd driver to blk-mq" from Nov
26, 2017, leads to the following static checker warning:

	arch/um/drivers/ubd_kern.c:963 ubd_add()
	error: 'ubd_dev->queue' dereferencing possible ERR_PTR()

arch/um/drivers/ubd_kern.c
   921          ubd_dev->tag_set.cmd_size = sizeof(struct ubd_pdu);
   922          ubd_dev->tag_set.driver_data = ubd_dev;
   923          ubd_dev->tag_set.nr_hw_queues = 1;
   924  
   925          err = blk_mq_alloc_tag_set(&ubd_dev->tag_set);
   926          if (err)
   927                  goto out;
   928  
   929          ubd_dev->queue = blk_mq_init_queue(&ubd_dev->tag_set);
   930          if (IS_ERR(ubd_dev->queue)) {
   931                  err = PTR_ERR(ubd_dev->queue);
   932                  goto out_cleanup;
                        ^^^^^^^^^^^^^^^^^

   933          }
   934  
   935          ubd_dev->queue->queuedata = ubd_dev;
   936          blk_queue_write_cache(ubd_dev->queue, true, false);
   937  
   938          blk_queue_max_segments(ubd_dev->queue, MAX_SG);
   939          err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, &ubd_gendisk[n]);
   940          if(err){
   941                  *error_out = "Failed to register device";
   942                  goto out_cleanup_tags;
   943          }
   944  
   945          if (fake_major != UBD_MAJOR)
   946                  ubd_disk_register(fake_major, ubd_dev->size, n,
   947                                    &fake_gendisk[n]);
   948  
   949          /*
   950           * Perhaps this should also be under the "if (fake_major)" above
   951           * using the fake_disk->disk_name
   952           */
   953          if (fake_ide)
   954                  make_ide_entries(ubd_gendisk[n]->disk_name);
   955  
   956          err = 0;
   957  out:
   958          return err;
   959  
   960  out_cleanup_tags:
   961          blk_mq_free_tag_set(&ubd_dev->tag_set);
   962  out_cleanup:
   963          blk_cleanup_queue(ubd_dev->queue);
                                  ^^^^^^^^^^^^^^
Dereferenced inside the function.

   964          goto out;
   965  }

regards,
dan carpenter

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

