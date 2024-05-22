Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57E0C25B77
	for <linux-um@archiver.kernel.org>; Wed, 22 May 2024 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G79858Qy7qxctyO6ZwaifbkX+0kin5gbL3RzdPs5HwU=; b=C+mXMUEL3EBO3Fbzb+N2sAh/a3
	443yXoPLwkBh38T4buXcxFshddZDiqhQz662KmO27uwNoISsI0MnrRjEYp+1wC/oGHYyyHDr2NDGb
	NNGDrz0td5JH7zbroAQD4CmhA3xhUDaXfwSu20TmZa2oj8x20HMqRB/CK3kXC5Omh8qA0WtUgelGy
	ivDuC6nfNGiFn8rnNqs+hzA+AXG+LISSz3ms6sfu/GwHf3byUKkrhvJBB7mneKHqWhmr+vAOQILDN
	YdRxEkBdZgK2lZ2KWVweDFP8UWjbolZ/5dm4XCIsuNGE5eiSyrUVLcENwaT+cwDtIvqe8OBFSQJzp
	XEw8iaig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lKs-00000002xlh-1nKN;
	Wed, 22 May 2024 12:44:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lKo-00000002xl1-3KPM
	for linux-um@lists.infradead.org;
	Wed, 22 May 2024 12:44:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716381885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G79858Qy7qxctyO6ZwaifbkX+0kin5gbL3RzdPs5HwU=;
	b=ICquGIy0ZIV7TlYainWhIqIw166/BH/B9eM8XCVcG296py5dJbzGkvE+YQVR31PheWZpqW
	MxeBMftoh2gNcbA5fn1vDbLSiQfYRYn5yP/v38RBznKIZvG7sKnxJZ5bINT4ZHUhsyWA4t
	g0Vo9zx/Ck1eeodtw2xlomeixz4Snpk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-grbsqLOtPESpGDothJO_HQ-1; Wed, 22 May 2024 08:44:43 -0400
X-MC-Unique: grbsqLOtPESpGDothJO_HQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34dce5456c3so10645374f8f.0
        for <linux-um@lists.infradead.org>; Wed, 22 May 2024 05:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381882; x=1716986682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G79858Qy7qxctyO6ZwaifbkX+0kin5gbL3RzdPs5HwU=;
        b=CatQ51bx24J97+D8AUvoUdSokzPhp/JRD63hwKXhkjzmc3aJOOUtDFOWTkmElPSE5F
         WnFxIayyBRSID5kQL/gIkSaWK++tZc5OxRVg3omgcuWC1r90n0NnV1oyR+mchVtTNc5j
         fAAqq2TPQN2OZ4NBYI5pr5r+uR9iLcdrekoTdzUJU7iR1rIxB3yXvQwSjZc7YjWF+Bga
         XGa+HV2h3ygO/DPbBll3H2u7od9XRgRKbEF3qAhLcQSz+3kG1bWnz3eQDit/gX4w15Qn
         GU51K21lLTrR1pOrBKNW+aGNAoHhVNzc48nErJY/NcwDImxc74BzU5rGqP60aNAwBkUE
         kifA==
X-Forwarded-Encrypted: i=1; AJvYcCUbqsaXxooxAifjqHGJInRXVTduMxliO1fd80GYb+2MfT2n5VBx8DW50glYE+9hUWSMAB88IcsEb6gAqzKgnS4S+43MtRXLanObrWUG
X-Gm-Message-State: AOJu0YzJSotnGjkVw9UGRFBp8k4rxhW6bU83Lbnf5sFgoGdFOBq2zFw2
	v2Th/Yup7X3PwA7v6zkAZy8x4ZfY0pHg63xw0KQeWrqC0AOtTrQ1czf8zX3GAA8ta2J+KUqyLhn
	T3PhAuESOq4QhHMPNcEInrAdlQTV24n9m4bOjfdIhLEmR1N0w17wenxwWKcaiUQ==
X-Received: by 2002:adf:ce01:0:b0:34b:dc21:68f2 with SMTP id ffacd0b85a97d-354d8cc5a13mr1742151f8f.28.1716381882128;
        Wed, 22 May 2024 05:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT7L+lqndiUNsnDetmvAcccavCLRG44XuusS6ulhxqEwo9Z7Kj+36SZ9+3rI8JW2CWKc4zpA==
X-Received: by 2002:adf:ce01:0:b0:34b:dc21:68f2 with SMTP id ffacd0b85a97d-354d8cc5a13mr1742112f8f.28.1716381881565;
        Wed, 22 May 2024 05:44:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:e862:558a:a573:a176:1825])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacf47sm34302937f8f.78.2024.05.22.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:44:41 -0700 (PDT)
Date: Wed, 22 May 2024 08:44:33 -0400
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
Subject: Re: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Message-ID: <20240522084405-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240522082732-mutt-send-email-mst@kernel.org>
 <1716381321.6426032-1-xuanzhuo@linux.alibaba.com>
 <20240522084221-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240522084221-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_054447_083349_3FE4E234 
X-CRM114-Status: GOOD (  36.83  )
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

On Wed, May 22, 2024 at 08:43:52AM -0400, Michael S. Tsirkin wrote:
> On Wed, May 22, 2024 at 08:35:21PM +0800, Xuan Zhuo wrote:
> > On Wed, 22 May 2024 08:28:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Apr 24, 2024 at 05:15:27PM +0800, Xuan Zhuo wrote:
> > > > This pathset is splited from the
> > > >
> > > >      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com
> > > >
> > > > That may needs some cycles to discuss. But that notifies too many people.
> > > >
> > > > But just the four commits need to notify so many people.
> > > > And four commits are independent. So I split that patch set,
> > > > let us review these first.
> > > >
> > > > The patch set try to  refactor the params of find_vqs().
> > > > Then we can just change the structure, when introducing new
> > > > features.
> > > >
> > > > Thanks.
> > >
> > > It's nice but I'd like to see something that uses this before I bother
> > > merging. IIUC premapped is dropped - are we going to use this in practice?
> > 
> > 
> > 1. You know this modification makes sense.
> > 2. This modification is difficult. Unlike modifying virtio ring or virtio-net,
> >    this patch set requires modifying many modules and being reviewed by
> >    many people.
> > 3. If you do not merge it now, then this patch set will most likely be
> >    abandoned. And I worked a lot on that.
> > 4. premapped has not been abandoned, I have been advancing this work. What was
> >    abandoned was just virtio-net big mode's support for premapped.
> > 5. My plan is to complete virtio-net support for af-xdp in 6.10. This must
> >    depend on premapped.
> > 
> > So, I hope you merge this patch set.
> > 
> > Thanks.
> 
> If this makes thing easier for you, I can put it in my tree post
> release.

I meant post -rc1.

> This way you do not need to keep reposting it.
> I'll then merge it with premapped.
> 
> 
> > 
> > >
> > > > v8:
> > > >   1. rebase the vhost branch
> > > >
> > > > v7:
> > > >   1. fix two bugs. @Jason
> > > >
> > > > v6:
> > > >   1. virtio_balloon: a single variable for both purposes.
> > > >   2. if names[i] is null, return error
> > > >
> > > > v5:
> > > >   1. virtio_balloon: follow David Hildenbrand's suggest
> > > >     http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
> > > >   2. fix bug of the reference of "cfg_idx"
> > > >     http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com
> > > >
> > > > v4:
> > > >   1. remove support for names array entries being null
> > > >   2. remove cfg_idx from virtio_vq_config
> > > >
> > > > v3:
> > > >   1. fix the bug: "assignment of read-only location '*cfg.names'"
> > > >
> > > > v2:
> > > >   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
> > > >
> > > > v1:
> > > >   1. fix some comments from ilpo.jarvinen@linux.intel.com
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > Xuan Zhuo (6):
> > > >   virtio_balloon: remove the dependence where names[] is null
> > > >   virtio: remove support for names array entries being null.
> > > >   virtio: find_vqs: pass struct instead of multi parameters
> > > >   virtio: vring_create_virtqueue: pass struct instead of multi
> > > >     parameters
> > > >   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
> > > >   virtio_ring: simplify the parameters of the funcs related to
> > > >     vring_create/new_virtqueue()
> > > >
> > > >  arch/um/drivers/virtio_uml.c             |  36 +++--
> > > >  drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
> > > >  drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
> > > >  drivers/s390/virtio/virtio_ccw.c         |  38 ++---
> > > >  drivers/virtio/virtio_balloon.c          |  48 +++---
> > > >  drivers/virtio/virtio_mmio.c             |  36 +++--
> > > >  drivers/virtio/virtio_pci_common.c       |  69 ++++-----
> > > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > > >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> > > >  drivers/virtio/virtio_pci_modern.c       |  37 +++--
> > > >  drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
> > > >  drivers/virtio/virtio_vdpa.c             |  51 +++----
> > > >  include/linux/virtio_config.h            |  76 +++++++---
> > > >  include/linux/virtio_ring.h              |  93 +++++++-----
> > > >  tools/virtio/virtio_test.c               |   4 +-
> > > >  tools/virtio/vringh_test.c               |  28 ++--
> > > >  16 files changed, 384 insertions(+), 394 deletions(-)
> > > >
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >


