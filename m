Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E90C02187
	for <linux-um@archiver.kernel.org>; Sun, 19 Jan 2025 23:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZjR0D9OJYkTv33+1FaquvTR2dO7FT7WfXiaS8Ty4sFE=; b=nxDWkcdBKwi1Xm
	T2ChRIYoW217AaYUzbOslUE73ugBZuruh6RNsaQylmW8Ypf0etbuwVnF4XjBV0OU6a5o1MhulmhTz
	9NridA6WYh2w+gBsSBDRJJXlcZ3nydCicWtMm+rMv9vOuTMOQcZkMu2/BpyhRKFDT/LR/RM5eMELl
	+kynP+3kBxd+RTNViItcIl7WhPOGHIK294CtySuy0iSk4tAebjTEq9ulUivEDHnt2dpwbcBce1TbT
	Y8edun28GcnRB9U6VWovUxBiJKaGlX5Bm5+8FTewl0/+YRgQaq2jIndOwXHVmIsU6FRUHU8bmHQBP
	NAeA0lHHWASMARWV3mHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZeft-00000004RRi-3aSi;
	Sun, 19 Jan 2025 23:25:49 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZefr-00000004RRI-0ttQ
	for linux-um@lists.infradead.org;
	Sun, 19 Jan 2025 23:25:48 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4679ea3b13bso36857951cf.1
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20230601.gappssmtp.com; s=20230601; t=1737329143; x=1737933943; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjR0D9OJYkTv33+1FaquvTR2dO7FT7WfXiaS8Ty4sFE=;
        b=zJy/9Zsw3zPA9LoVa7mjziH4EEvHaeZbCkMJwg2AwHP4zHoken4rlxttATgsbZeF5o
         ChwxIdquKhVnkyLmim8X4U63ZXmNAgmd75cZEOywI0SeQ9poYIuc2RzQJxEp5IqLVr1r
         Zlw4AKciTkD7ESlL/pxWwTN/xCdplV0dENlpZhV5ybEhQbLzQ54sBAXd51olnfZnT/zT
         QbatVwXwSgxwzofqq2DYUo0JvEoN6iK9eTir6Zyu8nPciG2Hd47OzdRJP4VbFt4ZMl+t
         1UQvcgtYLHWUgzc9rQdEslPA82nCbguOa2uw1Rs2IKyH6nTPnSaIfbv2Hid2nszvvUzq
         v0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737329143; x=1737933943;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjR0D9OJYkTv33+1FaquvTR2dO7FT7WfXiaS8Ty4sFE=;
        b=peXwOXR4d+aJ0apukbk+ml5LvWfhNkhHn7pIGKNDCv4K/B5ZIFgdRWJAuzu//mWrz/
         4SlCw0BfdWlxmpFnnoIV8Ii6vSD6fnh3YRk4cVOtX7KSXDBHZk9gOrn32q/rzjmR3dcZ
         ZvPNmZDQ3o2TAklF3YOfoXSNMX3vnuAV8tS66EuxWnWTGSH4rPp77zji3R+LrmqOjQ/z
         tTW7TorUTbhux09BoYpb72ggJ9KDCHJff37+XL3F4GTaPWwkfFk8lwu05j2SfnxVFisk
         CHB6eXEUobh4fVBa/rivXY+8apreLEXLGv3Vks2YWfgW6EA3OajGeAaL4Am9yoz+kGD/
         dbwA==
X-Gm-Message-State: AOJu0YyXbJuSRTfdeNOa/rBDfX6ZRfsQZJk3qo6ckqpZqI323Uj3CRii
	WU5zRPoRh+tzRC5rnAuE9fSA4/fvuMwy2Ab6UjxtcsLbi7hU4MhPA+nKQV1p9WbyDimIcVODwiA
	=
X-Gm-Gg: ASbGnctiqCHydpv+w5Dc6gXcC3k9beYdKcNcbzN4T1toA698hBmrD1zxczgSuwjwvC7
	o32OPv5SkEaJYG02cbAZ8ZSItmjy89LTlE6gEY+EOqlotENUHaOAw8Udyyw/M1LYwDWRS5ZsfUC
	FrrkQzgslcO+cziWUFELLPPjUfgMxlRpq+gIB45GI8Agj1U31wgnukGg/KOagsH2eC4pHrVjkgO
	C2fSUsbo4OHBLb8P6t4cIloEOeiRV1szaAJD72jwzJma3cFkOt+fizZlkIEDGzZbK5KpwXoJVcY
	9FhUSniJqf6z0A==
X-Google-Smtp-Source: AGHT+IFpedIdGmhrLctO5HzsPIheSTv5SkzLRVmZVhmgKCi2F9klRUzQFI7Gsk25znFwlhBB4fnK2A==
X-Received: by 2002:ac8:58c2:0:b0:46c:7657:5ab5 with SMTP id d75a77b69052e-46e12a58bb2mr173851901cf.20.1737329142794;
        Sun, 19 Jan 2025 15:25:42 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([199.58.83.12])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10321ce2sm36982571cf.47.2025.01.19.15.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 15:25:41 -0800 (PST)
Date: Sun, 19 Jan 2025 17:25:35 -0600
From: Glenn Washburn <development@efficientek.com>
To: linux-um <linux-um@lists.infradead.org>, Benjamin Berg
 <benjamin@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg  
 <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: UML failing at "Failed to initialize default registers" on kernel
 5.10
Message-ID: <20250119172535.42b4bca5@crass-HP-ZBook-15-G2>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_152547_526020_FB54B90C 
X-CRM114-Status: GOOD (  10.22  )
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
Reply-To: development@efficientek.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Benjamin,

After applying the close_range patch, I'm now getting a failure at
runtime where the last line printed from UML is "Failed to initialize
default registers". The host is on Debian 11 at kernel 5.10.216. I've
bisected the issue and it looks like the bad commit is: 3f17fed2149
("um: switch to regset API and depend on XSTATE").

On another machine which is on Debian 12 and kernel 6.1.119 the UML
binary compiled from v6.13-rc1 runs fine.

I notice that the bad commit appears to be using ptrace in a different
way. Perhaps there is a difference in how ptrace operate from 5.10 to
6.1 kernels. I've tried debugging this without much success, as GDB
can't be used. Any idea on what's going on here?

Glenn

