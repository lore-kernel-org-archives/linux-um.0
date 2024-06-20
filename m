Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45462C2BA18
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YDuLutVSNe5rSO4mU2km20/sLHcVu1RDWVk3Uo1JFTE=; b=1Dn+1J+DOBAKcs+rSLrGWnCwj+
	uVscBTigRY3O4BF2CpbSdo2up5P3fligz5hHZRLk9DEmOQHqeNeaOYaaXrTuIg1VZs1fnFhlNK3T+
	w1vvsItUJoscvWlCUp0MSerRr1xo2jA9dhqC5oC9HaCwFjiO5BC1w+3JK0lEcZcnYKk2K2eoNIJiv
	qgvrxkTzwejlTY+zYQNx7fwfJHPDkrfEoekV6VARuuQkqyzZvwdeu7ip9AuwmABK4o/6PDD8ZBDYf
	WJfcKcfqEpVwM2kb2yVJ4RfC1srbLpNmel2vZMG/AINulFV281FSm9PNBKYJiDfkjcdIdzixfxgLI
	GP7xa+ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKEcL-00000004UNc-1cxl;
	Thu, 20 Jun 2024 10:02:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKEcI-00000004UMl-1Pin
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 10:02:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718877725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDuLutVSNe5rSO4mU2km20/sLHcVu1RDWVk3Uo1JFTE=;
	b=Uv6M1ovfEFPWomZejZy9IHdG0cjR315N35xQFh7VWxDbEu12wJx0IVLYoinVfMpfh+AXzt
	mby4gFvN70oYlf6rSGo7PbhwCFZAVKIw3bd7SAo0gmvrGHP2qMKN4zrtr6kRcqGFaiILiu
	FiEZz2YK9geQ/fXFHX0uz+sfUDXz3go=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-IBr9npTHMaq2MG3a2p2BlA-1; Thu, 20 Jun 2024 06:02:03 -0400
X-MC-Unique: IBr9npTHMaq2MG3a2p2BlA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6ec06ed579so35057666b.2
        for <linux-um@lists.infradead.org>; Thu, 20 Jun 2024 03:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877722; x=1719482522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDuLutVSNe5rSO4mU2km20/sLHcVu1RDWVk3Uo1JFTE=;
        b=vkGheQzWoY4S/+yLSIZqSSShRgLSA759XLqKOjFA5yP8DLCbjaQTSK/jOO0rDTGog9
         dn+X7OCH9R+O8JKASCp1rrdxyxOQvGHjt+AbZhJj3YP5BkVPR2Nk66qBg0yo+6GUpSIg
         jyVIeQ6dFOunxroDeTvl7kqxqJ8UbhaSe3TpTX8Ty8NM3rwJeBcBEPUGPjieEc2g91TY
         pdROUSwi7RPl4gtSvFHSExFyLc9kz388rUlBtsg8qxhzLEiHwo9Q8IKQfbSnFKzXuPdO
         4ZAoeZn4Ro5iAT7RTPQKKxLRYx5Ok1hFv6rekzl3kt97EDp54sGbjGUh0MUpghsaVH5Z
         Cang==
X-Forwarded-Encrypted: i=1; AJvYcCWcAM/J7xCg3hnNIlOhcKjIpJPWErZkL1QQgJiUK60bX8b0rAXpaUUpc8jbNo02RstU8Fii6V51aHfwC0iZ7W8pKIyq9pxLRaSE0ccb
X-Gm-Message-State: AOJu0YzXLYVjYFGf14bpeq1ZQDfz50yNv0zXCK/nNp+6p6yoJjNEz0/W
	06a9qUqaXqLKVeMX/bHFMR1j/ZzKO3tT/G3B+cc39+DZv+Iaag3M3x8WKJi2/n3EexAcjOsgJjG
	k93ffe8ZDd/dh74Ox6EJcMIrOt3paK7YkDK3kMfF5D6ieEeO7B0+kR3sYQ8QTOw==
X-Received: by 2002:a17:906:a398:b0:a6f:3f75:41ac with SMTP id a640c23a62f3a-a6fab7d7c2emr269528366b.63.1718877722556;
        Thu, 20 Jun 2024 03:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOVPKUPfyHjzvCp3jOmaukYXIFLJ/paPmYIKro+AvCHkv/tuVFAiJNm8SiwWX/rjwGdLuqWQ==
X-Received: by 2002:a17:906:a398:b0:a6f:3f75:41ac with SMTP id a640c23a62f3a-a6fab7d7c2emr269525766b.63.1718877721990;
        Thu, 20 Jun 2024 03:02:01 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa4150sm757023766b.212.2024.06.20.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:02:01 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:01:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH vhost v9 2/6] virtio: remove support for names array
 entries being null.
Message-ID: <20240620054548-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
 <20240620044839-mutt-send-email-mst@kernel.org>
 <1718874293.698573-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1718874293.698573-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_030206_485340_B7CE6281 
X-CRM114-Status: GOOD (  36.52  )
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

On Thu, Jun 20, 2024 at 05:04:53PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 05:01:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> > > On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > > > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > > > > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > > > > doesn't apply. And not one uses this.
> > > > >
> > > > > On the other side, that makes some trouble for us to refactor the
> > > > > find_vqs() params.
> > > > >
> > > > > So I remove this support.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> > > >
> > > >
> > > > I don't mind, but this patchset is too big already.
> > > > Why do we need to make this part of this patchset?
> > >
> > >
> > > If some the pointers of the names is NULL, then in the virtio ring,
> > > we will have a trouble to index from the arrays(names, callbacks...).
> > > Becasue that the idx of the vq is not the index of these arrays.
> > >
> > > If the names is [NULL, "rx", "tx"], the first vq is the "rx", but index of the
> > > vq is zero, but the index of the info of this vq inside the arrays is 1.
> >
> >
> > Ah. So actually, it used to work.
> >
> > What this should refer to is
> >
> > commit ddbeac07a39a81d82331a312d0578fab94fccbf1
> > Author: Wei Wang <wei.w.wang@intel.com>
> > Date:   Fri Dec 28 10:26:25 2018 +0800
> >
> >     virtio_pci: use queue idx instead of array idx to set up the vq
> >
> >     When find_vqs, there will be no vq[i] allocation if its corresponding
> >     names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> >     with names[2] being NULL because the related feature bit is turned off,
> >     so technically there are 3 queues on the device, and name[4] should
> >     correspond to the 3rd queue on the device.
> >
> >     So we use queue_idx as the queue index, which is increased only when the
> >     queue exists.
> >
> >     Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> That just work for PCI.
> 
> The trouble I described is that we can not index in the virtio ring.
> 
> In virtio ring, we may like to use the vq.index that do not increase
> for the NULL.
> 
> 
> >
> > Which made it so setting names NULL actually does not reserve a vq.
> >
> > But I worry about non pci transports - there's a chance they used
> > a different index with the balloon. Did you test some of these?
> >
> 
> Balloon is out of spec.
> 
> The vq.index does not increase for the name NULL. So the Balloon use the
> continuous id. That is out of spec.


I see. And apparently the QEMU implementation is out of spec, too,
so they work fine. And STATS is always on in QEMU.

That change by Wei broke the theoretical config which has
!STATS but does have FREE_PAGE. We never noticed - not many people
ever bothered with FREE_PAGE.

However QEMU really is broken in a weird way.
In particular if it exposes STATS but driver does not
configure STATS then QEMU still has the stats vq.
Things will break then.


In short, it's a mess, and it needs thought.
At this point I suggest we keep the ability to set
names to NULL in case we want to just revert Wei's patch.



> That does not matter for this patchset.
> The name NULL is always skipped.
> 
> Thanks.


Let's keep this patchset as small as possible.
Keep the existing functionality, we'll do cleanups
later.


> > --
> > MST
> >


