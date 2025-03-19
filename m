Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64B5C36001
	for <linux-um@archiver.kernel.org>; Wed, 19 Mar 2025 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nX7toramy6u7ciwrrelrEMZ2JgNdPAGjUIRVDI/SBfQ=; b=1mIL3O2+Bzlaqjbmzaf81p20el
	lo/I41j/Se66NzLhZuOV9HfK7ds8FVqzCO7rdLEOSD7chDs9dzec2HurglVD3kHUafL8NUplL3pEZ
	VlZKpbou+E0ReY4+1IGZk0XIvMlFRztM0/l7yXh4UzW2NbPKQT7mquFr2Q+e9GK2MU/50g1mH1ocE
	WF3scmZ5eI/ww1kFPr4E3QiTZb/TOdGSj+PQcx2oZqfzdnq58FRRSNu5s5//seUNILWv8ZxWiXLe/
	xMsLXgarg6qD8OEcTvr1XeQDVYL7XwiryaLs3h53GpWlePOxAPQPyHqsniaPPodzlOEaeNDOv+/kP
	FT9th+sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuttX-000000098VA-1UHl;
	Wed, 19 Mar 2025 13:55:43 +0000
Received: from out0-216.mail.aliyun.com ([140.205.0.216])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuttT-000000098Sv-1WRf
	for linux-um@lists.infradead.org;
	Wed, 19 Mar 2025 13:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742392535; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nX7toramy6u7ciwrrelrEMZ2JgNdPAGjUIRVDI/SBfQ=;
	b=SbEsdDrpEc6JZswUgVbzEOdHUkGzIiGxCNzhtH9oZhHLg8nK76CTcBLo+6Samm7GXKfBilTOtM+JwxUEgZWVkuUrDx3Iy3bhyHeB7HSPNYLL+7Zk+U60fGaOnin6dfTxZvwCM3uu11ajfbSkhJIPTK4mHwXIhHyQl4NKHv0FRrE=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.byXmriX_1742392525 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 21:55:33 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 0/4] um: Make errno multi-thread safe
Date: Wed, 19 Mar 2025 21:55:19 +0800
Message-Id: <20250319135523.97050-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_065539_900992_900ADD99 
X-CRM114-Status: UNSURE (   4.42  )
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

v3:
- Fix os_kill_helper_thread() (reported by Johannes);

v2 (https://lore.kernel.org/all/20250306150747.2926434-1-tiwei.btw@antgroup.com/):
- Do not define the thread handle type as void *;
- Minor tweaks to commit messages, log and comments;

v1:
https://lore.kernel.org/all/20250221084049.1332318-1-tiwei.btw@antgroup.com/

Tiwei Bie (4):
  um: Add pthread-based helper support
  um: ubd: Switch to the pthread-based helper
  um: Switch to the pthread-based helper in sigio workaround
  um: Prohibit the VM_CLONE flag in run_helper_thread()

 arch/um/drivers/ubd.h       |  6 ++--
 arch/um/drivers/ubd_kern.c  | 25 ++++++--------
 arch/um/drivers/ubd_user.c  | 14 ++++----
 arch/um/include/shared/os.h |  5 +++
 arch/um/os-Linux/helper.c   | 67 +++++++++++++++++++++++++++++++++++++
 arch/um/os-Linux/sigio.c    | 44 +++++++++++-------------
 6 files changed, 113 insertions(+), 48 deletions(-)

-- 
2.34.1


