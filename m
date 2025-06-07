Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB09C61CE8
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 02:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X/JKVoHG52bM7iYj5PS7gTiSERcG5UqrCOig8DJiksU=; b=ltUj9I/wDmPt+rQ7FwtR85JFtA
	LrP1iKqw81DZlcIC+S5YwQDeWlfuRIPGlwqnQJJ2GLPO/VjsesB/g9FZ6WSQqaz5uWlWfDIPublKl
	K8aZAEFyXJmVaEEuYc0jxsEnESw7M1PHTxb3xaG9kjLGZG1sqp6401WHndsuOc5dmteVwYoir2HMP
	qZN1XQnTUdaOVOExR7lrcDA3fS+g6vu7y4xHEb7R3B/64iYTJjIidm39LU+vqgl9UMGAVRYcZcnR5
	sozZygwmk5C5n+CxJGpvewLQlGeerkH+gE/OIvwNcnbcE2GsnjKdqbToq0TfU86d/I8YYAwbZilhi
	kHnpZDLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhY-00000001Giq-0e8D;
	Sat, 07 Jun 2025 02:54:32 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhV-00000001Ghf-3TFO
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 02:54:31 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3a3758b122cso1715549f8f.1
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 19:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264868; x=1749869668; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/JKVoHG52bM7iYj5PS7gTiSERcG5UqrCOig8DJiksU=;
        b=giSzxbLmYN3Fqa8TtLEPF4cjfKfR39S0HfExu+ojDin7VtjMcLlJLqGWOua2brnVBI
         XnkKHtLr9NprOacZOFj2jRrxrFtiIu0vgEN26FOnXxovbg64hqenuhZxUA4e4EZxTON6
         nqx2mdXWL5Y4vSm1VUec4rzJBO5htLwgj4N/N7kS1FDlFwGUFYpNPSDyQXzws3qLrgRA
         HWJ2P6RQwxvt2OT910b9DdQ3HQoIrD0wuZSJER2cufTt5Y/16dzrG4FLqmnKd8TjVjcO
         m8ZO/uPtNtTuH/B7wmLD94FJ8eTmL0TWbYVYlkmh8a8mHI9eSycWd9stKOMaF1j0DlJ1
         AtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264868; x=1749869668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/JKVoHG52bM7iYj5PS7gTiSERcG5UqrCOig8DJiksU=;
        b=Nrm9hs9/piuOKUjrfxu1fQYI5DgEVlwcp9LScksTguWGlJroz69nY9kW69FDIQ3feU
         M1Cu2RmPfXK2OaaclOrHdKPNRX0H7Qokh5HLPGLn14s0d/ptS+UvrA9TuXEJ9R3V+xu4
         fWEeUlJMn2cz/QHMRw9snHMeIKHuotl55GtQK//JprfN9GJ89p75kc3nEECZZFHyfdOJ
         jw3iodK1wMSrhbT4W+pKY38BkLH75d8pzrcO4o7vuJyX7GBye3JdGTtSXcgyqCXC2nnT
         4pyLtOuE0Pm2VWrZRuduQHzZ4p85j409Af/EMlzZSfjMIlTyliqiXoIriKnbT3VwT2tK
         7gfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoF4dUuE0ozKCSTAJfe7XbjQo29LH25QB24E6AvOAIhiQ368WCkN0sLf5RnxLrSY0/9Sxx+ruScg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwikQ1m/WLh7cqN1UyXFYQe0tCQ7W65G2LGBWKHFNTEhMc3QVmt
	LT4NKMYdfxiyu1Y4WHmAutvG5hc1AxfJk3LQIwS7J5sew+qkgwGpynorIit96Dwo/ag=
X-Gm-Gg: ASbGncuMAlJ6UPbBrjBKinDQluTq4uiBJiY0CZa4bXZ0GoASRrwyVprxurvGhjs277h
	Oa9/PeXzjh5lCrglwD7Py3dF2oSYNKz1/g44JHhChjYlfTuqFn5cb9y1L76QxUjKL1tEdKImEqe
	FzNTkV3Yug5fi35w6PFyKY9h+KQtdYNcJmPGwOdjZjtLLJOxrrBKco0ow0FZ7/HTiDKYpWF8d5e
	xmTid8ZOt5ujSuMBoIh5s6FRIraEFuZO3WlhKqh56++xNpOPN8OxFExE6O1yAFjYC/Y/9zU5Caf
	aMadKPW9QbuUAvXW1Oh1zuTXi7fyUxI2gKWU/mIYV3IFnNXy
X-Google-Smtp-Source: AGHT+IH5d/vDAJyZSz6fuV0j5C8IVfGiu/PKk0FvmAPHACrM59+l4DsDYjrQIDTW1PtMdxhQU8+9aQ==
X-Received: by 2002:adf:e705:0:b0:3a5:39bb:3d61 with SMTP id ffacd0b85a97d-3a539bb41abmr1337284f8f.27.1749264868362;
        Fri, 06 Jun 2025 19:54:28 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:27 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:47 -0300
Subject: [PATCH 5/7] arch: um: kmsg_dump: Don't check for CON_ENABLED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-5-f427c743dda0@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=916;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ZiQkH309SsPv8lN8ObW99ERD0AIPkQszerT12qHwgsk=;
 b=jWqGiPKl/XV1kWO8hkwg925xr1q6tsYBxos9FuxBE92z/Pq14tW6oRTqYnah8nuO92j1JK2AA
 efZNwgbsN74BdsXUFSv+HbPRvTzvr8dhPJfS5pW4gOs10Hl/GEHry89
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_195429_865493_94EEABDA 
X-CRM114-Status: GOOD (  10.79  )
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

All consoles found on for_each_console are registered, meaning that all of
them are CON_ENABLED. The code tries to find an active console, so check if the
console is not suspended instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 4190211752726593dd2847f66efd9d3a61cea982..f3025b2a813453f479d720618c630bee135d4e08 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -31,7 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    (console_srcu_read_flags(con) & CON_ENABLED)) {
+		    (console_srcu_read_flags(con) & CON_SUSPENDED) == 0) {
 			break;
 		}
 	}

-- 
2.49.0


