Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22B9C46CD2
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=68WGLYeT5XGxdBIWX7j3qvfnpmvTuS0nYBOOJmACvE8=; b=IXZFb0BEvTMY8cKgl2QSZcXe2N
	Gk25VR32MC41X/xKIwxwmdEO//jYDNkBMBA9aWbXRYkJ1QqK+WBF8pHrubUG9wwkvcGoJCz4/pP8Z
	ylS9wugtUTvOSGT6Koqw8KK/KSFw3Pns1iyJhXU5G9uZ1ZzkXhF+cSVGE+JqMM9taDbkrD35F1qhW
	05f/NYhqQk9f2kwsOXCCVcVDf+DqHr9RP5JrqF68ZBPQCf14K0TaervyPqgbhxU+u/fJF9aI215jy
	d7yaIdyd3bcnIB9mrDRdEChHQ8yPPVdO8UOWY3FPSF2s+JnJe/DZyqpqokeVOZ/phFwMPEjxSYrp0
	NZrknFyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmYy-0000000GXHr-1T6r;
	Tue, 30 Jan 2024 11:46:00 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmYv-0000000GXFx-0Ncx
	for linux-um@lists.infradead.org;
	Tue, 30 Jan 2024 11:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706615155; h=Message-ID:Subject:Date:From:To;
	bh=68WGLYeT5XGxdBIWX7j3qvfnpmvTuS0nYBOOJmACvE8=;
	b=i/Xdb4g1cubmxx+x9Crfw1Fw3ENsH+wvPtI9vo9hRERrfZyU4lsiWIgzIE5OQAOahC+AO86BNZTmsCeJcBCiedjWPGriadC1cVJxCumrd0sxyNlGPDxJYetl5vJ5exPd913Vor17xtsvkiTlTB0a+ZClDYzGPKekC9xpO4WY0gI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0W.g5hEv_1706615152;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.g5hEv_1706615152)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:45:53 +0800
Message-ID: <1706615031.7414055-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 00/14] virtio remove dma info for premapped mode
Date: Tue, 30 Jan 2024 19:43:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
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
 bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240130030604.108463-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130030604.108463-1-xuanzhuo@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_034557_288962_DB04269D 
X-CRM114-Status: UNSURE (   2.56  )
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


Please ignore this.

The new thread is sent.

	[PATCH vhost 00/17] virtio: drivers maintain dma info for premapped vq

	http://lore.kernel.org/all/20240130114224.86536-1-xuanzhuo@linux.alibaba.com

That includes the refactor of find_vqs().

Thanks.

