Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5D6C48286
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 03:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+jjk3jE8PhNNZNmWy+1f2O2oViFlMeQMdnMn/9Z9Ruw=; b=2tLRSzyq+kEhSmOodwG/BRwAO9
	CEgUwW/Q/Whr8UUalAMIvh97jMTwEJ3svlGlAgjED8tH6e7YAhCZIdGvL+kI3LD4QSU2CFtqfjsqC
	W6WlPzIlDmaY9lNx20upnd6MTKJrjqT0/zGC+WeycxsvvtXnM1GWEv3cyYFDYD0VYd/h2/Z0mAdtO
	jZRkHkfi7b1kn6n6roO7S3J3OG+7NPTKc0U81MqA6bNj59GrBk3LYisoI8iV+JKTg8ramQvYcDC+N
	4iF5jV1nHtYVdhKSgbcNwK2ZpqKOb/4DQ1u7Bn1q7g/Pn/WKxW6vReOrwrRcYs5s+7yPF5ucdlkXL
	NGrrgXqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVjr3-00000009y3L-33fr;
	Fri, 02 Feb 2024 03:04:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVjr1-00000009y1O-049G
	for linux-um@lists.infradead.org;
	Fri, 02 Feb 2024 03:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706843072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jjk3jE8PhNNZNmWy+1f2O2oViFlMeQMdnMn/9Z9Ruw=;
	b=DG3nDFLJZk2HpdOZoW9VNcbL8pfike+8vtCrchmyVPYB0OQZaOgHpEyH6BWKp/eBD0nnBd
	D9wNYmvZM1ttJ37bq9d8Viilu+Lnb3QnIk2hqqr6g55neLsBbs9tpiaEWL3B0YSLM5fcHn
	pGJpw2mgkOvjLLxVivWqv1vnFs7e554=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-eb6H8rz_N3a_FaSdnmhVnQ-1; Thu, 01 Feb 2024 22:04:29 -0500
X-MC-Unique: eb6H8rz_N3a_FaSdnmhVnQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6de2116e7c2so1569584b3a.1
        for <linux-um@lists.infradead.org>; Thu, 01 Feb 2024 19:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843068; x=1707447868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jjk3jE8PhNNZNmWy+1f2O2oViFlMeQMdnMn/9Z9Ruw=;
        b=RbCqDR14UG6ViKMsHp/rzv3ItAq/QBD5+ewkh2rW8OVjDfnBqgA1m8VmALSuAnOHec
         J5364D8fPw034ff8xz41oKSXyY2pDmenKR8TGUFq35gAYHL2u2/GQmdy/+3dfCxEp/iR
         vbhu6cb0mLn7THbg4+tLJWu78oANdIUgKdxZAlcmoiF+u7eSV2UCkCF8p6B+OqCpD5Gu
         ILwqSfKw+EXyGpCNMHH86hSkNvQlBERemycWq+gZs9dJUSGiK/JIeapimYU8reN6r93/
         6PLeuhvfs0pSCJbtmcQeBbRYh4O3PUg6O8Y5d/pWmb+sdL/lYQR+ALJ+dDDRRulSfKKf
         3AEA==
X-Gm-Message-State: AOJu0YwsHn3dac20/If1XuoE7FqWivfQV5MJIF6crWJycER8f6FrcCm+
	Tv7Lzj2fSAohMl22fpRz6qihfj7XyufnCL51XSmp2iHF8FeqfJ6KyPuv2v8oBK+eLiaIRFPcGYI
	G83rxPY2FL8mAiJc/le1I5wD0P342P88DAHj9W/LUy2ByVmPOWCRad9mR8vnORYOvm8ex67acdr
	VhBVUJRJz7UT804wUzJmObtu/QPBwDyyykuXL3
X-Received: by 2002:aa7:8a4f:0:b0:6d9:9613:cb9e with SMTP id n15-20020aa78a4f000000b006d99613cb9emr4121335pfa.29.1706843068413;
        Thu, 01 Feb 2024 19:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnfmCLPGlpseo2aKm7Vdc5x3EZtRZIzutRGAyaKH3V2ZuLamufaE9axFl8TAes1c8kVipviNI+/nVDsMZzFNU=
X-Received: by 2002:aa7:8a4f:0:b0:6d9:9613:cb9e with SMTP id
 n15-20020aa78a4f000000b006d99613cb9emr4121309pfa.29.1706843068115; Thu, 01
 Feb 2024 19:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-7-xuanzhuo@linux.alibaba.com> <CACGkMEtNCjvtDWySzeAqETGZtBSL0MR6=JySBBtm3=s19wB=1w@mail.gmail.com>
 <1706767497.2529867-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706767497.2529867-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Feb 2024 11:04:17 +0800
Message-ID: <CACGkMEs80VRVUaWJX6SFcQAzBy3Yo2M=0zkDspt10FyyzR7FqQ@mail.gmail.com>
Subject: Re: [PATCH vhost 06/17] virtio_ring: no store dma info when unmap is
 not needed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_190435_156834_FAFDB6AA 
X-CRM114-Status: GOOD (  22.42  )
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

On Thu, Feb 1, 2024 at 2:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Wed, 31 Jan 2024 17:12:29 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > As discussed:
> > > http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_=
yC21bgGkKZh845w@mail.gmail.com
> > >
> > > When the vq is premapped mode, the driver manages the dma
> > > info is a good way.
> > >
> > > So this commit make the virtio core not to store the dma
> > > info and release the memory which is used to store the dma
> > > info.
> > >
> > > If the use_dma_api is false, the memory is also not allocated.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---

[...]

> > >
> > > @@ -1245,14 +1269,16 @@ static u16 packed_last_used(u16 last_used_idx=
)
> > >
> > >  /* caller must check vring_need_unmap_buffer() */
> > >  static void vring_unmap_extra_packed(const struct vring_virtqueue *v=
q,
> > > -                                    const struct vring_desc_extra *e=
xtra)
> > > +                                    unsigned int i)
> > >  {
> > > +       const struct vring_desc_extra *extra =3D &vq->packed.desc_ext=
ra[i];
> > > +       const struct vring_desc_dma *dma =3D &vq->packed.desc_dma[i];
> > >         u16 flags;
> > >
> > >         flags =3D extra->flags;
> >
> > I don't think this can be compiled.
>
> I do not find any error.
> Could you say more?

Sorry, I misread the code.

It should be fine.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>


