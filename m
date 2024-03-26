Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C7DC54E58
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 07:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lvPHXAmlthw4ylJLu+8Br+cOBpAUBI32m3n1uEjmn1s=; b=tZmAFMpe8gwvROwrJOnzx5sn1m
	t7uY3DvAJU1aQhl75fieJ68hB9H5nHkgOw6RYFy81/MggL9kT03WezbnY3BgKSoPRXvbt+nb6Yw4M
	Cz9AIZT3YpTDCQhHh3GL6S+LDmkA6SvvHN2YwH2dfaG5eHrHEzwv9QIvmnabm/H4M464+RY+7yoZ8
	TztuBRUHKw2x9cy7f4oRUJUul/xbSQKYdXpyZc/tCc92Sm+8uuLZgvtiFWI9PoJnJNHytACthzP6P
	O5XhBrRjGxEETLyVxGg+TIOJCARyUk0nSKXlCf9J+fVFhWfwkMbmw5EHkw7mLWI9RG2EqUE1ZCXfx
	npYdRkEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp159-00000003Pmk-0J0z;
	Tue, 26 Mar 2024 07:18:51 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp156-00000003Plh-0zsV
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 07:18:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711437523; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=lvPHXAmlthw4ylJLu+8Br+cOBpAUBI32m3n1uEjmn1s=;
	b=lFXhl/ZC4QpqSwpOeIJPi/fAs4vOnl+5Z5VIJzJoidz83uqtzPSPEsWjAMYZ5zQj0yEAjl+WZCzLwu5k5zxIWOcwevH/xzePKBQEGzUE9ob7UKERAcgWm3C2uhM0XdPHHlhrvKSs4+36fYfBKrO11D/RA+Hx/529o6G0iNeF6b0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W3K6Xbp_1711437519;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3K6Xbp_1711437519)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 15:18:40 +0800
Message-ID: <1711437497.65582-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Tue, 26 Mar 2024 15:18:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
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
 David Hildenbrand <david@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
 <20240325090419.33677-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEtBw86fXjFrk6Rt4ytOYOn2q7r5a4WuvsgqPGT8O7tr0g@mail.gmail.com>
In-Reply-To: <CACGkMEtBw86fXjFrk6Rt4ytOYOn2q7r5a4WuvsgqPGT8O7tr0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_001848_721026_A8139B43 
X-CRM114-Status: GOOD (  13.91  )
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

On Tue, 26 Mar 2024 12:14:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Mar 25, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Currently, the init_vqs function within the virtio_balloon driver relies
> > on the condition that certain names array entries are null in order to
> > skip the initialization of some virtual queues (vqs).
>
> If there's a respin I would add something like:
>
> 1) the virtqueue index is contiguous for all the existing devices.
> 2) the current behaviour of virtio-balloon device is different from
> what is described in the spec 1.0-1.2
> 3) there's no functional changes and explain why
>
> > This behavior is
> > unique to this part of the codebase. In an upcoming commit, we plan to
> > eliminate this dependency by removing the function entirely. Therefore,
> > with this change, we are ensuring that the virtio_balloon no longer
> > depends on the aforementioned function.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> With the above tweak.


OK. I will add these in next version.

Thanks.


>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>

