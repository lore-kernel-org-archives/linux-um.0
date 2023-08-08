Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B604C41513
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fzKrFEFP/anmQRF7ybtzGUhGG3yI1CucfG09lohMnjk=; b=VEi
	72YpAKPQUyPXIxDI51d69AZ8jyC7OodlOQ595tMfCrPuI23Kvh+Zf2sIJ+bCEHUJUM9F+4un187Wi
	0mOsZDtoNrelRHVvcTJd227kGAqzFsJNO47RtHTRiYnd68GOUv/C0TqEK9Y7defGBuO4Y+CVxBVuG
	UjeHVVnYu4hME9uOWoR+LBkAEauNNW5a7I73XH+zUgXAq4tbdMhZx91+jdOXoD4Td+vvsRd1eRfjZ
	+2cGsPjPni7muwOXx6L2AvPqHRE2LuFKBbFMtLKEy3GUmFgSlIwg8w8XHCV5ITT1SVovKemnOEWDm
	UhP8UVj2xg9H5ntICbYPNHI6Z3UVQQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQQE-0037LL-2V;
	Tue, 08 Aug 2023 17:23:06 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQQC-0037Jx-1D
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 17:23:05 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5847479b559so76856667b3.1
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515383; x=1692120183;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tZSxNnusQnqM7bOFqjAX37IzOmPldIdsi1KW1Hkrx20=;
        b=gLEuK3W/Hv+DbvezYqwcXKPPzm0v+UaZRRvoEQwSNCZDV3EOZcOnN4vlXwJeDpnvXh
         s8oltOqG0CscYCPYoamYi+tb35p9Y6u2Kr00jR/Qf2uQ3j1JP2+GtuwaKe/dAbnmBXl7
         +67m1XYNQdu+B9KXTR/x4BD8Z0LiSBJe4ICocI4Qzs4dL0f+D2NbGdQJaWq+oaJOGMx5
         K1TvJxWgduvpTtU+Oh4ZopmEZHv9UjDYZQgsK7ODLEa2EPO7WwI9dIdW0Tj0VIWmXFff
         yTUuKcZlKvBCza9ZbLOZH7gHwVtE28WLEiNRraKxFJ3wOzsqt2/11jOCLGsZ+F5t9hA1
         xz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515383; x=1692120183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZSxNnusQnqM7bOFqjAX37IzOmPldIdsi1KW1Hkrx20=;
        b=SZaYsatP1IuA+ywVyNlSDV7fQKRlpe20lIZcEZ97N1nkBxTYxQmmLYk8eP+vNHeqmB
         ELJHzZ5skzy9ficys4DznExsk4k4mijOIW3iC/hsiJcLjsWVrovdGMzWlpxQeg83JcRe
         ncz6KNNVArBV/YyPITNXtE2kHxchGRlQt3YA9JJCrCZLRdAx3NEolWsF51O9riGGP45N
         z2yIZONAnCY601Ts1ZaYogHKTZSC0NuXFhGG/uau2wYuApJqp8Nd1Rb/VAXbKnS9h0VK
         dak880qEFxBK1wyIZjkeZd8Wh7/e9sql5dtC67TfYil1o6i4FsEBlYlcvvyXhonnHzBt
         95gw==
X-Gm-Message-State: AOJu0YwIfYwWYUBCeCVYTPvUw829Os2KYXfvrgtv4qYq8yIeRrPs3Z+Z
	Q9dddTEcxqDrCdflOiDHp3flBlEb1yO2dkqOwTk=
X-Google-Smtp-Source: AGHT+IGhKIYXbGqQFa3PNzDwZFStQZnz3B4JCOhZKzQz+zmk0c/LSgrF/1imHAfTp1q4woPyqeiNcjqwpLiSdZcROp8=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
 (user=ndesaulniers job=sendgmr) by 2002:a81:4114:0:b0:565:9bee:22e0 with SMTP
 id o20-20020a814114000000b005659bee22e0mr4887ywa.0.1691515382897; Tue, 08 Aug
 2023 10:23:02 -0700 (PDT)
Date: Tue, 08 Aug 2023 10:22:59 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPJ50mQC/3XMQQrCMBCF4auUWRtJUqHFlfeQImkzSQZsR5I2K
 CV3N3bv8n/wvh0SRsIE12aHiJkS8VJDnxqYglk8CrK1QUvdyl72YpsfgdNqNksstLKdlp1Fgxb q5RXR0fvg7kPtQGnl+Dn0rH7rHygroURrL9KNqNyo8OaZ/RPPE88wlFK+RFUcXqkAAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691515379; l=1570;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=dbN32OaDa6wdBfpJqNjWVde/ve993rqcumzB7h2wQwI=; b=R1babvoEEcd3tWtPK5ZsMtf8Mc8xS6lV6vxwZrg5QTVql2nwCMa16rXoANn9viYqoiuKT+/3y
 BOzTAe2GtTnB9GLZpkUnwwSd3r/WXgVvAvyOoYa0yBWCeDGg7+FvhPL
X-Mailer: b4 0.12.3
Message-ID: <20230808-um_hostaudio-v2-1-000b4e5e3c35@google.com>
Subject: [PATCH v2] uml: audio: fix -Wmissing-variable-declarations
From: Nick Desaulniers <ndesaulniers@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_102304_414812_3F5E2C5E 
X-CRM114-Status: GOOD (  12.14  )
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

I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
bot spotted the following instance:

  arch/um/drivers/hostaudio_kern.c:316:3: warning: no previous extern
  declaration for non-static variable 'module_data'
  [-Wmissing-variable-declarations]
  } module_data;
    ^
  arch/um/drivers/hostaudio_kern.c:313:1: note: declare 'static' if the
  variable is not intended to be used outside of this translation unit
  struct {
  ^

This symbol is not referenced by more than one translation unit, so give
it static storage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/llvm/202308081050.sZEw4cQ5-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Fix kbuild test report lore link.
- Link to v1: https://lore.kernel.org/r/20230808-um_hostaudio-v1-1-3d40fbe1fb1e@google.com
---
 arch/um/drivers/hostaudio_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 5b064d360cb7..c42b793bce65 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -310,7 +310,7 @@ static const struct file_operations hostmixer_fops = {
 	.release        = hostmixer_release,
 };
 
-struct {
+static struct {
 	int dev_audio;
 	int dev_mixer;
 } module_data;

---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230808-um_hostaudio-21d7207deaed

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
