Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A0BD1BDC3
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tbP+2lwAJPJ9A1CD88cVCLEMtQehziqPotA3rPigMM0=; b=doXbOUckJaTjJfsR41K8q0Azd7
	0/YJ5X7gm5kBmTq3Tn5ztBWKrz1npYHX5jyHNNtIqR6KyfZi+X/0RHy7ICe7XPHeGf4R3gkCVWbsV
	VymSM2/loSGV2c+5OjE7CX9KgyLdWryzmP7NgNbIdIVS9rT/UJuFyDK/L3/3Hfbw9n4p75gD5mkiY
	MBCTN1B/WEINVhqql4ch+iq2uFGdqRnpCv0I/VAN+L1io7U2KxigKEeC+xQIwSjzjwEqL+QAVWMrf
	ZwCMGHcE0pdvqTtk7wvRxplrXgVeFrfpxJqUMkKMsFry176YA2HczS5bQHI6bT7ZzFmCOvuT4AoXy
	ynU5Zc+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t801g-0000000EOOE-2oJB;
	Mon, 04 Nov 2024 16:34:00 +0000
Received: from out0-212.mail.aliyun.com ([140.205.0.212])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8005-0000000EOFu-0pt8
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 16:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730737934; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tbP+2lwAJPJ9A1CD88cVCLEMtQehziqPotA3rPigMM0=;
	b=DLThjm70bXNnmei/nx8VmS7jO5BZHHPw6fFuaiTCWEFmcc1A7dJa6MZhOw6vvvVl7QYDrdIOGU9NCzTk2Ew5om/n+O5vKnrnVVQS5xZ0iB6xyzuKBtXovW2Mo0qN2MuJ4e2NczOL3UloBXtZSCvXS9FQSE5ZOIeAUZooL6fsTHg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bCj_1730737926 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 00:32:12 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/4] um: Some minor driver fixes
Date: Tue, 05 Nov 2024 00:31:59 +0800
Message-Id: <20241104163203.435515-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_083221_757066_CD1BA64F 
X-CRM114-Status: UNSURE (   5.27  )
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
  um: ubd: Initialize ubd's disk pointer in ubd_add
  um: ubd: Do not use drvdata in release
  um: net: Do not use drvdata in release
  um: vector: Do not use drvdata in release

 arch/um/drivers/net_kern.c    | 2 +-
 arch/um/drivers/ubd_kern.c    | 4 +++-
 arch/um/drivers/vector_kern.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


