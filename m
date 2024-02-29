Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ED9C54798
	for <linux-um@archiver.kernel.org>; Thu, 29 Feb 2024 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X/vfymhnan3upoVf726nPIc8SXJCCwv4OsemoA6fj3w=; b=PHCzv/Ocmpnp16Z4XWn+mzH6zV
	DYih+ExPCi4bLphOxzTokcHuR2I1DoencwLFyEzHQ3Q8ilJDzIeOw+ckgRzmBZh4Ksahjuz7ov1JQ
	JY9bRGjjub2BJ22Sey+S4cWg4B/JuYCtHKf2//heyw+EWrMAtykAqflyqZPYlsdJ7c+mnTzpZ0tIC
	SY0qZt2b9ahGi+jjBus8UlIlLdcv18az45MyZkJrGzRIi+ga2ADH22bFY74QVz38Vm57m6NrCRbfH
	1S2U0AHXxcRbUP1QtXRg3KurVCNOwhzfxItl0I5lGtGaS1PFvA+cMSKFWAQR5rVjp4uxR92r0E9YI
	DAYZtT4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfcxK-0000000Cz34-1XRj;
	Thu, 29 Feb 2024 09:43:58 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfcxG-0000000Cz1v-3ViT
	for linux-um@lists.infradead.org;
	Thu, 29 Feb 2024 09:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709199831; h=Message-ID:Subject:Date:From:To;
	bh=X/vfymhnan3upoVf726nPIc8SXJCCwv4OsemoA6fj3w=;
	b=FL8YFcIkjtTuVVfANDqDzhAWfgveKdjjP7sD/Xftxg0dCigr1s7Ilblipg9h4GDAXx4nPIhbjPbCpyQGHURQqQy4xMm2g39zTi1Jexp1vovkfacEkxSLcfWqSZFv332WvAsqGg2FKkeJSxvrsRWEB961pHzJbXe2j+NYS4WWB6g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0W1Sa3HZ_1709199828;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1Sa3HZ_1709199828)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 17:43:49 +0800
Message-ID: <1709199778.0187387-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for premapped vq
Date: Thu, 29 Feb 2024 17:42:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?IlpoJ=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
 linux-um@lists.infradead.org,
 netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
 <20240229031755-mutt-send-email-mst@kernel.org>
 <1709197357.626784-1-xuanzhuo@linux.alibaba.com>
 <20240229043238-mutt-send-email-mst@kernel.org>
 <4825d7812ac06be3322ca4ae74e3650b2b0cd8de.camel@sipsolutions.net>
In-Reply-To: <4825d7812ac06be3322ca4ae74e3650b2b0cd8de.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_014355_240821_73127206 
X-CRM114-Status: UNSURE (   7.00  )
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

On Thu, 29 Feb 2024 10:41:11 +0100, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Thu, 2024-02-29 at 04:34 -0500, Michael S. Tsirkin wrote:
> >
> > So the patchset is big, I guess it will take a couple of cycles to
> > merge gradually.
>
> Could also do patches 7, 8, and maybe 9 separately first (which seem
> reasonable even on their own) and get rid of CC'ing so many people and
> lists for future iterations of the rest of the patchset :-)

I agree.

@Michael How about you?

Thanks


>
> johannes

