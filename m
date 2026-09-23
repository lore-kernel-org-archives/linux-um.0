Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95A6C98302
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 05:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5EzYF6pBVx8SbOMcLOHwu2cxYGJaiivFeHPjTqK+kVc=; b=tGJvAnPttWSH2xOWCT1Vo1Qkj+
	lvIziV3vlBUgW3NnvJ+XULfoSZDTnw+VFa/46VJO/mUL20T5wbsFM+z6HpyNCKr2nsAB/Xz3tuqvL
	QNxmY9kGO3Fiqvn+lRfNiHzjiKJw/Tkn8GgdyYCyUxhJwsHgDchtC68Rj4oeBrSSpX86L2SS9nfxy
	PKIXDlbzHbYWHn+RTxSXjaZiO+pkrF10iZUdtMdlIkHkolW7prEXp5niG9JD8ZKz2Z1HKVjFFEqfi
	qSmXp+WLFscYr8l2s7NmeeGoIxpV1LvQ6s4ebT9j48rviFI2nhwikpyPWH5UH93eNbyvc0qSK4g3o
	TiZCl5Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9FAU-000000079qJ-3kjW;
	Wed, 23 Sep 2026 05:05:18 +0000
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9FAS-000000079pz-38qO
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 05:05:17 +0000
Received: by mail-dl2-x0f.google.com with SMTP id a92af1059eb24-142dd025d07so404646c88.2
        for <linux-um@lists.infradead.org>; Tue, 22 Sep 2026 22:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790139915; x=1790744715; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5EzYF6pBVx8SbOMcLOHwu2cxYGJaiivFeHPjTqK+kVc=;
        b=HZcSJgrnIrBIWmel6AHx2Ge8wUEawd5y/AWpIE3zmra4MSiaGS9ovPy2ArDHyyTL0E
         1ekAk/2jFuYtzL+b+qUOnuLa+PXtvhAIusRf0jGc+H2J17hvgBH7+oXbDIHsXr2jujgh
         2DOM8d/bWi9eM/DmyEumYBHc+nWQdMeve/ocGl6pinMOyy8IXJIo1orGniOT4rPslxQo
         WIxiOM1T5t3ORURBLdYnOXQZXUoxNUA/IySzb/+A57hmG5+jbtdh98kO9jbt4IGYHt36
         eUZOQgYpI53WJlClSPmdX0MGRrfOD42zsKRgShqlKTUNGd9Dyj3RwX9vtcXSGlbx1HKK
         zm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139915; x=1790744715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5EzYF6pBVx8SbOMcLOHwu2cxYGJaiivFeHPjTqK+kVc=;
        b=jT2SXmtG4nFDS2XkAqfl29zu3ZQfO53wW3u9CvVY2fE/aDLVcCVlJ2E0q21U+k6YOh
         EqKs8i1djgrJHwNPonYVyYjwuwdZS99OhzcQb+9Ypi/hWefwCbMPuXB4kDpdLkGmjjH8
         2sbBk0zTofIMyRoo/16gKfd0sJdgUgbc6tgekanmSGxz9dQlZ85G07R1gieYfB00N4AU
         Bv8rvo5y1pf/sgAzGNijF1zoUm9CV1BcxbOmahO0o5std6/CX2EbA43goqZBEcrmHcEl
         BxMp2n6PHAGZQTsyyNN5hPXqQ80Ogsi2ZjX9KCSF3m+FGhBs2mfuXtBnFyAwl+nF/iWB
         BmOQ==
X-Forwarded-Encrypted: i=1; AKwUvBydA30T7olACqNThDv91sEjYB+o0T1WdDaE1B25OiFlIX98T5vxg0TQdDda1f/MLpvNLl+Mj6UEVQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nTuKy+oL6+RMmNOcZVnxKGt1PZ9n3ptmWclExjMZyO5UwcNH+u
	jmwT7gVBviEwi5ohFmizwIKy9TtmRYgz2muRGHB8pUH/r1n4uf9Fqqrb
X-Gm-Gg: AYBFou0FYHnhdWK4ycb6qjRC846kvvVKjBo3Aw9cxrTITXQFKcJS5E5nHRMtZASoxoO
	KlnhzaYTzKYrXvJ7af9c2td29x/2rc100Xcx0vpOOwFiQQ0mFWTNfzfyJriLxNy35ENNJUc5ps8
	VWc0wESAEKaA6D1cFhAe6kp5oyvOP6KXzRwH2N0HPk1FF0LDKUQ5oDWS81rSk1QfUT3gWx8nLok
	jZX/aCfdMV/l710TzxENHWDCype1zCTjvvfndCHA1iCLziNfLSJud5EJQFjSk01uBghUZpCbhXd
	Jg0ooXaOKQgZOoDHK6l4vR8bgLOolJLhJr4tBj2r5sQEs1bpE6K9XFp9mPAb0kEn56FFQ/u+fZF
	9bpOOJHpi3jwKypjy7e0fOyjIYAJc/o/BD5Ww+VOq8hUvaEc+5PypAvmWG95HQbYodg2G+SqRZa
	Rzx6nT2mPVpjxmmFtV6s8YSnWm9XvaId0HWaks5894VcbgSQUbOQOsD0m8MSxq9/FwoUpa+y9rM
	43vrLa7Zhq8BDespR7GiySRPKEM
X-Received: by 2002:a05:7023:902:b0:144:edc5:32d5 with SMTP id a92af1059eb24-144f915d60cmr1863121c88.22.1790139915132;
        Tue, 22 Sep 2026 22:05:15 -0700 (PDT)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:5377:c447:908c:8a13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983c5a1sm4481075c88.7.2026.09.22.22.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 22:05:14 -0700 (PDT)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	alex.hung@amd.com,
	linux-um@lists.infradead.org
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: Re: [PATCH] um: fix CONFIG_GCOV for built-in code
Date: Tue, 22 Sep 2026 22:05:10 -0700
Message-ID: <20260923050510.204386-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727195515.2306731-1-alex.hung@amd.com>
References: <20260727195515.2306731-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_220516_811271_A8E2D6E7 
X-CRM114-Status: UNSURE (   6.09  )
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

Hi Alex,

I tested this while investigating GCC/GCOV coverage under UML using KUnit.

Tested on:
  Architecture: x86_64 UML
  Kernel: v7.3-rc3-61-gbc77531b2a6f
  KUnit configs: default.config + coverage_uml.config
  Compilers: GCC 13.3.0 and GCC 16.2.0

With GCC 13.3, the unpatched tree produced 731 .gcno files and
0 .gcda files after the KUnit run. With the patch applied, the
same run produced 731 .gcno files and 704 .gcda files, and LCOV
was able to generate coverage successfully.

I also reproduced the same result with GCC 16.2:

  without patch: 731 .gcno / 0 .gcda
  with patch:    731 .gcno / 704 .gcda

LCOV coverage generation also completed successfully with GCC 16.2.

Tested-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Thanks,
Mariia

