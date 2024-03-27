Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08871CD1287
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NZdy0X3liUqTEzRbInNe/vjDY6MNb1re1WUM40McVv8=; b=aj9ZK36iQf7CXkxrcx6Ph7Yq2Z
	3WDdGNyRGv2h6a5cw6kKsk1xoY9Of/iaT94Xmj4+uqIhZrqQHuwW3NKW95aro1B98fE7W1eNbNyio
	gPYcQ1zLyh27QbSUpEBDMQaE4ebZrPJSB8LQHG+yXG8vBsubU2CYrzYa+xdKyT1Ec5B7buCL2TNxu
	9wcg0WLH+sNEXHm8hPmxIVcaEVTJlAc0UvdoVJ3BdMdNMTPljckQrpkygF0IbZbaTBvtzlEj7alOS
	Uujfgw3hr/KxHC83MngFekyGyrivZX9ZpJoTsukxDNL9319q1EBtyiHJ2YE0ydla8emKKxfmwhBpK
	AP5t8Ohg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpTQW-00000009DbB-0X2o;
	Wed, 27 Mar 2024 13:34:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpTQT-00000009DYQ-1llz;
	Wed, 27 Mar 2024 13:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NZdy0X3liUqTEzRbInNe/vjDY6MNb1re1WUM40McVv8=;
	t=1711546481; x=1712756081; b=Uegbrs6XYoK83KdQ4Q0Sm3Dh9uU+jR4uRGEe9k1uJg3jTMl
	QL5cpsb/xGn/3Sr6SgpwIeXOBT3lvKkv+mlfiuq3hFvMDQkEHhYJXAcraN7nCzBpGavWhZo4RANfe
	6pTBkOSC1ZfdGltjRxB0FSzZPYqWxNfYgldirkEfmI1G+USJuF5M1M5cfUmoA2nANzdLYTh04XH5/
	NGk7HyEQ9fjcGUZVkEU+JCeTxY+ZEYUMahel+F8+GcWtGbAvOIDuyDRHSb7USZ49e/e3jCo53bW9e
	0EXt6rkK6eCejTRpANFiXrMpF0/kuW5pt7vUSLK3YPCRVm5VZCuLcXSVaJYCDTtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpTPq-0000000H6pw-3l9Q;
	Wed, 27 Mar 2024 14:34:07 +0100
Message-ID: <46e9539f59c82762e3468a9519fa4123566910d5.camel@sipsolutions.net>
Subject: Re: [PATCH 02/22] um: virt-pci: drop owner assignment
From: Johannes Berg <johannes@sipsolutions.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe
 <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von
 Dentz <luiz.dentz@gmail.com>, Olivia Mackall <olivia@selenic.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, David
 Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan
 Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel
 <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar
 Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,  Stefano Garzarella
 <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Pankaj Gupta
 <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Vivek Goyal <vgoyal@redhat.com>, Miklos
 Szeredi <miklos@szeredi.hu>, Anton Yakovlev
 <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
 nvdimm@lists.linux.dev,  linux-remoteproc@vger.kernel.org,
 linux-scsi@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 alsa-devel@alsa-project.org,  linux-sound@vger.kernel.org
Date: Wed, 27 Mar 2024 14:34:04 +0100
In-Reply-To: <20240327-module-owner-virtio-v1-2-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
	 <20240327-module-owner-virtio-v1-2-0feffab77d99@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_063445_485885_42F2D8D2 
X-CRM114-Status: UNSURE (   9.77  )
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

On Wed, 2024-03-27 at 13:40 +0100, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.

> All further patches depend on the first virtio patch, therefore please ac=
k
> and this should go via one tree: virtio?

Sure. Though it's not really actually necessary, you can set it in the
core and merge the other patches in the next cycle; those drivers that
_have_ an .owner aren't broken after all.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

