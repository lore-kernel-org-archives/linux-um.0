Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E668CA5FED
	for <linux-um@archiver.kernel.org>; Fri,  9 Oct 2026 05:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NuO+cEwl1THcW21+Ds79ErJcGz7v7cRbe13paNhTdvU=; b=W9h1AHPYIaJSGeZb7kqm9EKV+g
	r3VLQjumkB3/DqYcFEic9Y+WxfmYteqeuMjMqSAuORJY8GYQOJMI8OTq2PvC5Cgd8t5/Ofg/GE/zn
	gd2Hm7eY27hrXNQ0USs5I5xQd5HlKQDcThxgXz+GA8Fe3TTXLAwfpN0qImJuK1rqH7Vkr+dvs89cJ
	scHIGQt0jjtdkeyWKsfhC6WnHFvFSu13OOMWyCchreJA9mrwIRdrYXF4lzGTTKhwNz4d4D4p7MEle
	4kO9k439h4/q3fEKGIWvyg1TJklFqAKuabt3JzY+a6k1QKrhA2nB3yymGERQz9WV821N4wz8DBRbr
	q27Wb2ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF39l-00000005XjE-3grS;
	Fri, 09 Oct 2026 05:28:33 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF39j-00000005Xiu-2AHl
	for linux-um@lists.infradead.org;
	Fri, 09 Oct 2026 05:28:32 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2e82462a3f1so6821905ad.3
        for <linux-um@lists.infradead.org>; Thu, 08 Oct 2026 22:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791523710; x=1792128510; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NuO+cEwl1THcW21+Ds79ErJcGz7v7cRbe13paNhTdvU=;
        b=OhN4HWDrFD8pHscT5e7n9dJiVCGUr4d5dY5upfCPmmn0YZutSr5JQWOXkS5jb0ec26
         mnl6pIaM0KvQq7YRWhoXp/2MbCjwgcXy39j3yTC/hzxgOBiVEGA8NGv/EHnBXWI+X3Eg
         R5Nr0aBCI3HPnB1aDsn+DZoVqMTGuX5yMRFmafmDJyUskbgkRj3UN9rSuMpzK01Q4E0m
         JqGOhijDjVFDRn1s16UcUpaCjSCkqAi0WTbGRDrATcVp/MYrMii/l5McO9bVky3fo6Jd
         QnItykZRtxNrSzHctHRHBfuHY4uaAbeq8SqOPTDauB7je/m9LCg6cotr5OxQUixj7XpZ
         KLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791523710; x=1792128510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NuO+cEwl1THcW21+Ds79ErJcGz7v7cRbe13paNhTdvU=;
        b=P2e2pf4SnkoJ9Qs3ZxyWTVP0dWtTP+DS/6xyznKkhXNn1EDfummgk+8AAPvaj24OB3
         LOIh9tdlBTLl5UvHI1Rg/CZuRdGQHNkzzrUG2xAUf00mbsfAHdu2xp08NcZiJizN0c80
         E99wwKHurY5Cdr/Ldb3C1gMtrzJF+dBLEOHf+Dvz30exv+JMrkyMmJizPfjOT0pTDcsG
         Q8nbgyYKOfQdgNltfcNZ/p9WU7RliMH2vb1/KaR3VHzs2Bmczx/mmZ5CSfPUcr5vKKPo
         4hWYPoigvoJm6DJgVHYnByUn0vUXXgPzKTgh5ZptVkiZH34dOtNMkGbFSRImiGihdNlX
         2DuA==
X-Gm-Message-State: AFq9FYJKa4HXF5Fwxvd3d4hcwYZuWdeNBbLNcxVoyq2p9TCVDc7UrSml
	JnIyxytAHZXi38z22bFFUBfD59POu3z1oAM3XjgwFSzwpQZZHfbpBRmpXnXHAw==
X-Gm-Gg: AYBFou3kzDaAW/FJdUGKqpDB2n4DksCj//aUm5E+kAQQXMuBjsTLsU6+34m5sBLb9Cq
	ii5eEQYwADf5tJkW/xuh1vLNlubt3TjGWenQ30Gi7iMfpt7EmTmpywWWOyADDjJ0u8SG8By2gv+
	80otl5BXH5HFqwsTWc0BhEkYhLji8w+RA1+A3I5jw6UCdHswzoELgFrkkDqcbd4IHFMY0UQl7HY
	4FRgX5ab3ikrFhvUoTZJiiJgqQWMRug6C4ZLbX6CuBz3s5WViAsmamE8xioHDmHA1Cc58GWBeC2
	O7jfeoL5G1PddIU5WwPN93tDLd5KkOXXRBap+ogHpyWXKby6I5PTRQZttToCEExnio5EkOt5Gmy
	6RgbvjM2Ae5EHUY1hVrJA4zNnXd2jCYhJ5iC4cWdFpII27p5ha4mAczpftxVKuZ1P8eix+dLQnQ
	robstUUMi5LCf3BeudDuqjSxLGl9OT5zRWmeAnWM0wfM2owpnivWbTqhIhKxYWpRgGLNZykXnbj
	H9A2IjT0QbhAMksWJjQlgnZVMWHMu0H6bsQf3w/s02TGdJSJBqWPXGED0HYmqf2y2nfxaXhRuqf
	OCbqY8YifOT2hJW6yQg/R69CnGce91S5stqcrqrE50KOXZ/dPr/43ty3mB88
X-Received: by 2002:a17:90b:5346:b0:3a8:1830:8b9f with SMTP id 98e67ed59e1d1-3ab3a9118aemr718968a91.16.1791523710243;
        Thu, 08 Oct 2026 22:28:30 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3386ba90sm1204129a91.1.2026.10.08.22.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:28:29 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 219CA1701BC7; Fri,  9 Oct 2026 14:28:28 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH] um: place large BSS inputs in an output section
Date: Fri,  9 Oct 2026 14:28:26 +0900
Message-ID: <20261009052826.179995-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_222831_575149_65E12515 
X-CRM114-Status: GOOD (  10.70  )
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

GNU ld requires input sections matched by a linker script to be
assigned to an output section. Place UML's .lbss inputs in a named
output section so the linker accepts the static UML linker script.

The .ldata inputs are already collected inside the .data output
section, so they do not need the same change.

Fixes: 779c65ede680 ("um: link .lbss/.ldata/.lrodata correctly")
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/kernel/uml.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 4aabcb7faa38..f6e100143558 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -109,7 +109,7 @@ SECTIONS
   PROVIDE(_bss_start = .);
   SBSS(0)
   BSS(0)
-  *(.lbss .lbss.[0-9a-zA-Z_]* .lbss..L*)
+  .lbss : { *(.lbss .lbss.[0-9a-zA-Z_]* .lbss..L*) }
    __bss_stop = .;
   _end = .;
   PROVIDE (end = .);
-- 
2.43.0


