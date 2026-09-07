Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CD8C79F99
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 21:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SrHtKsbOCKteoqWFV7lfV/tXkTEj1Fv0IcHEJx72zjM=; b=Osgjm+oguYeGb93dPmRtK1vzvH
	tP8Q3hBvEbQ7mApx8yClrLPURqaQGeAAqltqvMe+PuOBBVck0F1OtivgohjLpw58k/ERUzd+ttkil
	5bz9CO0h48FVTbTRQBpo/jr8zCe6Djc1dJB5vA5x/kZaxZNrvkQWckU5jJoLOHxCQ9ObF6mlMGRUO
	8fx7ooF2n19Tq+J6ZCJ9M0n6j4w33U7cZRlGIqVrK8yKofDFtYx/MBmdI7FX5jBrUWoLXyGXrE/Jz
	29r+v4LcHvqntdQMyEvR8fVpmW/X4yffhj2WYdxqYl4qQD4rBCDgAsBFmV6qkIgwrROe4KFZiZWXW
	hbaUM38Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3h1b-00000007m04-0TGt;
	Mon, 07 Sep 2026 21:37:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3h1Z-00000007lzZ-0pEW
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 21:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SrHtKsbOCKteoqWFV7lfV/tXkTEj1Fv0IcHEJx72zjM=;
	b=KSU67eTqCZ1VIXK4VMFtF4Fh1kKEqB7M58KKmWSyWIB+k0qvqwC50tYX/9mviAK3Zs/ZJH
	ZVZ9B/19MPedjFrfi8FnouKpVAIFf4LHyBI8XeJ0pIBsID3yBvWiEyrYYlNveRW9UJQfOG
	JSqvoJh3tSyJMXfHdPgMnzbKEkca3eU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-VB4xbDlyOQqAimcJgLhDzA-1; Mon, 07 Sep 2026 17:37:07 -0400
X-MC-Unique: VB4xbDlyOQqAimcJgLhDzA-1
X-Mimecast-MFC-AGG-ID: VB4xbDlyOQqAimcJgLhDzA_1788817026
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-484362cb000so2651883f8f.0
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 14:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817026; x=1789421826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrHtKsbOCKteoqWFV7lfV/tXkTEj1Fv0IcHEJx72zjM=;
        b=k524bJSibXk3OzK75LBO1GAuOUZ6rU7xqpaDkeXbIPOqSSqjz1jQCpiZ5s3/E7hSou
         bEhKde2mON/MHsXQFuPZahWkRNCPHsL9FWVY/ePd39POS6ieEI7F/rHHnezEGd7M4fUU
         ZPhrfHx1TFWC7iakiJdu1neqjrnEGo4u5V5Jzno9a1GVeTtJdCmdbobhlLuh2aYo6XT8
         18f8oc1/CpI2JGJK5bxNF4rQSVPAVy1bElvR4Kdw4Vn3KRUHhrd1X0cRYSRG7Ysj1A38
         PU4piXVZxecVwdAPSAQZ6yVfs3Z1fgkTXeiy5l+WJwByniuHw2Sae29bDTo0YRryEXbe
         U11w==
X-Forwarded-Encrypted: i=1; AKwUvBy8Df+vGbx9t24WhgkDCfj1d/nVy2u/WVfOar5PyDpbYjSeuss5CXiwluWepvaNvd8Y7Xb942FmpA==@lists.infradead.org
X-Gm-Message-State: AFuF++mOWbY3gufMZjwDlRwoOJjAGtTyP4v+YDB8iCE1LxpItgXgQAOG
	Emz+/mg1PGNDpGiCA6PpB3x4kihamb+dfmh9aDXKyhsR0pt5ipiMhOnJdGwFuJc5PWbwPg1gfeO
	yQYycejrCS9NM6dS8AtZABsLxRoGMrzoDZKm4Ai5Xvnovydd3a6FY1gJmpPktKa6FDw==
X-Gm-Gg: AYBFou3L1WhGC/t2e+T8VeZTXBabj3WtZh10hwWWlNMYzYnwxB8yj+BdXdmYATjolSG
	Bw7C3R8QCUI9yX05n7g01h7QN/wA4yqAKaj1RIANbzfY1vu3cuUcm/tooc50x7CIDt0gJ9WU/Jn
	fnlWYRKHyLSHMQNj2DuQXtGYjXXug33p0/FwvEEiPyFU1jsnaTaR2Qj6lkqOchRp0paa7BYjyyA
	6V2hIcOF8z4yOtB++CxsNb8fkSJrOnNNCVB3ucZF9IemIVWk6XAXOCCZFxoVFoi8D83tA0ihnqs
	vM8bx7oVF5T+Iu1pikp1coceQqmc+ZAazEohOvdoEasK464hzjLXluugFE7jX4pZMeBZfds4rxb
	TAU8Q0Cmuybo7SYBfyUzgh/U=
X-Received: by 2002:adf:edc8:0:b0:482:e658:7a39 with SMTP id ffacd0b85a97d-4857e5171femr27162884f8f.11.1788817025761;
        Mon, 07 Sep 2026 14:37:05 -0700 (PDT)
X-Received: by 2002:adf:edc8:0:b0:482:e658:7a39 with SMTP id ffacd0b85a97d-4857e5171femr27162864f8f.11.1788817025220;
        Mon, 07 Sep 2026 14:37:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm35717372f8f.25.2026.09.07.14.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:37:03 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:36:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] virtio: synchronize callbacks during device reset
Message-ID: <20260907172202-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-2-kmehltretter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-2-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: featCPv_6hyi2h0x28CLEfwlw3be5EM59SZyPnQJxy8_1788817026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_143709_309762_7E476444 
X-CRM114-Status: GOOD (  30.93  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, Sep 05, 2026 at 05:20:57PM +0200, Karl Mehltretter wrote:
> virtio_reset_device() promises that vq callbacks have finished when it
> returns. virtio-pci waits in vp_reset(), but other transports can return
> with a callback still running.
> 
> Call virtio_synchronize_cbs() after config->reset() and drop the duplicate
> waits from both PCI reset methods. Add the wait to virtio_device_shutdown()
> too, since it calls config->reset() directly. Keep the pre-reset call under
> CONFIG_VIRTIO_HARDEN_NOTIFICATION so callbacks see vq->broken.
> 
> Always take irq_lock in the classic virtio-ccw interrupt handler so it
> pairs with synchronize_cbs even without notification hardening. Use
> is_thinint to choose the lock: airq_info can stay allocated after a
> fallback to classic interrupts.
> 
> The transport reset must still stop new callbacks before this wait.
> 
> Fixes: d9679d0013a6 ("virtio: wrap config->reset calls")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c   | 6 +-----
>  drivers/virtio/virtio.c            | 2 ++
>  drivers/virtio/virtio_pci_legacy.c | 2 --
>  drivers/virtio/virtio_pci_modern.c | 3 ---
>  include/linux/virtio_config.h      | 6 +++---
>  5 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index bab6cad3fd5c..552d77998012 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1062,7 +1062,7 @@ static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	struct airq_info *info = vcdev->airq_info;
>  
> -	if (info) {
> +	if (vcdev->is_thinint && info) {
>  		/*
>  		 * This device uses adapter interrupts: synchronize with
>  		 * vring_interrupt() called by virtio_airq_handler()
> @@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  			vcdev->err = -EIO;
>  	}
>  	virtio_ccw_check_activity(vcdev, activity);
> -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	/*
>  	 * Paired with virtio_ccw_synchronize_cbs() and interrupts are
>  	 * disabled here.
>  	 */
>  	read_lock(&vcdev->irq_lock);
> -#endif
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */
> @@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  		vq = virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);
>  	}
> -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	read_unlock(&vcdev->irq_lock);
> -#endif
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 75bb4ffe3b87..ad1c50b8a94e 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -264,6 +264,7 @@ void virtio_reset_device(struct virtio_device *dev)
>  #endif
>  
>  	dev->config->reset(dev);
> +	virtio_synchronize_cbs(dev);

I guess we want the "Flush VQ/config" comment here?

>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
>  
> @@ -424,6 +425,7 @@ void virtio_device_shutdown(struct virtio_device *dev)
>  	 * Some devices get wedged if this happens, so reset to make sure it does not.
>  	 */
>  	dev->config->reset(dev);
> +	virtio_synchronize_cbs(dev);
>  }

shutdown is different. vq callbacks are not the issue at all.
but config callback potentially could be.
So while we could keep this, with "Flush config" comment, perhaps
preferably, disable config callbacks like we do
for remove, before the callback:

static void virtio_dev_remove(struct device *_d)
{
        struct virtio_device *dev = dev_to_virtio(_d);
        struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);

        virtio_config_core_disable(dev);

        drv->remove(dev);

....


}




>  EXPORT_SYMBOL_GPL(virtio_device_shutdown);
>  
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d9cbb02b35a1..8115aa39e01e 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
>  	vp_legacy_get_status(&vp_dev->ldev);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..c9e21317c51a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
>  		msleep(1);
>  
>  	vp_modern_avq_cleanup(vdev);
> -
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
>  }
>  
>  static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)





> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 69f84ea85d71..8684a1e268ee 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -71,9 +71,9 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> - *      The function guarantees that all memory operations on the
> - *      queue before it are visible to the vring_interrupt() that is
> - *      called after it.
> + *      Wait for running callbacks to complete. Memory operations on the
> + *      queue before this call must be visible to vring_interrupt() calls
> + *      that follow it.
>   *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
> -- 
> 2.39.5 (Apple Git-154)


