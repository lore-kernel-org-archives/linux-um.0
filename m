Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79996C7EE45
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/ntLNUhV88D7qpTP56sLopEmeKX35U2Lw/3ptQUnT2o=; b=JTzqZgE4wHX7Hp
	UyDrRMuVpxeBWF+KVs4dN5u2BWnezMcBmrYo0YZEmpE5IPcIRk0R8orjkJrfw93uxqVJCHMnHBFOl
	A7yZWRpNyWLOx2kbHan6fY3F8l7LMhXLsltj932A97YvchAo0k1n4shACraKwYwcRSuFZALzadEhO
	Rt5QjUmHyan5/v5dUs83kHxukTlYzY0Z8rKzlCKIkFv28ATcIFKFp/EB16/O6R7mZtAOAeP69sKE5
	RZb0ETJBIN+cJGInyN8k49PkFf2JuFE+MvFKJ5zHpXaL77C+I+HIklTIr1ktj2+CTJijO7Lc87Ley
	3hcFHQ0a4NfB/v1fQucA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZO-009cK1-00;
	Thu, 08 Jun 2023 14:24:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZK-009cGt-2Y
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 14:24:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 539E564E1D;
	Thu,  8 Jun 2023 14:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F59C4339C;
	Thu,  8 Jun 2023 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686234293;
	bh=iWuNSLxO6q6HZETxHyJL7TfXVCdA5aUkY9bgnycApiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tq32c9BM1jBz7n3OZOSVEKvK8CIw2f30Sc5jMXaFZuSj9ggqikMCPqn7VTj54d8A6
	 L7W6koyjYkTKWhvPAWAoB/DocpdbNRQmVt7Fb6QgmxXrdv5SFvwiXuL8uKm4M62mOT
	 ftmyEiKKgMoxx1KrVuv7D09woIaGiWylwqoFWcfa8po12eMQYGGODmx4Jjd6AOO2NB
	 jSFXVIwXS9dQM2AZy4hv9NMyrdZJnf8ZNCUki98sFcLHqDAtcH/nZ5J+a1tDBs1jx9
	 tN8MNU+VTiPXxDdZ/fUbebfIXPo80i69iWmxuCBkpsXXS1BIcMPA9IbSAXXAVIrTsq
	 kp5GlTS6jU7DQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 10/11] modpost: show offset from symbol for section mismatch warnings
Date: Thu,  8 Jun 2023 23:24:27 +0900
Message-Id: <20230608142428.256985-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_072454_870203_6A0B65D4 
X-CRM114-Status: GOOD (  12.91  )
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

Currently, modpost only shows the symbol names and section names, so it
repeats the same message if there are multiple relocations in the same
symbol. It is common the relocation spans across multiple instructions.

It is better to show the offset from the symbol.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 85df3f3ba9ee..40967ed816df 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1147,8 +1147,8 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 	sec_mismatch_count++;
 
-	warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
-	     modname, fromsym, fromsec, tosym, tosec);
+	warn("%s: section mismatch in reference: %s+0x%x (section: %s) -> %s (section: %s)\n",
+	     modname, fromsym, (unsigned int)(faddr - from->st_value), fromsec, tosym, tosec);
 
 	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
