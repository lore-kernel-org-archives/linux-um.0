Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA05C27C79
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F5cLrcBZuYCEeePJIc62tRcAqhOXIeLud2uXAMK36HI=; b=csaKVZiG7QKNdL9fX10L8i4y9I
	Xz5IV+bR0hZ5mfCCxg+pCUZKsbgjSThE5859iCM6kqmPvAg+ckg3oVp68IMAu9q9dUFhA/eVng904
	2Gax5wtosTyeLGN0cmB22bZo2wSaxLFfoB4K/dWl0qxCD8bg7xGgvpX+bcXzJH2j6/92rpmDXWHJF
	2AfO+XNVSj0owXtTY6lvpVWHg6rJ0SvAPwxJdE0Xj6Q9DKZ6pAte508JIw+fVtA/sQLOQSNjOj/vL
	yP4W8WGDMiJEF+aYICO+Tkcy7YmWnXNe2MJ/ZJO9d20Ak5bVwzRmPAcAsQutoI6acwaE1Kkh1xX+e
	KSAHcu9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKEp9-00000004Wrc-3sW7;
	Thu, 20 Jun 2024 10:15:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKEp7-00000004Wqt-0i1Y
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 10:15:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5cLrcBZuYCEeePJIc62tRcAqhOXIeLud2uXAMK36HI=;
	b=YTR9iNQBxz8JHO3BoOsYjwyWFp9sZfmtM0IpYBVI5EZjZTnfGFa2jryYz227wu0hfbw7y/
	lk+uBKyPsLxgrl6lRkCEXL1K1FegAiAoSF91AqYJQ/ZINN6zJKglVHJRW+Or0eJN4r05kv
	H3Bk82A26kfWe1P0xMEFBpLaIK1f36E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100--K_n5vHBOi6xm5jQZD4wQw-1; Thu, 20 Jun 2024 06:15:17 -0400
X-MC-Unique: -K_n5vHBOi6xm5jQZD4wQw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6f0fee1f49so34125066b.0
        for <linux-um@lists.infradead.org>; Thu, 20 Jun 2024 03:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878516; x=1719483316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5cLrcBZuYCEeePJIc62tRcAqhOXIeLud2uXAMK36HI=;
        b=dkwhe8L6Nu2zkBi9yIKVqFQNuR6ijjIVN1MnVb1OJQRDHjdxXa3FHS11y34EoytIpY
         qEPc7OnWmovBoR5Xj1d5Siqs/f8/jfN3dLexkt3hFN6N8269SxrPW2f1RDNPIZEFxRvx
         4C4I+uw3rOi9uJrgvrwZpAUEtV/g+HZHq6CcP+ZcxoDsAOCBIyYveHSO4rNvYOzhEIoc
         Ukwi2Ta1j/5tl8vJlujvk/H/e3YE3uzNyvrLL4HiIFZsAH+g82Ye4j2BWxnF6LI0kUsJ
         TSN/ZnmZbb3l+QWyrMk2Y55bmHxK6ZLWzYJf/Jf8gKfnaNZC+IkoM4uFuyk65hDZAnkh
         m4hA==
X-Forwarded-Encrypted: i=1; AJvYcCUC6V+dE8rsvXNsI9HmyTk5ebS5HSutZQzZt5uiE3sC1I4FtdsGjTdQ5dsj4dnI6ciPZo66hIvgajA8Ep8ERI5svkUTzJQy2qFJoLBu
X-Gm-Message-State: AOJu0YwapetR2ZkOWrV05mwHWK47e1YjZ1h/YPdqHcQqEketxr5iayyE
	lPYrhLFvGkioKm8c56av2bLX083kxfuartX7CgDQDktHctz+9Jvd+9UO3bfUBxtic8hThU5ZZph
	q3FW6QGnliK6JNrpqG6ijshmovnLxXCY7U15RJn9GAY6qQB4vbmHDFFuGGkMPuQ==
X-Received: by 2002:a17:907:2d08:b0:a6f:501d:c229 with SMTP id a640c23a62f3a-a6fab60ba19mr339712666b.9.1718878515669;
        Thu, 20 Jun 2024 03:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLolJ3t9kBt/FV6CSCM4Ryf1U+wjtgY8UpBQflIEZZb/4e3FwGJgSy2Bl6IqLXHgvitjoz1Q==
X-Received: by 2002:a17:907:2d08:b0:a6f:501d:c229 with SMTP id a640c23a62f3a-a6fab60ba19mr339707566b.9.1718878514780;
        Thu, 20 Jun 2024 03:15:14 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41a7asm750071366b.159.2024.06.20.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:15:14 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:15:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v9 3/6] virtio: find_vqs: pass struct instead of
 multi parameters
Message-ID: <20240620061202-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
 <20240620050545-mutt-send-email-mst@kernel.org>
 <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_031521_311414_9151DC3F 
X-CRM114-Status: GOOD (  20.92  )
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

On Thu, Jun 20, 2024 at 05:20:49PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 05:14:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > > > >
> > > > >  static inline
> > > > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > -			const char * const names[],
> > > > > -			struct irq_affinity *desc)
> > > > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > +		    const char * const names[],
> > > > > +		    struct irq_affinity *desc)
> > > > >  {
> > > > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > > > +	struct virtio_vq_config cfg = {};
> > > > > +
> > > > > +	cfg.nvqs = nvqs;
> > > > > +	cfg.vqs = vqs;
> > > > > +	cfg.callbacks = callbacks;
> > > > > +	cfg.names = (const char **)names;
> > > >
> > > >
> > > > Casting const away? Not safe.
> > >
> > >
> > >
> > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > and the virtio_uml.c changes the name in the subsequent commit, so
> > > change the "names" inside the virtio_vq_config from "const char *const
> > > *names" to "const char **names".
> >
> > I'm not sure I understand which commit you mean,
> > and this kind of change needs to be documented, but it does not matter.
> > Don't cast away const.
> 
> 
> Do you mean change the virtio_find_vqs(), from
> const char * const names[] to const char *names[].
> 
> And update the caller?
> 
> If we do not cast the const, we need to update all the caller to remove the
> const.
> 
> Right?
> 
> Thanks.


Just do not split the patchset at a boundary that makes you do that.
If you are passing in an array from a const section then it
has to be const and attempts to change it are a bad idea.


> >
> > --
> > MST
> >


