Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE9CC54E67
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 04:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=; b=W17SN8E87V5OHpDG4Dtj18uH+k
	DkjxQVwiXnU/uzfQRYiBJOphYFarX9WL89cXt7+eBK+JMa+iUq6Ej8NSbLa6OeTY1XCw8geFzkF/m
	K9vZDQK2z2KfV/oKCE3922tvKDcA1+CJuwYTpDARduDe44fFY/P2Ao2FynxPxqvJrHOef6gF+4ZW5
	MRH/YSeiqhKuy81La6HmFTMLVQvQBnRRoTsuFdOwi0NijuT1AHJbtndSFbYlSQ+dTStPvPGq9nEOo
	dYLUbjhkXj9g6kW9Uwgu3fIF5/6afDxH3sDxbBs8BeIRVZ2KVyC6XBr4LAjg98n7JhLStmGpMb3VE
	1/qj/YEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphax-0000000CQ2S-0vOM;
	Thu, 28 Mar 2024 04:42:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphau-0000000CQ1i-1Php
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 04:42:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711600947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=;
	b=BUWtDvUnAnIP3vOUCsMV3Zl4WsEThtO6dj50v3AHhtqxjmBqp8t97BR3nkqBS/QmhSs3u3
	de1BAv1PRgirrhgB3KhbRl7kPnHyrXKSRtlmgD4u+j8sb7j8a3qjvZMEkokuEwOL1LAasi
	Zu/nHBLMp7KZu9Y0X4yVrugpIe5QKw0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-oLtUjy1nM460IBSBLwbYxQ-1; Thu, 28 Mar 2024 00:42:25 -0400
X-MC-Unique: oLtUjy1nM460IBSBLwbYxQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5e5022b34faso564401a12.0
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 21:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711600944; x=1712205744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=;
        b=UnZIF/BMGGLHSg1m/ZTcQnjMcbc24qh5fpASZb3oPXtPa1x+LYcBLETIGC/F7pluM/
         jhONd2y9Pv1yET5OLvOmeRs1CjhwCJv0F8UrWQOuhaGN784hjjphCLPqWsk5cJ/SOW97
         YYM2GumO2+gtcbTwAqOzaSPz3urmcso3A6bLSyBUKHnjKFSu7H2wp4C7SQDJSpSFWuDE
         NFuEDak69D9fzyb0OPhsxAaAMkAhRA80+dNN6IGpfDEMzIE+qlfEDzC9MlEmjdv1bnZy
         IrpOfDsGjMkCHdAtugbPGEjsRN+dPoDsfyZUWMdsJQmDsTVKd2CThJEerZgqMXEiKS8i
         uhpg==
X-Forwarded-Encrypted: i=1; AJvYcCXbamh4Lve5MXna/p0J6kMQG2kNkyjcHAHxx858gz/76VoJEpvLIsz5OYpi/Kyqt3vehRg8YISgNYBkT2Fk9uddh4I20xVTLoPkqhCH
X-Gm-Message-State: AOJu0YxTous0iokl2YYWbSOkP/Vv3aBRwIaTr/Bh3pULymYjqx/ZINHQ
	K5I7q3IfwoMG155xgJvudFCHtg57Jq6rQ7S0+jRplSNXmRt3pCw2hEceZ9tECl62KH/WLYhn2tL
	nZREnQADFzYxzsHgrZ61i3aSWM7B5Inopfm7Px86E3pLA96lAjgz426E2tqiLfmVxveEkBcb287
	cPz9Ck2BS+A34d2fJdisEIJ9ytQLuwFhioNrDy
X-Received: by 2002:a05:6a20:3943:b0:1a3:aecb:db60 with SMTP id r3-20020a056a20394300b001a3aecbdb60mr2612150pzg.9.1711600944741;
        Wed, 27 Mar 2024 21:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGqMeGlScFLGjuf9ntL+wJAbmcBUMH9qH8VV+quAV82wNT4oC4BMh5FM/UUwwoJlJBLwmVhiSP74tk9QYL8V8=
X-Received: by 2002:a05:6a20:3943:b0:1a3:aecb:db60 with SMTP id
 r3-20020a056a20394300b001a3aecbdb60mr2612140pzg.9.1711600944494; Wed, 27 Mar
 2024 21:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com> <20240327095741.88135-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327095741.88135-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:42:13 +0800
Message-ID: <CACGkMEsViOCh-DGuRqZr=XGT+wJcG68CFAdiTcLc-q_2CtZ8tg@mail.gmail.com>
Subject: Re: [PATCH vhost v6 6/6] virtio_ring: simplify the parameters of the
 funcs related to vring_create/new_virtqueue()
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
X-CRM114-CacheID: sfid-20240327_214228_474211_609C8219 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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
> As the refactor of find_vqs()/vring_new_virtqueue()/vring_create_virtqueu=
e
> the struct cfg/tp_cfg are passed to vring.
>
> This patch refactors the vring by these structures. This can simplify
> the code.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


