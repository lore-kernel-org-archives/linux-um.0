Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886E2C41513
	for <linux-um@archiver.kernel.org>; Mon, 27 May 2024 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aOG5sDL4+n/6vB0Gs1mPrD/Q3yrLIbZZVjloyGDfu8Q=; b=Qxd/5SIIg219Tpyildexuojk8n
	5iKQEqdOIH4ltC6L5A/MkNUGnx+i0RPURvwxJauudaZ1o/vTnAZWoe69z4TJdqemEuvozp16WyyXG
	ZePZ/xH5LsjVxtOjBdcq5j/qyLyjQmIM6F8YxNsuEEBa007KxXepXf2qS3n1X5yiiaReBnjk/VClE
	FxtPeaVmBEvw9I7ExgKE3WFWCyQiGHHy6c8FgFwS76V5HN8WJHn53qAJFuKnxOlPxXHg4hBpiSZgB
	NttOY9HB7dsB/Rht8EBMtGA3zkYFyMS65dJsNX4Vy17cMBVSEpKb9yi/iZCg38wLXVRW8pv0jMGiS
	4AhlJsZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaaq-0000000F9Lc-2Unv;
	Mon, 27 May 2024 13:40:52 +0000
Received: from out0-222.mail.aliyun.com ([140.205.0.222])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaal-0000000F9Hs-1MaR
	for linux-um@lists.infradead.org;
	Mon, 27 May 2024 13:40:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716817239; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aOG5sDL4+n/6vB0Gs1mPrD/Q3yrLIbZZVjloyGDfu8Q=;
	b=x+7pBqbAmNQ34e9TfOjdv8156su9pbJIiL8c8Ysd8uRGYHvkJq3aO88ve9Ff+FiG7CSfl7czdksgHSeISX4SkSkRlPPyUNOt9qPQg+WpNosFsmNZa62CG0u+z8d76ZtN9oOlQIKuRqFiNQzBGW14ZPYnZNBxo83yuuXZF0RNyw4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037135125;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XofsrFK_1716817231;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XofsrFK_1716817231)
          by smtp.aliyun-inc.com;
          Mon, 27 May 2024 21:40:37 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/2] um: Remove some dead code
Date: Mon, 27 May 2024 21:40:22 +0800
Message-Id: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_064047_714753_69FADB75 
X-CRM114-Status: UNSURE (   2.96  )
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

Tiwei Bie (2):
  um: Remove unused ncpus variable
  um: Remove /proc/sysemu support code

 arch/um/include/shared/kern_util.h |  1 -
 arch/um/kernel/process.c           | 67 ------------------------------
 arch/um/kernel/um_arch.c           |  3 --
 3 files changed, 71 deletions(-)

-- 
2.34.1


