Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FAFC3DA41
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 03:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=; b=HEcvDwFiFQA+ivBk+6DJH328+Z
	Tgk5i9fPXevdvVto93JgCAKOAA5CTSlW9/cg0LaI2UOpKUWUyzu3SzJbTt2yZDffkbesKH+2Hs9Cc
	p4PZJb9DLC2QqacJg4y38MSBXz9QwKi0Nx+kOHzktm60wnPRgKOYpmDMufxOb58SaygGJ//HG8EGC
	NP4IaoFJ/UTu+yPovoBdCdCfsy/sbYY8qOh8G2rzKvzCFJyrp98r7csSaar9oTRpEYIh1P+77Q3WK
	uPDyOSWM5VhK5RQTfc2ToU4xM3VtJMGJ12tSYbRY8DQgNToWcegFSCgWBa1wolhjmvQoHpp4Jttqn
	SZ8aLRAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRNxV-00000009ISe-0gf3;
	Wed, 10 Jul 2024 03:25:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRNxR-00000009IS2-2Rmp
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 03:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720581926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=;
	b=aTrhxYDlrPDBDxPUBMpyBmDBVp0vflMjdd5qWlwkHsvdK/8V+WnNmeiTQd4eZZMrFxPsUE
	18smDvsd4nraDkauXXdBpkFYKovlIW0uz7QZOsbBA8pGy5Q1qFzvoLm7tk37Sr+24TtFcV
	5xlVTt74e9Q8nRuXOyoRll3lHvmQt3E=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-1q9OnSIzOb-dC0ZRwZfoMA-1; Tue, 09 Jul 2024 23:25:24 -0400
X-MC-Unique: 1q9OnSIzOb-dC0ZRwZfoMA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-380de513597so59668935ab.3
        for <linux-um@lists.infradead.org>; Tue, 09 Jul 2024 20:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581924; x=1721186724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=;
        b=UF9U31Y4y0u8oIAybP7+HqRccI+OopN+l59bXfw5HVqZm8osF2czixUUDkreqBoSCm
         4rFRGe4wcNT3c/SOZawSfOIQYThQH1YDDGcArayiFxWwYP1x8Jx7B1kOhlqna1Pw+ZEr
         9QuTeprmnvD5JqDSZ/wWc1m8fSNm0UN75lWnduApV0krXmWVwlVh+tghMnQ//xbBKr3I
         z9Urnz7+h+BM1VbFgOFsDsOEaBV3t3BKnCm8P/PPd7i05iIBlIfI3B8f5PLonxCDTr/D
         Xsk718dI1dRHtUJM6tu+P7a8VY52a4R8o6zvVVubPtIDQ7ZiTXuUXYeAXb7Sd5bA1v9x
         hbFg==
X-Forwarded-Encrypted: i=1; AJvYcCWZYq4rLV0owNHfk98Wk0TxgqPyPvaYvhzGnARPPOTyYzsuu0GDYGWM827F4leBX1lpypg6DrLICLeKfBzv08GDziArBi7vE6xnQ6Sx
X-Gm-Message-State: AOJu0YxmVqMkmB4yZiO3KPwoQEsl6Il3Z7LfgwjLZ+gxeVU/lGLBuc50
	kQGWMlAAyttpgZSwBmq+4lvPcn04vOjFxPRdbT+q9rwftLQQz+NQfFCQm9HKS61jkXqYhPOzAf0
	5wv7/zV9u8a9nl7vqdsxImFGSGAAYGndIbgY8M10QHLx4pwO7t23wv7IdqehrPLDeYGLTBfMedK
	5IWWSqByYvYW+kYZTV/c7QnTUlHHaOHq3Xw+XC
X-Received: by 2002:a05:6e02:170b:b0:382:b436:ecbb with SMTP id e9e14a558f8ab-38a57bcd755mr44254725ab.11.1720581923967;
        Tue, 09 Jul 2024 20:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW8tp760Eusr7cpOewOOzt8KywljVE5imblpi4EA9nOMhtnhRxpdbKT5KwR6ZV/XXWj53jrT/VMHmkMmslXtc=
X-Received: by 2002:a05:6e02:170b:b0:382:b436:ecbb with SMTP id
 e9e14a558f8ab-38a57bcd755mr44254435ab.11.1720581923592; Tue, 09 Jul 2024
 20:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720173841.git.mst@redhat.com> <1a5d7456542bcd1df8e397c93c48deacd244add5.1720173841.git.mst@redhat.com>
In-Reply-To: <1a5d7456542bcd1df8e397c93c48deacd244add5.1720173841.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:25:10 +0800
Message-ID: <CACGkMEsg0+vpav1Fo8JF1isq4Ef8t4_CFN1scyztDO8bXzRLBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio: fix vq # when vq skipped
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_202529_714870_96D14F0A 
X-CRM114-Status: GOOD (  11.24  )
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

On Fri, Jul 5, 2024 at 6:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> virtio balloon communicates to the core that in some
> configurations vq #s are non-contiguous by setting name
> pointer to NULL.
>
> Unfortunately, core then turned around and just made them
> contiguous again. Result is that driver is out of spec.
>
> Implement what the API was supposed to do
> in the 1st place. Compatibility with buggy hypervisors
> is handled inside virtio-balloon, which is the only driver
> making use of this facility, so far.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


