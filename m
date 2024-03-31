Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234A9CD1284
	for <linux-um@archiver.kernel.org>; Sun, 31 Mar 2024 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hXk7oLjUc91eh5OVw4e4b7aL1nWlLHgh1H134S1O7c=; b=cygLwEPSyI0W/lNSD91kBg1mV8
	NIePXCguLgLqH/4MeOEjRmFLFdZWAxzsYa5PPpuRu9UMiO/4pWJ9SOARsT91UF9FQh9U1mu0F1k1k
	QMLmxBx8sONvSmuIKqlxK0A5ZTpFnXyb3S5R/4U2zcQmj/qFy59Ihr0FNxtTzrdzWkO3cNZZm1e83
	BVTUXOSFKxHL/doj0FAZoTMnJ+Bww+sV/meDmvPw2hnoHsLznhLHr9IC8kexhvTn1pBsmdYrBoZZ5
	NbV+pxtPBYpPRNpisKEEXDM3e/dQMI3bwM5x1+p4Pk+ni2zfAYM6G11vi7fWkErLv+Qsz0T8dSGPO
	VQvsVN5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpu-000000054EZ-2pYq;
	Sun, 31 Mar 2024 08:46:42 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpX-0000000541L-1JZq
	for linux-um@lists.infradead.org;
	Sun, 31 Mar 2024 08:46:22 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-34339f01cd2so1605582f8f.2
        for <linux-um@lists.infradead.org>; Sun, 31 Mar 2024 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874778; x=1712479578; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hXk7oLjUc91eh5OVw4e4b7aL1nWlLHgh1H134S1O7c=;
        b=G5D2D7tqCUS4uR7NtNNmab0n0TYNL5Axu1E7Sb4pCz8h3i46fr/bkGsIzk28pXPCOG
         5oVRnqXJnf2sKySkGYYwuXuaE44gebOhTuzGNjlNO/IQhxtTsMil+TyrU3XsQNwEueP7
         Jp/ED+U8E117t4ay3kaLuNO0EHE1I0xuLRPT2DIRpL8uf+yScChLa/MKsW9bIr270nVl
         5sTCnwj7CiVVuqf/QfIV+Lvpc+NGdX9VNTFlLwdreJ69w197HWEm1OSlfb7D3oSsS6No
         gnr+Gd9pvYHQ2ckD9yeYSt2XOlQZsAslzXA/vPo+rb9ACRgLUcP8ke+Yde6tCtX2rlN4
         33cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874778; x=1712479578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hXk7oLjUc91eh5OVw4e4b7aL1nWlLHgh1H134S1O7c=;
        b=tolpK5puPWqPf+xEGXtBOJIAXSsh5v/Zt+/X/tGnsIDKiQm7fjpTsE1IVUOk+DIhe7
         YlSSbm9YeoCJScBY/5oJNuGLi+t3kO/5IglgVdGdJN68NXavDR0N/iZg7H5NKJqyeW0s
         odE8nak2lN+7bVIVMgvXOg8Guim9mhWtt/GED1ti/kVm0P4NRjJhm9nHYQY4RNFHMslb
         EXdTDNjNatDUvkDwVRv55s+9GPf5Kfkiw9iDdQMJJ+tQ9x0/ELzZdbsHAPfZGle3kfK5
         zG4Voigx6HYI/S9gzfvRDLEn/O9MuxkPUSf7oo2ra81yw0MaSlr0gxe00t0MlaKKfQ2X
         pY+w==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4d+Y/Mhr3CSMdE4IJZ+U9EyYaHtxSnFbarolKt87uBOxgP7RxRnCJByQyyFZoXb++8KrwRq2HYtEtKk2m6vePnozUq8PsF8kveXT
X-Gm-Message-State: AOJu0YwvgaYrT1EHysSag2gszVh+CUFCajQ9ff33SHzMjwQlzgViYlNc
	xz66GwGyMA3cLisFVd2HJWCYySowIdanrVh+m4cxdbZLUZf5+OBCWRblSAFDTWo=
X-Google-Smtp-Source: AGHT+IE9V06PTg08uEopkbJ04c8a6uBtTIR9CWlJErFVOFfKXjGGPjxREmzT7kuqo4+GTJVlpjvjsw==
X-Received: by 2002:adf:f047:0:b0:341:6aa6:6985 with SMTP id t7-20020adff047000000b003416aa66985mr3528623wro.65.1711874778033;
        Sun, 31 Mar 2024 01:46:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:46:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:11 +0200
Subject: [PATCH v2 24/25] fuse: virtio: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-24-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=hlijIWO+f0zfriC947LO/aEcL8ON1TzqcVm2ZicUaAk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJlYYK2x+iETQecMy7Rd9QRwtIrxd4eiqNrm
 72pDjbyZaqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiZQAKCRDBN2bmhouD
 11rjD/0cadPlIIMhVNJE0VpSZbFTo9cnkSbv8WntJY4r/RXUxciZpq1kgQpJQ9i4QemC4iyt+5+
 UMW1gvijdTi9yJ391NDmdgM+mW5HAt5PojCQF7ajI8NcBQErmPtAxiAKHKSitVjAQ5T+R949fCO
 WW3LvVd/dbOdg1ELAHEvszxPUP6AtzmhLXLqUfEECRlCGEZzjzVFRNRDzoEswt178gIcpJcQrlw
 42dtBFHGC/PZQOkZaFKEoCRwPlq8ibhSdLJXDNYo7DhM1R2df+SY+i6XN48GtoNOCntAdvfpCwJ
 w9Mt+lgJROd7/JfyKPN7Wltw9dZARpYmfLM0XI2qi7LmU/oiTVDxeuLHG4CI7DEaNQUyDfuonqU
 ZW2qYg0Msf8VoHhrpeXxZBJjZ1d+9yHG7oyCFk5GklettqztszcrgSfqyQQKst0Djkmd0bSZ/nl
 Hh/hAfe2N3uSUHqXNIgUjyyrwUKYZROG0rFw+okSrOiPWyIksgGaXryOYbMhS3cNjDCl0etGLak
 gx8Uk/t3EN108nl/DHdHECbMFInLSVSA55M78H1Uf+qgRMorxUy5zpjE8xZb78cwrArF5t5rBXj
 NtkILkEJ7o1bBSg80wag6Qg6g8NuQ1d6UrqUdnXVNfaO1AnxyLRjmuro+C5xJ/feOaQhCdVGXAC
 ltJoH3HUczNLi3g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240331_014619_761187_1A8BA543 
X-CRM114-Status: GOOD (  12.78  )
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
 fs/fuse/virtio_fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 322af827a232..ca7b64f9c3c7 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1023,7 +1023,6 @@ static const unsigned int feature_table[] = {};
 
 static struct virtio_driver virtio_fs_driver = {
 	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.feature_table		= feature_table,
 	.feature_table_size	= ARRAY_SIZE(feature_table),

-- 
2.34.1


