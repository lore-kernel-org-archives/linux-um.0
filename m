Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C53C47258
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=peGGQf3sjuZMqqhDGxYZpBNQpOww05kdciLu+8qQbKs=; b=kSlbCH5dkAK7F8yso5G7cqGV9c
	L1iFCXeLNDGlramQ2c2uzYjthCyPMKRV+G9kVFxGDpSGviXKWznhhJ8ZzJX1aIRVQLrUS2G1qd0Us
	ySx0jUvAmaEzg5K8r2oYbCzA0AXVzSMFrqmrtN7+sKIkwGZfUysfLs86lsVVhXCy50tjCAIx97po/
	hpEdk+enjy+YuwDD8PzHlWDkOXZp/7Ec1y9dyYzNVTRHCfc2FcbfB5kkcqkd326fk5t53a2OO14Ck
	VDFepTd6YrfETwihgEBCcz/VsOVnwi9VfyJf2X9h+ZMw8R6TEmap9D2k9re555Zbl3U/ikW14B2fL
	vgsByftA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6ff-00000002NUZ-2Ouw;
	Wed, 31 Jan 2024 09:14:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fd-00000002NSV-2HN3
	for linux-um@bombadil.infradead.org;
	Wed, 31 Jan 2024 09:14:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=peGGQf3sjuZMqqhDGxYZpBNQpOww05kdciLu+8qQbKs=; b=XjGZpPvqMgqZHn6n4VZTIs/b2Q
	iD0s4+X/nKK5Aml27ozeb6yWd9RrO64+sPAauKq5I2IZ+1N2jO5w9L9u2kDXk0DtKTQjImEbZZ5Mb
	OPseiTV4/krtBfKyIgEufoxGp3fvsJFRDKlYIX1Wngf0+EBF4pNr1NDYb2+9OQzwGA8vRco0NqO5b
	NOXA0y3L2Yzm3J6Oi1POtEoIs905/7m+mIfz9ikKUIUGkG7Wl21XoQeWF+/r5uNDXKywm9/o7tne2
	WL1jReBkRs0KJ+rqBCLheBU2+GRCtk4wEkq4ue0oAz7BSufq4ldz5VIzDblwip9d8FOtehIR7GHre
	n+fJMdbA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fU-00000008tiI-3iht
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 09:14:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peGGQf3sjuZMqqhDGxYZpBNQpOww05kdciLu+8qQbKs=;
	b=MFCORpRPQpwfMlxTjbBE02o/krGkFxXPn7o2+kSlSZXXiGFyhO+beNW2rkeLSYrGaK2g+G
	iMTUnbBKv1Y59QaQ7k4eIg8uuj61ChsKmLWVMKjb4DBD3MTKM6yCxLZYUxXrSTNpQjU8mC
	znnvb9DqrOvE46LyhePxD661VwNAeXE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peGGQf3sjuZMqqhDGxYZpBNQpOww05kdciLu+8qQbKs=;
	b=MFCORpRPQpwfMlxTjbBE02o/krGkFxXPn7o2+kSlSZXXiGFyhO+beNW2rkeLSYrGaK2g+G
	iMTUnbBKv1Y59QaQ7k4eIg8uuj61ChsKmLWVMKjb4DBD3MTKM6yCxLZYUxXrSTNpQjU8mC
	znnvb9DqrOvE46LyhePxD661VwNAeXE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-NduPbcseO1--_-pIb6e_Vw-1; Wed, 31 Jan 2024 04:12:38 -0500
X-MC-Unique: NduPbcseO1--_-pIb6e_Vw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd3bdcd87fso7281408b6e.3
        for <linux-um@lists.infradead.org>; Wed, 31 Jan 2024 01:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692358; x=1707297158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peGGQf3sjuZMqqhDGxYZpBNQpOww05kdciLu+8qQbKs=;
        b=IP/czPRGjdWLJGj59Zhvy2URsBMrJKazLWZSDxk166KZdnJH1hSIGuJrSuppsKT5Zw
         wp0XNe7a/lqXDCaB0mLP/qPsW6lJ9Uc3yYqglIwmJ+D9a++IodvQslnq9HTd2rgDfNDQ
         wQK3O9XDwt1jDPsiaGey+ynDWKDTEx2pZGeOhzGn+buGC4qhqE9ksLy+/23bNvqKfQJI
         qeTYV2XFXmyaj7uUxgPh6IxT9ciSD127LoQrzfHmPgksl1pYB9yTiHWUwLbImMOTNWPg
         fL+pqdY01yPHAvn5808dAXAf/nzVDTESkL/P86E6kJjIAoRNSFzdO8QCi8tKjzC9L1cx
         mZiQ==
X-Gm-Message-State: AOJu0Yy8TMFURGLicP7CRjUHyB5U3V+uon9dRKTL7fZOcQw8R4CCChtl
	mryuuPkwG0MqVGv7vzLN/+z59NcbNuUiEiyQOKFTwVTP+E2hJWI99V+5C8psttOOiakfAxDXvdH
	flEBUlCnhoPjQuoRl715z+VP6cVHIVwX6E+6s/GdLf1NeylvK4z3fTuyZXpBIGOQfjjvqLDH9YR
	F6ToYln4NnJWu75TiVJwRa9IEW8bGuONk/4BCe
X-Received: by 2002:a05:6358:6e8b:b0:176:4aae:515c with SMTP id q11-20020a0563586e8b00b001764aae515cmr994103rwm.17.1706692357789;
        Wed, 31 Jan 2024 01:12:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7fIfH41RbzJ4uMQRVZeD0/FtypkpuMBhNalI0GgIXQr8L0GNwGZEMNsexvxgVEoc2spN+yWaoh5j46pvgQwg=
X-Received: by 2002:a05:6358:6e8b:b0:176:4aae:515c with SMTP id
 q11-20020a0563586e8b00b001764aae515cmr994071rwm.17.1706692357511; Wed, 31 Jan
 2024 01:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:25 +0800
Message-ID: <CACGkMEst-k1uOUA6diC2yB+=9ZYezuz=n3=kAzDFpXLxGE=etQ@mail.gmail.com>
Subject: Re: [PATCH vhost 05/17] virtio_ring: split: structure the indirect
 desc table
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
X-CRM114-CacheID: sfid-20240131_091407_040002_C603D476 
X-CRM114-Status: GOOD (  14.65  )
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

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional. But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 86 ++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2b41fdbce975..831667a57429 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,9 +67,16 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif

[...]

> +               kfree(in_desc);
>                 vq->split.desc_state[head].indir_desc =3D NULL;
> -

Unnecessary changes.

Thanks


>         }
>
>         vq->split.desc_extra[i].next =3D vq->free_head;
> --
> 2.32.0.3.g01195cf9f
>


