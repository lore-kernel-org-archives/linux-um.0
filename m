Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5BDC27C79
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CNpcAjabNj7U5Kjrejmg/ilwXEXZseiB+OI7rnWLE5Q=; b=X9BPaqf07h/iyGV+ErewiSrIIL
	K8opeSYtaWZyiTIX+DluGjx9yE/og034nzX4px7UzxzUQx9Z7fpIa1s6hAsRF5H5GniGR3D771JRN
	Zv8zuYAUiH+V2aCTLrjIR7Cu88jDJhtIABfcy1SOQDvlnJ6PJzpSZVIMR1jWxk3m2jeSwe3j/w8VU
	wYw9jUqyKPfTsPc9lAO4Pf9zW/kxd3K+7U+EKiTgWtLcAvalTrDrV+lNMhweBPQRJkRyDjxo3St7i
	rN8er1lMC5I8seJKkjWgzzN3PbJ4RNADQfu9n60/hmm6U3FK0RIIN3iMVv9RCbxX8Jd0Pvy/Aw+a+
	QaY4rMwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKID4-00000005Hsw-3AH2;
	Thu, 20 Jun 2024 13:52:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKID1-00000005HsE-3AgW
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 13:52:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718891534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CNpcAjabNj7U5Kjrejmg/ilwXEXZseiB+OI7rnWLE5Q=;
	b=FHXIc83i1IFWAuvZ7bO1DC+WKv5kV+miQ9+UeFzbllGG7IQGwEqhEEpG5b7My3VBZLCRwE
	vGv4l6uxgC43fjtyqXPlfwu4TFkoZzWg32rmnDSGoY18Ri2n3Vsn6gHGTvibppJ4mU6o4N
	4Ak8M9xODdGIz2cae0ZdVPJVzUGHUU4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-BR1adVDcPmWB4AV_BiwSVA-1; Thu, 20 Jun 2024 09:52:12 -0400
X-MC-Unique: BR1adVDcPmWB4AV_BiwSVA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57a306c4b1eso623849a12.0
        for <linux-um@lists.infradead.org>; Thu, 20 Jun 2024 06:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718891531; x=1719496331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNpcAjabNj7U5Kjrejmg/ilwXEXZseiB+OI7rnWLE5Q=;
        b=UeKNgjGDJbNcokOeyMbvvgmzTqhaDn+QxQqBNz6U19alSMpy6jz7sFWKadQZsa6ICM
         u2L3Fhn1JWFSUQbuo2/a5RcTljCOvvH6ajBuNqgQ6s75thkOINip5FMzfBF/f3jxVxdf
         ZHc6JKRrPwHi3sqw9KgTiX7AfwMrKFm6irIAlUrGqreSOguvgfXgdzqyFl3M22NXEH4w
         EaPgxuwzeWrsxteV66bCVYVVN8AQK9NR05qWmrLipuUW214/X+ou9lH8ptr5GYuYzAJi
         uf32BsOh8WG9Pymw0EKFAYrblkECadhizYnGDLSCKECR5UM0RdegtkFG5OygKXjz0WwL
         mksA==
X-Forwarded-Encrypted: i=1; AJvYcCV4QxWPFQLapE530XMINwdw+MtPwDyEYQQCvHFpr+/MX8x8med+EhBsV+PIzthn4yOM8sTCFGrIbPAEApdmlDRhpkhmxV/p2g8rqDYQ
X-Gm-Message-State: AOJu0YwRef3N0yNLCy6DL+/X8N8N8qkbB4JMyplaJn20cWYHOOAOwKmp
	q9/NiRcLBmmaj2EixB+VHTx9aD17kaZyOQhhUj0EypcSU88PonS6n2oB/slWIEabi41X03KMmE/
	ZcQma+zQSX28Wco8KotwwBua1pi21J3UQHZfJCqSA6hGV627UkUMi50aDD9dqTw==
X-Received: by 2002:a50:aad7:0:b0:578:3335:6e88 with SMTP id 4fb4d7f45d1cf-57d07c59ce6mr3503141a12.0.1718891531433;
        Thu, 20 Jun 2024 06:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF90OFOGv2ZZVHJ5dm1EVg30XUQltEQfgDt90ACAE1nuPoxRvgkNZnMIK5JtmqXjWOLvdB0xw==
X-Received: by 2002:a50:aad7:0:b0:578:3335:6e88 with SMTP id 4fb4d7f45d1cf-57d07c59ce6mr3503106a12.0.1718891530819;
        Thu, 20 Jun 2024 06:52:10 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743b026sm9630648a12.97.2024.06.20.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 06:52:10 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:51:58 -0400
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
	kvm@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH vhost v9 2/6] virtio: remove support for names array
 entries being null.
Message-ID: <20240620070717-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
 <20240620044839-mutt-send-email-mst@kernel.org>
 <1718874293.698573-2-xuanzhuo@linux.alibaba.com>
 <20240620054548-mutt-send-email-mst@kernel.org>
 <1718880548.281809-3-xuanzhuo@linux.alibaba.com>
 <20240620065602-mutt-send-email-mst@kernel.org>
 <1718881448.8979208-6-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1718881448.8979208-6-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_065215_937780_0FE3EA9B 
X-CRM114-Status: GOOD (  49.17  )
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

On Thu, Jun 20, 2024 at 07:04:08PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 07:02:42 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 06:49:08PM +0800, Xuan Zhuo wrote:
> > > On Thu, 20 Jun 2024 06:01:54 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Thu, Jun 20, 2024 at 05:04:53PM +0800, Xuan Zhuo wrote:
> > > > > On Thu, 20 Jun 2024 05:01:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> > > > > > > On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > > > > > > > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > > > > > > > > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > > > > > > > > doesn't apply. And not one uses this.
> > > > > > > > >
> > > > > > > > > On the other side, that makes some trouble for us to refactor the
> > > > > > > > > find_vqs() params.
> > > > > > > > >
> > > > > > > > > So I remove this support.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > > > > > > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > >
> > > > > > > >
> > > > > > > > I don't mind, but this patchset is too big already.
> > > > > > > > Why do we need to make this part of this patchset?
> > > > > > >
> > > > > > >
> > > > > > > If some the pointers of the names is NULL, then in the virtio ring,
> > > > > > > we will have a trouble to index from the arrays(names, callbacks...).
> > > > > > > Becasue that the idx of the vq is not the index of these arrays.
> > > > > > >
> > > > > > > If the names is [NULL, "rx", "tx"], the first vq is the "rx", but index of the
> > > > > > > vq is zero, but the index of the info of this vq inside the arrays is 1.
> > > > > >
> > > > > >
> > > > > > Ah. So actually, it used to work.
> > > > > >
> > > > > > What this should refer to is
> > > > > >
> > > > > > commit ddbeac07a39a81d82331a312d0578fab94fccbf1
> > > > > > Author: Wei Wang <wei.w.wang@intel.com>
> > > > > > Date:   Fri Dec 28 10:26:25 2018 +0800
> > > > > >
> > > > > >     virtio_pci: use queue idx instead of array idx to set up the vq
> > > > > >
> > > > > >     When find_vqs, there will be no vq[i] allocation if its corresponding
> > > > > >     names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> > > > > >     with names[2] being NULL because the related feature bit is turned off,
> > > > > >     so technically there are 3 queues on the device, and name[4] should
> > > > > >     correspond to the 3rd queue on the device.
> > > > > >
> > > > > >     So we use queue_idx as the queue index, which is increased only when the
> > > > > >     queue exists.
> > > > > >
> > > > > >     Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > > > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > >
> > > > >
> > > > > That just work for PCI.
> > > > >
> > > > > The trouble I described is that we can not index in the virtio ring.
> > > > >
> > > > > In virtio ring, we may like to use the vq.index that do not increase
> > > > > for the NULL.
> > > > >
> > > > >
> > > > > >
> > > > > > Which made it so setting names NULL actually does not reserve a vq.
> > > > > >
> > > > > > But I worry about non pci transports - there's a chance they used
> > > > > > a different index with the balloon. Did you test some of these?
> > > > > >
> > > > >
> > > > > Balloon is out of spec.
> > > > >
> > > > > The vq.index does not increase for the name NULL. So the Balloon use the
> > > > > continuous id. That is out of spec.
> > > >
> > > >
> > > > I see. And apparently the QEMU implementation is out of spec, too,
> > > > so they work fine. And STATS is always on in QEMU.
> > > >
> > > > That change by Wei broke the theoretical config which has
> > > > !STATS but does have FREE_PAGE. We never noticed - not many people
> > > > ever bothered with FREE_PAGE.
> > > >
> > > > However QEMU really is broken in a weird way.
> > > > In particular if it exposes STATS but driver does not
> > > > configure STATS then QEMU still has the stats vq.
> > > > Things will break then.
> > > >
> > > >
> > > > In short, it's a mess, and it needs thought.
> > > > At this point I suggest we keep the ability to set
> > > > names to NULL in case we want to just revert Wei's patch.
> > > >
> > > >
> > > >
> > > > > That does not matter for this patchset.
> > > > > The name NULL is always skipped.
> > > > >
> > > > > Thanks.
> > > >
> > > >
> > > > Let's keep this patchset as small as possible.
> > > > Keep the existing functionality, we'll do cleanups
> > > > later.
> > >
> > >
> > > I am ok. But we need a idx to index the info of the vq.
> > >
> > > How about a new element "cfg_idx" to virtio_vq_config.
> > >
> > > struct virtio_vq_config {
> > > 	unsigned int nvqs;
> > > ->	unsigned int cfg_idx;
> > >
> > > 	struct virtqueue   **vqs;
> > > 	vq_callback_t      **callbacks;
> > > 	const char         **names;
> > > 	const bool          *ctx;
> > > 	struct irq_affinity *desc;
> > > };
> > >
> > >
> > > That is setted by transport. The virtio ring can use this to index the info
> > > of the vq. Then the #1 #2 commits can be dropped.
> > >
> > >
> > > Thanks.
> > >
> >
> > I'm not sure why you need this in the API.
> >
> >
> > Actually now I think about it, the whole struct is weird.
> > I think nvqs etc should be outside the struct.
> > All arrays are the same size, why not:
> >
> > struct virtio_vq_config {
> >  	vq_callback_t      callback;
> >  	const char         *name;
> >  	const bool          ctx;
> > };
> >
> > And find_vqs should get an array of these.
> > Leave the rest of params alone.
> 
> 
> YES, this is great.
> 
> I thought about this.
> 
> The trouble is that all the callers need to be changed.
> That are too many.
> 
> Thanks.
> 

Not too many.


> >
> >
> > >
> > > >
> > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >


