Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A01CFD358
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XaH+HrDOONCnVrlgIRr7EJ0vjGugHLu4U4mCg4db9+A=; b=XJ5Wbe/1rY8mnJi3Y9rdAN3YXQ
	F1gDJ1PYLmd5y2hfxHcRXnt1CeIa/M+JTVDzIaC7Vzdf9V6zSPrTk2QyCrgy3YKOHOiV18nfNuWll
	tDZ+fNCGo4QSRJ2iWqAs52smF539cmnRIRlfAsRBE6/8sSBaLEAOiv4xyRVQKwAUP3wP1jKj7ebRD
	+QcasvkFJdDyYobJ4oyK/YCTFxMpLkxqaKSz8sAjtQDQSB6fB85ZgzHghh9w46rtu8qz6/P7Ko8qo
	kigU8qPXa8CsoS+iNbMjt7iz1zA/H0t5xM7IoQXYYz0SRwJVoCHSvrVJ9CjDO32thP29jj1lEK8km
	FbvhR54A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szDrs-0000000G8rb-1CtC;
	Fri, 11 Oct 2024 11:31:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szCop-0000000FxcW-22a9
	for linux-um@bombadil.infradead.org;
	Fri, 11 Oct 2024 10:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=XaH+HrDOONCnVrlgIRr7EJ0vjGugHLu4U4mCg4db9+A=; b=Vk+sjLWhOTnMLLwYcbZdwj/IP6
	YCs/4ftieRfdSIV1G5yfHXd+7dxZNlWhTJVpEL2ImDprQZ3pwhn8ltbD8XvXSw/6S3CAt12Ok27f2
	idTYGBzIgFq++H/U+kSZkzM3L6nn3U0VxZtTmcytaeylD+BLqGeCa56mVES191bfR3QfMjakslah2
	8jMvV9zC1X6kVsIcEfDQoOBiv1GwpVhIzkWtGHSC0wJUzSdQsWt8YpVsT8TNTmAY902MWsJLBhMJP
	pKvsxz0fzdyrR5uh/afw2+sMHLKP/TGBdXtfR7KkuZsrgNyGd+nZzvfKA4J+WfTLqWWtuxGihsK3q
	7oTheWpw==;
Received: from out0-210.mail.aliyun.com ([140.205.0.210])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szCok-00000005qVq-3ySU
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 10:24:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728642245; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XaH+HrDOONCnVrlgIRr7EJ0vjGugHLu4U4mCg4db9+A=;
	b=qANZZEnwUrz0vTRZQqE2YKMa7MaB4ocg6hPZWDVGBIVA29hcJ7SVviBNFzmKMF/ws79ej+gnTXRn/MNLfrjCnD3kw/jVe8pBYYdZZkw/ek6toIMMXkkyP1L3OI4QnRaMH9LpWvXqzZQfE/bEkko/LGUz0sfu9n8q2MRdj30SgBA=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeXjAEj_1728642236 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 18:24:02 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/2] um: Some page bit cleanups
Date: Fri, 11 Oct 2024 18:23:52 +0800
Message-Id: <20241011102354.1682626-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_112420_081865_4C0E1DBB 
X-CRM114-Status: UNSURE (   5.19  )
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

v2:
- Remove the unneeded "if" (suggested by Johannes Berg);
- Collect the "Reviewed-by" from Benjamin Berg;
- Add "um: Rename _PAGE_NEWPAGE to _PAGE_NEEDSYNC" (suggested by Benjamin Berg);
- Add a missing comment update in tlbflush.h;

v1: https://lore.kernel.org/all/20241011053843.1623089-1-tiwei.btw@antgroup.com/

Tiwei Bie (2):
  um: Abandon the _PAGE_NEWPROT bit
  um: Rename _PAGE_NEWPAGE to _PAGE_NEEDSYNC

 arch/um/include/asm/page.h              |  2 +-
 arch/um/include/asm/pgtable-2level.h    |  2 +-
 arch/um/include/asm/pgtable-4level.h    | 14 ++---
 arch/um/include/asm/pgtable.h           | 75 +++++++++----------------
 arch/um/include/asm/tlbflush.h          |  4 +-
 arch/um/include/shared/os.h             |  2 -
 arch/um/include/shared/skas/stub-data.h |  1 -
 arch/um/kernel/skas/stub.c              | 10 ----
 arch/um/kernel/tlb.c                    | 74 +++++++++++-------------
 arch/um/os-Linux/skas/mem.c             | 21 -------
 10 files changed, 68 insertions(+), 137 deletions(-)

-- 
2.34.1


