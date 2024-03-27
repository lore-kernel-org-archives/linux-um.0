Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B22DC54E67
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5+XUlpPqxzudteQHjuSJRjlJzQJhMWAmtNdNyAF5ks=; b=JOOWrNL0x4RWmIjjd0fGS64bJr
	nN/FodXzrmEPdB+g7ygsB0HRlm9FSn4/Us8kyVo0XqiywZtk/wF+Ym55RddMO88sVWoQNSacPnIkZ
	0Ks5u01LKrbgBoONYH/RzqKXLJThB0rIJHW2+iNJFNmgkHG7jycpQG/8ur3E0OJVD7S9VyQauAUPt
	GaYX/VNBVrQhi9MqppiEmaAZsA1pdL6eIfNhen453Jf99keCJkiq1djgGqo8cb3fbULw4Rgt8Hq7b
	2jTKgcJpbKhlynCzW2YkcvpwtqZxvsLvct6Xt6FIMOMIndqwyL4loavZgmYWcQoKW+nwaEYx/wq/v
	YoHbdRpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSeE-00000008y81-2pod;
	Wed, 27 Mar 2024 12:44:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSdh-00000008xzM-1NsV
	for linux-um@bombadil.infradead.org;
	Wed, 27 Mar 2024 12:44:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=X5+XUlpPqxzudteQHjuSJRjlJzQJhMWAmtNdNyAF5ks=; b=k1ezhtB5KK4lLv885rhx6/vdgC
	gYgkeH1WaqMHe6GITos5Tcm9AUoCw2ZLXJKbv2qDYh7zwTZj6CMygvkrgygwcte9ABxzihmE1ev2P
	T+kkR0F+QvdBtmbokcqOtf0QCHYciTcNB2Nu6rimAe3AMijCCaoe9v9d7U/oeBfKIaccWVv2rfJov
	w4LMy0zzAca63YyJZoFVKBsyE5EbtA+N+8QHUHStXEKUHapeHxYwYWx63sQ8OVl2BD8Rbhndt+pdC
	Uu5RXD7zHrzRuquE6Op1OKaqiNKzrr6sqxD7mUEPsq0+p7N8vDrvF/08BYpI0tA2Dw3o601eeDhlA
	0V9n0vhg==;
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSdZ-00000000EtG-0stX
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 12:44:16 +0000
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-513d3746950so8341056e87.1
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543450; x=1712148250; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5+XUlpPqxzudteQHjuSJRjlJzQJhMWAmtNdNyAF5ks=;
        b=ZvtuWIQ7kEFzseFRW1Fx3wm4TDe3/2GEk9L7Q9fMr5u+kaILvw1WHtvzHhOYSMA+PA
         h6fZvLAamFGrgHbLXIW3QsF5eVJvpFGO8qVBFk9F6etFKcOZNKSX1TXAHGSUx1JrTWJy
         p3GavgU0dDGyBpyM/6PkDzMnUvU4d0ZUT9GR2KejY1z0pkUYqS4AAuQ9TrndCSF5fX2Z
         yysEUvSVK+8aWcDWtbMHpoKQqgpCRuUYoyc4Ozyt8sqDLBS/7dop4scoKcNeSAcMooHB
         mlU8ssmU46CfWYP0pOQcDVP3DcjiAscL6/jkEhjvFWXfPe3XXeYCHf6tVbga72/8ltR2
         F8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543450; x=1712148250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5+XUlpPqxzudteQHjuSJRjlJzQJhMWAmtNdNyAF5ks=;
        b=Snh0pB5s9u3U6Hw99w9pXxDHGYzRG/VVQErgTOpd6zSfcdplIqWiCvy4ATxlGVbfMg
         4vpD7K5XaS9B6+KP1MCkDoF9q4hiUWJvvorxFYvszV9hGI2wK015Ajf9Ih+yLBFGdXa+
         5dk+09gd+QHiRM+tsRp9BWMh4cLquPPldiuiu8LiZcf6AnYy377F6dpTmmGIy+DAP/ro
         C6Nb8yfFeFX1pWq9CiOgRHJYs06UQQ45D3Z4xWc6AjD+bCcS5MlkQ6Fz5OYOvIldd1Vi
         CTGufeulqRu7Wq2dRW+RiGvZOtv9n/ArD2ediq8ndZZjiCsDrw8vgIQ3LA+psM2/bFq8
         aPgA==
X-Forwarded-Encrypted: i=1; AJvYcCWNJMTrdbqkfSaz0u8yFaRboFU+9rBH63uaEec0jQZgOxD+GvnCPThMI9ROTDGYRcFfDCAT5szUCBohMpChUJBQGnmJxSntbNIYZGhi
X-Gm-Message-State: AOJu0YxmjaahN8LHzWkiQuquDEfEe7YgysAN0Z0KJJj9/EW67QMmkciA
	D+dPxlOAVzIJH4go3oKA1HVXhWjqZUfArlEW4eELNKWKnhnxb4Aas6XzN8xJusU=
X-Google-Smtp-Source: AGHT+IFLbWSGKPYPN0YUh6BVqWa7xSpn/h2CAadvs3AEXfazvc7vUEszh9lyFrb4qLDLLf1Fc9nK/Q==
X-Received: by 2002:a05:6512:11f2:b0:515:a733:2e0e with SMTP id p18-20020a05651211f200b00515a7332e0emr1619496lfs.25.1711543450532;
        Wed, 27 Mar 2024 05:44:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:44:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:00 +0100
Subject: [PATCH 07/22] crypto: virtio - drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-7-0feffab77d99@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=855;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BF5+L9M6rh/9q/lpIn327dnJkaSg5SfZZk5BFIHRLEw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPguclXCHa8ugbyDeozIgOpE40j4Ll+BWhad
 9ENvd8G4cyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT4AAKCRDBN2bmhouD
 1xpCD/0frLUUPc34SuflHSrw1c+DAdA7PTHGAMpSybU7zf9+DXYkUo3/yxiPsfF4Qy4uOc4Wtwy
 A1TIFzq4fwfmzfs66DCV7daHcphW3cgSZO8x4NFn3290GE6/9sgh9G/JhNPlSkKaTbG1xX9E0YS
 ElYgyZqqFS1bp9UskO+KWFQWYz0cVtjKGRWNo+D1vsgAr++nLtJQhI5dBMRyMWEmNgU9ERlvlw6
 sBveGJ8CL/yY/OPe8RxdjryyHxMMVbtY/DeyfMBP4b6SGocw6P6tWO1M+wHKtzXWXOKejwOESU4
 k0zxTyJjKKrDLlJAt6ktxKMQOZ6lu98gwv3MStUZ4P4Y12wfHsApT9p2YTkcgwlyQMcnSw25S8p
 rJbZtM9xfX4clwm24W3t3B9NPUz0rfUSLosmImepb+WAw41SKMkVfDrjkmlqulEK38p7i+op2BW
 sp/4aE1DSaOvzrG7XGUsDioZVpirWwFBKx8MmUHbXZcNKABnylTq1eU0EOOgnG8kwtp9cDj1NqQ
 kbS/mS3INL55pcWyR3AJyby7Oh+tsCQdsIHl0bnu7AQjguQ8vIF78wWBaERhxi4mdyUwQQlzcS+
 d4H43QeiFwyCny2ajatFWzipq+b2zCgNUSlTBK2oxKDHAOmy+HdtG6hp9oizXbgsNFW3NPdqFoT
 jt9qtjGBGFB6Cyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_124414_962336_8F8C1A37 
X-CRM114-Status: GOOD (  12.01  )
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
 drivers/crypto/virtio/virtio_crypto_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 6a67d70e7f1c..30cd040aa03b 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -581,7 +581,6 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_crypto_driver = {
 	.driver.name         = KBUILD_MODNAME,
-	.driver.owner        = THIS_MODULE,
 	.feature_table       = features,
 	.feature_table_size  = ARRAY_SIZE(features),
 	.id_table            = id_table,

-- 
2.34.1


