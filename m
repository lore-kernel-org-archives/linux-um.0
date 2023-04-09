Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B7FC77B61
	for <linux-um@archiver.kernel.org>; Sun,  9 Apr 2023 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JB9q7AWGxKCNCXYofSqcPnPalR16k8gL18Oy2NQyCHU=; b=VvaBnu+xomlrQ5
	UL6+hTEOfi20a5D5IiNuMLUobi7e0urVHBUrzlYrY4xvFCxDEz45rLtOD/wzY9w9JAqOZxeJciaCV
	zOIbU9i+ixOyrRr3DywZHtEuSwqU/NNuDYoo/vpvlMArwbOmjEkevqL1CaioSYR2zwPDMjBxbjWks
	26T7AE7Ur9ITNkBRUyQJVb92CtAzWf6g/4u3ZaagIin0f8fY7FF9TFpWiirjKFnHgjOgfENWmN/iM
	K8t3+PHLIPMI7eDlgCstildjrgASPmAGdvs8j+h1vdV9aNfJSrpXUp25YsacgF2bYhq4lN9ZcC3XA
	QhKp7xnRsJ1VUusT/9lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plbPk-00E9j9-0c;
	Sun, 09 Apr 2023 20:13:28 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plbPg-00E9iG-35
	for linux-um@lists.infradead.org;
	Sun, 09 Apr 2023 20:13:26 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 667C264551BF;
	Sun,  9 Apr 2023 22:13:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id k9cYmywI7XmE; Sun,  9 Apr 2023 22:13:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 19AA464551CF;
	Sun,  9 Apr 2023 22:13:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eXrkVjwXTyZY; Sun,  9 Apr 2023 22:13:17 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id F031364551BF;
	Sun,  9 Apr 2023 22:13:16 +0200 (CEST)
Date: Sun, 9 Apr 2023 22:13:16 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <272357376.30348.1681071196889.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fix for v6.3-rc7
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: Te4fckDRJcZ/An4JPUiQECJUDET0dg==
Thread-Topic: UML fix for v6.3-rc7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230409_131325_169431_836FC1FC 
X-CRM114-Status: UNSURE (   3.06  )
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

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc7

for you to fetch changes up to a3046a618a284579d1189af8711765f553eed707:

  um: Only disable SSE on clang to work around old GCC bugs (2023-04-04 09:57:05 +0200)

----------------------------------------------------------------
This pull request contains the following bug fix for UML:

- Build regression with older gcc versions

----------------------------------------------------------------
David Gow (1):
      um: Only disable SSE on clang to work around old GCC bugs

 arch/x86/Makefile.um | 5 +++++
 1 file changed, 5 insertions(+)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
