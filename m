Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C6CC77B7A
	for <linux-um@archiver.kernel.org>; Sat, 10 Jun 2023 09:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZQfkoaWT6dyml7fmwQ1OyKYo3wXDVC35g3L9HmIPt/0=; b=Pad5Ea9dwyaPE4
	SdAOX4AHtOcVXP2mvp6KESxTnK+9PbDkC+XaJD1+4lB7vtNG+cV5RLKiTL5pqrGbS5hz7iHl/00Ja
	PorGQJffJsEsmfGrVMVQFlOCLmH3XfgRYsrNQO9Le7+6uIdew49JxOoclQJi4bN02gSvzXQ07udaO
	v/ouMKda8wumFnMGbqBLxt4Vvg/vxslrHYUX9yvlh2Go6U+xeENoD92KnsONr9ZN8InfjxauOyuCa
	nYDddPKIBglRkkhWjc5FtYPUsseh4Q8U5ipEhOPjx6pLvMbL6q+0TdZhXnF68l7ANSp6qxF07j/rC
	SaGgW3cwfRVUHPy56yaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufd-00Fcpn-0z;
	Sat, 10 Jun 2023 09:14:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufa-00FcoH-2k
	for linux-um@lists.infradead.org;
	Sat, 10 Jun 2023 09:14:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6593D61EFC;
	Sat, 10 Jun 2023 09:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96415C433D2;
	Sat, 10 Jun 2023 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686388441;
	bh=bSgiFXb7ZTjwLTsJwq+dnf6gUoYaRAfD7X61i4sz3V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hv8O9+nc+vktReYdxDm4KB3gyGRtONLjgrcTDTVxRRW85xNwf1HWmKH//k61Z+pDj
	 iP7E6VsZBFfxZuKuqix+YFGkkKA2BE4bjUP4I4H3KsFHNHb4wcm44cZh+/0WGpP288
	 EYpwyZm0D6mPYdWfmOOKjNzzNvJkMCuEC5D4DcbQQGs9aHsgFze0++EH+Zkh8Bi4tJ
	 ulS1aYe4CZYHL5pyHU8wJB441JQveiDXFB3Ocp+8q/p26D9vRFO7IOS9aYziL3ZDG4
	 C7Td6mMkaa0PUF3RncOQZ0HxczaQCffx36G3c1US88x4bFgOitvhmVepVCbeu8v+w2
	 SxvM7fWV3qJvg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v8 10/11] modpost: show offset from symbol for section mismatch warnings
Date: Sat, 10 Jun 2023 18:13:19 +0900
Message-Id: <20230610091320.1054554-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
References: <20230610091320.1054554-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_021402_954804_0E46FC15 
X-CRM114-Status: GOOD (  12.49  )
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
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
