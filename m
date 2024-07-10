Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF0EC3DA41
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+f+kV8PGs9cvgE7zeVigaMsenY/36PRSuVdnQGbWD0=; b=tCXZOJDNqCu9NsKoJuXCVwSzdv
	zzjW9RNK5gKG4wPZ8w+gpl9CnOYk0/EpkCfZg0F/ze2Qq0+SyWk/vHUDpf0Oo9++O+BBnf3l1svbK
	AA9iKNk5QopN/e9axQ/vGAuRI22TO4A+W5Zj86cXrb5DVLgN0/ZAir/2WtdOz8CoCeyY2HR/kGXpp
	XUlrrq8dFg2NQn68abDpW41FrRTGVDATVIt+1iLl/U1CSsP3fMTZ00y3WDHkSkwR3rixmAeHddAak
	kTJbmS2YT/oZG5ftF/mUZwBMZdNHjbZmH/2fHI60aj0wcjrr6F7QpBbRQodz2kouDp/TS+Nz/dcs/
	YhodM7xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRe6G-0000000BgBc-1R8v;
	Wed, 10 Jul 2024 20:39:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRe6D-0000000BgAu-1uh6
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 20:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720643975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+f+kV8PGs9cvgE7zeVigaMsenY/36PRSuVdnQGbWD0=;
	b=OezJpbxC3v3Q/EPgW7DQTNpRRvuvbRBz5Ichi9TDe1o5rtVSGKoQUAwcX/XHmZAlr4uf3I
	KjDySKNskPfe9jG+9pt0kNrPR8UWzZRSTjOc7I3Q75a5SqIsTlAyntgk5sy74GtHiFO2xF
	emD7glavDZ2GeIqxb/0WatsLsm25FJI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-ngbcx461Oeek0v98o8nfIw-1; Wed, 10 Jul 2024 16:39:34 -0400
X-MC-Unique: ngbcx461Oeek0v98o8nfIw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-426d316a96cso1260945e9.0
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 13:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720643973; x=1721248773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+f+kV8PGs9cvgE7zeVigaMsenY/36PRSuVdnQGbWD0=;
        b=xL8SBOWQ/dRzxV6v6TZLHSSsdJrpbF6418Rcm5x8T3zvVdjhYbamFa5KyCPAukGNVs
         Dpmvf68BuyXQgPi37/sUP+tDavxOcKBCzCbO16RwvoEuDLaflkdWBtmuhAcpWweH5P55
         et4CQ6m6QHZ6mOh+dv4iMHjxZcebiKeNTV8kdV4kY9RCgEFElP/A0G3D4M1AYk4rNhS/
         ImFDhr1qWY2PZwN2t3MBsX46mINa3JIWDOWyo+ZeBp2dhVWjyRcGP6fMzcSVvyWA7OJn
         Hu4XsTX8JyZurjYb2AOpYrDuIf5O1+4UurxWOmjAgnTuXKKI/oJm0FkJjyuTwwb4Sdc+
         LKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqAb/HhQ/i4Hs+ezg4L6AAdafWmVLi8mUJZrAQ3HWFJdq2LXBv9nZUCFGl8SrcDaqLm6mzmh4KsasUNgwmNx1AhuNhNfsXDuO9u6/p
X-Gm-Message-State: AOJu0YxkQDeO1Ts6Txz0F1jLTzLfyhv9aBq2iwfV256T5By4IK2mZ9PF
	yX7yGTBXqNbIdPsjyS25fS9L1Le3LLCKGnjT9g3Z/ovDmkwQsTQh537AyJ5kVFrIp2ZAHbSa04K
	EzVZvq78NP/LeSzOboPwCZAatvgKqO/mJ9Dageh4+31Dh4Bso6EVa+8EyEOs1dQ==
X-Received: by 2002:a05:600c:229a:b0:426:5f75:1c2c with SMTP id 5b1f17b1804b1-426707cbc97mr44811805e9.11.1720643973116;
        Wed, 10 Jul 2024 13:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtCfrEexr56Rkv7hJ8Mgk/LJU1kKofEwb65pnZ1cmAQDQy0+5tLig+uLI502/i8+1HPIzcTQ==
X-Received: by 2002:a05:600c:229a:b0:426:5f75:1c2c with SMTP id 5b1f17b1804b1-426707cbc97mr44811475e9.11.1720643972423;
        Wed, 10 Jul 2024 13:39:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e9666sm92264125e9.9.2024.07.10.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 13:39:32 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:38:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
Message-ID: <20240710162640-mutt-send-email-mst@kernel.org>
References: <cover.1720611677.git.mst@redhat.com>
 <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
 <20240710142239-mutt-send-email-mst@kernel.org>
 <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_133937_597340_942DD35D 
X-CRM114-Status: GOOD (  50.59  )
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

On Wed, Jul 10, 2024 at 12:58:11PM -0700, Daniel Verkamp wrote:
> On Wed, Jul 10, 2024 at 11:39 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > > On Wed, Jul 10, 2024 at 4:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > virtio balloon communicates to the core that in some
> > > > configurations vq #s are non-contiguous by setting name
> > > > pointer to NULL.
> > > >
> > > > Unfortunately, core then turned around and just made them
> > > > contiguous again. Result is that driver is out of spec.
> > >
> > > Thanks for fixing this - I think the overall approach of the patch looks good.
> > >
> > > > Implement what the API was supposed to do
> > > > in the 1st place. Compatibility with buggy hypervisors
> > > > is handled inside virtio-balloon, which is the only driver
> > > > making use of this facility, so far.
> > >
> > > In addition to virtio-balloon, I believe the same problem also affects
> > > the virtio-fs device, since queue 1 is only supposed to be present if
> > > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > > meant to be queue indexes 2 and up. From a look at the Linux driver
> > > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> > > and assumes that request queues start at index 1 rather than 2, which
> > > looks out of spec to me, but the current device implementations (that
> > > I am aware of, anyway) are also broken in the same way, so it ends up
> > > working today. Queue numbering in a spec-compliant device and the
> > > current Linux driver would mismatch; what the driver considers to be
> > > the first request queue (index 1) would be ignored by the device since
> > > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> >
> >
> > Oh, thanks a lot for pointing this out!
> >
> > I see so this patch is no good as is, we need to add a workaround for
> > virtio-fs first.
> >
> > QEMU workaround is simple - just add an extra queue. But I did not
> > reasearch how this would interact with vhost-user.
> >
> > From driver POV, I guess we could just ignore queue # 1 - would that be
> > ok or does it have performance implications?
> 
> As a driver workaround for non-compliant devices, I think ignoring the
> first request queue would be a reasonable approach if the device's
> config advertises num_request_queues > 1. Unfortunately, both
> virtiofsd and crosvm's virtio-fs device have hard-coded
> num_request_queues =1, so this won't help with those existing devices.

Do they care what the vq # is though?
We could do some magic to translate VQ #s in qemu.


> Maybe there are other devices that we would need to consider as well;
> commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
> benchmarks that seem to be from a different virtio-fs implementation
> that does support multiple request queues, so the workaround could
> possibly be used there.
> 
> > Or do what I did for balloon here: try with spec compliant #s first,
> > if that fails then assume it's the spec issue and shift by 1.
> 
> If there is a way to "guess and check" without breaking spec-compliant
> devices, that sounds reasonable too; however, I'm not sure how this
> would work out in practice: an existing non-compliant device may fail
> to start if the driver tries to enable queue index 2 when it only
> supports one request queue,

You don't try to enable queue - driver starts by checking queue size.
The way my patch works is that it assumes a non existing queue has
size 0 if not available.

This was actually a documented way to check for PCI and MMIO:
	Read the virtqueue size from queue_size. This controls how big the virtqueue is (see 2.6 Virtqueues).
	If this field is 0, the virtqueue does not exist.
MMIO:
	If the returned value is zero (0x0) the queue is not available.

unfortunately not for CCW, but I guess CCW implementations outside
of QEMU are uncommon enough that we can assume it's the same?


To me the above is also a big hint that drivers are allowed to
query size for queues that do not exist.



> and a spec-compliant device would probably
> balk if the driver tries to enable queue 1 but does not negotiate
> VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
> whole virtio device initialization process if a device fails like
> this, then maybe it's feasible. (Or can the driver tweak the virtqueue
> configuration and try to set DRIVER_OK repeatedly until it works? It's
> not clear to me if this is allowed by the spec, or what device
> implementations actually do in practice in this scenario.)
> 
> Thanks,
> -- Daniel

My patch starts with a spec compliant behaviour. If that fails,
try non-compliant one as a fallback.

-- 
MST


