Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A66CAC582
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=; b=BEkAn2xfC+iGXQYLsDoSqw2uim
	rSRys9B5cP0c0MmFaZZA4BGHkLO4ixlB37zqnDxumtuTc3WgirqxFNzH9hujH4lDcDnH4H8NqhmeG
	bMTZ7FCl+1JBPk0i7phZ4e26ITHvGmKtcGS5I0IbUpJHMPXQgyyQhtJLXnUHce+9Aef+X7Aib9S6R
	2+7dKq3ESx1NbxL1URvJ9g0tBmlJpsHyACLWjKedcObqwdgJWdeXNLVLuYhCzIqohggBDQZ23lEST
	ZCqU+G1Qt0TnB37/FwmfsEQaMjJU6VL/OLPDsImmmO36aEwOLNWoO49Ukgt1rdHkw7r5loMRhyGCf
	PvF6aWWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCu5-0000000C0zo-27zH;
	Fri, 12 Sep 2025 23:10:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCu4-0000000C0yp-0pgQ
	for linux-um@bombadil.infradead.org;
	Fri, 12 Sep 2025 23:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=; b=Lim91dqA0HsJen1OY8TPnyPIiB
	6+3O9ucaLy5CBBJWUkionQor+X7kQHvgG0I2BnPzBAFW3+FkGR5bKpvkWjvwFMirg2bt9L3VutefC
	FEEDII6D9+WovW2vPi7PQZ2xrqye18zINvK6Fcv/qT3waSd0AjrsQ8aUFUW9jAZx25nLPj8Ay4uEe
	bf2mH6wzyXBxkjvLbI7JjsFHsqArtbC3QcosbFq9YTSoC0ZtlqSuMAmZpuUCi3HsX7xkpiDjN8Hpd
	Leq6DeoJ1Q/y/L3SI92CChCH4RPu8VP7G/Cty3mkGRrgjXbWMTwFn8LWA+OuRlWnguMaGDgCEOGJa
	k3m4Y7NA==;
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCu0-00000006TNY-1EPI
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 23:10:02 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-32da88701c7so2547187a91.0
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718597; x=1758323397; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=;
        b=i/lFuIho6yPKMVPGBa7TiubMgMbdwUrJ98jZMr0p39BsiYymz+CUUAI6jjBHlbIYfd
         j8Yzj4jUbkd4Oc1vQ88cQeIYe+QeQaetsGf5nc8uuJ7CqIbeUcQlKP1wyFv9ePK4ZwmM
         TjOGM7CmPRtzcOQxDtu5Q/KpbLTC3QW1ycS0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718597; x=1758323397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=;
        b=qnSl9+X+DqK/yyxVCbMzwXA3Jq+WU6ziKDIHzMYG2JTeB6mkF6kJjRRRxo9m5nuChb
         Fow/CBGeBJtQ1QeishnazpKWeoKZTtWmOl14Z/KZltIDqKJLNz8JGhdCEUMvDz8aqSXV
         2WhsFnbVHzYwgyhEx/aQCtezi08B2zMxcwIsx2BuX7xe4Z0/pUT42Of+tDNg048pG23q
         qWJimqoLxidUKqYIUJ4xMXj0ywUQZrhTzfRQS2GvTLCXAyIFW3WOvUEznw/L5glXxouF
         FRhyNJQ7rj9wffukqSTzPV6HeToGlCm6Nev/XsojZrEu5YZUmWRSh10nZA/5drUlknUg
         mKQg==
X-Forwarded-Encrypted: i=1; AJvYcCUvnRmc8RJj3MjxcS3yW+NAws8iukCFXSGmUkLl9/JnXp45wZc5/odWmECIFNSTCW7F2WZ1GH2WwQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHhi74SwWuCmzUvDHTNA1hXTOJwKkTln+xHJkVsqf6c7Io3X31
	hEnFxgXO1UheGwdWtiurcGefNBmcwTHisq02vUrQ8zyZX/o5KHM0UV+fdaNkjTCjCg==
X-Gm-Gg: ASbGncsgvaA1wb16aK2UODGdlMb6uT/L5CqvgMCDmRgEsLK3eq1vsObvZuuZlwy3ifG
	TX+1o7I2aaqpxMUWFEC+YhV3aAUO1W7/YrWFeAa/SF9bWfVybDAneRlhGN1pt4hu46urP8gJ48s
	A8KxayI4zAOKL+cHGQ68Libiy4PQ3sGiOovkgTt5dQTkrywV9oUeLME8J35jR00ZQoqAjppwk2a
	WrgEuO005jxx9IttigTwVeqa8mdfBznrET8Ckw+ucFaTEqL2uhJP7ofqcKqehA1tAxsuOk+bDfO
	Bfz/AxgP3fJe/rtpNI3SOy+nyo8IHvum5t3n9OcOaa2gMPc+wIDzslGO+dU1xL/IN/jSc37GVsK
	ypt4ZeofD6kSJzZ3GOLbEtK+LKblu1frjUcR3KEzSLXXCmmGZc2a4I5J1nIE=
X-Google-Smtp-Source: AGHT+IF2cmiYrFQ1xKWdEqefxU7NdVKHQQ304cYE/Le3s9iB7z7uuIXrlH2bNcZ2AM03GLoo+rEoOg==
X-Received: by 2002:a17:90a:fc4d:b0:329:e729:b2a1 with SMTP id 98e67ed59e1d1-32de4fa1c8bmr5042000a91.35.1757718597437;
        Fri, 12 Sep 2025 16:09:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32dea223ddasm1310790a91.2.2025.09.12.16.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:56 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/4] um: Select PCI_DOMAINS_GENERIC
Date: Fri, 12 Sep 2025 15:59:34 -0700
Message-ID: <20250912230208.967129-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_001000_640692_6F3A3426 
X-CRM114-Status: UNSURE (   8.39  )
X-CRM114-Notice: Please train this message.
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

This is useful especially for KUnit tests, where we may want to
dynamically add/remove PCI domains.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..7fccd63c3229 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -38,6 +38,7 @@ config UML
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
+	select PCI_DOMAINS_GENERIC if PCI
 
 config MMU
 	bool
-- 
2.51.0.384.g4c02a37b29-goog


