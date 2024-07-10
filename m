Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3B2C3DA42
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=; b=eK+fIyYdQ5wWd5x2Kpn0vprfyy
	L75SB6PBc1VVv9W3KxqQHF5iZR9MPVmaIlD3KT1TamtY5GnR2VUAYtV5A0IMXSG3fqr+Vcozvoof+
	SqKT4iDZ+j2bhS+ap12O6e1BGhHDjWX5/ZRg9uotPaFOjVpWMinfTfHmmg870XdTBn3fag4p9hnuM
	u1Wxx41zfp5GfxaVVc9VAFW9d0e+DYE1hxDOykDGQiCeKtuJAhrLlBjk36F3FIpSxKvAkcyPM/ppd
	JRkwenLO9h5L5iFwNY5Om6pSwnkPPWDLsIMLub7TewG1CpF10ck+Wn2UuLfrWaf4Ph9mq3ufHEtM0
	lx72mTLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRgDc-0000000Bzc7-1gVM;
	Wed, 10 Jul 2024 22:55:24 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRgDY-0000000Bzai-3xQR
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 22:55:22 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so362846a12.3
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720652119; x=1721256919; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=;
        b=hJKiDQh0PO4mCZcwFYT6PYzOc7dvYoExapCIWjZ9w+ollIO8h5BcrpEU9pPQRyEnDY
         OZIwDOb5fU8moLDTun7B7qkES1XNVCGt9Ixsag33iqC6sf3sEDaVDrnVXAZWRAnvEU/6
         ONXJ26FAUcuZfFGppaXYVQUJk2SnV3Cyt/pmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652119; x=1721256919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=;
        b=BbO9eQLUg359PhIdViI0Tls/2CvrL5i3xXb8EYT3fCEZJuFxVkaiMSao1VnqmMg2XW
         fGvq+dA2NHh7XMt2ibHe3x0AeSL6KANKzxenTWgwIitYi4HEpG5OFssoihgfpeIXJ5hb
         v4QiUjvoDdDUH3y8wp8KwsdKEsTt4mzRZ2wwfWycmg+NfZyB1UgucBRbid6X+RwirPJW
         VtNdgvsbyDq76qZEmztFODAHZMy7/upe8ZGVNLoPZ7BeNDfibFxU3T8hA+fmHGjfmJhc
         Bau/Q2C7lemUH2/ng6X+WBtxTjT2w+o/g5Pw+7ce8CenR+mf8vE+sDwZNgdBet8ys0/S
         vXvA==
X-Forwarded-Encrypted: i=1; AJvYcCXVsUGTW/efb+UTQNaW16K5Zr1CXyRELfDJPcXUHsB8Z6yYwYEUdm78Olv5T6GtilPsRL/tsT/3cmYelPwHlZbbXGSNQJhJmfW0G4+T
X-Gm-Message-State: AOJu0YwsC3vUfqvryoent82hIE1UrSvqAhvT9YTJrIT3avD4xf/aVes7
	p8SCapUidA1pkcsLsanPoPSznMVCKrBbMY8wKOaZyVXZXynvpSY99kLkKiuvzUcNb3oATZ711nO
	IhgNIqhQ=
X-Google-Smtp-Source: AGHT+IHiXRJvldq8vgyP76DkYmENFn8DHRlreN8/URSLQdSA5Fwo3F7N+Q47Rudvt9Yzp7OWEQ96dw==
X-Received: by 2002:a17:906:aec5:b0:a77:c043:5b5a with SMTP id a640c23a62f3a-a780b7052e6mr380075866b.39.1720652119067;
        Wed, 10 Jul 2024 15:55:19 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a85603fsm201943466b.176.2024.07.10.15.55.09
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 15:55:10 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so362720a12.3
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 15:55:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYNed8WqKu0TEq0FQMHJS1vS1ltMStc8Dqll4ynoGScI1L5BRLsH7dAqwBP0UkEhkKeNxd5dfc+n9+v4Zee6udmI4MjnozjWe8T0Yq
X-Received: by 2002:a17:907:7f12:b0:a77:db34:42ca with SMTP id
 a640c23a62f3a-a780b88347amr588125666b.49.1720652088624; Wed, 10 Jul 2024
 15:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
 <20240710142239-mutt-send-email-mst@kernel.org> <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
 <20240710162640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710162640-mutt-send-email-mst@kernel.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 15:54:22 -0700
X-Gmail-Original-Message-ID: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
Message-ID: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240710_155521_013038_7A84A4AE 
X-CRM114-Status: GOOD (  59.40  )
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

On Wed, Jul 10, 2024 at 1:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 10, 2024 at 12:58:11PM -0700, Daniel Verkamp wrote:
> > On Wed, Jul 10, 2024 at 11:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > > > On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > virtio balloon communicates to the core that in some
> > > > > configurations vq #s are non-contiguous by setting name
> > > > > pointer to NULL.
> > > > >
> > > > > Unfortunately, core then turned around and just made them
> > > > > contiguous again. Result is that driver is out of spec.
> > > >
> > > > Thanks for fixing this - I think the overall approach of the patch =
looks good.
> > > >
> > > > > Implement what the API was supposed to do
> > > > > in the 1st place. Compatibility with buggy hypervisors
> > > > > is handled inside virtio-balloon, which is the only driver
> > > > > making use of this facility, so far.
> > > >
> > > > In addition to virtio-balloon, I believe the same problem also affe=
cts
> > > > the virtio-fs device, since queue 1 is only supposed to be present =
if
> > > > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > > > meant to be queue indexes 2 and up. From a look at the Linux driver
> > > > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATI=
ON
> > > > and assumes that request queues start at index 1 rather than 2, whi=
ch
> > > > looks out of spec to me, but the current device implementations (th=
at
> > > > I am aware of, anyway) are also broken in the same way, so it ends =
up
> > > > working today. Queue numbering in a spec-compliant device and the
> > > > current Linux driver would mismatch; what the driver considers to b=
e
> > > > the first request queue (index 1) would be ignored by the device si=
nce
> > > > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> > >
> > >
> > > Oh, thanks a lot for pointing this out!
> > >
> > > I see so this patch is no good as is, we need to add a workaround for
> > > virtio-fs first.
> > >
> > > QEMU workaround is simple - just add an extra queue. But I did not
> > > reasearch how this would interact with vhost-user.
> > >
> > > From driver POV, I guess we could just ignore queue # 1 - would that =
be
> > > ok or does it have performance implications?
> >
> > As a driver workaround for non-compliant devices, I think ignoring the
> > first request queue would be a reasonable approach if the device's
> > config advertises num_request_queues > 1. Unfortunately, both
> > virtiofsd and crosvm's virtio-fs device have hard-coded
> > num_request_queues =3D1, so this won't help with those existing devices=
.
>
> Do they care what the vq # is though?
> We could do some magic to translate VQ #s in qemu.
>
>
> > Maybe there are other devices that we would need to consider as well;
> > commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
> > benchmarks that seem to be from a different virtio-fs implementation
> > that does support multiple request queues, so the workaround could
> > possibly be used there.
> >
> > > Or do what I did for balloon here: try with spec compliant #s first,
> > > if that fails then assume it's the spec issue and shift by 1.
> >
> > If there is a way to "guess and check" without breaking spec-compliant
> > devices, that sounds reasonable too; however, I'm not sure how this
> > would work out in practice: an existing non-compliant device may fail
> > to start if the driver tries to enable queue index 2 when it only
> > supports one request queue,
>
> You don't try to enable queue - driver starts by checking queue size.
> The way my patch works is that it assumes a non existing queue has
> size 0 if not available.
>
> This was actually a documented way to check for PCI and MMIO:
>         Read the virtqueue size from queue_size. This controls how big th=
e virtqueue is (see 2.6 Virtqueues).
>         If this field is 0, the virtqueue does not exist.
> MMIO:
>         If the returned value is zero (0x0) the queue is not available.
>
> unfortunately not for CCW, but I guess CCW implementations outside
> of QEMU are uncommon enough that we can assume it's the same?
>
>
> To me the above is also a big hint that drivers are allowed to
> query size for queues that do not exist.

Ah, that makes total sense - detecting queue presence by non-zero
queue size sounds good to me, and it should work in the normal virtio
device case.

I am not sure about vhost-user, since there is no way for the
front-end to ask the back-end for a queue's size; the confusingly
named VHOST_USER_SET_VRING_NUM allows the front-end to configure the
size of a queue, but there's no corresponding GET message.

> > and a spec-compliant device would probably
> > balk if the driver tries to enable queue 1 but does not negotiate
> > VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
> > whole virtio device initialization process if a device fails like
> > this, then maybe it's feasible. (Or can the driver tweak the virtqueue
> > configuration and try to set DRIVER_OK repeatedly until it works? It's
> > not clear to me if this is allowed by the spec, or what device
> > implementations actually do in practice in this scenario.)
> >
> > Thanks,
> > -- Daniel
>
> My patch starts with a spec compliant behaviour. If that fails,
> try non-compliant one as a fallback.

Got it, that sounds reasonable to me given the explanation above.

Thanks,
-- Daniel

