Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211A2C47DDB
	for <linux-um@archiver.kernel.org>; Thu,  1 Feb 2024 05:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CBg4S8QmOTSeweCbha4veMntFYrtd8iVVLl9ekfIfl8=; b=UZMrSvaqAGgJ8wdRD83jrT77pt
	B6IiREu7yRXGqRQfUD3Fva/CMXy34pLymM3esFbZe9KHfSZXQKFwkaubs48Mucivvptc/4AV7AKUd
	EoTKW9J/u4xRUx9nO7VaTYM8KUXcw7yL3nZii0g0SlOYY4Av3yHOV62gZONzyJRTJnn4JgLaVW+56
	2ZC3kZYZ/wAIKGfuEci3nClrcVzX6WnMAknBDFO1nCm/SZ6hVRxc4mEoD3Oe/vP+dv2sS2tMSsmEP
	2i9CvyAV44aqwCiF08i//l+YSWuAufTpNkPzSCCXvISFoNNOef/h/aNBwlVDMZpStMX0J9C15pk74
	+icImt7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVPvE-00000006fdL-36zN;
	Thu, 01 Feb 2024 05:47:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVPvB-00000006fcT-3i9N
	for linux-um@lists.infradead.org;
	Thu, 01 Feb 2024 05:47:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706766452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBg4S8QmOTSeweCbha4veMntFYrtd8iVVLl9ekfIfl8=;
	b=gdzxbxNI7YXA5dDFK/Gzd8uKcmrh//zZOuwZrxFyyM09/Fc+kuKbSgI34yVYjxE7hX+ybx
	t5m1NkyxTUsni4+j3WuD2qScwiaQROS9SrWZ5Jk7jWceYSpHTly/nTvet23FkvfQyrEM6K
	pgPDvAVRQX7izSdlYgoDCg/o9zU4ItE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-BR5quWWePISsPtZ4rxivtw-1; Thu, 01 Feb 2024 00:47:31 -0500
X-MC-Unique: BR5quWWePISsPtZ4rxivtw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-59823dbe921so669686eaf.1
        for <linux-um@lists.infradead.org>; Wed, 31 Jan 2024 21:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706766451; x=1707371251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBg4S8QmOTSeweCbha4veMntFYrtd8iVVLl9ekfIfl8=;
        b=aRaBZYh19MrG9UF9V44sF35K0KzMZc4AOuiwVwRkHMbtf95jILziUNdUseyna3V2Z6
         qgVhWsDi2/HtpXe4nqqZhvzlOGiS5lHxdMvpQrD9GpZ5IekyKGxvsPJ3cBSHYiDIH1WM
         W6TE2d6BT2z9YtOr/fjEaySPGMmAhSWa8ny2HlTEwCqTCqamwCeUPeJScC540hHSkNZ7
         B8fNDre3Ud6GVEHGbec82xnikLESEKhE2N6meVJCoEKNE8Tu9c/QnAMmRkQ8Ufqi0MpZ
         fjJ8VRmwK8OCgnndW7HIf+MgC8yBUyKwCnnQcn2zGnS92OsHdZYflNHlOp5DbtTe3C3d
         Gitg==
X-Gm-Message-State: AOJu0YyEIR0Ktv9U2evPZK5crMAao9pM09D3AfEM/Mg72GtlbGAR5VH6
	e1IIxcwg2rPCTvmEyuMfDq0GnJtyB/QRWiAXctkQWTlgGFB+P9pUgG1MMzh6zgjmv2d8T3eaC1F
	eamijfxzL7cVbd99F2McuhhMGJFJ3tmBdwNvT8El4tR93s06EY1x4C7yjU8KNTPaBsn1Hyl5F/h
	ZcSayeETt0ieUBnL40GvlC5tOPHcCxZg8o8sX0
X-Received: by 2002:a05:6358:d39c:b0:176:8f0a:be with SMTP id mp28-20020a056358d39c00b001768f0a00bemr4016610rwb.13.1706766450826;
        Wed, 31 Jan 2024 21:47:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3An1AT31hO5hdkkjtXW6+RRmDXc3skwLBvXnf7TlMSMjKRjtJlegau4gTcU4VNwvLpLMGyNjYJHuT0DVlBR8=
X-Received: by 2002:a05:6358:d39c:b0:176:8f0a:be with SMTP id
 mp28-20020a056358d39c00b001768f0a00bemr4016580rwb.13.1706766450596; Wed, 31
 Jan 2024 21:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-5-xuanzhuo@linux.alibaba.com> <CACGkMEs-wUa_z_tGYEwBf7EVJAtuJdkX4HAdjqMXHEM1ys-gKQ@mail.gmail.com>
 <20240131044244-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240131044244-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:47:19 +0800
Message-ID: <CACGkMEskm6O0q86LOJGndiCmaTCnoqKYWVct_g-0fwV3c+_1fw@mail.gmail.com>
Subject: Re: [PATCH vhost 04/17] virtio_ring: split: remove double check of
 the unmap ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
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
X-CRM114-CacheID: sfid-20240131_214734_019305_C9D96F66 
X-CRM114-Status: GOOD (  10.87  )
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

On Wed, Jan 31, 2024 at 5:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jan 31, 2024 at 05:12:22PM +0800, Jason Wang wrote:
> > I post a patch to store flags unconditionally at:
> >
> > https://lore.kernel.org/all/20220224122655-mutt-send-email-mst@kernel.o=
rg/
>
> what happened to it btw?

Haven't got time for a benchmark. We can evaluate whether we still
need it here and do the benchmark if yes.

Thanks

>
> --
> MST
>


