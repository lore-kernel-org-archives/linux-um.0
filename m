Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37050C001B0
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=pD+IO4/qZu2MTS8NxUAc6BhYd8KK7u63Gl9+xEnp/Ew=; b=cqW
	MZe1z2UOFxO5IVn8VP12dOWdyYpvG34BQ1XVgOKLO0F2bSBDkgtkGCQx098NqUbYoaE0v5XgeRGAg
	arnII4aA5rsLW3rAWzgAdu08JgiDpVn+kxzU5iKE7Yp9432cgFRqTdB9ZN3QAzm8bh1dbIBp45Q86
	YRy+TD23hjqYtSMc3moReqBkmaIh95qT/RBiQZJdq0bHHOAsJ1/3TIwEhhK5DCXYMzjWbbdZ6NG2p
	aDI47G89Hy3H036pyll4peKSVSlebMtu28aHxZQt4R414uLemBM62ii9GxcvcV2JuTL1ehgo3KUL9
	rBKSATtxhhFUV83N5fCFOq23RNhSf7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQYn-0038Cu-17;
	Tue, 08 Aug 2023 17:31:57 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQYl-0038By-01
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 17:31:56 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d0d27cd9db9so186425276.0
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515908; x=1692120708;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JK8CUncptgcyNF0cGkjEA8kKWV78TabfUcMXlDPGaN4=;
        b=a6Ag7VXjAsl8cBU4aYzrmGp+LGdAmWWFvill0aLl/BfUEGAMo9Fps6frvQLeqjIuhD
         XlN66q+gi938xPlgkBioE+6G5T8Ol4cL8eHouqLBmXJDKJ4ofNgNbEyzFQgfwJN5wX5h
         FYDm9fsDAdaSMZe+FiluFtG/hjeKkEawL1za/6eCiRJN35Mc4LW12k1s0m1xOYJ896S1
         ajizwbTiIXVwvKayvFjResg+QbJFi5sSjCD3RDXK0Aed9+bvab3RpQkJ1elmdhgv05Su
         a8qNKNMfPEzvEjf8JDTmpmBChnLwWPeqN8Nh96D4P3CNaUchJtCcdF9/W/qDduK8As2c
         UF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515908; x=1692120708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JK8CUncptgcyNF0cGkjEA8kKWV78TabfUcMXlDPGaN4=;
        b=H6G06UNslIoXY4JGIJZLWB2Siz0goprDUm7UHMUurVmiL7+UZF3kFkmC6101an0CQL
         GAYJIVnYGUm5s/fufDzrj8m0BJEZlHPTAh9DV6qP0nUzlKW4RzzJFCeSdtVAhfpuzt2I
         WeokwLpz/nUmvV++Yrue4xej1AGGI6y7ewUyJ1Dp8t0uNZkLZN7ljndxPm1DZyAtjxGz
         WiSQiSY11rl6RrxLZJixB+Vyj1ZtG2JHVuTcgcehgROZ54fc7mHMiUNdOm0uhN8ZenWq
         OzccMg/SsFF6Gyso46TS3Hbx5zzaf6WMMCq8bRjvnwf8YS8d6Y/uXORr+iiQm0ZsD9Ro
         O8ew==
X-Gm-Message-State: AOJu0YxkgvqLNw9inFLnHCQXVIPxyElGHDAbl1//PfiVDjCzbJq+UOUf
	5FEs+VLeyPLz5piewa5YDIQ7Nw+Z5VEbLhBow2U=
X-Google-Smtp-Source: AGHT+IFuIZZ9U+HFkMO58uj8HDjeBgI0ZQAsk0P/vzaZPrJxYj2UOeQKD8aOt/SMEl5gPv9zleDrc3PVPpUJ3i0n+p8=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
 (user=ndesaulniers job=sendgmr) by 2002:a25:590:0:b0:ceb:324c:ba8e with SMTP
 id 138-20020a250590000000b00ceb324cba8emr7568ybf.4.1691515908064; Tue, 08 Aug
 2023 10:31:48 -0700 (PDT)
Date: Tue, 08 Aug 2023 10:31:45 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAB80mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwML3dLc+IL8opL47NSiPF2zNMNUc2Nz47TUJFMloJaCotS0zAqwcdG xtbUAp63nSF4AAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691515906; l=1516;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=wd2IgnzJebaakuklw0wfvUJX4iZiu7mdNDFHD+AAxrI=; b=nwemPY1tE0AdQPYAgJzWaeXtnN2spPLRAwSR5RGznOobwW8wki4Ug95D04bQMIQZ3m3VbdjLh
 iHtBufNW+DbALPRP0+Qd07XoJ9pW2Z1jMIj5ZXyXQVKXAMHML1aY8z8
X-Mailer: b4 0.12.3
Message-ID: <20230808-um_port_kern-v1-1-867351f32af9@google.com>
Subject: [PATCH] um: port_kern: fix -Wmissing-variable-declarations
From: Nick Desaulniers <ndesaulniers@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_103155_045596_CC2B1315 
X-CRM114-Status: GOOD (  11.41  )
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

  arch/um/drivers/port_kern.c:147:14: warning: no previous extern
  declaration for non-static variable 'port_work'
  [-Wmissing-variable-declarations]
  DECLARE_WORK(port_work, port_work_proc);
               ^
  arch/um/drivers/port_kern.c:147:1: note: declare 'static' if the
  variable is not intended to be used outside of this translation unit
  DECLARE_WORK(port_work, port_work_proc);
  ^

This symbol is not referenced by more than one translation unit, so give
it static storage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/llvm/202308081050.sZEw4cQ5-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/um/drivers/port_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
index efa8b7304090..c52b3ff3c092 100644
--- a/arch/um/drivers/port_kern.c
+++ b/arch/um/drivers/port_kern.c
@@ -144,7 +144,7 @@ static void port_work_proc(struct work_struct *unused)
 	local_irq_restore(flags);
 }
 
-DECLARE_WORK(port_work, port_work_proc);
+static DECLARE_WORK(port_work, port_work_proc);
 
 static irqreturn_t port_interrupt(int irq, void *data)
 {

---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230808-um_port_kern-6f1e7373feb5

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
