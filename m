Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84465C48BC4
	for <linux-um@archiver.kernel.org>; Wed, 21 Feb 2024 02:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ORbxc1aLPAjWIc3vkR5GtdqUtX005SNYWEsxv9OAOk8=; b=FLTbEZYJ2hbGE22bIAkNqnx68l
	TppYkvK9z8zgRgf9jP/MxqaiTiz21bVusD0XjDHosqbNlE5REQCFat0VeZKbYNr8c3gYg/8HXTsag
	utdU9zyNFFh5TaOXMx7E2mXLaOrvPjbtPXRpe/UKTMKRK0A/7Hms29LRY2HWsRjfGQXLL1uu1rvnf
	K5ssAFN1zh4cJFv7epzXn5G6OtKi5yvpTdZn09EI39EOpP83wEn5rVNmGGZF/nspirhjmaNP+otjz
	45pgNxTl3mMGW/U9B9c1Vl+yRinl82fLdIs7/OZI63AG8KTjHPl/EOvAJnvCsWtXBfWxZiOciDPy1
	VJB0aJWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcbyk-0000000GoTg-3Llc;
	Wed, 21 Feb 2024 02:04:58 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcbyh-0000000GoT9-36b4
	for linux-um@lists.infradead.org;
	Wed, 21 Feb 2024 02:04:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708481090; h=Message-ID:Subject:Date:From:To;
	bh=ORbxc1aLPAjWIc3vkR5GtdqUtX005SNYWEsxv9OAOk8=;
	b=SWwzhmyR2Rx10Y0e8JhKvGH9n+BAz8SFVj+cL6jZmWpaRkl1j43BjOZ+80vTAM0AVdW+FbbCk++m3IN/htZ3Fg1etgsyhfMKRIG6c1Oj5lw1+2sOhw2e4VKN0uEQaOeeg2JQrSHaS/fCR+QERFlTlidHk4GEjl1NLsAJH18TY1c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W0yFyS._1708481086;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W0yFyS._1708481086)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 10:04:47 +0800
Message-ID: <1708481025.1893313-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 07/17] virtio: find_vqs: pass struct instead of multi parameters
Date: Wed, 21 Feb 2024 10:03:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev,
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
 bpf@vger.kernel.org,
 Halil Pasic <pasic@linux.ibm.com>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEvb4N8kthr4qWXrLOh9v422OYhrYU6hQejusw-e5EacPw@mail.gmail.com>
 <1706756442.5524123-1-xuanzhuo@linux.alibaba.com>
 <20240220151815.5c867cce.pasic@linux.ibm.com>
In-Reply-To: <20240220151815.5c867cce.pasic@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_180456_513209_8507F83E 
X-CRM114-Status: GOOD (  11.46  )
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

On Tue, 20 Feb 2024 15:18:15 +0100, Halil Pasic <pasic@linux.ibm.com> wrote:
> On Thu, 1 Feb 2024 11:00:42 +0800
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > > > And squish the parameters from transport to a structure.
> > >
> > > The patch did more than what is described here, it also switch to use
> > > a structure for vring_create_virtqueue() etc.
> > >
> > > Is it better to split?
> >
> > Sure.
>
> I understand there will be a v2. From virtio-ccw perspective I have
> no objections.

The next version is v1.

That is posted.

http://lore.kernel.org/all/20240202093951.120283-8-xuanzhuo@linux.alibaba.com
http://lore.kernel.org/all/20240202093951.120283-9-xuanzhuo@linux.alibaba.com

Thanks.


>
> Regards,
> Halil

