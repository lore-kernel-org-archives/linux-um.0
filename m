Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D211C47DD9
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0hmLEhtDW+HCSY30P31S1H131D4FuLuLKkbSxHVWro=; b=Mj7bQG5B/7h4ILfn/tN02AwxLq
	fQescylbutL20XGlLE+E645AgjZOLJvJFr9/RW248woaqK/Qf4PQp1EjL/jhOSV1dJGZ55qhmBB6y
	WJeP0gjnkFzsdrIRU+jENzKQ47rK02gUMhkAW3gl+Rqaz/MMCVY5V8XjZYJbxZnoLMGuB6MCLum2o
	IcoePOvYEG4Lh97ydFLaLuPUN/8o9heodCaH6ZQPpMNcmaS5ejn48GGBUs1HyQT0ExFZm4oec+Wir
	XRk/oyQ90ZKs6BqjnfA+voR4tK7zDhVs4WpC/nfwQQqRWS6QzCQaena3+f2uPs+afKR8jocnxHfoA
	RB2FGf+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSee-00000008yFt-1bOy;
	Wed, 27 Mar 2024 12:45:20 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSeO-00000008yAc-2RaG
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 12:45:15 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a46ba938de0so890750666b.3
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543502; x=1712148302; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0hmLEhtDW+HCSY30P31S1H131D4FuLuLKkbSxHVWro=;
        b=nwwqGIJwtoLvKKaCvNIgf4iWC6dMmbkzgd0MkBpmpxRHAO+z24j9W/+VdgF2s7zVOk
         Qdid5jrUR7JNIKT/mfB4vU03/u8QsDS410uIB5kzl7uVqO1jKOP1QGAHaHe0HqS/Yba1
         12ffrV0gFW2i/2pqM7wzhsePwDhgPZIvocwDFklh2gK3+mj3F7qZaU58KIC6mAbm2QWC
         HfcpBMy6Z4wyZ85EqkG0xaDKa8xPEB5szZ3cOQPmAAQyEY9GbNMBwtrmp+ofE3NLuj7v
         XLiQYwFrjXczAJvsfKeHocu9lKFPWZS9CS92Nkm3nPalSCVHcYx/LTR6/Ck/PQ9n5TgH
         GiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543502; x=1712148302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0hmLEhtDW+HCSY30P31S1H131D4FuLuLKkbSxHVWro=;
        b=EG5d/+3YQOIrsTpEmSun/r7a46rGYDzFZ3AgVg06qD4fz/95X0Gg5wVIXymXaQtsVY
         XqKMWAeLSw5cjQE0h+TDBe+Wbx3qIINXWurID7Y02r40vAx6snJytRCAMfYGziVbZQH+
         DW5LZVCMBrovUsGGXevwkKVQi1iR1UEFbOxoBBe172B8W/osJjT/avIFI+FoMRJUBK7w
         Cnm2WCg5tfhcgbzIWpAc1e2WsJ8M+CDe1gb1/lBN6bengAkRg7YBHYbzsYPxsJ/NRqFd
         XRAwaG84nRX3ZkPeufnqZw6TFO2z7nJQXMDnmaQY7aEb22DwAlqVggUqK4DVnvsTSTCZ
         C4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGegJnyISxe/MVm2LzhCw7rNOJ9/3FYXqD6arsQLox15VVg5HHI89WNYGwclhTJjBxQeM0oPW1tr0FgVU2/P7irb738KGiIWYN6pIM
X-Gm-Message-State: AOJu0Yx68BP1J4GpXjnAV3JwY/KtpecdbfAcCTMHnP1GPYqVh+Kgsg/V
	zb4mzS9XLIn228ASb0YXsKIjNVO5tv1sgzlP+nPs2XQOmIyfpxdQEmw38kNpqC8=
X-Google-Smtp-Source: AGHT+IEn6vRTkmoHQ1wiFr8qmjh3PJ0Q6up00xiHporN+nJtNCU2vs+jLj3PzJepGOiy+pfR8eLRwA==
X-Received: by 2002:a17:907:9729:b0:a47:38c0:fb4e with SMTP id jg41-20020a170907972900b00a4738c0fb4emr4546499ejc.19.1711543501964;
        Wed, 27 Mar 2024 05:45:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:45:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:02 +0100
Subject: [PATCH 09/22] gpio: virtio: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
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
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=//Clpegv8bBxUlHlrbVbhwLuVMMJ/bk7DPF0aGjgRRI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPhAflQ1FGJhDAzbOegIOtyn0DiKBCT3tO0B
 s7IjiqYlSaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT4QAKCRDBN2bmhouD
 1wlSD/43RfNzYMYcTE6YGm6f/+zF4ZOeA7+AFzoz25hWACnn09ZJUKsqo8b4OOQmqYEITbWY9+h
 XPRwnPPXeNlc4DgWGOJbLmvCBCUuBSqKMyqIVUHeiKQYkKcodvybd1f5lbAL+Uom9vSnbje9Plv
 wIiwg36QHAiGjrP6FCrbFTARU+u3TVSo9UrmxbOR/Cs2zcsROAS787ue6dERDMHRhTICDHzchGs
 8lirSnX2eLweIUdLVeflXwAHFaVpdj5k9bUmCEJ9y8Dy0+5TaOREm3IIC+BMGqKTPwXr2xpX3Dd
 iUxBWyxquOdJ4D2K/0LVhYSSC+VtEt5ZZuC3ZoWa4HTxJM5tAElcgWaOQps1lNfT5UbRtK8uoQi
 iqAyMFhheEhnye6diL6L4H3hulkrYJw6LN27JtLkTStHd3lYU+1MW7TqZMKXQcujQNGhdzO9d+m
 3of1UO+mt5KeIH2CAx/mgbR5MLfW609xLhuHPWn3i/GzYYdKJxXMrj25rctSRtBvtmGHD8iF6o7
 CMdorn7Yl1SzBIoYcHUmygb3XOTnW7Zn+L9RB2k2epy90G6CsuIsaV5Plxhgk41/NsTCYyh6gWq
 GCkiLrJ9HW5biRhItd0RUt02PbEl7Tg1O0q20/cwbVq4IAyTVScxVYfx4ilMNlem9KQg/2l7ayl
 fFGCYquCVzZZykw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_054513_533904_89DBCD92 
X-CRM114-Status: GOOD (  12.08  )
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/gpio/gpio-virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index fcc5e8c08973..9fae8e396c58 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -653,7 +653,6 @@ static struct virtio_driver virtio_gpio_driver = {
 	.remove			= virtio_gpio_remove,
 	.driver			= {
 		.name		= KBUILD_MODNAME,
-		.owner		= THIS_MODULE,
 	},
 };
 module_virtio_driver(virtio_gpio_driver);

-- 
2.34.1


