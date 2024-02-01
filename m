Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D89C47DB3
	for <linux-um@archiver.kernel.org>; Thu,  1 Feb 2024 03:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLhFLSirN3zIM/Dl1SY9Z1UcGt6Zg3JBMDy6mgyyODA=; b=plen8OnKp3lAvfCpFo9//UhbI2
	dWcoLVfPbuzPt9RIH6rsoraYWB5kb2NvGf/q8BNEuTO8Vy1Q7xN+qB8mdP/HD2sRlxTNHU7aNEynx
	GxAI8X/utUONWHz7QljQx6r/ua+pzn2ii6QONNZff5+0bu0D9LVqnaLnrk1MBMHEVjMD8CzEakmqG
	PX55Tcpt1DYSATYp/EwN7Y/AguQzos2xYGMfyi8RBP3Yu6gaGLNXER0+iBft2HprxUsHaTCaYD5MU
	IC9QKJPjaQQtf/O2k1DcOaDMPTG69e89EF6hOcYm86TN9WrTl6raEbCr112AQEbOT2VaLDMw0wB4F
	8TUUqaLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVNcG-00000006N3w-269O;
	Thu, 01 Feb 2024 03:19:52 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVNcC-00000006N32-3QXO
	for linux-um@lists.infradead.org;
	Thu, 01 Feb 2024 03:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706757585; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=PLhFLSirN3zIM/Dl1SY9Z1UcGt6Zg3JBMDy6mgyyODA=;
	b=bO+msRE7cnGpsoweN6yZmJdWuWiosg+E1bUhQFlSV4rCF9PnuhHdr6w+pkZ1qpx2SVhqWcPuuzEFpQWbHr8jyvstZR9JZB8P8IzyRcHVpc+wrD7hg/x8Df1e+gR05YMvSC2WEg9wS9ZvAm0uQN5omuCN4Os2xEJ9GXIDvJ4fi+Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.mW7Yb_1706757582;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.mW7Yb_1706757582)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 11:19:43 +0800
Message-ID: <1706757435.040749-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 11/17] virtio_ring: export premapped to driver by struct virtqueue
Date: Thu, 1 Feb 2024 11:17:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
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
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Yang Li <yang.lee@linux.alibaba.com>,
 linux-um@lists.infradead.org,
 netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-12-xuanzhuo@linux.alibaba.com>
 <CACGkMEtWt1ROwJCeEa5FbQfxV2eqo0xRqHQZMsq-Q2TcQBur9g@mail.gmail.com>
In-Reply-To: <CACGkMEtWt1ROwJCeEa5FbQfxV2eqo0xRqHQZMsq-Q2TcQBur9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_191949_033519_30B6A85F 
X-CRM114-Status: UNSURE (   8.70  )
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

On Wed, 31 Jan 2024 17:12:43 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Export the premapped to drivers, then drivers can check
> > the vq premapped mode after the find_vqs().
>=20
> This looks odd, it's the charge of the driver to set premapped, so it
> should know it?

If the use_dma_api is false, we can not enable the premapped mode.
Though we wrapped dma apis, but the AF_XDP use the default dma api directly.
As we discussed, we just work in premapped mode when the use_dma_api is tru=
e.

Thanks.


>=20
> Thanks
>=20

