Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7A8C54E67
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 04:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQsyVicGgRcIN44As4bUegtDIQaw+ubTJUdf1CG0g5E=; b=i3MYfPeG6QrZjpp5W8HVJCvC6G
	1tHwAhEXQMr2X3zE0gL94AIEA63swe8ssU7ETWLV7LGng0Fj5slegAVUjhJahEJPDOOVdBnqI4qTT
	WeWFSwccbQTdJvawJfs/IC0MU8IOL2V5JcudDS9VwRCeDD5y3CHWh/U9Rk6VV3ITqbv1+eOQvFn3n
	Ubm3WazQwXYG3OUBxv13XfikgUGVhFUmZGYci6BWWnGyq70fzUDWLwk14u/ZZRqh1+pFoKo/+d0la
	Q25hH8pZ9V58dSQkknYS/aN7gosawBKqDMri1q3lh7Mip+goKKK3MDnatbIVvzXwdBdt7vebH2cvp
	T0ycRy+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roy9y-000000030bd-16tC;
	Tue, 26 Mar 2024 04:11:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roy9w-000000030bG-1AJi
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 04:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711426293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQsyVicGgRcIN44As4bUegtDIQaw+ubTJUdf1CG0g5E=;
	b=E998erZR3RUMQhFGLsTlyZhcnlCCnFt63Xh0xzTwtarzswi/UpZrvtoQckMvhbLnPUoFTU
	IWM+QR8R/RJIi1xsLBL6xtHXnYn0QsARju8JWBoF/i//P1I42a4aqEFBu/QMmFhJyq8Q09
	OXL/VvYyC/Jjh2E6AcA9qFB76DT7Tmo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-7_ONbcHyM8ie69mDt16dgw-1; Tue, 26 Mar 2024 00:11:28 -0400
X-MC-Unique: 7_ONbcHyM8ie69mDt16dgw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8bcf739e5so3773188a12.1
        for <linux-um@lists.infradead.org>; Mon, 25 Mar 2024 21:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711426287; x=1712031087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQsyVicGgRcIN44As4bUegtDIQaw+ubTJUdf1CG0g5E=;
        b=uyoqnGFbuiF8tjeTl5dc/SPV4ZOPdhl+04Usc6FATEZ2YAL6zsvfjwadoDOX3g2ept
         LzNXWIwQDzCHkED21qZR4VgSd9zw9U87CjFo8Oa7+Y5/5LdFunDvds7PDOIw1gnx9FcY
         U6zx9r01TusDOt9hKzib0sYalwF/I0ZQspM0rzXy9UwHUKdGYr1eJ+fSQ7Vy05ZisAxW
         OrNNK3emqROcFqtz7vlFpC6dRe8jBGUNsROsspewR9QxpUPj+xu8FjMLYo0vT4SadxgC
         igoqNFPWcP/0AwfHRiSpE8mEVuJ9V/wYJ6Rn5J0M0QBC21C0ZMePJceVbHn9nD0zxwFv
         PJJA==
X-Forwarded-Encrypted: i=1; AJvYcCULM9oBwu3BOmRzhrtg7sUKuCvd4j29WEC5+FZ6feYAC+2ybt75lCSuawnNtzFQ7Z6iz6TE4dAZhX0qHUOkY8EpVMLxNRAqyrstUHHC
X-Gm-Message-State: AOJu0Yzz6mSln0PIBrCXF9tcBE69WdkZce+u6otxSpqBFybjbPKeaTNa
	YgPR4UxQyNeHvp7Uu8NjdbzISBKRRK8CYcgpaNOPK7NXtT90orI82IZCfGo+kUEA0nsnIeMy3Aj
	6q/jil9YKa4njX3fGNKc/7vatQ/uVynZ0j6x5UROPcW8a2dTOx2dut8/Fv7ERlzxjO4IQ0xVtDT
	DmJEKfhfDdUDS5T6mfyofq0Rap8EANNeJlFQrj
X-Received: by 2002:a05:6a20:258c:b0:1a3:c38d:3faa with SMTP id k12-20020a056a20258c00b001a3c38d3faamr5648384pzd.42.1711426286926;
        Mon, 25 Mar 2024 21:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiRyQj7rPG1kUKPZ23XZNSein3zhu5gMpJRn7QAtQMWCO9dHpV877gL0Y33Jgc90wBoRXEcgX2bRa4NFcju8o=
X-Received: by 2002:a05:6a20:258c:b0:1a3:c38d:3faa with SMTP id
 k12-20020a056a20258c00b001a3c38d3faamr5648365pzd.42.1711426286588; Mon, 25
 Mar 2024 21:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com> <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
 <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com> <1711346901.0977402-2-xuanzhuo@linux.alibaba.com>
 <87zfum7ii8.fsf@redhat.com>
In-Reply-To: <87zfum7ii8.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:11:15 +0800
Message-ID: <CACGkMEv0g9CJmZzO4bH2BjcL5Wc0NxE6+zQ2Wgg=3v2AqR=XQA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240325_211136_419353_2A132C84 
X-CRM114-Status: GOOD (  44.81  )
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

On Mon, Mar 25, 2024 at 5:44=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> w=
rote:
>
> On Mon, Mar 25 2024, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > On Fri, 22 Mar 2024 22:02:27 +0100, David Hildenbrand <david@redhat.com=
> wrote:
> >> On 22.03.24 20:16, Daniel Verkamp wrote:
> >> > On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> >> >>
> >> >> Currently, the init_vqs function within the virtio_balloon driver r=
elies
> >> >> on the condition that certain names array entries are null in order=
 to
> >> >> skip the initialization of some virtual queues (vqs). This behavior=
 is
> >> >> unique to this part of the codebase. In an upcoming commit, we plan=
 to
> >> >> eliminate this dependency by removing the function entirely. Theref=
ore,
> >> >> with this change, we are ensuring that the virtio_balloon no longer
> >> >> depends on the aforementioned function.
> >> >
> >> > This is a behavior change, and I believe means that the driver no
> >> > longer follows the spec [1].
> >> >
> >> > For example, the spec says that virtqueue 4 is reporting_vq, and
> >> > reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
> >> > but there is no mention of its virtqueue number changing if other
> >> > features are not set. If a device/driver combination negotiates
> >> > VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
> >> > VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
> >> > that reporting_vq should still be vq number 4, and vq 2 and 3 should
> >> > be unused. This patch would make the reporting_vq use vq 2 instead i=
n
> >> > this case.
> >> >
> >> > If the new behavior is truly intended, then the spec does not match
> >> > reality, and it would need to be changed first (IMO); however,
> >> > changing the spec would mean that any devices implemented correctly
> >> > per the previous spec would now be wrong, so some kind of mechanism
> >> > for detecting the new behavior would be warranted, e.g. a new
> >> > non-device-specific virtio feature flag.
> >> >
> >> > I have brought this up previously on the virtio-comment list [2], bu=
t
> >> > it did not receive any satisfying answers at that time.
>
> I had missed it back then, but now that I read it, I realize that we
> really have a bit of a mess here :/
>
> >>
> >> Rings a bell, but staring at this patch, I thought that there would be
> >> no behavioral change. Maybe I missed it :/
> >>
> >> I stared at virtio_ccw_find_vqs(), and it contains:
> >>
> >>      for (i =3D 0; i < nvqs; ++i) {
> >>              if (!names[i]) {
> >>                      vqs[i] =3D NULL;
> >>                      continue;
> >>              }
> >>
> >>              vqs[i] =3D virtio_ccw_setup_vq(vdev, queue_idx++, callbac=
ks[i],
> >>                                           names[i], ctx ? ctx[i] : fal=
se,
> >>                                           ccw);
> >>              if (IS_ERR(vqs[i])) {
> >>                      ret =3D PTR_ERR(vqs[i]);
> >>                      vqs[i] =3D NULL;
> >>                      goto out;
> >>              }
> >>      }
> >>
> >> We increment queue_idx only if an entry was not NULL. SO I thought no
> >> behavioral change? (at least on s390x :) )
>
> The code for pci behaves in the same way.
>
> >>
> >> It's late here in Germany, so maybe I'm missing something.
> >
> > I think we've encountered a tricky issue. Currently, all transports han=
dle queue
> > id by incrementing them in order, without skipping any queue id. So, I'=
m quite
> > surprised that my changes would affect the spec. The fact that the
> > 'names' value is null is just a small trick in the Linux kernel impleme=
ntation
> > and should not have an impact on the queue id.
> >
> > I believe that my recent modification will not affect the spec. So, let=
's
> > consider the issues with this patch set separately for now. Regarding t=
he Memory
> > Balloon Device, it has been operational for many years, and perhaps we =
should
> > add to the spec that if a certain vq does not exist, then subsequent vq=
s will
> > take over its id.
>
> The changes here do not really seem to affect the spec issue that Daniel
> had noted, unless I'm reading the code wrong.

Spec seems to be wrong here:

5.5.2 Virtqueues

0 inflateq 1 deflateq 2 statsq 3 free_page_vq4 r eporting_vq

And this is the Qemu implementation:

5.5.2 Virtqueues

    s->ivq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
    s->dvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
    s->svq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);

    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HIN=
T)) {
        s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                           virtio_balloon_handle_free_page_=
vq);
        precopy_add_notifier(&s->free_page_hint_notify);

        object_ref(OBJECT(s->iothread));
        s->free_page_bh =3D
aio_bh_new_guarded(iothread_get_aio_context(s->iothread),

virtio_ballloon_get_free_page_hints, s,
                                             &dev->mem_reentrancy_guard);
    }

    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
        s->reporting_vq =3D virtio_add_queue(vdev, 32,
                                           virtio_balloon_handle_report);
    }

We need to fix it.

>
> However, we should try to address the spec mess, where we have at least
> some of the most popular/important implementations behaving differently
> than the spec describes... I would suggest to discuss that on the virtio
> lists -- but they are still dead, and at this point I'm just hoping
> they'll come back eventually :/
>

Thanks


