Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F86C77B7A
	for <linux-um@archiver.kernel.org>; Sat, 10 Jun 2023 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ADv3z4HZl6jQ8Lf0QtEiX5nPp+TUNvSMmeojJF49A1o=; b=jad1CP23HSJ3H4
	FHpXoDiy5rT4RIT2KORAC0awGpTgo3tuM0l30rzSEZLumBOJZQepUeDPtU15LVELCqozjwr/vqqkO
	D7WlrQzC4UqO9o7dupdm2q63h+0e8Msp8N04Gwps/dZlhV78lFNF53CtoNu2RAl1YBrLU8s3pwYiY
	IGbqcTscnLe9eLF1/RzoBt52HB6nmLaJxfNuMroB2JYqne7xuSXdTJYSEa3W112apzutnBblo3Ngn
	t3sz6PTDBuTzPe3o7negVT+7GfvrkgGihm97fYBt1iIk9bNuXwi+Pxi7t5ybHDMMfvqnxcu63Zv99
	Q7K1vTr63Fjonpss+Cnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufa-00Fcny-0o;
	Sat, 10 Jun 2023 09:14:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufX-00FcmN-2W
	for linux-um@lists.infradead.org;
	Sat, 10 Jun 2023 09:14:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA8761EFC;
	Sat, 10 Jun 2023 09:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76B1C433EF;
	Sat, 10 Jun 2023 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686388438;
	bh=Tv49Wx2718uLurHeG8QRHYpB10Ur4mWH5TKdeB3r3Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pF+3eVrLOKZc36SGrL1YuGnZKfORbIAal/gwsSYOtHaI9IfK13Wo14NYdB68UKFpu
	 fSj80VrG7tqNx//4ahG59mVJ6bfGLIILVLaEznbHcK4X8QIjfQJF7uNdAEhawTgeWv
	 8CmH6X0+5LhKS2jN7al/EfxMYpGg24I0a3FPqENmKQa8Gt7JM69DdI0tXGf0w4t/1b
	 1dbcd+YgeNuk82CPvmpvhQqJNXTNnapi3S4+9Vps2ctxtKGLt2/w0mADYLmhBsyJrb
	 cW6V/IEy8I4yM3wm0kgIhC1h90X/RQ1hNLW7dymzDKpAshOeua2DyTUgO2mVc2OLny
	 Q7Ssaq8h811BA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v8 09/11] modpost: merge two similar section mismatch warnings
Date: Sat, 10 Jun 2023 18:13:18 +0900
Message-Id: <20230610091320.1054554-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
References: <20230610091320.1054554-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_021359_876089_FA10F8B3 
X-CRM114-Status: UNSURE (   9.66  )
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

In case of section mismatch, modpost shows slightly different messages.

For extable section mismatch:

 "%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n"

For the other cases:

 "%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n"

They are similar. Merge them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index decb7d23ef9f..85df3f3ba9ee 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1147,21 +1147,10 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 	sec_mismatch_count++;
 
-	switch (mismatch->mismatch) {
-	case TEXT_TO_ANY_INIT:
-	case DATA_TO_ANY_INIT:
-	case TEXTDATA_TO_ANY_EXIT:
-	case XXXINIT_TO_SOME_INIT:
-	case XXXEXIT_TO_SOME_EXIT:
-	case ANY_INIT_TO_ANY_EXIT:
-	case ANY_EXIT_TO_ANY_INIT:
-		warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
-		     modname, fromsym, fromsec, tosym, tosec);
-		break;
-	case EXTABLE_TO_NON_TEXT:
-		warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n",
-		     modname, fromsec, (long)faddr, tosec, tosym);
+	warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
+	     modname, fromsym, fromsec, tosym, tosec);
 
+	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
 			fatal("The relocation at %s+0x%lx references\n"
 			      "section \"%s\" which is black-listed.\n"
@@ -1181,7 +1170,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 		else
 			error("%s+0x%lx references non-executable section '%s'\n",
 			      fromsec, (long)faddr, tosec);
-		break;
 	}
 }
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
