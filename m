Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DE1C54E71
	for <linux-um@archiver.kernel.org>; Fri, 22 Mar 2024 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=; b=bN7PYMh4DCOpXIx+nC6yn1ccya
	vV9RpCCc+NU+YtaLnLlxbwN4Nj4t5GambzuVcOQ2mLAPy79dmyg0iVD578huyMhVgJEBvX4weZ1dL
	3z0wgmVlqqOs/8rBbvmBmi9FKT65+s7fwEKGJooFvWq1melTL+PWY5noMiwP4x99rBlyAhKNxKyS6
	5vpMBe/fWnrI0Int1VcAEInMrVAaNT0G3DelfpzoY+gORnaoR1A7UrpioAxb8Am8Ea20Ujs6vKgsg
	JYzavBZo4ZVyk8PAW6jMWpD6cVAVn0Y81YYk2mLBAQnvkSPGYQud1PIc+oY8bptyK3YfP+zhGhTpa
	eFLS2nvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnkNx-00000008Tsr-1owb;
	Fri, 22 Mar 2024 19:17:01 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnkNu-00000008Tpq-09LS
	for linux-um@lists.infradead.org;
	Fri, 22 Mar 2024 19:16:59 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-56ba6c83805so3014131a12.0
        for <linux-um@lists.infradead.org>; Fri, 22 Mar 2024 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711135009; x=1711739809; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=;
        b=Rz3UI6Jc14orUC6iATO3XWOysVRAdWiEm7TIq9o5K9ijVPBOnuyrUwchfsdaziePKq
         PhzIv6+ZOZZ3Grl1vztS4LtkKNbR4ZDtjHioAOf5G+u9oW4au5ZF+SdJYwlrZuy8Yhfo
         3lVi5GBwfz2ZNvkVk+JKlxQvQoJQOHQa5RUgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711135009; x=1711739809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=;
        b=pCisjELg2tgSqVV8nxxYi6sh9DwL2qqkdMqO3WaZAfV4wMTswMle89JgWC+ifP9MaI
         e6jElduLMOjRMgDacSrkFJsObiVCPeVZxiSTkrInTpUk26M3415y3KoDVvifXLdvJFMO
         RnWRq+Ic87aXAJOgDZy09er7D1jERmI5much7Kqs6dbpEFLDXdYTk8AZ+V6ayP6UOWzw
         BdSswZ6CVVJslzheb04WhczgVlO6dnYzuwHoe6ejW2Zz3s1ubzI5kj24hDRNafc3z2cX
         WAHS583wLzaa37sOkS6NByGfsgrcOycQZazYBznI2ws710eG8k3fA2ozuME4kCemYkgr
         6umQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSC6ifVnjJrlP2sBKPJBWZRiTr1m5xeQQwbiaYS18vyRXOc6RGLGSkWNyJj0ssK6Vlp0/4mJrsa4exDjIv6Idh+HkVaCpsECc17FKA
X-Gm-Message-State: AOJu0Yw7FwB3lyoXYZ/dPYapQzi/ClEWbsFvqebdD1HlkmFGOHkNY2a1
	HFpggc4Dr4Ame0JzjuKq/W+1lMh0bMGwNYuZ+Uox5f5kZoRCwz/ZBaEbYQU2zUkP5eYX73Mrn9Y
	9pQ==
X-Google-Smtp-Source: AGHT+IFslL4VR8n5ezCMbXid0nhFhqQFx61/gkkfjydgqBX60eKneg0Y9jeraZsmBfJWKRC5Bbz4eA==
X-Received: by 2002:a50:ab07:0:b0:56a:ae8a:acb3 with SMTP id s7-20020a50ab07000000b0056aae8aacb3mr229646edc.42.1711135009528;
        Fri, 22 Mar 2024 12:16:49 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id e8-20020aa7d7c8000000b005689c2c6508sm118234eds.70.2024.03.22.12.16.48
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 12:16:49 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34005b5927eso1449469f8f.1
        for <linux-um@lists.infradead.org>; Fri, 22 Mar 2024 12:16:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9YPf+tlcMl8ShZzUaFaCotyqVUD66frnAn9wugxF/u4ZQthe3z13gtw7PWbiYid5x8THRYkGleEteqFSoYNWFCsjsyDFu22CPIbbB
X-Received: by 2002:a05:6512:32b2:b0:513:4b90:ae9a with SMTP id
 q18-20020a05651232b200b005134b90ae9amr255604lfe.67.1711134987739; Fri, 22 Mar
 2024 12:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com> <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Fri, 22 Mar 2024 12:16:00 -0700
X-Gmail-Original-Message-ID: <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
Message-ID: <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
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
	David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_121658_098127_EAEDC0CB 
X-CRM114-Status: GOOD (  15.38  )
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

On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Currently, the init_vqs function within the virtio_balloon driver relies
> on the condition that certain names array entries are null in order to
> skip the initialization of some virtual queues (vqs). This behavior is
> unique to this part of the codebase. In an upcoming commit, we plan to
> eliminate this dependency by removing the function entirely. Therefore,
> with this change, we are ensuring that the virtio_balloon no longer
> depends on the aforementioned function.

This is a behavior change, and I believe means that the driver no
longer follows the spec [1].

For example, the spec says that virtqueue 4 is reporting_vq, and
reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
but there is no mention of its virtqueue number changing if other
features are not set. If a device/driver combination negotiates
VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
that reporting_vq should still be vq number 4, and vq 2 and 3 should
be unused. This patch would make the reporting_vq use vq 2 instead in
this case.

If the new behavior is truly intended, then the spec does not match
reality, and it would need to be changed first (IMO); however,
changing the spec would mean that any devices implemented correctly
per the previous spec would now be wrong, so some kind of mechanism
for detecting the new behavior would be warranted, e.g. a new
non-device-specific virtio feature flag.

I have brought this up previously on the virtio-comment list [2], but
it did not receive any satisfying answers at that time.

Thanks,
-- Daniel

[1]: https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01=
.html#x1-3140005
[2]: https://lists.oasis-open.org/archives/virtio-comment/202308/msg00280.h=
tml

