Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EC6C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=; b=HdFni9AXs3nMytc3jKGTukfH0h
	hRduNQ6oOyBPKQPM3OplQPZSe8tQwgDVRnukJf2Qb/18Yd39cx5W+6i9xnjeGu2X6MOafg8zWwEaI
	XLdiiYYf1pOWHM9lQ6mUFKAiUa4Vlkpuxk/MPi9V/aJx7tauu+xAzh+4VjKDm9mVr8iJ/1hxjfczl
	l+pbG6uEJFC8DvxlClBl2JnsUjQ4F5y14iWsa2pyYwpkOUv2EUJMtlJW4MxeDYAL8L+79vIQY0c4i
	+0hRltIcL/TASSnz7/pGMVDJL7Kr/V7PzmI9mFbM6o398mJlMUOqtkDcH3qmD49wAE9ANO484PZIa
	4mVw7g6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkml-0000000D1K8-0GN4;
	Thu, 28 Mar 2024 08:06:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkmi-0000000D1J5-2m1Y
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 08:06:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=;
	b=L2y4PDtPbUMy6OEF7iZciOm2T7jugmA8ghoVoqV+ibdcb0ePAd2erRo47eJ1I9USGTC+fy
	tNwd+cYozVGj/zhDZFI4I9G61NU3E7P2Q6YbUAqocQs74Mpb+UJwNpPNVIy79tgWj1EHcH
	qvF+epPy0qr0WAGha4cHgFuhOxB7zac=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-Zk5IUtmTOlakD8suKyXEew-1; Thu, 28 Mar 2024 04:06:50 -0400
X-MC-Unique: Zk5IUtmTOlakD8suKyXEew-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29df180bedcso691673a91.3
        for <linux-um@lists.infradead.org>; Thu, 28 Mar 2024 01:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613209; x=1712218009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=;
        b=cUvMkfYiGzUq3J0qfslYFnzRU1yKvhp2t/Eax1NTCWc0PomI/BaoTQp5Xz+xx5jOfk
         8siZJ+eTNQGkBciY454qozSXSkQVDw1oPBpC0vlWnI0uVNdiZbTs31ngIQ1hDn3ODRJN
         ucSqz+j9B35SrlsIcv18jiVtdpBPXoweQIFs5qWWZgI9WtDUlZupXSmQsw7jVOsf0JGg
         iPsU47kKy2mLbbT8kF4Mlv6zb09KaHbLzpD0yd8MUA0cj6G9v8rZFebTxGDyfXVkgzQL
         Kk14DZV5TaYDsT2eUsqikzK+gWF/9lZ809bKGOdW4s29An2RuBW3uyo17yrtvOK0twmZ
         NVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9v24U8PAbukaJBCgQ+JXtCfNEHuhT9Bnlj1ceKke63i7HIxQ3yi/1d0Zdq0fRPPFNnQSVzWlUqBFkHO6BU+tkieEd2D+s0GURDlh
X-Gm-Message-State: AOJu0YzU5n+edZ+cnUx5nrknHVg5k73pOHnl4h0yPzjMpJ+dq9fvyXv9
	pzrYFpf/CfyCpgJeuSC6O6ZBUUqBPLIE1m7dp/quxjOcQW182vJfJUnX1+8eYhM74MwDld6hlc9
	J/p+GdmUm6l+Y+BQvdLWPHUffZpgptrKrjXvc+CUnr1qyFMdj/UJrdVdyDmcSnIekf7Nhs8QQGE
	xccj+fjuami4AfGHI3JnOli+KxFcnwx2uHosxq
X-Received: by 2002:a17:90a:dc08:b0:2a0:4c3b:3454 with SMTP id i8-20020a17090adc0800b002a04c3b3454mr1573889pjv.47.1711613209128;
        Thu, 28 Mar 2024 01:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr3cKtOM4ZCyHExJ4R7r8BZoA5SFTXeHHD/kYgfJMhl+KEh6JWHIkXDQz44FirN0E+6Cmhpkbslv31U6+rB3Y=
X-Received: by 2002:a17:90a:dc08:b0:2a0:4c3b:3454 with SMTP id
 i8-20020a17090adc0800b002a04c3b3454mr1573868pjv.47.1711613208786; Thu, 28 Mar
 2024 01:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com> <20240328080348.3620-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240328080348.3620-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 16:06:37 +0800
Message-ID: <CACGkMEvv5UdAEC4N_AfQRM5TeVnPLC7PWpBvURxn+wSUhjFqrw@mail.gmail.com>
Subject: Re: [PATCH vhost v7 5/6] virtio: vring_new_virtqueue(): pass struct
 instead of multi parameters
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_010652_802083_39D8DEDE 
X-CRM114-Status: GOOD (  11.42  )
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

On Thu, Mar 28, 2024 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we pass multi parameters to vring_new_virtqueue. These parameters
> may from transport or from driver.
>
> vring_new_virtqueue is called by many places.
> Every time, we try to add a new parameter, that is difficult.
>
> If parameters from the driver, that should directly be passed to vring.
> Then the vring can access the config from driver directly.
>
> If parameters from the transport, we squish the parameters to a
> structure. That will be helpful to add new parameter.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


