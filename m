Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B19C7EE23
	for <linux-um@archiver.kernel.org>; Mon, 27 Feb 2023 04:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4AyAYQNRWmORAJc1LwOUPI6xAx30zWVKTstjbPleY4M=; b=1OymPfXZbR1ECT
	DmLYoH3DkcVo3KqVXWvj/yv7xEv1/k1KV2Ij2hMRl4vvLDkOxOdnkQ+/jM2guheQDP5Kr5FzUTiTw
	pK/KyyxiMDRsikVdoAO+vDTu82/mgbbtWEFV6JAqnqjRLhMR2U2KBHVyPYOmfGQOuT+i/qlmRuSgs
	+vyrYD2j+vaB57nBq1okHCvdLpMNCW8A83ffImV3/jZHcK++Q0FVvyl4Y3at7ydiSRM9WFM3n2wMZ
	7DlPGrDJI9T2IpD6We6hr15Fx3xkEirZW4apmST5AxVjKApGeeEM2mkUEcBjo8oezjE+ixmC7Eubn
	TiwROg+5/+zh6UE0yPEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWUmn-008Pki-Oh; Mon, 27 Feb 2023 04:06:50 +0000
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWUme-008Pik-E9
	for linux-um@lists.infradead.org; Mon, 27 Feb 2023 04:06:46 +0000
Received: by mail-ot1-x32c.google.com with SMTP id a14-20020a056830100e00b00690ed91749aso2885783otp.7
        for <linux-um@lists.infradead.org>; Sun, 26 Feb 2023 20:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iZgPnDq1wPjqueobf/M4oDcAkjldH92kHB/el5/Fzc=;
        b=j5tFynW9kqal2hVWICOdqlsKcD+vVI7wEoFzxbjy2/xCQTj05Uai+taTnQRXGpsyI8
         yMESjLj9sBUznf1FOaGSt3tR/+R/d0mqELmgYbyWHXeosHGmOGjuxLik1Fo7qzLBQUPO
         ekV/jARW45eWDoe8h06Kiu6LvwbmkhdGzlTML7MJhSS2+BUErBovbI2KEkA8doS/IyzB
         YFnrYs9GwnWkmn5V478Tjvxd6NW5PLcnjsD8KDSu/0e8kl/gbVqHuqW+mCxzZyTIUrSo
         XXFn1QZ710zsozmnsfDTFX8sHtMFkJrZHWQZdb+cVN6W0tEv8Z8QFbpF8eoVtnNw6Hin
         MWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iZgPnDq1wPjqueobf/M4oDcAkjldH92kHB/el5/Fzc=;
        b=BkXs06BMVbAp8AM7gTxO33qfgomvElBCz8wnerhiPCHEmB9F+kMPIC/yVIewLenvXB
         qE5Bb/k/9eLWVQ5GZG+EqZm+9gjniIv9GuB7ZOkFZpO1xsp46B7OEnze5yLIPC/B3Mfi
         YOf2/CgmePn0tgxAG9CZz5XP4Su9kja5X7c3pcjDm3BlpVpW8Hn0q/j1jonzJ1SfX8j+
         tONyxVVIDwz53/hv+G59kB1o9gpyBOXf6OGNwKoV+3CG3r6r0xdYhX1kxJagYYdyO91O
         muPV4ryfoK2fVWOZvVvKo+rLi7aFhpF5nC7CoA5H+17f+NRJPi1jowyPbIY1UI/PSzQc
         Efig==
X-Gm-Message-State: AO0yUKXOkapVtV8+veeIJnib8XUecTD7XbK3Aft1UTZepkXDyB+9RH8r
	mHmjflL81f8SvwL+uprklbRjSA==
X-Google-Smtp-Source: AK7set8p4y0b4YAe33oiCrG1LUD1gNe24YhWPYU7qv5koyxlDrt3YPn3c6QLAh0DJAZGAAl+4OXogQ==
X-Received: by 2002:a9d:37c6:0:b0:688:4670:e964 with SMTP id x64-20020a9d37c6000000b006884670e964mr6856648otb.27.1677470799390;
        Sun, 26 Feb 2023 20:06:39 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b00690dd5e7345sm2219589otq.26.2023.02.26.20.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:06:38 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Glenn Washburn <development@efficientek.com>
Subject: [PATCH v3 1/2] scripts/gdb: Correct indentation in get_current_task
Date: Sun, 26 Feb 2023 22:05:59 -0600
Message-Id: <2e117b82240de6893f27cb6507242ce455ed7b5b.1677469905.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1677469905.git.development@efficientek.com>
References: <cover.1677469905.git.development@efficientek.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_200643_802767_218A612B 
X-CRM114-Status: GOOD (  10.27  )
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
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/cpus.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 9ee99f9fae8d..e8d2a62ff119 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,16 +163,16 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-         var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
-         return per_cpu(var_ptr, cpu).dereference()
+        var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
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
