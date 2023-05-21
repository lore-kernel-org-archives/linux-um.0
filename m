Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5D2C77B73
	for <linux-um@archiver.kernel.org>; Sun, 21 May 2023 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2sdh78XZVZwGg7c1OT465hcrGaXBijUuLJ/8CQyFrrc=; b=XxzxxaLP6p9JRl
	evKbuGkXskMcfsyRJ/1SwzuXA4d+EPWCMgQpSMiCcxMBeO68XXDMX1gYrldIDUMeKwbxWHZD1GGD9
	EymOpQ1G9UmexW05JVbD2rBsMnzZ/LoCCJY3tso6JHnh0I0I7wBFeAeHgLAjQYnVIPhftGWs1x387
	MAcHGvREf3Ih6I1iIFHmRdp7/+VKeSHcIxtfqD/d6Bv8TNXyFMMCOAVmMUJalbaj9PERJX3cmSYlg
	IYpgbdub06C9j6niN8r/xXW+mmCOBum758Mu/9VnmZrL5U23t8LgPxtOFLRe2tPfZ3UWT/boSMzXE
	gB9ErAEyYs6sMRoV07NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0pNd-004Znr-0U;
	Sun, 21 May 2023 20:10:13 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0pNZ-004ZmU-2m
	for linux-um@lists.infradead.org;
	Sun, 21 May 2023 20:10:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2E940616B2CC;
	Sun, 21 May 2023 22:09:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CuOYgnqiKr9i; Sun, 21 May 2023 22:09:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CD371616B2E1;
	Sun, 21 May 2023 22:09:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ERJ2vz2BOpEY; Sun, 21 May 2023 22:09:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id A9873616B2CC;
	Sun, 21 May 2023 22:09:57 +0200 (CEST)
Date: Sun, 21 May 2023 22:09:57 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <541536756.9328228.1684699797626.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fix for v6.4-rc3
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: HEGKhk+vvLUmoYlurGDS4VID8LjNRw==
Thread-Topic: UML fix for v6.4-rc3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230521_131010_075738_61DC1F8F 
X-CRM114-Status: UNSURE (   5.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.4-rc3

for you to fetch changes up to 73a23d7710331a530e972903318528b75e5a5f58:

  um: harddog: fix modular build (2023-05-10 00:21:30 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Fix modular build for UML watchdog

----------------------------------------------------------------
Johannes Berg (1):
      um: harddog: fix modular build

 arch/um/drivers/Makefile           | 4 +++-
 arch/um/drivers/harddog.h          | 9 +++++++++
 arch/um/drivers/harddog_kern.c     | 7 +------
 arch/um/drivers/harddog_user.c     | 1 +
 arch/um/drivers/harddog_user_exp.c | 9 +++++++++
 5 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 arch/um/drivers/harddog.h
 create mode 100644 arch/um/drivers/harddog_user_exp.c

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
