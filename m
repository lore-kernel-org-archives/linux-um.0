Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9E5C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 04:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1QzCz1Z3ysjSBtKSuwdaJecZAl0r65qpJTzi3fJyIfg=; b=QYuo6Za1ANC1WmrTD5joCf9A9M
	cdBHQdcWP/wvln3n7kzjDo4+KtBwGQL6gsjR0bZCXcXl7ERb+WNuZa18OTO1neJxMl6/e7MFCKuBq
	mg02ot1csEmt0swUrDxmZnt6CggcYWTDirO1EoVDU82MXlI1RKG4u7CCOu9npObMd+qS8d9VRnJHV
	TH6LqDTHCBeTKjIwFu2P6TsbvWEKg7ihL9rAnKWob2OG7LKLlGZ+U9wUTBPDnYz6rtHNr8Ke0y3TI
	5B/D4hUXvdc3gyCf1NNO1YUpdICWV8TdmoLY6a/iDD0GrjOFQ/juAIuw0AoNhEV5exOyztpWxy4HG
	VtRM7GSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphOe-0000000CORs-0fVZ;
	Thu, 28 Mar 2024 04:29:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphOX-0000000COR0-41Xe
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 04:29:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711600180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QzCz1Z3ysjSBtKSuwdaJecZAl0r65qpJTzi3fJyIfg=;
	b=LL3GrdDmoyIl7S2PDWZk7P05VT/bU+KKVRPHYfG3BTw+qr9WJYuByFdBNZJXGBNP1pERNm
	ZYkihnP7Zvi5MCwvsLXsyQORINL7EGM9TtkdP7ecPTHhlTgyQRxRvdmp5ieWM0tppV0RVO
	VTYb6mDfX1w5a65Yp2lWwJEa+V+Y4dQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-4l-sEt65PIGbyEmdZkRMvQ-1; Thu, 28 Mar 2024 00:29:39 -0400
X-MC-Unique: 4l-sEt65PIGbyEmdZkRMvQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ce67a3f275so380055a12.0
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 21:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711600178; x=1712204978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QzCz1Z3ysjSBtKSuwdaJecZAl0r65qpJTzi3fJyIfg=;
        b=UccFWqtIRvBTpvLb2Wnwk3YnT+Tu5tEpHWZR9tJ4IeNrDPhbDh9yFxI3U5GqBPEUn6
         tmDG/xK8lyF1j/Lw6YKxQFFKDjHmW5GynhYyw1j9Wve31zfVk+lYodgTNSSyLrcU24BC
         U1mSCkwBOF7Ul1ZBnQR10/VHBCwe3uAMxFuwujk2HAILKJx5BrHDJzCaGwXUIjT+b3qJ
         UCiCWDiP+vDdzINhmB39X/JmAz1c1Rt2ep+Lm8EBVZ2bxUSEUv96R3tZn8Zr+AHzKd2q
         K/2vovbnWl9L5R/TOsYPcgKx8R4CgA8spXkSccQl8kNaoOSTRU07+n8A/P8Uwm/w+C3i
         +HZw==
X-Forwarded-Encrypted: i=1; AJvYcCXVqtRtX5vHhH26x0zvSmPvuORFGI2YQSSmgrB0GGVMpUDr2Y7a6G+7Mh/hETN+PWbIMnwqwpnLUDAQAwCMfvfpE4O18VLpBtW3nint
X-Gm-Message-State: AOJu0Yy7sywS2GtLN1W/tOW5/hfqZdRvN1n0f7LjGfVk+Kjs8kjTZcg2
	/RjqYdS0j8YJtbgDiyVSdoqReu+ScI27kWw+MRuevq8Jue9/t4aaIOGnwhrBOnSGkgjEe11iLgw
	49Y76oycjx0wdB2VEj/K38BCzxSq0bcVxQqwAdjPNE/9AoTJkX5v5Cz38W1nKlUlejay4Kv0sx6
	cb3we7vaaVs4mk1PsSUEWba6V0LGE0TbY+bFve
X-Received: by 2002:a05:6a20:7f9b:b0:1a3:6ed2:ee27 with SMTP id d27-20020a056a207f9b00b001a36ed2ee27mr2348493pzj.16.1711600178150;
        Wed, 27 Mar 2024 21:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdRSG9G7uJHKVNNXcj0F+YxANq94mAXIs7d49a5PjNlTRz4N2ThVivJdAz+RFXtJHhPLT9mm3BTBAY6vJ4ZyA=
X-Received: by 2002:a05:6a20:7f9b:b0:1a3:6ed2:ee27 with SMTP id
 d27-20020a056a207f9b00b001a36ed2ee27mr2348485pzj.16.1711600177897; Wed, 27
 Mar 2024 21:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com> <20240327095741.88135-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327095741.88135-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:29:26 +0800
Message-ID: <CACGkMEvAUNSC2VnTLpbCR4Zq=rTOW-CHvXLvB1PuGadf6J77UQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 4/6] virtio: vring_create_virtqueue: pass struct
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
X-CRM114-CacheID: sfid-20240327_212942_102005_7409F55E 
X-CRM114-Status: GOOD (  11.66  )
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

On Wed, Mar 27, 2024 at 5:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we pass multi parameters to vring_create_virtqueue. These parameters
> may from transport or from driver.
>
> vring_create_virtqueue is called by many places.
> Every time, we try to add a new parameter, that is difficult.
>
> If parameters from the driver, that should directly be passed to vring.
> Then the vring can access the config from driver directly.
>
> If parameters from the transport, we squish the parameters to a
> structure. That will be helpful to add new parameter.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


