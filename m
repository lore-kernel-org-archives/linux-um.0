Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B51C2BA18
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 09:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XR61vx35OTZX9XFWt8YdyvsDaIUHY+xQKab0QtNP4Qc=; b=Sw0BqFPoIDrcoEF/eVqAAIF8IG
	O1xh0aeLKSq2fU3rCpoJ2lxIX7eMeYTSfUHhRVxux9F7j/69/EWWyaqjjpsgRLwHTtBxOzyG5QffL
	GatNLqbl87NvdofrInUmPvhAwbhYJagqisRz12OF8uD68Uxw2f9FfDDAi+WSqHPcxeae9TrL68f1J
	2FRXf8rIBjCGtHZh7boxdJF+4/+10y14t0q/F2eBYB21pl7Umk8SsgxUlNPfgFMJa66gZJnpKHJWM
	9V7oduEODX0b4oCYIZ4p83syTHrDpV6KhEXhOQyY6NtPXwhWakRqbu8ypwfYh2Of6I8WP7vOWrfMa
	A5szZ54g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDfY-00000004Iz6-09iX;
	Thu, 20 Jun 2024 09:01:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDfU-00000004Iws-2Wsv
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 09:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718874079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XR61vx35OTZX9XFWt8YdyvsDaIUHY+xQKab0QtNP4Qc=;
	b=SR6WBTF4zh3aZRG1XLePLbTnMStpDw/t1Trbd4eLbGLuWtnSL23ee83scsGtEydvQnQfoG
	iQ7puFwYVAXSJ3Hn6obiNwlhG6VOq6VClgjlzt9l+tRVAwCq5THmxV1aq+Nvtv8cjSDjaM
	Dqm8Yo4MG82MV7P6WUxDQeI+HUWnJFA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-kVlZeNlDMzmdqxRa8eQK4A-1; Thu, 20 Jun 2024 05:01:17 -0400
X-MC-Unique: kVlZeNlDMzmdqxRa8eQK4A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6f3f614e58so34545366b.0
        for <linux-um@lists.infradead.org>; Thu, 20 Jun 2024 02:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874076; x=1719478876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR61vx35OTZX9XFWt8YdyvsDaIUHY+xQKab0QtNP4Qc=;
        b=R69NxZhXSdTXfSfre0Nn4KFzTZFYTzSYdUAlUpeW9H9vBfgTlDv0cJKkSXN1QTRjKh
         2n5t8VJ4QRyzpOy6Kz0BiOn7CyEmzH3Z4esZGV81Darl46o12bUdde+1QLy/XcL3XqQt
         3wvXW96dShFBDb/gr7UNsX+xS/b9LApfyjCGKX7i0B2YfjA7fXdb81kwv4p2QH+Efz3M
         2U1B4nvDRpLB5RvwfWdhwFZkzS68tcSEcb7yV3qB9fKtltr5ejVY9Big9Or+0zsODQnC
         ogIxn4IDP8yfg1r3ahPGQGOqKRPpN9j6PuzpKNm3KXFyXCHN6rBCnMaiwK+JN1dtz8af
         iwrw==
X-Forwarded-Encrypted: i=1; AJvYcCVJkH2PZXzTO/FmT+/gLLFbEAF79zDvcAq2n/Ie6psyJvjjRXIeKNmZgli9BUeoegaPK3JOQInEbvM/G68AEuE9diMKC0fH2zxCvmK8
X-Gm-Message-State: AOJu0YyCuKO3GZopXBCwZ21qX1BLvEBOl8bRmXW3B+r1769tSp+MGXsB
	ArlQM9YtxwghJfSf/hFeRMMWQtSFz/TzABTyEg9qtgFTNUp0SPK2q7X/Nh40tYGOPsrCGDDwA2E
	sK5BnDidtJU4+X0Dhu7NY6OxvLmpMECyYnEkZf1StNK1Zf4lWPmp67sekKJRDSw==
X-Received: by 2002:a17:907:c805:b0:a68:b73d:30d0 with SMTP id a640c23a62f3a-a6fab609e47mr400228366b.6.1718874076402;
        Thu, 20 Jun 2024 02:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5+F4gugdmHhB163V4ULVbHnYMOFq3eTuk1V982iZ6yAjow4HL/6ytgFaWqg7nTSdPpnke9w==
X-Received: by 2002:a17:907:c805:b0:a68:b73d:30d0 with SMTP id a640c23a62f3a-a6fab609e47mr400225566b.6.1718874075875;
        Thu, 20 Jun 2024 02:01:15 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3356sm742953866b.40.2024.06.20.02.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:01:14 -0700 (PDT)
Date: Thu, 20 Jun 2024 05:01:08 -0400
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
Subject: Re: [PATCH vhost v9 2/6] virtio: remove support for names array
 entries being null.
Message-ID: <20240620044839-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_020120_742231_0A907A97 
X-CRM114-Status: GOOD (  21.80  )
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

On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > > doesn't apply. And not one uses this.
> > >
> > > On the other side, that makes some trouble for us to refactor the
> > > find_vqs() params.
> > >
> > > So I remove this support.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> >
> >
> > I don't mind, but this patchset is too big already.
> > Why do we need to make this part of this patchset?
> 
> 
> If some the pointers of the names is NULL, then in the virtio ring,
> we will have a trouble to index from the arrays(names, callbacks...).
> Becasue that the idx of the vq is not the index of these arrays.
> 
> If the names is [NULL, "rx", "tx"], the first vq is the "rx", but index of the
> vq is zero, but the index of the info of this vq inside the arrays is 1.


Ah. So actually, it used to work.

What this should refer to is

commit ddbeac07a39a81d82331a312d0578fab94fccbf1
Author: Wei Wang <wei.w.wang@intel.com>
Date:   Fri Dec 28 10:26:25 2018 +0800

    virtio_pci: use queue idx instead of array idx to set up the vq
    
    When find_vqs, there will be no vq[i] allocation if its corresponding
    names[i] is NULL. For example, the caller may pass in names[i] (i=4)
    with names[2] being NULL because the related feature bit is turned off,
    so technically there are 3 queues on the device, and name[4] should
    correspond to the 3rd queue on the device.
    
    So we use queue_idx as the queue index, which is increased only when the
    queue exists.
    
    Signed-off-by: Wei Wang <wei.w.wang@intel.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Which made it so setting names NULL actually does not reserve a vq.

But I worry about non pci transports - there's a chance they used
a different index with the balloon. Did you test some of these?

-- 
MST


