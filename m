Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308C5C61DC2
	for <linux-um@archiver.kernel.org>; Thu, 27 Aug 2026 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjW3UBtBE/XmT6KkSplPYiM6V7zSUQJYuA80LoB2NEA=; b=T99QEjlv75fgNm8M2UXedIsN7z
	Ke0S7bh4SGQ0Xph9FZ7RU6PalF5LKFWVMj+j2L4Dqa7nJsTZHydeEhic3qgjWhmKl212fC1WnnyVl
	bcYZjkwRh54YhnI32frKqGwhTpTGHz9Or2B0R/4DkYG+TeLQob6FUOb684xRXeY9c5P0H3B93Efvf
	ii7NXoJTk8NFqVejqqNcfRqFWbs2s7b7Fj9o1Y1GgM3DDHXPOGoIb3sOmz6+fFB0QEOD/0om0QqhS
	NQprUkIX2yM1pptLb4KO95BexadwXmkz03A3t2lGV2THkI8lLxyivXdOBKOXYK1jtUPSDS5jBIr1O
	c6b6kGgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzVvY-00000003hF0-0QIP;
	Thu, 27 Aug 2026 08:57:40 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzVvV-00000003hEG-2iBY
	for linux-um@lists.infradead.org;
	Thu, 27 Aug 2026 08:57:39 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2cace91f112so21668075ad.0
        for <linux-um@lists.infradead.org>; Thu, 27 Aug 2026 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787821057; x=1788425857; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wjW3UBtBE/XmT6KkSplPYiM6V7zSUQJYuA80LoB2NEA=;
        b=ZwBsBIXN4kagyBVXLbNIva4gKJZKCUGn27M2BQVFT6/v7aITiBHIVuLCle3tgyXGNa
         ihMXqVlaU/ZfjIgX6ub4HRQwqj+QiNjVqsLmSmvVJjzIE7GNVEqaoN5aceXuU4kKAwLe
         GaO2mt/tyEOlOh759kh3l/MYAtzQ1fCK1XQndaSKXv+WDmz1bnzTUnCaif6uvWq3wPDv
         Rx1r9uc3hzOeGGr9EpFurk0EhECmDmIktPdquLK+FJsZnc01DyapP3SUDSDxQ9eTq33l
         AGclOpuyG69v2l2JfOAR1AnIzvsaPZSO/mRfbKRijtYoXArMNyUalHzs8t/X9jsRbLRU
         vT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821057; x=1788425857;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wjW3UBtBE/XmT6KkSplPYiM6V7zSUQJYuA80LoB2NEA=;
        b=M6xZlyguHyXeGRu4BKBTTtT9jfH602SwUDiyXEqU6+XnZGiGBlJw0KKgmtZyu4kPqb
         hrC2kvktrRQchy+sHrJlHaWpDhwXXEPfY9pnosenOTPV8G3B6I9WZ1a+8n1yP8srR3nQ
         pm5fZIzRZVnPGf6ROTZmUE7ZSzwiLw+hhTJvtnR0kb6dFT3lngE5bHvUNfQlmHOBKFpG
         6xxAk1uACKfmZtUTBhmrUyD2MJ5t2NWZ1/ccSOBVO1+QDEVM3Q4+fJHUyCum9thZ+PS2
         mzhuzMH+CfQoBCulkDmXcEqD3kIS84Embh9pwPl0idpTXt6rcQTJU8hrnremF+uMQpdu
         V4kg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0fOXI1eMKfYOaMhPj849RnEY9Xgdz361PsW/5wg0s68UT8u5DgH3hP7V5YHTRoN2GirIyh0tq2g==@lists.infradead.org
X-Gm-Message-State: AFuF++lWxnu2ec+m5+q3PJS03iZ8MPanuAsOZKcu3ZEMfOZiE5L3Tzub
	dQTWabUFIVRNWbCTG1A4rkX2ps5utayQjm0r0HEwVsA+pKknrnolys3x
X-Gm-Gg: AR+sD11VSSjw8BGQVRuKME9dP/f6KTUQuEKY2NEoiydCsXrZDcU3hbAbhzm4njR+yyq
	YpT+AG1qFg4WwDtk8SAR8bEtfU0scg9pRkdAfd2MDKN3lv3McJhyu+H9FgrXu6qls5Xsd1fMMKJ
	6uNkiivsa2ohdvdfo5viMsJgFHbYJdhIMqKipU32fOZXztn98ZdTS/Qse39NXwPJzsb1kX84BBv
	H2V9+zXSS2fajAvWrUZKyJKThz6aLnxywVpRTKoZ+R5Gc+DMQPUw4EqI9zAxRmMXgUM/Bl+FeJ1
	qv7pxPxGZQpt69RD5nkI20QDCZL2uLgWAio74CLJ36SsfaAylHb3n6Ox+0S/8YHNqsWWhvKDCUd
	YbOH36s8GX9TEsdqw0emu9gvs24z9S6Nk4oaRAOj4CDzzzMMV+Ba3zPQW1n5okx/ltEgbBrjRt/
	V1mxP+iMj20JdZVzk0bwvSFKQzoJNwig+LBe4d1Sm3RFBHYAOY+j50gX6rB7nk4lLYTLhpXo+0c
	7ewf7w8EeglovRMcG4+7Ly1GnUmEV/cGaXqfl45DJYyU6qWehgeiiwDlhD+eINOJxslLKztGyWn
	vk7nLQ==
X-Received: by 2002:a17:902:c945:b0:2d7:2edd:d140 with SMTP id d9443c01a7336-2d72eddd21bmr80438055ad.3.1787821056640;
        Thu, 27 Aug 2026 01:57:36 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70493caf4sm15181155ad.8.2026.08.27.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:57:36 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:57:32 +0900
Message-ID: <m2v78wueir.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: david@kernel.org,
	linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	geert@linux-m68k.org,
	daniel@thingy.jp
Subject: Re: [PATCH v2 0/2] support kselftest on nommu platform
In-Reply-To: <ao_541nBaa3SJS9F@gremlin>
References: <20260825015945.141739-1-thehajime@gmail.com>
	<f2ac9432-4fea-4007-aab0-ad80597b284c@kernel.org>
	<ao2Tl9CLL7WjHYun@gremlin>
	<bb9a3add-4849-4928-8b6a-0afc0c73b112@kernel.org>
	<ao2l9Ao7BQI6uRKC@gremlin>
	<m2y0dsuf1d.wl-thehajime@gmail.com>
	<ao_541nBaa3SJS9F@gremlin>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_015737_688652_B72CD864 
X-CRM114-Status: UNSURE (   8.66  )
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


On Thu, 27 Aug 2026 17:49:58 +0900,
Lorenzo Stoakes (ARM) wrote:

> BTW did
> https://lore.kernel.org/all/20260723093633.140989-12-johannes@sipsolutions.net/
> go upstream? Or another UML nommu mode? I've not been keeping track of all
> that.

The current consensus (IIUC) is above Johannes's patches are in
progress.  Another mode which I was originally proposed is postponed
in order to minimize the impact to UM tree.

-- Hajime


