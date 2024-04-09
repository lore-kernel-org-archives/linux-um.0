Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E9ACD1296
	for <linux-um@archiver.kernel.org>; Tue,  9 Apr 2024 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GFjr+qUI/xJlRfC49pDYbbQ+5mOHCUk/2gN5wZX0VPA=; b=iJCqRWQfkqXq8Xh5c8rof+L3FN
	0F/iBL58iBU++RSNqmyQryh/ffjdNBOPYN56rpJyAkFoc7FB8PYcNUM8r0aUL5k+ew43RdQbgaCTx
	NVq2Y+paeF3qIhSoFbcfGjLFm/mxml93SGmSuQSL7143hHWxvAjqPoEudrmw7/ICptPhO7m6m3psL
	c42NQbY2aCA9f0YUyCV4oSL2Yl/gjaTxzq9wa7yJXzuVQGOCy1Rdfi8p+EkWliR8qg6BNnfB7W+Kw
	AOiHLkdu6fysbwhQyiuiZjLcyZUCNZV4TOu1WA7piTErw2IsRsow6da7SKB+hWEXuU2ZLVfepN3yM
	km3L+PpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru9vL-00000001lui-20cw;
	Tue, 09 Apr 2024 11:45:59 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru9vG-00000001lpg-3amI;
	Tue, 09 Apr 2024 11:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712663155; x=1744199155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GFjr+qUI/xJlRfC49pDYbbQ+5mOHCUk/2gN5wZX0VPA=;
  b=Y0dE9rV0z2FXP12OtblaxUZjMvOPuxmhZ16LVMXdx9JQNy80EP/SFZsD
   6DD6HHqkgj9lRStK89cyy0tlfICcQaH5Q0oqaxHuG2HbZ5+m8S5S5QUVs
   x5l/Lhn2VTh5+F4S0CFHZ5IZROZ75FQFBcwIc5zs3KbzBinvnxytc3XvT
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,189,1708387200"; 
   d="scan'208";a="650727234"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:45:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:49900]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.169:2525] with esmtp (Farcaster)
 id 3f52ccb2-10c8-4639-a2de-4651f9e21034; Tue, 9 Apr 2024 11:45:42 +0000 (UTC)
X-Farcaster-Flow-ID: 3f52ccb2-10c8-4639-a2de-4651f9e21034
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 11:45:38 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 9 Apr
 2024 11:45:22 +0000
Message-ID: <7c82670e-6063-4b0f-9bbf-805a0d949d84@amazon.com>
Date: Tue, 9 Apr 2024 13:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/25] misc: nsm: drop owner assignment
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, "David
 Hildenbrand" <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Richard
 Weinberger" <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe
	<axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, "Luiz Augusto von
 Dentz" <luiz.dentz@gmail.com>, Olivia Mackall <olivia@selenic.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei
	<arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, "Sudeep
 Holla" <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>,
	Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter
	<daniel@ffwll.ch>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen
	<ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
	<asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
	Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Pankaj Gupta" <pankaj.gupta.linux@gmail.com>, Bjorn
 Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Vivek Goyal
	<vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, "Anton Yakovlev"
	<anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>
CC: <virtualization@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-gpio@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<iommu@lists.linux.dev>, <netdev@vger.kernel.org>, <v9fs@lists.linux.dev>,
	<kvm@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-remoteproc@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
 <20240331-module-owner-virtio-v2-15-98f04bfaf46a@linaro.org>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240331-module-owner-virtio-v2-15-98f04bfaf46a@linaro.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_044555_166420_A4AAC9CE 
X-CRM114-Status: UNSURE (   7.27  )
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

Ck9uIDMxLjAzLjI0IDEwOjQ0LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOgo+IHZpcnRpbyBj
b3JlIGFscmVhZHkgc2V0cyB0aGUgLm93bmVyLCBzbyBkcml2ZXIgZG9lcyBub3QgbmVlZCB0by4K
Pgo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2lAbGluYXJvLm9yZz4KCgpSZXZpZXdlZC1ieTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9u
LmNvbT4KCgpBbGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApL
cmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4g
U2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFy
bG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5
IDIzNyA4NzkKCgo=


