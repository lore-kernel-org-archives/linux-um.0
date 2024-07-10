Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3E0C3DA42
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=; b=VdLJNCYs924zGex6eNkO/frcOY
	pUhifbDj+sKlC5PlsxHx+im45kgCK1Nnghp0bY7+OKcQi3Fyr/EidANNNE470Z+JRTSnKb6+f1JIL
	7q6amoZuXPS5Pi2o3S4A0iyF9y7IHVkfERem3wiSnbmuSYvgxA7LQMjqiNW7QVMVTfSlEfz8luR9A
	Id2A73ntTzTC/mlQiegLglLSMMjIxQ4T93iY/UGmrvchg9cqYnFxTp9IwfwGI3vpWTX7SRODDqMgy
	TNjKxbj427MpQGMRf/I2ySvYVIIeIQY3ipb82tM6fSmIBQKWXLiSpcPk/+DwKfTI/GHqOxKJRuZeE
	lP7WkJ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRdSz-0000000BbC3-2N59;
	Wed, 10 Jul 2024 19:59:05 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRdSw-0000000BbBa-0xOZ
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 19:59:03 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5957040e32aso97005a12.2
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720641540; x=1721246340; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=;
        b=gtmxLW1URtwpUixsnx7kyiweyG+SvijA6hd+gnxW3pAnO3fIQcPvF/1jR+P7TfJMkf
         pTo1LrqXoz8/Oa0fYuBsBt0RInZt+wABGrtaJoN8ii09JJtat2ivp/Nr0nBABQDbXpNS
         r6bcpUDN8nITX6e/XxfrbfT4D5sibKABeGwPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720641540; x=1721246340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaZFbOF1F9Ja9FQEvL/ykv3jVOt1v2vsmoWiE05XgDU=;
        b=EbmLqkewghueZY8kOmx+s5OW/W65baad8Ituc5Wec6dWHMNjR/o0Wvfhy8WGez+aGd
         31r1gwbs8Iea1AB2l0qw5vziVR7XH3bMSa/gYiTGmewGUH4tgOB/RyGpMvw3f+kWSzuh
         2EcDuXQkgiZq7iWbtvFpScWih2DsVJLe2WalP0YCcwpcVtPOg43lHdHB5+69WsCy6BC2
         1LR+XYAn+57SSw6wfVzD/dPc0Zs7iuWNp2y40lbB9Zo0klMasG21RojUbORFTvaRlSFS
         WSP41vN56GjpPjHTqzIrskVlDVSH5xJDBvmVKDwz8Co1pIB5b3ZFzX5hcuYEF25RK/vu
         jqFw==
X-Forwarded-Encrypted: i=1; AJvYcCVngA5KRe3ZSQsiMn7ll+H+839CCo5BcJ2lP/8KZtgOqFmuoIsi87dzr5eMi+ZIEA70qxxNqTzlOW8ReA0ejrlDBJzYJ24xTE7p0D2V
X-Gm-Message-State: AOJu0YzJ3awdDTY8S70yZ+6XYjN1bZh0f9QIt5CqiFon2VvkOQbS3OQ8
	T1QOjVzIDkxpzl6wky/NQ7NZet0oxuIygZqbrTyAQUZn5UO5jCLpnIkz7KhHgSjS599ysB+HAxm
	vhJcKfUY=
X-Google-Smtp-Source: AGHT+IEZzMvocE9nNeLp9G3vxX5SzxtAH3RAQpCEiBW3hn43xb+RYls8ixMGW3+U44RQx3b1KSNUEg==
X-Received: by 2002:aa7:c38d:0:b0:58c:ce91:89b1 with SMTP id 4fb4d7f45d1cf-594bb181ec2mr5224973a12.17.1720641540344;
        Wed, 10 Jul 2024 12:59:00 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a855ec8sm189196666b.179.2024.07.10.12.58.59
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:58:59 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77d876273dso14711966b.0
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 12:58:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7zAsDJRXB+LI2fXVVNgT1uG2vAi/XsCLg8ChxZol9Ej3tGGsqQ9pPEFXY4AK6ZlYvIZ/UNY916vfvLIFF/V/EMptwz1U5qEeJ3gaX
X-Received: by 2002:a05:6512:2111:b0:52e:73f5:b7c4 with SMTP id
 2adb3069b0e04-52eb99a3645mr4058074e87.37.1720641518212; Wed, 10 Jul 2024
 12:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com> <20240710142239-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710142239-mutt-send-email-mst@kernel.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 12:58:11 -0700
X-Gmail-Original-Message-ID: <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
Message-ID: <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_125902_324054_C683A8B7 
X-CRM114-Status: GOOD (  41.21  )
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

On Wed, Jul 10, 2024 at 11:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > virtio balloon communicates to the core that in some
> > > configurations vq #s are non-contiguous by setting name
> > > pointer to NULL.
> > >
> > > Unfortunately, core then turned around and just made them
> > > contiguous again. Result is that driver is out of spec.
> >
> > Thanks for fixing this - I think the overall approach of the patch look=
s good.
> >
> > > Implement what the API was supposed to do
> > > in the 1st place. Compatibility with buggy hypervisors
> > > is handled inside virtio-balloon, which is the only driver
> > > making use of this facility, so far.
> >
> > In addition to virtio-balloon, I believe the same problem also affects
> > the virtio-fs device, since queue 1 is only supposed to be present if
> > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > meant to be queue indexes 2 and up. From a look at the Linux driver
> > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> > and assumes that request queues start at index 1 rather than 2, which
> > looks out of spec to me, but the current device implementations (that
> > I am aware of, anyway) are also broken in the same way, so it ends up
> > working today. Queue numbering in a spec-compliant device and the
> > current Linux driver would mismatch; what the driver considers to be
> > the first request queue (index 1) would be ignored by the device since
> > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
>
>
> Oh, thanks a lot for pointing this out!
>
> I see so this patch is no good as is, we need to add a workaround for
> virtio-fs first.
>
> QEMU workaround is simple - just add an extra queue. But I did not
> reasearch how this would interact with vhost-user.
>
> From driver POV, I guess we could just ignore queue # 1 - would that be
> ok or does it have performance implications?

As a driver workaround for non-compliant devices, I think ignoring the
first request queue would be a reasonable approach if the device's
config advertises num_request_queues > 1. Unfortunately, both
virtiofsd and crosvm's virtio-fs device have hard-coded
num_request_queues =3D1, so this won't help with those existing devices.
Maybe there are other devices that we would need to consider as well;
commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
benchmarks that seem to be from a different virtio-fs implementation
that does support multiple request queues, so the workaround could
possibly be used there.

> Or do what I did for balloon here: try with spec compliant #s first,
> if that fails then assume it's the spec issue and shift by 1.

If there is a way to "guess and check" without breaking spec-compliant
devices, that sounds reasonable too; however, I'm not sure how this
would work out in practice: an existing non-compliant device may fail
to start if the driver tries to enable queue index 2 when it only
supports one request queue, and a spec-compliant device would probably
balk if the driver tries to enable queue 1 but does not negotiate
VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
whole virtio device initialization process if a device fails like
this, then maybe it's feasible. (Or can the driver tweak the virtqueue
configuration and try to set DRIVER_OK repeatedly until it works? It's
not clear to me if this is allowed by the spec, or what device
implementations actually do in practice in this scenario.)

Thanks,
-- Daniel

