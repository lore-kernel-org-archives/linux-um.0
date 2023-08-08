Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5701C001B0
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=l8EA03X/GGZypp7jqgKST5rHSRzhGXH3bvh7SUUaxbA=; b=qHa
	4y+u2UHUlx/48YLtIoVOXj6fKOQlWwqqv4pyn9YbYtMRgfCmbA/cIDuvXYo+mkwxwgJGWKNMNGjrl
	WmppRJ8KLDSojlbALMZxs9L6ccC/sHJ6oqcEdR9HdMPh+vcuZN7B648e4tcf5hlU/M78pVUQIQjZX
	cia57XX/zi3Aqsbnsd4mBfu7X1HluoUQgNoDQpYMt/XqxVFwNThgnslwV9fQnzi7gyLpYveq58I8D
	kpyHitzspgvHpIJEeB9w+Jv5B80az1MTWUOK+tr9exOs3yVLfXYQJxx1hVhwUNRqJ0k9HFIMuEy3W
	TwauZWBYH4NwckPBWlNdNwO/5n5ShEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQOk-0037CX-1j;
	Tue, 08 Aug 2023 17:21:34 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQOh-0037CB-1H
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 17:21:32 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583c49018c6so69615467b3.0
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515289; x=1692120089;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A52RibxNLEy97VBVqOrueH6EOuxfxLmE/sIUm+aEQ+w=;
        b=uVZmnYoriE+9+Mq+YaugxJfh0MQ3WQB2B4J81xX5KW9BbHnW4WVpsihYMg+oVitArc
         dx2Qw47nhPdh50lsb/VLRbzhiv+TdKPdfWmhCkwr58jLsVwWiQHY0t1zutf3qfLgtZhG
         HhedOLVGzDFThVbo75z1hWiM+TCa5xtkbKT6GNy4MgmqFajMKu/HBRVKDcxoBQd+nwi/
         EgddBBgIs67pmSf8wQB90OD4iDNjLPBS5fFXz3c5Ac+8K3kImH9TwWvqh/lYgMQBzoJY
         Z6BHKA9s8oK/dPuSdLxZsgd0iuYaXfo0rXRGIHewy4wiO+Uv+SFo4jNVwHONPa6U3zC4
         YC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515289; x=1692120089;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A52RibxNLEy97VBVqOrueH6EOuxfxLmE/sIUm+aEQ+w=;
        b=BRPmQA4GtD/HcW9FsktogQXTc5T5/ODfNAbWjoy0T/cVlNH13QP/uh5uE1shxVuhKb
         7pmQ8Qv9huhLzpnMUXYdv0X7mLMx1J6SprP+9uBPkoQboWVFPJDSAPSNNRtRm4USnHb4
         TlFn/ywL/Vd7+UlzpucLTe0fYtpJnc8k2sco2hjnejPsCrMhZ/vRAc2E1AFvzhdbY+7+
         0pcaNvZ0e1k458Xn9YRfTLU6tzFileZTg+I8lnnEUXv4FKH4nyZMzEP+eMWx0oQtKmwd
         +3CYc7UOGl6u2SkKeYuLVvU37m7MfdFrkvk28+Q+X51Ywmr611aen4cxaac3xyVR4qyA
         eIRA==
X-Gm-Message-State: AOJu0YxQknWjd62dVJqPRaFADaMwKvFsPfzlG4xJLT0bgIzxsSotg80N
	eQn/qhX0U7NFOKAlMokdvlR4p/Sg1JFKBpLx37w=
X-Google-Smtp-Source: AGHT+IGJqMAAiUXBHcdyYGpY4t2f1wB6tRaSHDofaAQJaQYlmWAQhsPJY+NqguyPoETN/GUldNNfV/ngPqHKxSm1btI=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
 (user=ndesaulniers job=sendgmr) by 2002:a81:cb0a:0:b0:560:d237:43dc with SMTP
 id q10-20020a81cb0a000000b00560d23743dcmr5515ywi.3.1691515289533; Tue, 08 Aug
 2023 10:21:29 -0700 (PDT)
Date: Tue, 08 Aug 2023 10:21:27 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJZ50mQC/x3MQQqAIBBA0avErBPUFkpXiQhpppxFGloRiHdPW
 r7F/wUyJaYMY1cg0cOZY2hQfQerd2EnwdgMWupBWmnFfSw+5svdyFFohUZLg+QIoSVnoo3ffzf NtX53Zd2YXgAAAA==
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691515287; l=1420;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=EVNrQJhfphmof8sUAyFcvsNS+eeuJ4/HQslsOrxMtGA=; b=ZF1X+Fz/2ksGP4RCvzO1mQ60oyrQbavwKrExZxs1egjFcWlVZhzv2is/dJNtgP47UleLNYUpW
 mQqLD5mRDVyBSMNL6JDv1NR2+E9ZEW19aD5kwtN+l1Yqfv981OQX4qC
X-Mailer: b4 0.12.3
Message-ID: <20230808-um_hostaudio-v1-1-3d40fbe1fb1e@google.com>
Subject: [PATCH] uml: audio: fix -Wmissing-variable-declarations
From: Nick Desaulniers <ndesaulniers@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_102131_459643_765EF389 
X-CRM114-Status: GOOD (  11.69  )
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
Closes: https://lore.kernel.org/llvm/202308081000.tTL1ElTr-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
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
