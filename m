Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8D7D2446E
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8NmPvcnWT91AsuQqlFB1CSKtDocctu2T6xzr5bt3FQc=; b=yJolp3Y05EcABrj+tlT3TcnNav
	Rh+osUSfE0bDd3FFM/Fdr5s+/oXSDLZFPI+kMh82MeXFE05GvUZznWO8BebTvhIP7DMZWsgBdlLfH
	xfGmfZa5qlFMHAt4T8MbSRLOjWrpb/NmCdHHh5psyo2hbTLIlIo4qVsa9dd8ZyYa3PubK9iDn3cOY
	bREEFgLmVk1rMm2QWt+RDN8KD8kM+hbsF9LqZR8v7EsfAtMgfrWwmV3tWjVt7u5ggfCXy79Mm2iqN
	hdyrEke5gEn/sblVMQpv2thJOzfpREKaUJ1O9rUlzXD0jxsrppT06uEUD9UeYD3HMrXRgFrI0x9NL
	Rvzwxdiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6ti-0000000FCFL-2bTM;
	Fri, 11 Oct 2024 04:05:02 +0000
Received: from out0-196.mail.aliyun.com ([140.205.0.196])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6te-0000000FCBW-27do
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619491; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8NmPvcnWT91AsuQqlFB1CSKtDocctu2T6xzr5bt3FQc=;
	b=K503P8u9Fcb8EbyXugotDrDAq2q09awe2Io1y2ymCcCZDntzpXQvVLjov2bvxOBunysEGP+ihznZsDdRQKyc+QXZjRvljRz/JKMkzzdc8gGYodq4FvxTeEb8nFrt1BNPdAR61YchZbXu6WFfmvavuaoQGC0RdB4RbcuECsGS1h8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33ttH_1728619484)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:50 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/9] um: Some parameter cleanups
Date: Fri, 11 Oct 2024 12:04:32 +0800
Message-Id: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210459_079209_B3328F62 
X-CRM114-Status: UNSURE (   3.07  )
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

Tiwei Bie (9):
  um: Remove UML specific debug parameter
  um: Do not propagate mem parameter to kernel
  um: Do not propagate uml_dir parameter to kernel
  um: Do not propagate dtb parameter to kernel
  um: Do not propagate noreboot parameter to kernel
  hostfs: Do not propagate hostfs parameter to kernel
  um: hostaudio: Do not propagate dsp parameter to kernel
  um: hostaudio: Do not propagate mixer parameter to kernel
  um: Do not propagate initrd parameter to kernel

 arch/um/drivers/hostaudio_kern.c |  2 ++
 arch/um/kernel/dtb.c             |  1 +
 arch/um/kernel/initrd.c          |  1 +
 arch/um/kernel/physmem.c         |  2 ++
 arch/um/kernel/um_arch.c         | 13 -------------
 arch/um/os-Linux/skas/process.c  |  1 +
 arch/um/os-Linux/umid.c          |  2 ++
 fs/hostfs/hostfs_kern.c          |  1 +
 8 files changed, 10 insertions(+), 13 deletions(-)

-- 
2.34.1


