Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D4AC54E67
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 04:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H9wx4BuvKLz4tvOMSdVGgTgc289YmZwETUSF9fXZYpA=; b=Jdvpf+kgnVVjgHB1dktPLshB55
	SJH4JA457ryeuAGHZzwN0PLEyDhyW4/uKledGJI1C0eoZ+qQN9aC1qC1SWm7ZasK8Gzb+0sPdHJUT
	aTYQnyqFqp85ZTfndX+f+TQKI0NWOyAhoLF7qdr1015vwce9UqE7MbSjivC7tDXZ/9UmuazdQYU2W
	bbDWSRr0uBQW2wF2hoD/GF7Vj8i6QyCN8oBmNtaGzM5ymcjiiu+cXNcvO+w4qTnNQEcH7AL8trP2o
	TzFVlsWDRCYDxEfakTnbnmJSVoPQ+VvVMMDaz6pLy2iINd1LqSVxpLb6UakdycYx0NteXgpv6eO9x
	B/ytMxMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1royNW-000000031iZ-21zr;
	Tue, 26 Mar 2024 04:25:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1royNS-000000031hr-3CBm
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 04:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711427133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9wx4BuvKLz4tvOMSdVGgTgc289YmZwETUSF9fXZYpA=;
	b=fOwR1SBRQS6trD389Z5u4LojnD9GYRVETKaE4ruVYySLiiobAmkoJZgErWm7X9C3fRcZis
	t3zkbFB8e1yzTE9w4kZfPLPQyIWf3p40VCpNRDPhU6T0Doq2PgJXRCIxe3nZ36TPWDBmib
	UCyJo3eo8d5yy7Obv04o1yTevdQFuVg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-qTb8y0YBPXmzHeZ-0RYXbw-1; Tue, 26 Mar 2024 00:25:31 -0400
X-MC-Unique: qTb8y0YBPXmzHeZ-0RYXbw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e0b3a4c2e4so13452675ad.0
        for <linux-um@lists.infradead.org>; Mon, 25 Mar 2024 21:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711427130; x=1712031930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9wx4BuvKLz4tvOMSdVGgTgc289YmZwETUSF9fXZYpA=;
        b=umcd2goAt7/cezZRywrQojHfXk5onTI313fjk2xvPR9/oCLkIcnW0wdM6aLwOThbnb
         jZBRq9Tc70nmR2zPLUq89sXs5J+RwSy6Lhb5iDsqUxEoqns2o3zLT/XFFwAp323MIUKG
         a4EhTWBUuY03FD4LBBiIznoq3fOYd/iBdmn3OX08bj27EVDHxM0egZTkPJCdY3ehKX6K
         Bo8xRbhyhhbUlaMAjD1HQa3g8iNHfONnfJOTwTHxy8QvCTtKCEkqwlZWMv9MXue8qiH3
         uYQEn6dk4DR/3yCMIG+Va0ti3TI5u6RT4b7mxnoPnUbYpZaWrkwy+nc2IYxYzxU0zZZh
         IAGw==
X-Forwarded-Encrypted: i=1; AJvYcCX918sr1R44IX0qownx7jNeq/IxLTo34tHQ1y/jbQhSOtyyMrMLNa1IgFB/lk4TytpBvkr5RGOXJF//C5U4yqjdf3ipEFfre6vZseuw
X-Gm-Message-State: AOJu0YzGfgj/8dHiJSoYPn1/pXrGb72f1RCDXCOB+7QSgfWALOo9F1E8
	dM31RxNbqb3L5t5Na7QxMCqiCSVZXQ/kcQB46uztFXuwxccntS3Ts9TktgrIsP8NOXPUGTdShsT
	PmMDP9bdTi4LEbKBY4TVLbVJa2nuo8wkJjTA678yUq/4OdKnf8V9EhRRVUDj52G60m+3rdE620Y
	clbfvVX2BuFwjjRmX6DwHmufezkwHZvsmm8MnK
X-Received: by 2002:a17:902:6b43:b0:1e0:e11:c631 with SMTP id g3-20020a1709026b4300b001e00e11c631mr8163130plt.34.1711427130634;
        Mon, 25 Mar 2024 21:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXA4/VrxxLV5/0yu0bKQNp2eKt6WpfLHFRyOM9uOZEF+7AXkJpebrXsx2rM2mTk3VQMJOQtUr0/A5INAd0BHY=
X-Received: by 2002:a17:902:6b43:b0:1e0:e11:c631 with SMTP id
 g3-20020a1709026b4300b001e00e11c631mr8163116plt.34.1711427130295; Mon, 25 Mar
 2024 21:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com> <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
 <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com> <1711346901.0977402-2-xuanzhuo@linux.alibaba.com>
 <87zfum7ii8.fsf@redhat.com> <CACGkMEv0g9CJmZzO4bH2BjcL5Wc0NxE6+zQ2Wgg=3v2AqR=XQA@mail.gmail.com>
In-Reply-To: <CACGkMEv0g9CJmZzO4bH2BjcL5Wc0NxE6+zQ2Wgg=3v2AqR=XQA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:25:19 +0800
Message-ID: <CACGkMEt4rkuieVzFs6OKmpOcp9oC1R-LCju+t-7WfDcSjLND6w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
 names[] is null
To: Cornelia Huck <cohuck@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org, 
	Daniel Verkamp <dverkamp@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_212534_989914_1FEF815A 
X-CRM114-Status: GOOD (  49.49  )
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

On Tue, Mar 26, 2024 at 12:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Mar 25, 2024 at 5:44=E2=80=AFPM Cornelia Huck <cohuck@redhat.com>=
 wrote:
> >
> > On Mon, Mar 25 2024, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > > On Fri, 22 Mar 2024 22:02:27 +0100, David Hildenbrand <david@redhat.c=
om> wrote:
> > >> On 22.03.24 20:16, Daniel Verkamp wrote:
> > >> > On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > >> >>
> > >> >> Currently, the init_vqs function within the virtio_balloon driver=
 relies
> > >> >> on the condition that certain names array entries are null in ord=
er to
> > >> >> skip the initialization of some virtual queues (vqs). This behavi=
or is
> > >> >> unique to this part of the codebase. In an upcoming commit, we pl=
an to
> > >> >> eliminate this dependency by removing the function entirely. Ther=
efore,
> > >> >> with this change, we are ensuring that the virtio_balloon no long=
er
> > >> >> depends on the aforementioned function.
> > >> >
> > >> > This is a behavior change, and I believe means that the driver no
> > >> > longer follows the spec [1].
> > >> >
> > >> > For example, the spec says that virtqueue 4 is reporting_vq, and
> > >> > reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set=
,
> > >> > but there is no mention of its virtqueue number changing if other
> > >> > features are not set. If a device/driver combination negotiates
> > >> > VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ =
or
> > >> > VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification i=
s
> > >> > that reporting_vq should still be vq number 4, and vq 2 and 3 shou=
ld
> > >> > be unused. This patch would make the reporting_vq use vq 2 instead=
 in
> > >> > this case.
> > >> >
> > >> > If the new behavior is truly intended, then the spec does not matc=
h
> > >> > reality, and it would need to be changed first (IMO); however,
> > >> > changing the spec would mean that any devices implemented correctl=
y
> > >> > per the previous spec would now be wrong, so some kind of mechanis=
m
> > >> > for detecting the new behavior would be warranted, e.g. a new
> > >> > non-device-specific virtio feature flag.
> > >> >
> > >> > I have brought this up previously on the virtio-comment list [2], =
but
> > >> > it did not receive any satisfying answers at that time.
> >
> > I had missed it back then, but now that I read it, I realize that we
> > really have a bit of a mess here :/
> >
> > >>
> > >> Rings a bell, but staring at this patch, I thought that there would =
be
> > >> no behavioral change. Maybe I missed it :/
> > >>
> > >> I stared at virtio_ccw_find_vqs(), and it contains:
> > >>
> > >>      for (i =3D 0; i < nvqs; ++i) {
> > >>              if (!names[i]) {
> > >>                      vqs[i] =3D NULL;
> > >>                      continue;
> > >>              }
> > >>
> > >>              vqs[i] =3D virtio_ccw_setup_vq(vdev, queue_idx++, callb=
acks[i],
> > >>                                           names[i], ctx ? ctx[i] : f=
alse,
> > >>                                           ccw);
> > >>              if (IS_ERR(vqs[i])) {
> > >>                      ret =3D PTR_ERR(vqs[i]);
> > >>                      vqs[i] =3D NULL;
> > >>                      goto out;
> > >>              }
> > >>      }
> > >>
> > >> We increment queue_idx only if an entry was not NULL. SO I thought n=
o
> > >> behavioral change? (at least on s390x :) )
> >
> > The code for pci behaves in the same way.
> >
> > >>
> > >> It's late here in Germany, so maybe I'm missing something.
> > >
> > > I think we've encountered a tricky issue. Currently, all transports h=
andle queue
> > > id by incrementing them in order, without skipping any queue id. So, =
I'm quite
> > > surprised that my changes would affect the spec. The fact that the
> > > 'names' value is null is just a small trick in the Linux kernel imple=
mentation
> > > and should not have an impact on the queue id.
> > >
> > > I believe that my recent modification will not affect the spec. So, l=
et's
> > > consider the issues with this patch set separately for now. Regarding=
 the Memory
> > > Balloon Device, it has been operational for many years, and perhaps w=
e should
> > > add to the spec that if a certain vq does not exist, then subsequent =
vqs will
> > > take over its id.
> >
> > The changes here do not really seem to affect the spec issue that Danie=
l
> > had noted, unless I'm reading the code wrong.
>
> Spec seems to be wrong here:
>
> 5.5.2 Virtqueues
>
> 0 inflateq 1 deflateq 2 statsq 3 free_page_vq4 r eporting_vq
>
> And this is the Qemu implementation:
>
> 5.5.2 Virtqueues
>
>     s->ivq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>     s->dvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>     s->svq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
>
>     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_H=
INT)) {
>         s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
>                                            virtio_balloon_handle_free_pag=
e_vq);
>         precopy_add_notifier(&s->free_page_hint_notify);
>
>         object_ref(OBJECT(s->iothread));
>         s->free_page_bh =3D
> aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
>
> virtio_ballloon_get_free_page_hints, s,
>                                              &dev->mem_reentrancy_guard);
>     }
>
>     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING))=
 {
>         s->reporting_vq =3D virtio_add_queue(vdev, 32,
>                                            virtio_balloon_handle_report);
>     }
>
> We need to fix it.

Another possible issue:

FS device:

5.11.2 Virtqueues

0 hiprio 1 notification queue 2=E2=80=A6n request queues

The notification queue only exists if VIRTIO_FS_F_NOTIFICATION is set.

Kernel driver had this:

enum {
        VQ_HIPRIO,
        VQ_REQUEST
};

Which means request starts from 1.

Thanks

>
> >
> > However, we should try to address the spec mess, where we have at least
> > some of the most popular/important implementations behaving differently
> > than the spec describes... I would suggest to discuss that on the virti=
o
> > lists -- but they are still dead, and at this point I'm just hoping
> > they'll come back eventually :/
> >
>
> Thanks


