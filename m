Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FF0C61CE8
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 02:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cwhjr/MwOcrXAJEej0LaRMGIcO9EQcwPYBdM3grsn/c=; b=TtoZXs8CQpmtz0+M5F/atOWzOH
	Zfn9sGlSfhSXGQCqaq4x3hYnTRCoVOvDoNZrC1ScMkU01CES7nKMEc5NevqbM6hAy6fHR2RF9VEhu
	B7dOAOWLo0NO6JGc5wmeiIwDtVHtrcAM74Urf8JvEWrQz/wTFnfU9y3bG2CXXG5RsajFatjf4X62N
	6js/cfs1X+Xofk3UEcF6mXMAuCyYyCJEv8F1dzpZQqx96iWwDCwBZFO+MSemvS5Qx7n1DmS+f8w7M
	3Z/pYfX+1WACjM3POrkx2iG9Q/OMAqlnSOvN9PeurYcVJjdVjnyQRLcoN9+PCBazSCvdLgBYtNEKD
	Hp07lGag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhd-00000001GkM-1r98;
	Sat, 07 Jun 2025 02:54:37 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhb-00000001Gjl-0nrh
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 02:54:36 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3a51d552de4so1501308f8f.0
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 19:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264874; x=1749869674; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cwhjr/MwOcrXAJEej0LaRMGIcO9EQcwPYBdM3grsn/c=;
        b=aCy3Dpmeqsnu0eOgynj/cbzZ0VZdJ0V4dpKUNWUprwHMyFBv14yfxA6QibvFqU+x0G
         OUpntMG9evXeAHs6/K83C/vX7Y0LI4iMHq5m6BhTf1gGRAa5Gk2WDJWI5gOYmgqY9Guq
         CK6VB/ViHct3563MwWYPkgOpZioauvM+XXdbmANS3nvio4JE5Dj1rxMdqs00uG2Zj+s3
         tpp3mvocc9tkTpJdr5IaaFwLGEvpoKGkyvjdHoS3Kpva20x0aqXCYodTacAJGoX2Vfh/
         p8qFlSmTSYsaBqiLBPIaGhkWCk6eFVikKFliJLk84dNQAILpYCEgm9DoCwrT4ewFTYRk
         raug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264874; x=1749869674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwhjr/MwOcrXAJEej0LaRMGIcO9EQcwPYBdM3grsn/c=;
        b=QRt8hj8ZXCyGgmOr7L3/36O1ySRvYwlif+k6MUBH5UopiAUl7wIRARvrZ7D0pDmG/Q
         XomhJy7Py4dbBTvK3vWZchFAmc+kROd360ba97uvcxSPp7LLsx8H4JgpmQQzkBbhHjKj
         FLOeV14S0O2VzkCaM0LdkFVaMqAxFcRDi8LlJu81BkdE7Geqs7sGtEeQcMu9y080sqGf
         1K2yOeH7B/v0Bvjqzn6XtB3BorSLGBz8JTyLoCO53xBChI2DY6q+xVd2XvigYibZyRhE
         tXdz9WF32nqWLbKG0AzKXvOqzvPa9eiDNOyz+GcKaKZ1XbvVy1nf3WoEv3SKdSXxqTtO
         ecbw==
X-Forwarded-Encrypted: i=1; AJvYcCUfb2NdX6NpVG04qsIiI3yS0j4ydNqXvoxV8lB1IkDpqsbU6/9wRf//hPuz0l6hJPDNIj6HYDurwQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyoJLhXc9GfZ/S0Fac3n8BkZrPtgtJOk1uGXPAmr+8csYn5mMZt
	Fgmpn4FL1Gye2cjR5UF9VrwTS/uWPk9FM5aJgfHM4x/N3YebMecmfkr4AL/A9r42k2M=
X-Gm-Gg: ASbGncvx1YfKt0uHzWeZYQu2HZytkAbHkeHWr0SKyHBMmpnQp1HA9DaoWn+CTiqBNHW
	s9uHk8nW2pbS+/dFsZ3dxxTobTAQGDvo2ByAJFMclqs0XZhhk3epPqzrnpw9xQPjIZg3rJNaAEd
	dAxNNc5CFuYOdxAMhqhDAA/w+pAy+XXI1OyCMdGS+D4CCvkyTaxdu6N8NMj2uWs0jMOK2hsNlr3
	Aerk8UClzbXj+CrXsWWbbeysxlI901UNmcakZeO46R086PctzbN2k7gFddFdJWcBrGXiM9vrjDL
	5ilqe55qZqyy1emLeWIM/QgPUk1PlpGHaTxc6LqJrgBcAChf
X-Google-Smtp-Source: AGHT+IHvN9wEy6EKNYkDxnnT81hoywOQZ08WI1JRYEWNl3eQSXHLiVXm+Dos5iynM7Sa+3YILwrh5Q==
X-Received: by 2002:a05:6000:1786:b0:3a4:d452:fff with SMTP id ffacd0b85a97d-3a5318837d3mr4663312f8f.17.1749264873645;
        Fri, 06 Jun 2025 19:54:33 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:33 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:48 -0300
Subject: [PATCH 6/7] debug: kgd_io: Don't check for CON_ENABLED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-6-f427c743dda0@suse.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=912;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=iLfgT9HQWZUDDzN0tovkdkdRnEgGdMwJcOWfpYFBuU0=;
 b=lwh6KzwEyh2dinkiRzMgjAoctl1hygotlVKEbxBK2YgOdS8fCmLq/Q05gztFUdw0JdxCeH0Hs
 zy4lhvv4ZsBAeKV44NBYiajx6Sqj8Awb920ZzuYNMmySvPls0kFGTyP
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_195435_234956_A999A7D5 
X-CRM114-Status: GOOD (  10.61  )
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

All consoles found on for_each_console_srcu are registered, meaning that all of
them are CON_ENABLED. The code tries to find an active console, so check if the
console is not suspended instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..cdc1ee81d7332a9a00b967af719939f438f26cef 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -589,7 +589,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!(console_srcu_read_flags(c) & CON_ENABLED))
+		if (console_srcu_read_flags(c) & CON_SUSPENDED)
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;

-- 
2.49.0


