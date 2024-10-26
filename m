Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AEBD10BE4
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 03:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o2sEsK68CwMXxf8toSl3kI0xQbvN8/oETGeq4Wqiy/0=; b=2dx3m/+57clVrDEpfF5IaR8Ex7
	icS5MMitcgKDU1CexqHF494+rXgi+Mu05OCdxQiizOxg/yC5LRyAd/0p3zUFs9spSD/0ocwU2qAhK
	lYBjwq6lMUpJ8fT+QTPgCAXWEvRjKQZrm8YG1xl+O0famzQcJnmtc/4YkY4oybb5ihLxqfm+AVwJZ
	EDtvdOrUD5GjNjLw8baddUnq0J3Caz0lANSRo6JdCEuD3pwBOGZrruDbFa8JIG+rxS//DHqKrpI2/
	EhxhWKSjmZWCL5rxFPvd2rba1cnNEkjOuh53lH5OK94gBPE0Q/h1Eyhq+fvQSwZ8TM3onQQqol7xm
	gdbs7ufg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4XlZ-00000005qw6-419o;
	Sat, 26 Oct 2024 03:47:05 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4XlX-00000005qvc-1T3E
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 03:47:04 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-20c693b68f5so27282965ad.1
        for <linux-um@lists.infradead.org>; Fri, 25 Oct 2024 20:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729914422; x=1730519222; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2sEsK68CwMXxf8toSl3kI0xQbvN8/oETGeq4Wqiy/0=;
        b=Qeaf4sUyqaw03tqD4DRVA3mJniJVKeZYhXl3oLhSqpxoGYu+7HUFaC7269aNmgdKIl
         Ln7XpSohWFXGtvzlJJqv9oBerUuMoNldNyIhr3CCk6/Z+lWF/AKv86v8rPF2tHJ4sO38
         v6n44k6bLM2VUaz0jj3hdcoJmHyHpqNAC6h6YhxWbrwi1WW7nrXva/xsGlpzgfrWryEj
         KBGZ3yLbgNPG/psZOt++CL7w6KAfMpGFSwNCn3wkdpNsvryLJNvXTNzqcY28DLqs1xyJ
         nopiN0JwDX5uFDbnA7/52SJ9Dm3l2M2DSYn6YmfTyGLytYD8nchFZe501c+LckW9MYj0
         DxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729914422; x=1730519222;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2sEsK68CwMXxf8toSl3kI0xQbvN8/oETGeq4Wqiy/0=;
        b=dFgprBP0dTbaK9ej/DUc42eaZ6VhqF3SXOUN8J8ij6PpVGm/ImZEv6xT+lOsrIw1Cq
         0Qcuk1j/QjLiFqkd49wnaazKUnNrbjZ1cYgWd/aeP+tpikqISXwIYCM6b25fgEwGpsHR
         HjM0nHd1dQ7ua8pbuu+expjkkZi/JAA/9gd3EM458sWZhU9dYhPJIhW5QFJWFKnbNnar
         14HpmjqcSbp+roSiEYV/dm4HI0CgH4W9Aul6gcQJdz7n1KPzoZAjecYz6RrEQqHurh8s
         0KxLw5c0QBwc5wMwv6k/IV+z+hJhJF0vLohPLWSIgWCznQtbLBj7ZxwZulAKwgZVggla
         cV3w==
X-Forwarded-Encrypted: i=1; AJvYcCXSI2KOhIFRN0MOn4Hq6uJzIyINzWtiiVA0iKQM9cH2csIjy/og0DxSI3gZ8fAgoSbQRIMk5gQs+w==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywo1244+b2uheDVLCwBd+zkBZkVmxzlnDGnJsOGP4GOmSjCkzaF
	dM+dI2Ddb/UNx68peagIn5ae8WQnQvKx2qhksvhvV1ey7gWCpDsE
X-Google-Smtp-Source: AGHT+IE6vFRIGposdfIGkKNHgDwb4FYyCPbH3HhoBg041NpIXzhhDVZxW88o+VKXZVUXEUFPDPjUlA==
X-Received: by 2002:a17:902:d54c:b0:205:3e6d:9949 with SMTP id d9443c01a7336-210c6ca8b6cmr16558935ad.52.1729914421977;
        Fri, 25 Oct 2024 20:47:01 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf46ceesm16939235ad.44.2024.10.25.20.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 20:47:01 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:46:54 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, kees@kernel.org, tiwei.btw@antgroup.com,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH][next] um: Malloc just enough space for fitting pid file
Message-ID: <ZxxmLngMg3iNjOfK@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_204703_429624_08A8BA9E 
X-CRM114-Status: GOOD (  10.67  )
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

umid is already generated during make_umid_init __initcall so there is
no need to allocate UMID_LEN bytes to accommodate the max possible name
for the umid segment of the filepath

This patch replaces UMID_LEN occurences in which it's redundant

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 arch/um/os-Linux/umid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index eb523ab1e218..513a2cce38db 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -212,7 +212,7 @@ static void __init create_pid_file(void)
 	char pid[sizeof("nnnnnnnnn")], *file;
 	int fd, n;
 
-	n = strlen(uml_dir) + UMID_LEN + sizeof("/pid");
+	n = strlen(uml_dir) + strlen(umid) + sizeof("/pid");
 	file = malloc(n);
 	if (!file)
 		return;
@@ -394,7 +394,7 @@ static void remove_umid_dir(void)
 {
 	char *dir, err;
 
-	dir = malloc(strlen(uml_dir) + UMID_LEN + 1);
+	dir = malloc(strlen(uml_dir) + strlen(umid) + 1);
 	if (!dir)
 		return;
 
-- 
2.47.0


