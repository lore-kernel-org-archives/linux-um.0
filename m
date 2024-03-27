Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A009FC54E67
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+IWUZpRkzyHsZ1EONPtdPXipfrRjQDoO3m+/nPtb0s=; b=dRg7zPxT2B0dtFZr5rAHkQTT3W
	05vwkysvDgDmjE7gBRnwJm6ngKUnhIl/zr93MRUUaeIrbQ4xzU8e/MHYABckqsKnDDazDyPciZZy1
	a2641BJCruaZRZ72cI/uFyZvOVF7OvDSA4f/TYJLPtY/mav1nLN18FT5l3pKMX7FkW1qjbw2EYDkZ
	lUEO4FiSLoHiy1YHWVTvH2mD+CyQe32i9jM5tpZCooNxvK4U+2+fepSGAY2vFHcZRvdE++HKM95gK
	YwTQSc8e1ExGo/2H0BO+qgjzO80amMFQ2y5JuCU6KidYpTB5v7bY7U+RmNHzaz/hpj65JiuqudMpL
	Z2eKZ9HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSfo-00000008ypb-3cfZ;
	Wed, 27 Mar 2024 12:46:33 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSfl-00000008ymG-06Ge
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 12:46:30 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso7882276a12.2
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543586; x=1712148386; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+IWUZpRkzyHsZ1EONPtdPXipfrRjQDoO3m+/nPtb0s=;
        b=uzkK8StV0wT+iT8O3bpkNbGOaCAwNWNQWGmopYWe29WSlqrJVQ1judWsFchY9Uh3Hx
         Rl0asBHG/aH81h9VK8IPfkVSffwTwmTPTCYnhEj+ZBaV/cb2SrN2m0vcJ/Ujb2gHefMY
         s03DxZCX1e1ktrfc9UbPE+aM8onPCd1js3iPkZpuwvskPoTwYHToj57M5OHQnIcsBWzo
         8EXeb3MCqeZl+blla2S6hbwx/MhPvB0v1IFmtnf1GLsgadprO7qQn4qsZ6aZng9Z+dHN
         6u3ZZp5iusS0qyod/lmOYOdFaRfa+4WgkO3zHxB7FAF9bOuKxweTQsVmnyTCQ9NmwAD0
         FNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543586; x=1712148386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+IWUZpRkzyHsZ1EONPtdPXipfrRjQDoO3m+/nPtb0s=;
        b=c89CU3GUBi4sIbEGkSAesVwDmWdp3jZWxPPLR5/+3qtnLPGc6Z58GkMI4n5eHWj5N2
         MNpu2yDQkaPXT0WglfAsVo/PnM/AB6sRCsU4CwxbrItPMe9IHNz6QsIW3XWVPjqjWsxV
         j8FMfPi0DnYjCWI9sjVD0Tt6fitJgudbLpXJ6d3F1PzG0fVkn49l4qE+m4ID9kT7TcV5
         EnwiA9EwVhqzN1GNtajDXnrGScZJw4147OTQF7hCmh/Gw60TA2iqldL7LR3dSzim9Oah
         w8MfW7OWJ/TD3Tc/EvUpZptctVrD8bElM4aY4b1KxMqZ+IQITpUr58pNQ6AZ5AaDAmGi
         Bd6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUP0tX+iwi93hl76/igZnYhnN9QR9P6zTt4g6O3QYPw/uLa5VucDflDdfH6QMEfG9RM77c/gL6E90ehs+G6mb5eV9NaIAIsH7jogPk
X-Gm-Message-State: AOJu0YzDvr5QC00G6CzW+sE+dAobSJNBIj/FrsvAjfyXHQGjzMpsSHaM
	OrYg08vTRQAF97jvTundCL8Ie0NreJ4V42Bt5aCMBn8TPUoL7p7sMx7S4KPoz8Q=
X-Google-Smtp-Source: AGHT+IG2dSVYwW41YyxFl8L2+72RN1VjLw8RGY7qnXdKzq9R9HlFqY7tKkX2f/OS3beqMjM8CcSpKg==
X-Received: by 2002:a17:906:1f06:b0:a47:3447:865 with SMTP id w6-20020a1709061f0600b00a4734470865mr2682248ejj.19.1711543583858;
        Wed, 27 Mar 2024 05:46:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:46:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:09 +0100
Subject: [PATCH 16/22] net: vmw_vsock: virtio: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-16-0feffab77d99@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=780;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=e4tuqmxOKBa98ztbKNe5ahZH7OqQYiz2j6eOquWzBY0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPnJZccFFcsTC71qi3rWiChFCsDKi/n7NA5S
 9gCWsoQ3kyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT5wAKCRDBN2bmhouD
 11kQD/9Yyyt31/J1DNX/ZeAWMMLbWssZCX4BMGHD8pFfBmo0a13vKCRviFp6P+QgJwr8QJktJP1
 51NJFIL0+XcMjeHCOX9Q1o13AubLMsthey1o+p943NOigCDmCwR0XFjWObwAV0JaixfuBieUU4V
 CzgDjDRlFm/yo6UkAZSVWVOBGq5ZGWHjr/y/dltUYkPxsTrHMqs7txRfPV28UvVq1YaGVuv0g7d
 o6LnBkhn194eI3iC8+KaOWWhpXHTnnQbjDY/pAdhYhOxaqyDJmVoW8CAHf17IE3P8ytRzDJ1vD/
 3F3fig/nhdA4yJNE2cn9np8a89S9Io+YjF6BGG69rfmS2YbN08qBcpe6KxDlAAmSfDd/rS9C1NU
 /2Z3JXJG1gScW5kyE9Z11TEG3fczxFE/mjACgdEKc5wsNJKF3Z1V1C/TODcuJ6rY+AlEFnpBdmm
 W8JHP+EDJeKgCesnUn1lZoav6lpHQmm2aumMdGBZcqun4y4v592cLUBc4kePXBanOo1Gojg2tBm
 1VFCXxS6tGgFaYn97GKxZSsEDRocYb9cGqKZRH+Snw29JoSMDVlCVmoKPBTcV66MO/JYUQM8yDq
 /Zq1Z+DMT8wcIVUrYbA/3nnxn0mcpz97oQjoQILvmJrmOw/mCkIWlSoE+PVGjMWQT+dgwUOyODX
 cQjcPnCVCKpCQJA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_054629_083730_93B4314D 
X-CRM114-Status: GOOD (  11.71  )
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
 net/vmw_vsock/virtio_transport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 1748268e0694..13f42a62b034 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -858,7 +858,6 @@ static struct virtio_driver virtio_vsock_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name = KBUILD_MODNAME,
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.probe = virtio_vsock_probe,
 	.remove = virtio_vsock_remove,

-- 
2.34.1


