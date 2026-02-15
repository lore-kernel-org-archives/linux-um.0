Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52172EF586E
	for <linux-um@archiver.kernel.org>; Sun, 15 Feb 2026 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sWjl7HPGBvhnIjt2NDHXlQWtF6bLS3V03uS6JDUla/0=; b=GqVmnokFYoSDb5afXlXw3TQVLb
	ArRP3jTvig6WI34Itw63082Kubh5foEAUaRuOHGxQhE62u4mHHvW/KzQn/GoVxAwF9NoGP48lGyKg
	amfEEINKztTbD3zb0KSOaHy6GbSkdM2d/f6LwAOT2t1SRmNOESJ/MIQ0VoZiuL43TxbVGGVYZDBph
	FIs1Nm2qZZl94kgQIEmizgbUx5xZoSxb68Vu8l2pQXrsVq0K1b+7faIpIhq0vq0YiPkgABAQ+xf7k
	hR4e5ZyLucGYnKtCFzTxw4Lpv3kzwq3A3BKUO0B1GkIbuZOeynB5eljKrEyDpWORcGJyBKBCATlVD
	pxhGZoeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrd6j-00000005RQy-21rj;
	Sun, 15 Feb 2026 14:28:21 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrd6h-00000005RQO-2cbr
	for linux-um@lists.infradead.org;
	Sun, 15 Feb 2026 14:28:20 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso898394a12.3
        for <linux-um@lists.infradead.org>; Sun, 15 Feb 2026 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771165698; x=1771770498; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sWjl7HPGBvhnIjt2NDHXlQWtF6bLS3V03uS6JDUla/0=;
        b=d2YYEMA23haGWO/Fe27mnjE/j73EzByRxJt86H0ON5P/pzojCTtefE3bGWJRy27RPw
         /1UrqCEUCEWD7gbuUnStA7MOqnaO3S9+o25syGc7ffmizQ6nm75a2coXXy6LUUr6AFJT
         K+LPmvBFEdzQatnC4Z77P3woWIV5kHRcBs/z1gAFLLOL1RSyqSuBtv4Pe9ySx2ht8owL
         lD1dhyNxzSEuBRq3MiPGpss9XYO7TagcsXOVAxr/z48MY3n3b0NiQN0IzZuXtuANyjVL
         nolrqmJa6R6X2Pcx/UBkQQzt1Ae2H4IJsEpfemaHiuSFGLgSv5z5z5BLHMC6LQ4KJF+I
         /foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771165698; x=1771770498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWjl7HPGBvhnIjt2NDHXlQWtF6bLS3V03uS6JDUla/0=;
        b=VKENje8+l4OrKaqGHSzrnTOTTdC9CP4Dg24P5dL9fKZBRH99MugaNDiZcJFhyoX132
         zCQwxy2eF9UQoWLHbVmmT4pC0j0Gry3XgxFpCcZoUeGG5StNqwesqePi+3a6b+p++/jV
         wdq3NnKhMDJyKrm7rPLiLivYc2s+Hl0qaQHOCXnbmqFr5S1TjXKx7oVJMwUJRCHoYlyN
         wP3MkwDFwSM9FPLWc1WTuw1e1OIrqEbZysCreouzCtDva3E7mTLdbFjhHI/9vp7MXZY5
         KrUbZGo3gAWIrtJo4YwNPXAnM+QKUGkMEa0E0b6wGJ/nrgMY6r5vZk7wn67yEgZ7FPsB
         sKuQ==
X-Gm-Message-State: AOJu0YyUgmsaMfVqKzMUy6faHUGdwpmlABPtUC7OEk5zTD1T7ydzb0I8
	hsHFz7JbVZEwVef7DinpgSqo8hvfazEeGzp2QTm55oHn4H2HURsTTYPW
X-Gm-Gg: AZuq6aLUgS+jvsnLtEfy06UNZxS2GZew2qDabtRKaRQSZ7x5WR+Yy92/8rbVHoAwJ+J
	nrUOC63F0qzKA9aoiusSaN6Mjz5q4i8bS5Khx9Hw3eEO3uFA6vAiV+BeCTGaXr+Jr9wjAhLhg9H
	fHN56EClxRKHs45dohnNKvWmNjfGjejeG3URvATG68W9JMq98FQV9HGUMO8hnbEdri0H8kI95t1
	WkPRQtylCyEn36PIK8xFayVkGihEtOy3a3T08lJnU+tElHXZqB8y3jl6MaWxpHq1MEswJCO89vp
	l84xGv6EnQYvQgAFb9VYr3x7sBxWB5iuWMdGT/GL8BceO0wb4MS3v4VNN8tQhYwmZZxaHmoXkoD
	m4eIXBfGY6pBR4F71Lg3oztJsSUnMzbUeB0xSn50qc/m/VhbzOudy01KUbRCJfE6SsPrJArQ5rt
	WShV1P/t2ufMe88ukpT4IIwT7h2G+qm9e78Ct2ZywSTsZ+H73n1JfqNFfJ
X-Received: by 2002:a17:902:ce89:b0:2a9:ebc0:cce2 with SMTP id d9443c01a7336-2ab50558599mr73616455ad.18.1771165697939;
        Sun, 15 Feb 2026 06:28:17 -0800 (PST)
Received: from speedy3.lan ([116.197.216.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1ace5bd1sm45617415ad.90.2026.02.15.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:28:17 -0800 (PST)
From: "Marcel W. Wysocki" <maci.stgn@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Marcel W . Wysocki" <maci.stgn@gmail.com>
Subject: [PATCH 1/2] um: fix address-of CMSG_DATA() rvalue in stub
Date: Sun, 15 Feb 2026 22:28:02 +0800
Message-ID: <20260215142803.1455757-1-maci.stgn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_062819_668208_BEF956A5 
X-CRM114-Status: GOOD (  14.73  )
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

The UML stub takes the address of CMSG_DATA(fd_msg):

    fd_map = (void *)&CMSG_DATA(fd_msg);

CMSG_DATA() is specified by POSIX to return unsigned char *.  Taking
its address is semantically wrong -- the intent is to get a pointer
to the control message data, which is exactly what CMSG_DATA()
already returns.

This happens to compile with glibc because glibc's primary
CMSG_DATA definition accesses a flexible array member:

    #define CMSG_DATA(cmsg) ((cmsg)->__cmsg_data)

An array lvalue can have its address taken, and &array yields the
same address as array.  However, glibc also has an alternative
definition that uses pointer arithmetic (returning an rvalue), and
musl's definition always uses pointer arithmetic:

    /* musl */
    #define CMSG_DATA(cmsg) \
        ((unsigned char *)(((struct cmsghdr *)(cmsg)) + 1))

Taking the address of an rvalue is a hard error in C, so the
current code fails to compile with musl libc.

Remove the erroneous & operator.  The resulting code is correct
regardless of the CMSG_DATA implementation -- it simply assigns the
data pointer, which is what the subsequent code (fd_map[--num_fds])
expects.

No functional change with glibc; fixes the build with musl.

Signed-off-by: Marcel W. Wysocki <maci.stgn@gmail.com>
---
 arch/um/kernel/skas/stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -146,7 +146,7 @@
 		/* Receive the FDs */
 		num_fds = 0;
 		fd_msg = msghdr.msg_control;
-		fd_map = (void *)&CMSG_DATA(fd_msg);
+		fd_map = (void *)CMSG_DATA(fd_msg);
 		if (res == iov.iov_len && msghdr.msg_controllen > sizeof(struct cmsghdr))
 			num_fds = (fd_msg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
 

