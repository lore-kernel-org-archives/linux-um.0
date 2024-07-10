Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FA1C3DA41
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pocGWFShxQ+GSWj0tkDTAgxmCbZcO+UfiqU5SyA0Efs=; b=cU6DTQpR27v5c6/6y9XSsXHG/J
	b62sGQWxUOLg94PqDJpp3Rd6D755W+boA15nRlQiwLZUVxt9lZ/+hfnJubwrQQBvjNqW27PK8qkbj
	/zlGc7eCnYsOj4Vmv0c9KdPAmSlhw9olE/eWOqNjjKDL5LOIRKt9c68o55PuBcGN/jaUegnODrgN3
	BcglYCp8Gs4t4jcJj3hfSc06TZTbzIu1Um+8LNsEljaoQYBWj+w3+vMfVvCaRJp6q8LAe4IYPYMcd
	dPWNO/wnGrsCMihtJYSW+fqMavLC5e9QbKFW86g4xMf+0PBE0Wr+8MLOvOCCPFgVjHn3uS9uR7wqI
	f3rvlj/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRgNR-0000000C1uG-0EOI;
	Wed, 10 Jul 2024 23:05:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRgNO-0000000C1tl-02Sj
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 23:05:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720652728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pocGWFShxQ+GSWj0tkDTAgxmCbZcO+UfiqU5SyA0Efs=;
	b=DwVM0d4b6Y12iVLuUEVLL0Atdz5CK7jrTtCR8n+aO0+L9PhX9nL6gDJPYIPWLHuzn/YTzg
	wQzospDOwRVaSnfsbaoEQwWwi6xRA9LpMoAcsP8Grtc+6w4l/Qth6fhnPvggOSiUEq1Oe2
	OGGq2XkTc1mIhMdW41lEMroF59V0QB0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37--Esi0jxnMICAAip6Vl9zJA-1; Wed, 10 Jul 2024 19:05:27 -0400
X-MC-Unique: -Esi0jxnMICAAip6Vl9zJA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3678fd1edf8so658146f8f.0
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 16:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652726; x=1721257526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pocGWFShxQ+GSWj0tkDTAgxmCbZcO+UfiqU5SyA0Efs=;
        b=j48tjR9WDIQBPMs6MPdqawSYRv5deMcsD6m+NE67SINA8fckQEHEps390yCaohPEkW
         1/QASKsohhuc+K1fQ1XCZEwB9FEu6a+ElM7KC2YLwd2PA7w2lBesBMlGW8ncp5kQywzl
         IOhzC8E/OEsuQAIKROfClR1sdRscS49TcD7nOFVCogovg4hYoESF+EXuGzjUvZqs4f5v
         L9hf85WFKxF4JW7q28fIKxuCXZQ0LbBUMHDn6cbimmT4jjeQOqhy7AFvK823JssVQYGN
         K6oCB0svJDBXMn0I3Xm7140JWNRsWf3Dpm8jaif3rR2zSREq4jKp+D1xLDpevUH2W6/9
         wrTA==
X-Forwarded-Encrypted: i=1; AJvYcCWqTabmhJvRWaEr5QaRD2WVyJOJxt9L6m/7GwEdZCnnsTSfs98rCV5uUaGypABseRAmzCuF+VuHfi3W+e+NybLFadzL44c1gE1XMwpH
X-Gm-Message-State: AOJu0YxxX4pu9x4l6Ar6+M17LJZ5ZgS6DpeNqOjTLEnbcSG5rxN6cP9X
	SBfPxXcBG6kycpRLkts3EAEUw6KSdk1zFUiMUWzIUl+EZET6BjVxW64806uhFpKCa/agHVdnnlD
	6qfOFDOV23AVBZ0ZAIXR0zn97lQNrBndxHEZSXQPROSFcbHI38Rz7EZFZ+czHLw==
X-Received: by 2002:a5d:674d:0:b0:366:e9f7:4e73 with SMTP id ffacd0b85a97d-367f04c394fmr848903f8f.5.1720652726244;
        Wed, 10 Jul 2024 16:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfrrspXtlMpDRODV1gtZ6UbNGtoYk75D8SS60rLLEn4NhjjhpRqJHKf/56m95g7RzAi+V6jQ==
X-Received: by 2002:a5d:674d:0:b0:366:e9f7:4e73 with SMTP id ffacd0b85a97d-367f04c394fmr848885f8f.5.1720652725448;
        Wed, 10 Jul 2024 16:05:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde8904csm6208508f8f.49.2024.07.10.16.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 16:05:24 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:05:20 -0400
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
Message-ID: <20240710190222-mutt-send-email-mst@kernel.org>
References: <cover.1720611677.git.mst@redhat.com>
 <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
 <20240710142239-mutt-send-email-mst@kernel.org>
 <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
 <20240710162640-mutt-send-email-mst@kernel.org>
 <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_160530_152840_EFFE8BB8 
X-CRM114-Status: GOOD (  61.97  )
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

On Wed, Jul 10, 2024 at 03:54:22PM -0700, Daniel Verkamp wrote:
> On Wed, Jul 10, 2024 at 1:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 12:58:11PM -0700, Daniel Verkamp wrote:
> > > On Wed, Jul 10, 2024 at 11:39 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > > > > On Wed, Jul 10, 2024 at 4:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > virtio balloon communicates to the core that in some
> > > > > > configurations vq #s are non-contiguous by setting name
> > > > > > pointer to NULL.
> > > > > >
> > > > > > Unfortunately, core then turned around and just made them
> > > > > > contiguous again. Result is that driver is out of spec.
> > > > >
> > > > > Thanks for fixing this - I think the overall approach of the patch looks good.
> > > > >
> > > > > > Implement what the API was supposed to do
> > > > > > in the 1st place. Compatibility with buggy hypervisors
> > > > > > is handled inside virtio-balloon, which is the only driver
> > > > > > making use of this facility, so far.
> > > > >
> > > > > In addition to virtio-balloon, I believe the same problem also affects
> > > > > the virtio-fs device, since queue 1 is only supposed to be present if
> > > > > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > > > > meant to be queue indexes 2 and up. From a look at the Linux driver
> > > > > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> > > > > and assumes that request queues start at index 1 rather than 2, which
> > > > > looks out of spec to me, but the current device implementations (that
> > > > > I am aware of, anyway) are also broken in the same way, so it ends up
> > > > > working today. Queue numbering in a spec-compliant device and the
> > > > > current Linux driver would mismatch; what the driver considers to be
> > > > > the first request queue (index 1) would be ignored by the device since
> > > > > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> > > >
> > > >
> > > > Oh, thanks a lot for pointing this out!
> > > >
> > > > I see so this patch is no good as is, we need to add a workaround for
> > > > virtio-fs first.
> > > >
> > > > QEMU workaround is simple - just add an extra queue. But I did not
> > > > reasearch how this would interact with vhost-user.
> > > >
> > > > From driver POV, I guess we could just ignore queue # 1 - would that be
> > > > ok or does it have performance implications?
> > >
> > > As a driver workaround for non-compliant devices, I think ignoring the
> > > first request queue would be a reasonable approach if the device's
> > > config advertises num_request_queues > 1. Unfortunately, both
> > > virtiofsd and crosvm's virtio-fs device have hard-coded
> > > num_request_queues =1, so this won't help with those existing devices.
> >
> > Do they care what the vq # is though?
> > We could do some magic to translate VQ #s in qemu.
> >
> >
> > > Maybe there are other devices that we would need to consider as well;
> > > commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
> > > benchmarks that seem to be from a different virtio-fs implementation
> > > that does support multiple request queues, so the workaround could
> > > possibly be used there.
> > >
> > > > Or do what I did for balloon here: try with spec compliant #s first,
> > > > if that fails then assume it's the spec issue and shift by 1.
> > >
> > > If there is a way to "guess and check" without breaking spec-compliant
> > > devices, that sounds reasonable too; however, I'm not sure how this
> > > would work out in practice: an existing non-compliant device may fail
> > > to start if the driver tries to enable queue index 2 when it only
> > > supports one request queue,
> >
> > You don't try to enable queue - driver starts by checking queue size.
> > The way my patch works is that it assumes a non existing queue has
> > size 0 if not available.
> >
> > This was actually a documented way to check for PCI and MMIO:
> >         Read the virtqueue size from queue_size. This controls how big the virtqueue is (see 2.6 Virtqueues).
> >         If this field is 0, the virtqueue does not exist.
> > MMIO:
> >         If the returned value is zero (0x0) the queue is not available.
> >
> > unfortunately not for CCW, but I guess CCW implementations outside
> > of QEMU are uncommon enough that we can assume it's the same?
> >
> >
> > To me the above is also a big hint that drivers are allowed to
> > query size for queues that do not exist.
> 
> Ah, that makes total sense - detecting queue presence by non-zero
> queue size sounds good to me, and it should work in the normal virtio
> device case.
> 
> I am not sure about vhost-user, since there is no way for the
> front-end to ask the back-end for a queue's size; the confusingly
> named VHOST_USER_SET_VRING_NUM allows the front-end to configure the
> size of a queue, but there's no corresponding GET message.

So for vhost user I would assume it is non spec compliant
and qemu remaps queue numbers?
And can add a backend feature for supporting
VHOST_USER_GET_VRING_NUM and with that, also
require that backends are spec compliant?
And again, qemu can remap queue numbers.



> > > and a spec-compliant device would probably
> > > balk if the driver tries to enable queue 1 but does not negotiate
> > > VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
> > > whole virtio device initialization process if a device fails like
> > > this, then maybe it's feasible. (Or can the driver tweak the virtqueue
> > > configuration and try to set DRIVER_OK repeatedly until it works? It's
> > > not clear to me if this is allowed by the spec, or what device
> > > implementations actually do in practice in this scenario.)
> > >
> > > Thanks,
> > > -- Daniel
> >
> > My patch starts with a spec compliant behaviour. If that fails,
> > try non-compliant one as a fallback.
> 
> Got it, that sounds reasonable to me given the explanation above.
> 
> Thanks,
> -- Daniel


