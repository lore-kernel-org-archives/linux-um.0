Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D64FA3757
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8aQ9RylDAas01MNvGKN18LRMuLpHKJUl0/PpqJ20ye0=; b=vRn9E84ep4T0A1jMB4JlYtJcVx
	7pnubXRzzJtXO4j4v5hQ90rUwUZGVveVkuD2lS3ON4+JsNtXgKMQpTLRcRKLBe9VO4b3rymcCFL4V
	avvxYhz7wRKmK93BBYO14SWUmqjCjS8dOiYSp2XMtu93kDVn43k+jQva85VlhqtnPThp/2cMrVbeV
	r/cRP7UI/lgaWSNBeTobAdo3ZOogAOn1zxGvhlBl6hoQMOUOblMI8feb5p+avYlwM2jfiIlOszfHD
	FB3wL43PMGURcMDOGFTVYD14KnTsgw/Xs2hOHJjtRqc9ytGeTrfj40mZV3NowFXbwT4uqRABH57CQ
	FdqBbAAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7BJ-0000000GApx-3K5s;
	Fri, 13 Sep 2024 14:21:53 +0000
Received: from out0-204.mail.aliyun.com ([140.205.0.204])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7BF-0000000GAo1-20Mr
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 14:21:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726237304; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8aQ9RylDAas01MNvGKN18LRMuLpHKJUl0/PpqJ20ye0=;
	b=YOznrP1dgxbIb92L8Z6f/4cslhrp7HSzOCIzx1w0ky0e97d0GlKXykymUhkukQlmlX2ocK3MuqQ5Ab3kozQqEg4ocTza2XlHtfYHLx0H5M6PHII9uk4jAgHol5q1gHt+YwM8r5e8Qu67ClH5uGvmH5zx1e28OTUv/IYQMcXRu/I=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZIP7E6d_1726237298)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 22:21:43 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/3] Minor physmem cleanups/fixes
Date: Fri, 13 Sep 2024 22:21:34 +0800
Message-Id: <20240913142137.248245-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_072150_006986_9B9E24CF 
X-CRM114-Status: UNSURE (   3.21  )
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

Tiwei Bie (3):
  um: Remove the redundant declaration of high_physmem
  um: Remove highmem leftovers
  um: Fix the definition for physmem_size

 arch/um/drivers/virtio_uml.c       |  9 ---------
 arch/um/include/shared/as-layout.h |  3 ++-
 arch/um/include/shared/mem_user.h  |  5 ++---
 arch/um/kernel/mem.c               |  3 ---
 arch/um/kernel/physmem.c           | 32 ++++++++++--------------------
 arch/um/kernel/um_arch.c           | 19 ++++++++----------
 arch/um/os-Linux/main.c            |  5 +----
 7 files changed, 24 insertions(+), 52 deletions(-)

-- 
2.34.1


