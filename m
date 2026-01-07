Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99346CF6BE4
	for <linux-um@archiver.kernel.org>; Wed,  7 Jan 2026 06:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YiAi/nkEf5yIibJ5bBTJohuqOXMhyK3qKh1D4xwkuNo=; b=qq/OFKeK6tuCxHUGPkf+k/3B4t
	BslsXXtp5TZ46U9hJu3V7njQ1Q/eK8DERa+7Xj9I/6SKbTld6HxoRepNF/hzZWstiIHzQmM3mftLe
	zgsSefL2d5638po5ywR8GbDZvrBlRHs+BytToKpYD17C/IHm4UA9bcIgEpXHbuPg6MrmEmGIzMg60
	nhruFJbUenw4rf5sb5mV6ugtLkEUKXVnzKAeNQxZMbMU4j2V9Ml2/90pDdODAk56ys+6K+eMzdgll
	/Z0mi7rIJkPptJUYMELQt+AOkqDrouae7KrFDr6TV09DvfrFKRo/YyTlnTjeh5WqudyRSPYsRutq3
	7jX+rVfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNDp-0000000EDap-3o1Q;
	Wed, 07 Jan 2026 06:40:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdNDn-0000000EDaB-1i6J
	for linux-um@lists.infradead.org;
	Wed, 07 Jan 2026 06:40:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C05F343566;
	Wed,  7 Jan 2026 06:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A3FC19422;
	Wed,  7 Jan 2026 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767768041;
	bh=nFhF6S8DstvshptYvGBB1v0YlfOMKI3HcVg72TFbNAk=;
	h=From:To:Cc:Subject:Date:From;
	b=IFkavGbnLt4r7y37c5CpUQz3D6/KoNudpL5WbvJ/o30EysXJsGcr3Vq5dIMMVqqm7
	 SE0e2ITYr/vTOHVf0IkwNUBslWYx4HoA4Sok6yT2oXe1hzddU/C+/N0RzuvBCgeWwE
	 pku7FKz38LOPbebOEkB1MgCOw9TjqNsYVvaVIJ96dSlmGeIiyZsVsSfNLAV89b1NMI
	 vfgWnIwTmDbeOtvO9cqj7B17+9mlywPeD3IJt8snyaL4jlfLgbsWhfPvcKUTtuUUsC
	 gJIYIONpuVNalMqCGCMXFt+UmP7g3u1XXJpPXO1wFniGnfCvvKyhuikCNBcUgpTL7+
	 575lFXNykDr4w==
From: alexs@kernel.org
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	Alex Shi <alexs@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-um@lists.infradead.org
Subject: [PATCH] arch/um: remove unused varible err in remove_files_and_dir()
Date: Wed,  7 Jan 2026 14:40:09 +0800
Message-ID: <20260107064009.15380-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_224043_473737_9D6C2E86 
X-CRM114-Status: UNSURE (   9.65  )
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

From: Alex Shi <alexs@kernel.org>

err is duplicated with errno, and never used. So remove it to fix warnning:
arch/um/os-Linux/umid.c:139:16: warning: variable 'err' set but not used [-Wunused-but-set-variable]
  139 |         int fd, p, n, err;
      |                       ^

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/umid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index eb523ab1e218..6b488be2c545 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -136,7 +136,7 @@ static int remove_files_and_dir(char *dir)
 static inline int is_umdir_used(char *dir)
 {
 	char pid[sizeof("nnnnnnnnn")], *end, *file;
-	int fd, p, n, err;
+	int fd, p, n;
 	size_t filelen = strlen(dir) + sizeof("/pid") + 1;
 
 	file = malloc(filelen);
@@ -155,7 +155,6 @@ static inline int is_umdir_used(char *dir)
 		goto out;
 	}
 
-	err = 0;
 	n = read(fd, pid, sizeof(pid));
 	if (n < 0) {
 		printk(UM_KERN_ERR "is_umdir_used : couldn't read pid file "
-- 
2.43.0


