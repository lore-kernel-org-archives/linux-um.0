Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC2DCE8D7B
	for <linux-um@archiver.kernel.org>; Fri, 14 Nov 2025 19:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aI9onR+f63JFzaNIBKoGx3OAwegzLui4sLBarF2xej0=; b=jlIGn5FfVZFOrAJHBxsNaGHzlt
	1jOBYguk2XxIDuWj+euyqa8/0PvQ9oFzDs8ea/yio1jDhCzOUfr86870fIcM+t9FeNKHANdnawO/k
	1Bot1Hj0jQpjSL7XlPzVU7n1/vlCR5vaGFfCe3aFG9e/CeHs9qfUlSrn0T2luoXuA9zY/DWzb7unQ
	UUEx1bYGUiuOsHcyOLfjMWYiOkR3krUwT7YPw3wILDk6zo1IXQBcPepKWLTtAd93GCL/rCXDsepRO
	FD8spSznTELC3Gk7K+ciqAnpwNg05ATTcHOafYq4FR1wO49BDljlS9TumcCANobD6qkOQEgmslbYk
	9p10UNPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJzFM-0000000D0fl-2su7;
	Fri, 14 Nov 2025 19:14:12 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJzFJ-0000000D0ey-2sui
	for linux-um@lists.infradead.org;
	Fri, 14 Nov 2025 19:14:11 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso3681771a12.1
        for <linux-um@lists.infradead.org>; Fri, 14 Nov 2025 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763147647; x=1763752447; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aI9onR+f63JFzaNIBKoGx3OAwegzLui4sLBarF2xej0=;
        b=CPJtyGm6/SIA/AG29uAl68qyfDImNTENjQDFnEHUtX5J/mhyY/ozPi0lRUHvjLYZQL
         Fw4HioYTB8UyEXyE2s0ozxFk/v1MFCshPPmNFA3ayN29PlOq7Lp7JuYg53xIHjuc1D6q
         IpkuzoBJQQ/xtNmVcBMEokXYolcGQkLPdMvfh0CoKOB/Sn1TqafIRxt1Q5iWVUTo3MWg
         pjkH2Os9t6GKU9+DfHTjpdm7drq+8OgzMjejLsXRWwDu1nvnU94ku7t0MMXmilyLC+Tq
         CgPQ/SCYYJMP1sRdrmH4IUGAJ3L8jp8mkvhIqxsW0lmt0M24sskb/B/CszKZZyOB8toO
         pZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763147647; x=1763752447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI9onR+f63JFzaNIBKoGx3OAwegzLui4sLBarF2xej0=;
        b=wh2dqAnzkvjP1GJwwsXrExpTidEPmAkq1wDa3bGWqYYccsq3lk4x3Xw59n7tLXh3Bj
         q3T81D9ROALceJqzkNGJI2ka0jEy+9dKDJo/UADOto3eR5981YWIbXRxSpKYIlM+2QTV
         H/baOYZGC5747L0oNFkThCatBEfeW++O9Z92A2SwhlPs1jKmWuyavJOK+QzpCwdYYvi7
         kUoVpuzDtj5u4MClFFiGFPfyGuo1kCs5k6AQNQ5EgMPGNpcrzyvFxd2lkOQjpb5nQ/6S
         PxIViBY/YK3g58h1IwRsSk0eFD7JXFpnzEZRYMWScn2IxBLKkzUhKB1bNxM/BQI8uzEJ
         5esA==
X-Forwarded-Encrypted: i=1; AJvYcCWDN7RBCBrRU+FFX4T5RMbP7pFRZUhSnNPqgSzieDkETHboFrGmUvtufNjWGFF8Xh5d1FanH6VUsg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywo6WKJmoRIRXndHMFIO9ZuMcxjfy3XG2i6DNsndHVV9Fc+ZEXG
	7aBFOfnwjRZN1wsuYtXMvq42oz/cHhFMr3g3+6j0NZTh5PWHwA7m/DjSk77r2WMGk6TE4w0SKHj
	m99CRcphC4Bb19JoDmvSva7bDLjGOcuQ=
X-Gm-Gg: ASbGnctDyFbSUce7IRglM9/8BA+QqQrIUJglUSi8JGUtwxuLMmqP9WA4Y/0x6zXDIdZ
	aWjfrbFJaU0vAYiqayYTa256i4H9FgMDXVw6JTKYRggkEBMZk3M9oLSQ3LN/2us52cN3KlbtUcc
	aPHRfzImIKfgMohMDVDZOLcf/In4WeCRsBXRId/UJYggzq7KHEI03AsHVwkWBRQYpbAyTmn3g9a
	nYgej9VEQHEzGQUEK1qxTbX7IrVGKk3Awwb3NxL8olRcM2LbxxF41F703i1Mw==
X-Google-Smtp-Source: AGHT+IEvBu7ESLrGNRMv2QiwL16IZgt6aUNJ72TYzx+vz9COzg0vAhK2L9oI/n3nL6QJ1JU+lRhqexZnJfrgTYt3DEI=
X-Received: by 2002:a05:6402:4603:b0:640:f974:7629 with SMTP id
 4fb4d7f45d1cf-64350e225e0mr3893696a12.15.1763147647239; Fri, 14 Nov 2025
 11:14:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763117269.git.zhengqi.arch@bytedance.com> <66cd5b21aecc3281318b66a3a4aae078c4b9d37b.1763117269.git.zhengqi.arch@bytedance.com>
In-Reply-To: <66cd5b21aecc3281318b66a3a4aae078c4b9d37b.1763117269.git.zhengqi.arch@bytedance.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 14 Nov 2025 20:13:55 +0100
X-Gm-Features: AWmQ_blqeEJIFeEqLe5Vq5SGpFC4UPadwiIAm270RAB9lR4JL9-RyEZ3PVaRM7w
Message-ID: <CA+=Fv5SGu_Y-zwryrQiTQDy32SipMk_dfjZezth1=aZmnDKNeA@mail.gmail.com>
Subject: Re: [PATCH 1/7] alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org, 
	david@redhat.com, ioworker0@gmail.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_111409_741792_6EAD395C 
X-CRM114-Status: UNSURE (   8.21  )
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

Hi,

I applied your patches to a fresh pull of torvalds/linux.git repo but was unable
to build the kernel (on Alpha) with this patch applied.

I made the following changes in order to get it to build on Alpha:

diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
index 7e9455a18aae..6761b0c282bf 100644
--- a/mm/pt_reclaim.c
+++ b/mm/pt_reclaim.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/hugetlb.h>
-#include <asm-generic/tlb.h>
 #include <asm/pgalloc.h>
+#include <asm/tlb.h>

 #include "internal.h"


/Magnus

