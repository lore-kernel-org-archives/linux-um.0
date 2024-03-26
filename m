Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4205FC54E67
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 04:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5seLBV3yQLKEzxkNLkKpqsB4myVj0SW/ABTJB8Ficg=; b=jX0fdDqPWlRPgQAdLPV1FvwJku
	3udz1tHehPuivGyHzQZPmaGgGy+oeu8v+AP0Kldl3GhBI0PWgEyY7UoVoNVOsdsngbj5DhnaRwNvp
	LN5uEufDRh4yF1yZSvJnJYe859k9KNX7TwNAhM+PyMQpRgvrj3r8tFRlvnRAr29YhnbSnh5bA3v7W
	58B6xniAigJSb9ZvogjnCWqGSuYjdVJtDrk0hCisbSPQQHWhr9XWMjptL3jrP4tdStiQEw/80eZ2W
	i98WoQnWz6zBrOUn8GL55nTSiq8pd8zVod4qbXys9eADTAA4YdMpimz+Oawe79Pi6oKlvFsgRCWnb
	HaAPlLZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1royCq-000000030pw-1xb5;
	Tue, 26 Mar 2024 04:14:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1royCm-000000030pS-3dzL
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 04:14:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711426470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5seLBV3yQLKEzxkNLkKpqsB4myVj0SW/ABTJB8Ficg=;
	b=Tu58LgMVpAeVrreq6gi2bgo64sCOnRVGUbtN1iGAMvm/H/mv9lg/JInUmMAy9BHEdfo1Dk
	C/286l6QUrUW0sgHtTwXzcyMrb2AozMHWmUL7LXW+pYgoEroVSMfj3E9gJDIopyO2gz+av
	SdLDYVE0r+nwA67ZIAathKq+GGfAVg0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-fAJmmk98Odi2D4E4TsHcSQ-1; Tue, 26 Mar 2024 00:14:29 -0400
X-MC-Unique: fAJmmk98Odi2D4E4TsHcSQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e0c4fbaf6bso13132515ad.0
        for <linux-um@lists.infradead.org>; Mon, 25 Mar 2024 21:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711426468; x=1712031268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5seLBV3yQLKEzxkNLkKpqsB4myVj0SW/ABTJB8Ficg=;
        b=DrdS49ydn1eA78QKtwEesYnKMVbjX5F4hxMt4ud37klGxAZjRhGRM1VMGp/yP/xiag
         Wc2XTUV9jZDk8PlMLA1oGgH1POdOrPkByQn/rc2M9I73a9SzK1IQFkobgY0MfS7ghsXx
         /jPHx9OGNTtLRZJBFjeYz597otTHJ2/efAORhsKKWGbXA4xRg7ooi5tQlAtkTKNwwzaX
         miDBWWrwtfu8j7eALdqZTs72F87y57lZoo+fXaz74g7+CTACFqUWdlde+kJzEvufjenC
         O0/9zsyqRAX4MBDFUExlLSi3YiX4fZ+id8z3YEfNKLq77EpeuHja2qNeKBx8qBvTCsV5
         SMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/FiMcXyHLjqzloX8Uwrab9dhyUxa7mlq6sTO26yaxFyKEHBfspkTvEjW2+0d2jJtFbjtLBKN4zYO7pTo/G0B5+oZ33K/iAolXbdQa
X-Gm-Message-State: AOJu0Yx21DZk44+iebu7oWWdMXQY9nYWuNywKm8RFKDh3cLSIZon2K/D
	49sF/tusRbcfSni+HEnaz4pUTPCjYvCecO6S2knfIcT+40yrk58udqGthduc0DURTBsSy0wVSVy
	ZhbfZridc3+lkC73KpQGpi4N2ZxNI2TT5ehfynftAsbmYhJFPmAhGoIinfcL2Xm360g5DjxcL5r
	1L3Acow2BfEWpIf1rdpq9A0+/U4Ks3dhq1twFv
X-Received: by 2002:a17:902:bb8b:b0:1e0:3447:8dc5 with SMTP id m11-20020a170902bb8b00b001e034478dc5mr7853378pls.63.1711426468466;
        Mon, 25 Mar 2024 21:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwt4O9JFYe1EZZmEzO6Sbv2fxkM9fzp0kVx8cNiJULf0bko9Urf0e0rh9UwekdZlbEud76q0+6xDYSjR16I7Q=
X-Received: by 2002:a17:902:bb8b:b0:1e0:3447:8dc5 with SMTP id
 m11-20020a170902bb8b00b001e034478dc5mr7853360pls.63.1711426468211; Mon, 25
 Mar 2024 21:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com> <20240325090419.33677-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240325090419.33677-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:14:17 +0800
Message-ID: <CACGkMEtBw86fXjFrk6Rt4ytOYOn2q7r5a4WuvsgqPGT8O7tr0g@mail.gmail.com>
Subject: Re: [PATCH vhost v5 1/6] virtio_balloon: remove the dependence where
 names[] is null
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
X-CRM114-CacheID: sfid-20240325_211433_211595_E5230C9D 
X-CRM114-Status: GOOD (  11.29  )
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

On Mon, Mar 25, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Currently, the init_vqs function within the virtio_balloon driver relies
> on the condition that certain names array entries are null in order to
> skip the initialization of some virtual queues (vqs).

If there's a respin I would add something like:

1) the virtqueue index is contiguous for all the existing devices.
2) the current behaviour of virtio-balloon device is different from
what is described in the spec 1.0-1.2
3) there's no functional changes and explain why

> This behavior is
> unique to this part of the codebase. In an upcoming commit, we plan to
> eliminate this dependency by removing the function entirely. Therefore,
> with this change, we are ensuring that the virtio_balloon no longer
> depends on the aforementioned function.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

With the above tweak.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


