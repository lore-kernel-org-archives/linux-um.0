Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9386C61DA4
	for <linux-um@archiver.kernel.org>; Thu, 16 Feb 2023 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E5q90lCXc1v04bLEnl2swP15g0n51Bw6Yw6+BPTVkYA=; b=GsT7nXpd/CMFlH
	rZtuH2Bio5taeptcj6QBHT5wMBeWGkqjyo9cURQwXf2T5yY2CQOpmq/VeHFBpbD/69idkrrXoFwQD
	t39ZuS5krIrh/ACOHC+3+OdHqvqLP7Lko82EvolEzm5l9eyfFAYnS1zR/D60Cj8XBVr/I3xBfxYhc
	rufeh6pPeFcKdIgUxplJ72cFPpIqcDi3fvNuDtW85v4nMcWAVHGbWELDQuj+kRxjXijEjGipzK9PS
	I4yafmraIhEPzsbMNzlsXSvMzERezlpw4/yIOfCYLnJ7N1Dtrbj7stuovAOgpGDGB5OB/sBN+Ard6
	yTKG289Ts6MOcBhWKXVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSYq6-008pgk-2O; Thu, 16 Feb 2023 07:37:58 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSYq1-008pew-EC
	for linux-um@lists.infradead.org; Thu, 16 Feb 2023 07:37:55 +0000
Received: by mail-qt1-x82c.google.com with SMTP id g18so1282430qtb.6
        for <linux-um@lists.infradead.org>; Wed, 15 Feb 2023 23:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V7b24tPUboc7ZThVESo7BLiGEr7m3xHl4toWhOct5s=;
        b=IHd0GNvvzVLWOlTMcgVjymA6Yd7ne82cFRJyNrbE9eo9Uo5DvxEXQTVpf0tvU7s4m9
         fIt42IjxaEesQ8ctwAFLFw2mvGR9FZG5wEnDTJ6e9npdVJpMpMEUJAQPLvTTUM132lyJ
         5ScD1bd1DP8uQGQQKs5HbJX8SZhnzmNbKimm1fhTDFZ7uZcYvEjkA9iN7cOOBtBZYbLO
         7h+YFSHMJ1bFVy36ylltIIwm6/UjP257rDN72XAtyB29b6McSVAEWB/QlbBR8CxmppfY
         N9lqbBd2HMzaiKJ2DP7VjzI5GLIFMgKZT01XnJsbGV2K7C4E8vu3vg1OhFg/lCNK3FYw
         985w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V7b24tPUboc7ZThVESo7BLiGEr7m3xHl4toWhOct5s=;
        b=4sKYmWfvmJBjGxpxzqNz9CgqZI62IPlknd6wUesSZo0gVgXU6v/AQZfEz223eZQYKj
         8WoIiNB2CxJaS0DeitfZXrLUrzPnKH30xl39+XMqaKYYcJyyIGhtsZZRMy7cB+MxFVRK
         0+ZncbMCYuABxaTCJLrlAQEoZXErP9o/AU4I8tK9Xfkakzru+DazqRJicjxnsUW9WfZ8
         etOxBSwaqCbq6iftLYU69TwwbFgpJFPTith+UQTDYR+UMJU7ZIWIGyg40z176bcndjE2
         KXEvBn6x88U9ItsG8UgCCg9y7+xDbs+vU1s09jE0I02hWKeFeqdOqDoHmlFDovmDkTyu
         QcyA==
X-Gm-Message-State: AO0yUKXzdC3F53Wt+Qb7ChqN56hR91MY0R8j/yaI9UZW+wGhSHHovezS
	xaeVqft3h7JzWEsRocWd/uysV9HnRydo8oD8
X-Google-Smtp-Source: AK7set/4W8K4J99rj8HwUotO2YefCn6bmSt0Qy3NMNDIdibDRIyo3SqST26lkxqCseH136IiuE+ptw==
X-Received: by 2002:a05:622a:20d:b0:3b1:c538:7026 with SMTP id b13-20020a05622a020d00b003b1c5387026mr8058635qtx.42.1676533071617;
        Wed, 15 Feb 2023 23:37:51 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id m1-20020ac85b01000000b003b9b4028d63sm756718qtw.80.2023.02.15.23.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 23:37:50 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Glenn Washburn <development@efficientek.com>,
	linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH v2 1/2] scripts/gdb: Correct indentation in get_current_task
Date: Thu, 16 Feb 2023 01:37:18 -0600
Message-Id: <c5a916e094d9c7acd551030b5dd793203046fea5.1676532759.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
References: <cover.1676532759.git.development@efficientek.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_233753_497394_B370CB92 
X-CRM114-Status: GOOD (  10.21  )
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

There is an extra space in a couple blocks in get_current_task.
Though python does not care, let's make the spacing consistent.
Also, format better an if expression, removing unneeded parenthesis.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 scripts/gdb/linux/cpus.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..3e02a1866751 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,16 +163,16 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-         var_ptr = gdb.parse_and_eval("&current_task")
-         return per_cpu(var_ptr, cpu).dereference()
+        var_ptr = gdb.parse_and_eval("&current_task")
+        return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
-         current_task_addr = gdb.parse_and_eval("$SP_EL0")
-         if((current_task_addr >> 63) != 0):
-             current_task = current_task_addr.cast(task_ptr_type)
-             return current_task.dereference()
-         else:
-             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
-                                "while running in userspace(EL0)")
+        current_task_addr = gdb.parse_and_eval("$SP_EL0")
+        if (current_task_addr >> 63) != 0:
+            current_task = current_task_addr.cast(task_ptr_type)
+            return current_task.dereference()
+        else:
+            raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
+                               "while running in userspace(EL0)")
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
