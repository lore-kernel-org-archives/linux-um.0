Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F39C021B7
	for <linux-um@archiver.kernel.org>; Fri, 21 Feb 2025 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1bnc4Lqe/PXXJpfGMaiHLTchsfpM5R6a9rjAe78ZB6A=; b=VwHGK6JtCwol2t+aQoMgJNJ92j
	lCI0HhfIykMIMGRsuxD7EreDLn02Wa3mKVOSTn+5qxHVj+fw9v0DiaJPejgGRCs74BEIV17JMIbod
	miKe6pN9MGR5j3usGNQaQF687Az+a2j906jUVOhpX+ZMndgFwnItRhSrw1lx29cGjGBeL1ORkjMDy
	NTQewQH1UgGnOZJCgNL1BYPghbbYRTw1Wau7AiHNLNKZpWsMJb6Of8yg1mpeajeviDU9CIoX8gPTH
	1uaU+Jrky8LfD/Vtv9nnbw0VhsAzCTVDhWmLNP+Xk/iSvU1tgTfqIhU2nD2pUWAgcH0CkzGK0oaK6
	LLkXkjig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOap-00000004kZF-0igU;
	Fri, 21 Feb 2025 08:41:07 +0000
Received: from out0-197.mail.aliyun.com ([140.205.0.197])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOan-00000004kWu-0M3h
	for linux-um@lists.infradead.org;
	Fri, 21 Feb 2025 08:41:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1740127262; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1bnc4Lqe/PXXJpfGMaiHLTchsfpM5R6a9rjAe78ZB6A=;
	b=mH3JPFqSRut/9dYCXP0cZb3dQB0CouEgOyS8p/6DV+uhtw8OB/ck/DOMNIuFzG1J67lMOH1meTXZCwZ5Mj+lrTb8Z1FrjylDuHU/NM44qocCdz1reHMBz+yK9Yk4iCp4IAXlYMjPXPjzPJCcHoBKGlRT+hJuRMAWpq0WZDeL75A=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bYJdX3S_1740127252 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 16:40:57 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/4] um: Make errno multi-thread safe
Date: Fri, 21 Feb 2025 16:40:45 +0800
Message-Id: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_004105_322180_E5D7BF6F 
X-CRM114-Status: UNSURE (   3.60  )
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

Tiwei Bie (4):
  um: Add the pthread-based helper support
  um: ubd: Switch to the pthread-based helper
  um: Switch to the pthread-based helper in sigio workaround
  um: Prohibit the VM_CLONE flag in run_helper_thread()

 arch/um/drivers/ubd.h       |  4 +--
 arch/um/drivers/ubd_kern.c  | 25 +++++++--------
 arch/um/drivers/ubd_user.c  | 13 ++++----
 arch/um/include/shared/os.h |  3 ++
 arch/um/os-Linux/helper.c   | 64 +++++++++++++++++++++++++++++++++++++
 arch/um/os-Linux/sigio.c    | 44 +++++++++++--------------
 6 files changed, 105 insertions(+), 48 deletions(-)

-- 
2.34.1


