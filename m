Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB24CD128E
	for <linux-um@archiver.kernel.org>; Sun, 31 Mar 2024 08:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eyRMm/wBFZCWNsLJMI0b6MGwMk/UDF0WMd3K76wQcuc=; b=E6nt3Vty2spmfjqivLf+XBdReQ
	IKcd8GWS6KBv1SyZiHixuQ2uAdGNyXcdD7vcNKhPoUux13pvHPocRy8FEp4IWprvVETgiHxB6IEUZ
	At1zQFtBrjoBZbkutv9Hrs1xpJNItDh1IbVsY7JYfZpBMakm7QPJrOXa746yUq4sjRCSsmb8i5rcd
	chfO0hQBumW9j65cYW9ipni91ehRH7dx7PGKZxkLKKpbG5R+xro93WMnuZHng84erGOs2HLJg4gpQ
	6tPb5VmGxm9E02WW5PFiIovRzYNkA9WHYcqX2KFvarvJL22TKt2k5mCQBOR9uvD6FJKsdcxnPl4M6
	DsdVWVSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqoh-000000053S9-383D;
	Sun, 31 Mar 2024 08:45:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqoX-000000053L4-2yM4
	for linux-um@bombadil.infradead.org;
	Sun, 31 Mar 2024 08:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=eyRMm/wBFZCWNsLJMI0b6MGwMk/UDF0WMd3K76wQcuc=; b=IU9E0FssaPBk4FR8pO4ylH5c8E
	TpaxlcXcqJ1sfxdQ7cVtprI+4ztJvCjK7BGAIlRcaTQhpJtFIi0ziD0YE9tfdBHD+sHFEv3deSYim
	Qoqjy/LqFxVVdvALgD5jES8f0UelFUP19hdgEkW5Tg44a5KSSPYXTnVfbEoAw9FEJLlHEsjnGFpou
	FU3nuEwMRSZ3WvoyxJ0sQPwUEgeohdt8Do/WvvLorQSxgN2RwB4XCcqqIlaudlkvtY0AG24RGRzJf
	rFyol0Z9nAAXqw3vdgo4xNb7OUG4WZkQbo75glxvWBzDJCzrYSoNpEu1dJ/apnUQgBEklzQOwOWH3
	5aG1FI5A==;
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqoH-00000002SFV-3GFQ
	for linux-um@lists.infradead.org;
	Sun, 31 Mar 2024 08:45:14 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-415612da35bso1196175e9.3
        for <linux-um@lists.infradead.org>; Sun, 31 Mar 2024 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874695; x=1712479495; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyRMm/wBFZCWNsLJMI0b6MGwMk/UDF0WMd3K76wQcuc=;
        b=GsIT8d25RAkpPCL77Aw8Ai+qKt8W00sA2M8pakQnl5iYpFmk8I0ZaCkfrLYxR3jbjI
         uDLZbMMFJVjC9aJ0wO0qRkLXZb8txMhmXd2G9XjiaU3bcG7akMQ+GT3uVTpXUltDDXNq
         q+xFSsR0AGdJDPMWmMHBSLwgC9RdAhP9sjr+GkJ5hE3EKq87zaCvO+OyLvYVfTV3pzZv
         2oEt0V4OpXEjQFHGRV6xBG5iOqJkCz4CICQOmC7RthICxjVznfmOdaQSIMGTeuKRdQ4E
         KmN0VDE69qFTkfNRg9aDAgn7OFqunXrSoBjgZyklJHGXl1mMaYuTub3D4UyxEA5rWzYJ
         3etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874695; x=1712479495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyRMm/wBFZCWNsLJMI0b6MGwMk/UDF0WMd3K76wQcuc=;
        b=PlB/4Fr9DW5zKjfSOMoofS17fCh1sSRYiK/VuZsYRkjQ37ldlw+SBvmhoZdio5oStu
         LCxZ941v17V3tmLQTXhUDxLD2EDELfFz6nhjfbDmBpDeWY2ek9TzaYHXz3bSIVzz/fJx
         vCj/BtefyCrj2pMl/8JhD5cgq/yQSZpHNeT4kwlkDQyr5W95653utgr5kfk0ZOQcpSvZ
         KCVLeGvhkUvpG7jUPSoojEh5bUmbkOSi5T2AcdvIAH5BlWHdSfqRJBCS1ZEtNFUfjpRT
         wCg5cFjYp3R7esGM9s3g9YMyaM5WojQLfkh5n6ubbkes1qcj8CVzCK8sVSeyfB+jMHTZ
         cARQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ5GvRFAZItyqHzE0k12R+acUxMUeGrVIstOTKVfKBri5orvPvFBQpu5ED8NA6Zlu4fJYIJ/CgR/ACbDM9WK+st64nW+zQDE7R9qqS
X-Gm-Message-State: AOJu0YzQgfd0vIATyh+XAtG99XCz3kPwXcJone8pOX7zaTSBPx5ZM8Uu
	Ts1degW1Y+UTouxp+cePyBk1voKR8MSUWUZIMlEyWi1LIGTa2jMgzXbNuLw2NlU=
X-Google-Smtp-Source: AGHT+IGACNL4bJrYwx0UztgLHkocO7cRlSfm5YEfvnab8zjJOAWgroG8Si4+SOgexI9qnY5FfsuBdg==
X-Received: by 2002:a05:600c:21cf:b0:414:767e:6e76 with SMTP id x15-20020a05600c21cf00b00414767e6e76mr4893865wmj.21.1711874695710;
        Sun, 31 Mar 2024 01:44:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:44:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:43:53 +0200
Subject: [PATCH v2 06/25] virtio_blk: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-6-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=774;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KrWaLvXjNRGS2R/7/B1+JUwLcklixu9aLwMl5ahCx2Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJVZjvxVp+IeLHj+IFo/zsUA020KvJ6wRVqy
 okF0tos1aGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiVQAKCRDBN2bmhouD
 11NOD/9bfs5h1GsEf7ulvr0p0JOFXciYxQWCXWYoR6UZ5Y1NWaTZV2G5P+aRmwsBC9m7f3RteEu
 LFFTsbIs4xPoFsUZnvq0EPN1ZoJlw5Lu+lCdhTOWE+/n9qRRnjiZMiZkf6co1scBlDKZZZiJJc/
 8aitfQ7rvN0kKKEfpD46vPy9sil2Qb4SdeCT337bpfJfX5KeMGCMIFRqr5Yqqrq2n0CTb9fzkCV
 ClJTNckXdrd67GbNc8Eovl9ib2M+9Hd3VGxLnGTXBulerZZAe+RlV4xNujaXSHOMLNqi3tk75fI
 cSCKEmU1uzPZNa7imkkSDGf/oitANw7AzhWH55TsJksAuuIgOjcmsVkaBPh5QeLE9nNKFP3aFoz
 2i/DXpiWy4/MDqswsZTJSqh1cGHThiakPD1e6g7P3qXi4taSDEmH1nK1jKKyYu2IAGLD7NY1AGN
 7TA1bOH1Gf/5fQ25e7ABSm2f4BP39YDYMYUKHwX/mttLEcNek8vxjL0VWAGUH9e9yDj+Ava7FeR
 3AWJYYIIDGfAX6P8ZCKw+DcuRhM0u/wfyRBDiKyDjLjKIe8EWDds2o4DbcKo4BHT4/K7a5Odwah
 0Y3ytFsh4TleFSZWzYanuxhyDxjatNAksDPlUlCiBH2EpNQ0CpjJ8WqXdLJbXEpkp8i+W9PhI1t
 z5LzaNGlz2he1Pw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240331_094505_357301_C13F2845 
X-CRM114-Status: GOOD (  12.30  )
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
 drivers/block/virtio_blk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42dea7601d87..46bdbad1ab48 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1658,7 +1658,6 @@ static struct virtio_driver virtio_blk = {
 	.feature_table_legacy		= features_legacy,
 	.feature_table_size_legacy	= ARRAY_SIZE(features_legacy),
 	.driver.name			= KBUILD_MODNAME,
-	.driver.owner			= THIS_MODULE,
 	.id_table			= id_table,
 	.probe				= virtblk_probe,
 	.remove				= virtblk_remove,

-- 
2.34.1


