Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D65D690EE
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S0Tlz+fMKxYINJ2n0F7ydnQiOF4/tVTMI3iTP3645Pc=; b=0F1PEfMIyR43Ebc5BSbg2DNUDt
	+0Z1Ps0O4bRetVwMyU3RHkcUsXYNu+/IfRkLAkZHPo6CTlDMRNniYObWMYI+ViBI83KyEoWeni2Le
	fQqZ7gdnTwtZSnIym8PNofx7w4C3jz+poASZ+kvOx9zxvDzkBOpkiMa5wuQw/mbBV0H8kqalwvNHS
	sjbMtsh9bk4oF9Zmd908shND1E1SuZ9/n5beTDfluCl1zY5Pi3lOt7McO/puhNR+IzCvjtfSqm5Xc
	WpzfJGAim2raokAgRY4EYSrxwnR7Z9lN7TMz2izKEYeBvb462jv6+3X0ykK5Ov6bqQ0V3IscKwOIN
	mOMgs/Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGaxJ-0000000F9rV-3b7p;
	Thu, 28 Nov 2024 09:37:01 +0000
Received: from out0-211.mail.aliyun.com ([140.205.0.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwC-0000000F0jI-1KMh
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782705; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=S0Tlz+fMKxYINJ2n0F7ydnQiOF4/tVTMI3iTP3645Pc=;
	b=tbxem2agw0OErIgfoyyU4ApCJx07L2SOHO5IFFfdZAplc32qLYyzwX6xE/z1m/thCFCvj75hDlu8/yIn1iKUp+F0gGSg8cyH4JOSntbJT2BO1uOK5ES0mNDcgAHPmwLhVmQuXD7g3uxqYbPtKgd4749le/Un7jf/V4/3WFswAcA=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WQi_1732782700 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:45 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/9] um: Some minor cleanups
Date: Thu, 28 Nov 2024 16:31:28 +0800
Message-Id: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_003148_851539_3BCD8FA3 
X-CRM114-Status: UNSURE (   2.95  )
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
  um: Mark parse_host_cpu_flags as __init
  um: Mark parse_cache_line as __init
  um: Mark get_top_address as __init
  um: Mark set_stklim as __init
  um: Mark install_fatal_handler as __init
  um: Mark setup_env_path as __init
  um: Remove unused PGD_BOUND macro
  um: Remove unused THREAD_NAME_LEN macro
  um: Remove unused user_context function

 arch/um/kernel/process.c           | 8 --------
 arch/um/kernel/um_arch.c           | 7 ++++---
 arch/um/os-Linux/main.c            | 8 +++-----
 arch/x86/um/shared/sysdep/ptrace.h | 2 --
 4 files changed, 7 insertions(+), 18 deletions(-)

-- 
2.34.1


