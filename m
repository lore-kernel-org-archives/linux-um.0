Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8020C47258
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=; b=Mf/KXQ9BFqNGQDxN2sAK6ynwNO
	nChGEB8ABsfDpLYd01vp7MD8gjluDJktIK835OgHKgP21nMR4nKuo91rYJPtXp1qLG1nPAoFMMZTu
	iziUZ+HoowK+jnluN7/ZZwjs28G9Ut/1WMtS8NKVPEs256loPhwaQ7EMvJme0ah92TZoSCdGUxBXU
	CTkofFOHa6XMDeedOm3tmX8YvPqO6OIss7GymE2Hb2/gzXBhb3qtO4y4aec/mmIUr2WgZf9FDWeBE
	Wb6qMUXhdbBajP4fh8iBECmuQpLL3U+D18TW7UUOYXbLpVYoc3d8ut11eKugTfn/EpcP21B3OOCQB
	vXhQ3cgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fL-00000002NKe-0Dme;
	Wed, 31 Jan 2024 09:13:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fJ-00000002NK4-3eHV
	for linux-um@bombadil.infradead.org;
	Wed, 31 Jan 2024 09:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=; b=b24l4xL3kiojvmXEkXmWw4hJFw
	AW+2cBNA8pibDGfOEQ/UCN6vD5U2oVVoqGqzRP+meSAzz82XXn3eetxsH+qFEx+5fQJtmWM22+6Ta
	zNTWRl/CS2LahZ1R+WiKj23uS+KDk2g9EAqs2yKuvIlNTzNkE3PVTeUc6ivNMZwiXPXLl/M9X+FeJ
	G+0DJsfFf2KkY3M/QSYRSULvp1tnRzId6P+uQuf/YGMzMdWXcFhM5L41NQLLLAkTmVqn6s+se1Ss7
	l8ItirVLV5pXUh8Y0SCUD7a6J2gyLk54xpFw/KeSiLGO3P77IYEr8SQjPVSC3Cp1DP7v/98VB3t8M
	0J843mAg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fD-00000008tfp-174m
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 09:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
	b=LTNslrtUEba/oc4q9GshhTmOGL/G5WCQBCANEyum0OCjFBhbc9bVJmrfJ9s9e7O5Vyy2XL
	lfghdvgHstj6kgJ3sW4cSQ17PNeIW3ATlhFstYUJBEbQLbWweiKpdT8hOAVTW8geHcdes5
	D6dkfEvoefMoXov5vivVTI5LCSyyJDA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
	b=QOazZjsqAzWXbqOUmVABbpVoE5aqaEeRBuGv44sgFepOzCLnM8TedXODbjeWVT9Qir3jK6
	UMGJQWBBkPH1WKdVL5UouQe1FfSqdnDLJa6hRklYIfDKyACigy82V7LNOLRHmseOUfrOvG
	gjrhf5sgpL5rC68bWP8ik7VzTTvkrrA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-Y03rQStxOwWxXhhE1XuIYA-1; Wed, 31 Jan 2024 04:12:20 -0500
X-MC-Unique: Y03rQStxOwWxXhhE1XuIYA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ddc1bf229bso745927b3a.1
        for <linux-um@lists.infradead.org>; Wed, 31 Jan 2024 01:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692339; x=1707297139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
        b=LlSw/tILyz+ViyglPlnYR3fL5XuiNqvOXZvZe+xTPkLiTJwF6MP9Exh4y40vvoOKR3
         XrEfgVfm6ammzuhYo9Uug8mOBsPyeocmfo1XjHvqXMuGyUH2j4ZFAdZkiAgih5MANQ3H
         USAqi1kZgnQF6JFehdoJFp0G0trfUSTejRNLSOq+P/CdLh8/ofU8Au/4/UGjXAJYNX2/
         7+UmIXkEZAv2oOKk4dub/OGCl7o+a+RC/GwqCVzdgkKJ+9vq4LUBO0WP8eNic6U+AUX0
         Q8mYkelVw0+EL4xxO3T75prNy296gE+xZoIC477TDQLEHTHuqRcBOGRiyApSPIsifD5d
         3rFg==
X-Gm-Message-State: AOJu0YybZF60enlZ7DIwEOSHEE8EnKhiLaE5agzMsxmpTXNAWDTGT/TX
	tgZoxUQdk8DawhSZu0wXGvr14NaSyubXNpLOUG/dRWhx3wESYej35tnW2nrQjXpYePDCo1y/LO7
	/5K5nptHfeP6H40jKhEmM6BXo+asKmiH/m1WgJ0KmxOiIVfE1IWhIjvYyi7wpSX2SWyjZfhVDIO
	LvkwoR43LNq8+8+5gxLnyrYpygHJadc9+ifkpx
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id mj23-20020a056a209c9700b0019c93eeb0admr1177513pzb.31.1706692339195;
        Wed, 31 Jan 2024 01:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmM479Cl5hy9Rh2S2MeFkPZK97XeCIQ/W+WuJDw6bc/3YGrYz5ABB3TPxpsK6OFnyn5gpDGlLKohRyPGIa5F4=
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id
 mj23-20020a056a209c9700b0019c93eeb0admr1177464pzb.31.1706692338808; Wed, 31
 Jan 2024 01:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:07 +0800
Message-ID: <CACGkMEsi4B7Rz7Uu-3sTEH=9XRBRDmNSacZkVt6zxaC-FbYqhg@mail.gmail.com>
Subject: Re: [PATCH vhost 01/17] virtio_ring: introduce vring_need_unmap_buffer
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
X-CRM114-CacheID: sfid-20240131_091349_220053_DFED55CF 
X-CRM114-Status: UNSURE (   7.30  )
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

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> To make the code readable, introduce vring_need_unmap_buffer() to
> replace do_unmap.
>
>    use_dma_api premapped -> vring_need_unmap_buffer()
> 1. false       false        false
> 2. true        false        true
> 3. true        true         false
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


