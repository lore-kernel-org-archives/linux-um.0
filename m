Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED774D2ED0F
	for <linux-um@archiver.kernel.org>; Tue, 20 Jan 2026 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OFhodcvRDH7q+MwCRWTVNOvZ9XPVdXXYbq7DeVi+2lE=; b=2g6uzwuu28PGQkF3SqrLesjlvc
	HUnuLfGbGcvjIP6Z6RrMXABLWnGHtSt+Bo3iSJlUWn0TuuD8KQd0Gc/z58K6u3ASBMM9k8kabxxxI
	YbFSpPvd8xVvxk5WrL5t5MZ0xi9aE5VAA39nBEKSQR5bg2Kl68GZTuO5BR3MMTCbKdxWlpQi3zRhQ
	+lSNKY8y1N6jTTLECx0wZzzyYoP0E9PREKiUCm6GrS+sxtUvcdVsE/Suuwh88MmFEMwFwYZ9i4HzO
	0Q+uojHjsSO5KfAq7Id8sb3JlGsBZEvbj7npIgRC6PEqr8HsjqfI0opqHE8K4YtUARIg6mONXzOb5
	pwxSYWsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi9wY-00000003iTg-2eEy;
	Tue, 20 Jan 2026 11:30:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi9wX-00000003iTK-1PNz
	for linux-um@bombadil.infradead.org;
	Tue, 20 Jan 2026 11:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OFhodcvRDH7q+MwCRWTVNOvZ9XPVdXXYbq7DeVi+2lE=; b=SOzMr+1VyHdoQrD9lujGLLqlH5
	60ssjjMKXypiB8k22lVDe0DuuiJOoyxh7UuBFtAFB4136PAEUoqOo2HS4DyrkhW9XQ/9VQLjOSpSF
	qendmcVoOs7Kn9+Kb7BAtQU3318sr7tiAm6IAnefLHG/LJgSmCt1J72khW3mnc4IT8RU/1NrV2CzL
	PyOENq/fIBzkYmTe1EzUG00g7WDsJYDqewR80TfZ3E86v6zHi79f+LWV8LVNRfpiyLOOlzuAB5vl1
	/txunw5N1f3tTehIdqCtQAu/y2a1qMq8wb5dvMndmJO6EtPh/UhfdpN5vfHeA8/VQIxLTc3eb/mo2
	MxARbFhg==;
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi9wU-0000000Duzl-23y3
	for linux-um@lists.infradead.org;
	Tue, 20 Jan 2026 11:30:40 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso3189316a91.3
        for <linux-um@lists.infradead.org>; Tue, 20 Jan 2026 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768908636; x=1769513436; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFhodcvRDH7q+MwCRWTVNOvZ9XPVdXXYbq7DeVi+2lE=;
        b=Z4CltRo65RReG6V2A5xvYTXdi8QVQkkG/6r9gXTCqYyTovGIrApy1rLNw/rtNq1IM/
         8IcocsxR97ebj9Z2sEWKzLh/0o3agEsVKAZOznHAU9gX5hEIbQz2xQzoN6LfHxemUyTO
         d1X7S18OXxtwyZMvHY+1ZF23Wi/Y0V3GrajGfoeyvlgcAlFPyGA03qZ/PinqaVJnxiVY
         GxAKVuu43xXGXCVDsQxkSqtLo0Xy1BZwQNYPnZTYSvxix5+qncWg+7CiiI3CJBlgMdib
         bqQT+iTVh+d0RzCwwLlZut/bvs/191OT6gyd5A+79/j8ufF6TBhKxpecpc2AdiNhjV4q
         P0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768908636; x=1769513436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFhodcvRDH7q+MwCRWTVNOvZ9XPVdXXYbq7DeVi+2lE=;
        b=SVoA8bAe5K4BP4NSp/eHrah/cOQDHJSwYr2aH1sp2XUwi9sRaKKWOvT+wvPgYkAOWU
         Wq0TTjWZZ1ZuiIL2/3/xUSg3mT22apGsCulVcoX4PF1Cc4rIOWffx42WMEJyIX/nN/1k
         8ssEfXNryBi4rpkRv4IdgD24zQElgrJCsNOPVk5HoGFFnZDux+fY3YRnfU8U6+PmbA7d
         DIxOLp7zP8/dmdKk2fDqZO9KAtgno2Q1XqeFBneDS18VY7puEm1KjRmlo9XVRobXm+sk
         Ftpu+qu2HhSP/TzDv3ChMtloJnZ3xnwPdR9S21Q7ZJJ69/fyK4P8c2ZTwK9qJvu8zuMD
         EPaQ==
X-Gm-Message-State: AOJu0YzkBSqj7g5R2gHcSs6ZCgpb3UBNwBlkUIFaNPQUk7g5jMoaDVo1
	ggyQssPUiiVvuX9mhgD7TddUdklDkpORnvJ7u47fG/RRvL5fMCqi5I6I
X-Gm-Gg: AZuq6aIEs9Or94KcuFRw+bqRqzO8EqFo9iXTb8eCweGJM1wAHScm/4xepTTSomW91Go
	nasCEM9Qrbig6l1FGi33hrXJFp+7kH24GKUz1LJ+EXmSaZEnz2+wF82wFJs3VwxljNcwoc8+2Hj
	efcBjCG3Eu+RknfKv0//yYxb5jz31XdZTZe8EfzAMQa10NgLYudld+KowlvUi9iMxvutMpH6Jhd
	maRURhP4FHN9+MrK350euQEzCzQ++XHVih6kp9hpU6UdQ0Il66TY28Vb8opWRdSv7IsguwV3kj+
	0f4lzyFnhNLCCdLYPTI0daJ/aA9fpUMgCOlvOx8WS8KMh8oRXAu9KNQuVBJR7amBC5ihC7U/EZZ
	iAIaoVRY2oxNpn58faNO1LzWu3mTqbRo5Ve2P74fHTFQnUSQUUu6LOKHs27pksTXQ6R37/nl9uR
	PYkWNL680REPJEu6KvU6Fuutt2qINLgf+X44XLIeaT1NZIvuocediJrA==
X-Received: by 2002:a17:90b:3f44:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-352c3e4a4c3mr1362569a91.10.1768908636143;
        Tue, 20 Jan 2026 03:30:36 -0800 (PST)
Received: from nwang-tw.host.com ([124.127.58.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352d57a56f2sm1045900a91.15.2026.01.20.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:30:35 -0800 (PST)
From: iamhswang@gmail.com
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	akpm@linux-foundation.org,
	dave.hansen@linux.intel.com,
	tiwei.btw@antgroup.com,
	rppt@kernel.org,
	kevin.brodsky@arm.com,
	snovitoll@gmail.com,
	linux@weissschuh.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iamhswang@gmail.com
Subject: [PATCH 2/2] um: use uml_kmalloc_array() instead of uml_malloc()
Date: Tue, 20 Jan 2026 19:28:55 +0800
Message-ID: <20260120112938.463596-2-iamhswang@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120112938.463596-1-iamhswang@gmail.com>
References: <20260120112938.463596-1-iamhswang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_113038_565542_A6533C1C 
X-CRM114-Status: GOOD (  11.30  )
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

From: Haisu Wang <iamhswang@gmail.com>

Replace uml_kmalloc() with uml_kmalloc_array() for multiplication.

Signed-off-by: Haisu Wang <wanghs18@chinatelecom.cn>
---
 arch/um/drivers/vector_user.c | 4 ++--
 arch/um/drivers/vfio_user.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 2ea67e6fd067..adc4280691cf 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -868,8 +868,8 @@ void *uml_vector_default_bpf(const void *mac)
 	} else {
 		return NULL;
 	}
-	bpf = uml_kmalloc(
-		sizeof(struct sock_filter) * DEFAULT_BPF_LEN, UM_GFP_KERNEL);
+	bpf = uml_kmalloc_array(DEFAULT_BPF_LEN, sizeof(struct sock_filter),
+			UM_GFP_KERNEL);
 	if (bpf) {
 		bpf_prog->filter = bpf;
 		/* ld	[8] */
diff --git a/arch/um/drivers/vfio_user.c b/arch/um/drivers/vfio_user.c
index 6a45d8e14582..4ad8c8c59e9d 100644
--- a/arch/um/drivers/vfio_user.c
+++ b/arch/um/drivers/vfio_user.c
@@ -194,7 +194,7 @@ int uml_vfio_user_setup_device(struct uml_vfio_user_device *dev,
 	if (dev->num_regions > VFIO_PCI_CONFIG_REGION_INDEX + 1)
 		dev->num_regions = VFIO_PCI_CONFIG_REGION_INDEX + 1;
 
-	dev->region = uml_kmalloc(sizeof(*dev->region) * dev->num_regions,
+	dev->region = uml_kmalloc_array(dev->num_regions, sizeof(*dev->region),
 				  UM_GFP_KERNEL);
 	if (!dev->region) {
 		err = -ENOMEM;
@@ -223,7 +223,7 @@ int uml_vfio_user_setup_device(struct uml_vfio_user_device *dev,
 
 	dev->irq_count = irq_info.count;
 
-	dev->irqfd = uml_kmalloc(sizeof(int) * dev->irq_count, UM_GFP_KERNEL);
+	dev->irqfd = uml_kmalloc_array(dev->irq_count, sizeof(int), UM_GFP_KERNEL);
 	if (!dev->irqfd) {
 		err = -ENOMEM;
 		goto free_region;
-- 
2.52.0


