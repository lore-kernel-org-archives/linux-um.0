Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A25FC79F9E
	for <linux-um@archiver.kernel.org>; Mon,  7 Sep 2026 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GC0WWsmiiFckjnXpIAV44INGlQO0KgKkCU7zQg2E+YY=; b=VQY/pk8hwr85FlIyeiVIeYwRVv
	kiNysoXlTT+S7fDvFwjQKfAqAvtcuWzuE/FpAy1s3u79ZW0ZRMnQlxHwV9wVjjS9PryM0R5LiIiGJ
	I2wEwda4slF6idUKGAOKaAU3cwpYFteCuHfJfkZ0+YvshCD+GAxfMBVz1HIpMNT9MD17rE6DZir6t
	Bf+O/R2sChGHIpUf5ET6VJVM+14cGk+4O2/t77zgeco5YDYhgdfzGpHDj5dFbNFHMaw4h3ICMYV+Z
	XK23zRcN7z0gRNCD7KsqGNOGufdFrJIVZiW1P+igSMDhDy7tBLP7nIZlGWtEnOHYLpdzbkRbotY7i
	RVWQH0kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3hAU-00000007mfR-1B2Q;
	Mon, 07 Sep 2026 21:46:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3hAR-00000007mej-11MR
	for linux-um@lists.infradead.org;
	Mon, 07 Sep 2026 21:46:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GC0WWsmiiFckjnXpIAV44INGlQO0KgKkCU7zQg2E+YY=;
	b=dqd9iSfAvIzg2LVYt3LXQy7E5x0lXcXDzt9n3MbAlJBaA1vTFIxlZnjdrdidEo+tVpMMvX
	oaV5yRrMfugtVc6IIAIqGwC2BmSJG2qo9dDbIuFpkqaWRtbtVw5x2+YzEIon4xB+dYDX+L
	w6guYl2scbwlzIhEwcmZDzUwGs9FjG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-Xas4AeKpO5KDLm0zcv1xOw-1; Mon, 07 Sep 2026 17:46:13 -0400
X-MC-Unique: Xas4AeKpO5KDLm0zcv1xOw-1
X-Mimecast-MFC-AGG-ID: Xas4AeKpO5KDLm0zcv1xOw_1788817573
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-499b99a8a10so35310585e9.0
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 14:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817572; x=1789422372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GC0WWsmiiFckjnXpIAV44INGlQO0KgKkCU7zQg2E+YY=;
        b=S1witO8JeOe77rm28dSQItkXhzS4JCxI9wrPjaP2nJhVta57nQs5wCxijBNsbFxfXg
         LMqbppJgqfuQf0wqgxmWixCCgWsQ895EM2mzLHp8neF2gC5iYhZoSs7819FgCn+rXmYk
         cdx/g12idl5KO6x1k0EXXjurU13727bkhfOhim9FKf9Tp5Pl1qx+LkKNwPtM9Fqj0q1D
         87vtdG3Q1bmUv9O/RNYxAFTdU2NZ8XopO/wlgU672CPhw9hQPmigjnfynhVuZOe+J6t+
         U0UK2u0JIAWfxN7ZBDRTzX5715OUL4MBMb/mCPRYouaqMdXAJ2XAhLpUF7lO4uhHN6jX
         iHag==
X-Forwarded-Encrypted: i=1; AKwUvByYd/YFjNJhWzE5q8OpfC7pxKZVTODITCjKA3dLm1i1n/srEuzMu/lOoLPAxtuKNiXEKN7/AUs4XA==@lists.infradead.org
X-Gm-Message-State: AFuF++lBROnDPim4sxrxgWj/7kiW5hGDxDv8vR4IZDFhAowWxPAAyA9g
	edsC2/7aQmKH7QC5acrThaAP8ECqTuKYDiphccF7Nctw+J88y+SM+Fjwbep3Dcl45yi4t4LVWVa
	PQxB2uzgBRlrJUY2b/Yi/kp/L4ICGYxfOQo7y1xa2fDDsjUgfRaArsRqiMXtpiaWetA==
X-Gm-Gg: AYBFou11LI0JJBLz+Y1J0MmQhuh0f/tCIE/CbxCtL+CWgX9O0AwvPKEhWEwlcZTc37P
	84/ikgrEEliqoNDUinWBhPp5uC3u86/rmlPPjoUN8GkOc07PNBUEyMH+v9QaBTpdg9tDdQJN9if
	8/8Au+f6Y+C6nLb/5wmQEedMak3w3xEBVIgMAz4aeN1aGuay9jV7n7StmmDMFy00U/VjIKH0V1i
	p9134JvZPBZmz1bO+ghpl9B3LO21ps33mxohrR672cPyBbjLQ8nDflaK8QKJbKl2/pk7aKLVRkh
	/GnSuqQa4ewd2BNhUB31YbBFHgD12Bazy4mcd452XSOodWGS94kY2WNrUK99K6TFa2mBKMvFVTX
	Fd/+tK2uFAOLgFvITklCI8dQ=
X-Received: by 2002:a05:600c:3145:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49d1757294bmr35387365e9.9.1788817572598;
        Mon, 07 Sep 2026 14:46:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49d1757294bmr35386945e9.9.1788817572138;
        Mon, 07 Sep 2026 14:46:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm194010325e9.8.2026.09.07.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:46:11 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:46:07 -0400
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
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <20260907174559-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-3-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5F1dIrMCWFh7HWGknGNPMDkiWY4InFKRd-b721s1Eq4_1788817573
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_144619_377625_5867DDEC 
X-CRM114-Status: GOOD (  20.87  )
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

On Sat, Sep 05, 2026 at 05:20:58PM +0200, Karl Mehltretter wrote:
> virtinput_remove() unregisters the input device before resetting the
> virtio device. virtinput_recv_events() drops vi->lock around input_event(),
> so clearing vi->ready does not stop a callback that passed the entry check.
> It can still use vi->idev, requeue buffers and kick the queue.
> 
> Reset first, as virtinput_freeze() already does. With the preceding core
> change, reset waits for callbacks before input_unregister_device() can
> free vi->idev. Recheck vi->ready after taking the lock again: keep draining
> completed events so an input packet is not truncated, but stop requeueing
> buffers and kicking the queue.
> 
> With evdev attached, input_unregister_handle() currently waits for an RCU
> grace period, which also waits out IRQ callbacks. This masks the lifetime
> bug on PCI and MMIO, but does not protect sleepable callbacks on other
> transports.
> 
> Fixes: 271c865161c5 ("Add virtio-input driver.")
> Assisted-by: LLM

which llm and which agent?

> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/virtio/virtio_input.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e682..7b654af0a42c 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
>  				    le16_to_cpu(event->code),
>  				    le32_to_cpu(event->value));
>  			spin_lock_irqsave(&vi->lock, flags);
> +			if (!vi->ready)
> +				continue;
>  			virtinput_queue_evtbuf(vi, event);
>  		}
> -		virtqueue_kick(vq);
> +		if (vi->ready)
> +			virtqueue_kick(vq);
>  	}
>  	spin_unlock_irqrestore(&vi->lock, flags);
>  }
> @@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
>  	vi->ready = false;
>  	spin_unlock_irqrestore(&vi->lock, flags);
>  
> -	input_unregister_device(vi->idev);
> +	/* Callbacks use vi->idev. */
>  	virtio_reset_device(vdev);
> +	input_unregister_device(vi->idev);
>  	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
>  		kfree(buf);
>  	vdev->config->del_vqs(vdev);
> -- 
> 2.39.5 (Apple Git-154)


