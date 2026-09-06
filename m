Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3355EC79F8C
	for <linux-um@archiver.kernel.org>; Sun,  6 Sep 2026 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RFAyqu/vjWVl9+ogYvQ74BpZIagkpPa2HIVHVUx9n8A=; b=dDpYImz2SWq2U39VITp/PAfUFI
	3EHcy+NYEhYKOGmNe+6slbhX8HYNivCcTwVHEh0CMOvljoVecHCUed0b83aUsdTjAiQmjG9Uv50am
	UbaKTGp+6gMl6W+nV8kRPs0gnLTAcIlj7CBO7qdmgFfIrhCQjxaZEY3+TZk7CyvHDgpxnmbHT+oe1
	0WeO/Gk9svnxM/35cBoLWzE0ozTPbVa833YGY927EVa/i3NoONGK1U6sTKoydop4aL//dEqGKfPVO
	W0QCZG2P138gFDfwjgsLNEHZ8w1qBYOtEXinaIeP3bKhMaGTqkFwnLYKxRsIApFL0xlKcWMSX8/BN
	nKrI6Wmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x36jb-00000004mhh-1PpQ;
	Sun, 06 Sep 2026 06:52:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x36jY-00000004mhE-06Qr
	for linux-um@lists.infradead.org;
	Sun, 06 Sep 2026 06:52:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788677526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFAyqu/vjWVl9+ogYvQ74BpZIagkpPa2HIVHVUx9n8A=;
	b=WC/pmLF8XZX+T6aS00R559+fczg6hAefHq5/Mir9jo98+lnanfI7uwOd5GAfUol0hJztSk
	9PAi2jMBO37ct27SjUHpAGS2umJAyQ7QjYRjtPHBNgC5s/aIekxsiuBpDuMQSVhsvtUZl/
	ubJrburrjzP6vB/NBeBNuJxESKha4K0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-mquH4gnYN4aRygDhSjl7Ig-1; Sun, 06 Sep 2026 02:52:05 -0400
X-MC-Unique: mquH4gnYN4aRygDhSjl7Ig-1
X-Mimecast-MFC-AGG-ID: mquH4gnYN4aRygDhSjl7Ig_1788677524
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4957287363bso19071485e9.0
        for <linux-um@lists.infradead.org>; Sat, 05 Sep 2026 23:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788677524; x=1789282324;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFAyqu/vjWVl9+ogYvQ74BpZIagkpPa2HIVHVUx9n8A=;
        b=g7ulw/IiddQoF1iytcvdFoXS9V11Lv8AP3k+//rTHl+g+nbxfZlN/2lK0lP2jo/mk1
         xwivcgZQ+mRvTSGXxynp5QgxWuQUqwpuBhplchsPRKqoHAdHqQI5coA01ka4E5IyZnYf
         GPXOSGmu+WAe3yqyL7PNR8cpnIjWGjodOqydWUnBjw/AmdJmQHtoPnYYuYA+JyWoFb4T
         WNr01JYniMgzckMQ6jCef+7DF/D0WTTEzWWvSC+5n5GYbQcsWyHNipokwiRaNBj+1uI8
         EkPqL8KUYsPnJBJfFb6d+va/UXW73+z46BP5eJ6P3WU4Sp1pIeZmMEoKkrQyeL7Md5lG
         MCKA==
X-Forwarded-Encrypted: i=1; AKwUvBxGlXSy4YLUlyK8IvQp5bW7RAkw4Gt+Cbm59pQFQbY2llkPNsufwiy9Ish1lLapyZ6JyfzonJerOQ==@lists.infradead.org
X-Gm-Message-State: AFuF++k3kaYJo4TERUll1c+E36OADMTWbcM7kveEeL8V/xxBm7Xux9Nf
	rzxszEGmkeWDfV6AOzEvUloopnZHCjFuFakJteJ66mifE51HaR3XSqfki1IQDPoUQLwn5TxOGYe
	iOFOnr05itnWeUNE2PAK7JOKL/QZlaXNKoL+17WduArPGvZJH7JEHh8CMWKQWkJ4Odg==
X-Gm-Gg: AYBFou1uuNn4tzExHSyx4tDgfG647kipwrM39kZ5bTl6KIrOo1OxPOt7++17h/HfyAi
	tZymQRG4Nwi5e/dvzzMD1x8piyQYqPNeo9aYJUMZl4tbR8JSA3Za19lsPQvlHq/hcJLulcTCz7Q
	z9qJRrMqwTKschcNlBBi0NXCuZ4sJjHN1iXZGWYS0eXhLNtAWvQNB3AOZAX+uoEhxrNoX1ajH6B
	1cJ7+ctY1++eoH92uYCmXXE/XdEM2jvmxPGENlAUu4vLCyuUaTWvhQteK6XWQNitBa8yZD5Uk1p
	AZs5fLDxVLa1U4el8hAw1lRrw3RzWTXJR1kMDt2UZK0ii8tPFtRdkWjU1/Amrq59U6ece69URYC
	PA66CIGyVxIHVLdJrpDMNIsc=
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr177240985e9.11.1788677523931;
        Sat, 05 Sep 2026 23:52:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr177240555e9.11.1788677523479;
        Sat, 05 Sep 2026 23:52:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm16190990f8f.2.2026.09.05.23.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:52:02 -0700 (PDT)
Date: Sun, 6 Sep 2026 02:51:58 -0400
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
Message-ID: <20260906025002-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-3-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0llUZma32L39IE1x3G6d7_n7wDoPm15tehA38Zbl3Zg_1788677524
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_235209_326614_7F4C5BE6 
X-CRM114-Status: GOOD (  21.02  )
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


And now I am completely confused. So it is other transports you are
worried about? Which ones did you test? And why don't you worry about
fixing other transports in 1/3?


> Fixes: 271c865161c5 ("Add virtio-input driver.")
> Assisted-by: LLM
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


