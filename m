Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5165DCD128E
	for <linux-um@archiver.kernel.org>; Sun, 31 Mar 2024 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YUfNTipefEmXHX8bGR8JVQXCUjDv6U/ZK8sNVLNneMU=; b=wrXqjyE3symdcRxmNSR4FrkoCB
	T3PYdesgXnsrftyli6kWsbHGMzlXBFAgNvN8IrayWqSM7piDLY/wRUj6JYWmczNNLDhFBKPyid6PL
	WvmZ8KCbEXKtxoPfHHC6aA/qWLVnERQy7Jexxa8Qn/a2OR6TNi/5UleuqNLfDrknHsGdE1FpUVA1v
	7U6s3qny5pare05Szd1rrRXUtVhlIqfkTPpzhIxFP5REAehO5pHk4WlTTp8zfXFRQU5deOilkI4QU
	+Nwwbeo8rRYzZiurPiJbimZdClyAOn8lHDMMosOH6AtgkulWJaQq93scB/7Zed5sKXCeC3JWk+zuR
	nUwMn8BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpl-000000054BN-31E5;
	Sun, 31 Mar 2024 08:46:33 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpO-000000053vZ-2GFs
	for linux-um@lists.infradead.org;
	Sun, 31 Mar 2024 08:46:12 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-341cf77b86dso3083722f8f.2
        for <linux-um@lists.infradead.org>; Sun, 31 Mar 2024 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874769; x=1712479569; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUfNTipefEmXHX8bGR8JVQXCUjDv6U/ZK8sNVLNneMU=;
        b=JfeIr9l/NyK9Z6FgwilYoj5vdX2oPwaNoDtc2p0jWsCiD9zgVaLooFfOx0ObyQTndq
         QsQfmrt7BSph5yNSjrs+y35yo2BxGOSUmAOAae5iwMwz5Tjn52zVGbKzGkGS0YN2xGAI
         HIEYxSdscQ32pGY1tgI/lXKiUjStF4DfZCrAMimhNsMsEQCIjqt9lAXCg6FYwX5Wbm8N
         ERhO5GdlqiXQeTuDm10Er95uLCyRN/biL1H56xMyT/WNA2rTmd0MLwrxvBOOn/IanyMj
         UAaroCqPBcoh0M4cqSh+0zJTPAFtnOWmIYUuEDgVQQTfCmaoGUdoadIlPWFYoHLzQBh5
         seDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874769; x=1712479569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUfNTipefEmXHX8bGR8JVQXCUjDv6U/ZK8sNVLNneMU=;
        b=TWww9L2HWKzSmRxtnmeUJpadBoPvskK/gXDePC2wMGvQ/+o/mr+/Xb0ErDECajYqX0
         pYUsnMpeZfv9wHr2OHAaHE3KfSvpXKvk/y9L9lDbPJRaWiRMgHCkbFXciRyUs3+xcG+o
         ONeIdpBv9EpsgnTa7a1kpxIEskDKoepsyfzAwgsdgRRP+0//Xj/QsEG24751gNZQUOng
         ujhpI/cbFd1yqg0Y+y2XXPbjEav3NktfwJC6bwhxscnhFYZVS3gC/tH3okbk6kNmelBs
         6uFGnG1+sa+b6NnFwz5AOulVvv2JYQT/yA8qiDdcBTwNCkOcv3bf0xH6IVyiuagAizBm
         DJPg==
X-Forwarded-Encrypted: i=1; AJvYcCVOiHEtHpRJPJx7Wln0IuAV7qjnLQcDx9GoJbvh6c/JkY6h8AlNLhPBi/gnV3NnOiVwBfQECb+wyGTpYiI7lGEBPVD0V4CTPI/O60AR
X-Gm-Message-State: AOJu0YyCW2VBiTTLEKzpbGOxywEmCnR8oIJqOSdD2EtuM6+4vgdahRss
	spBoosrQlu1womSTJb49Jr5V/d22f00gBTh9I6b8M7vL3qDlbIHDwsjttZ+OeJo=
X-Google-Smtp-Source: AGHT+IFWevhYpwJfNDhRVePhOCKsR2pLuIuY4+m5hIw7WrVLFKSGSUKbdP+zlvsvE7pLRoSnihSMqw==
X-Received: by 2002:a5d:6451:0:b0:33f:6ec1:56dd with SMTP id d17-20020a5d6451000000b0033f6ec156ddmr5675223wrw.45.1711874769326;
        Sun, 31 Mar 2024 01:46:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:46:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:09 +0200
Subject: [PATCH v2 22/25] rpmsg: virtio: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-22-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=825;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Vyo2AzXtnL+6nl0togC7Bicpz881704XBK8alsfqblw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJjAziX1LvXxL0d2928/VbSKx//pADCrWW+j
 FN9OFXbeL+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiYwAKCRDBN2bmhouD
 1/jLD/9KtMVjwOhUEJDx/ub/l0GG3C9eq4On4ikCu4uU9IktC6UQN4qDrfdIyavpPOM1thNNvlj
 atCzlA5IOQasnc05bfUzNkSHtv5crrSwGdZEo4ZGWlRxKUovKWlKC8GPWUjHoOMaB9E6p/F+e3N
 opLqOlWxnMfxAEaImxYl9WfXgq386SS+gyHwrrcRgQLzEihLWj/CQua3yBGYVru82G0iXFbyE1N
 NnpHS2LEXz9nUeiuz8yHQM0L3H/tP2KNCMOI/39T4CdjJUfqp7OV6XwRZBRHzWMgetls48hoxkJ
 tOQpD8o6SgwW0tEorSmgALMFN+e/z9jUi7IsyY/bpqLm8yP5eSBSxDxpNBCnfN5imfW/XCYQR1w
 ANS3OEXZQLudpa/cetAhWNV865x71WlsJAit1xDRCqe5oCCDdUgcgBYiTeQp/Ddvh4qsAF71nGt
 RTT2WKt7qUGR/ddS9zBe+El6BRYcWYFDzqWsjTaOoUbSZBHTcfgGg2SQDqd5lO+eaiS+ZQLjFNp
 f94PMSyEfpoISfRbHubkrqwR9d4hfYhtjBhFfWbHU+Igy6/zMawFXf3jgIpiCjX/jj6v6qpfda7
 umdXTfdN0OqQSTG2VarkPNsHyo94HagoTB997ZLjFLcYuv5EIg03gCjYeLLIuDAXtvfdat5mLgb
 odNYlyqVAniZrZQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240331_014610_944819_54231F80 
X-CRM114-Status: GOOD (  12.35  )
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

virtio core already sets the .owner, so driver does not need to.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first patch.
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 1062939c3264..e9e8c1f7829f 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -1053,7 +1053,6 @@ static struct virtio_driver virtio_ipc_driver = {
 	.feature_table	= features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name	= KBUILD_MODNAME,
-	.driver.owner	= THIS_MODULE,
 	.id_table	= id_table,
 	.probe		= rpmsg_probe,
 	.remove		= rpmsg_remove,

-- 
2.34.1


