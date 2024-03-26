Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11A4C54E67
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 07:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4Y2Cxq3/mRKaUI5wDBHgLNzWvAkhTGSKamX46lAkos=; b=1kTJet3E6tNXSEXi7dMUPfMX5A
	V0YomcRoFu+LBEtqcagAw7jP7IcdWPnpDzLaFn2+OlSf8Mb7Kh7rdObLq/4pA84cA1T8ih9RzMD3E
	m0YssA70HaX0aueBX99gxu/HmWoEAUek/5igGvdGUvY+RMwK9qppePY0WkTnnVDAoZaGREbV/m+JN
	cR7DEPclzaPNouJ4EJe1cZ1r1+MsLl6vt6DOpSTbxjsUtchWrWlgtr8GcwaUG0cqZR4OEWvlrjMYT
	SsnfTD/thtYVsUe1eh6ARVglTDFQrGy+fbedbJ/HCipNrhFXDN2B5U0FI3dvv0RruR/owhgNkQOnK
	GUb7dCZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp16X-00000003Pz7-3fd0;
	Tue, 26 Mar 2024 07:20:17 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp16U-00000003PyY-2Xj1
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 07:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711437612; h=Message-ID:Subject:Date:From:To;
	bh=q4Y2Cxq3/mRKaUI5wDBHgLNzWvAkhTGSKamX46lAkos=;
	b=atDvqJ+8xx3/BYGc0ywQDSSveBCI0AKxIXI6TLUM+ocdq3u7hoU+b8/HD/7zfQZLp8XTVvsybiM3xjUZRg8KCRDsSDYfklvPUqgibhkOAzUPLjGhGIUD/0sH9+/cwV/XIW/nlXfTFZqIpk+Kg3rnCAtblCkDJetsMfNUHhpRrCw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W3KMgO7_1711437609;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3KMgO7_1711437609)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 15:20:10 +0800
Message-ID: <1711437558.7066448-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Tue, 26 Mar 2024 15:19:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
 <20240325090419.33677-2-xuanzhuo@linux.alibaba.com>
 <1b5123f9-6fd8-4783-aec7-5cc5507ee3b4@redhat.com>
In-Reply-To: <1b5123f9-6fd8-4783-aec7-5cc5507ee3b4@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_002014_898547_313BFB2E 
X-CRM114-Status: GOOD (  15.50  )
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

On Mon, 25 Mar 2024 10:12:51 +0100, David Hildenbrand <david@redhat.com> wrote:
> On 25.03.24 10:04, Xuan Zhuo wrote:
> > Currently, the init_vqs function within the virtio_balloon driver relies
> > on the condition that certain names array entries are null in order to
> > skip the initialization of some virtual queues (vqs). This behavior is
> > unique to this part of the codebase. In an upcoming commit, we plan to
> > eliminate this dependency by removing the function entirely. Therefore,
> > with this change, we are ensuring that the virtio_balloon no longer
> > depends on the aforementioned function.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   drivers/virtio/virtio_balloon.c | 46 +++++++++++++--------------------
> >   1 file changed, 18 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 1f5b3dd31fcf..8409642e54d7 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -531,49 +531,39 @@ static int init_vqs(struct virtio_balloon *vb)
> >   	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
> >   	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
> >   	const char *names[VIRTIO_BALLOON_VQ_MAX];
> > -	int err;
> > +	int err, nvqs = 0, idx = 0;
>
> Re-reading, you could just use a single variable for both purposes.

OK. Will update in next version.

Thanks.


>
> Assuming I didn't miss a functional change
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

