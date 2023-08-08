Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C52C001DB
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aQFn7Xd9GY3poqjbo4N/xsW3jLKOGmCHxG0v991YLag=; b=gusmIIy8UToSEU
	3svczR6ynRLWE03RhQhkga1uFcPRGjDAuXmrHVf5c3ImuvvXNxEDcQ0FNGm4CJKa3v7Vw+T0e0Axd
	Vu1FccaXZDnPtCz9s3eFnQuLI5N4EQUuOMK/HTCJawJqrqgVXxtQ4nIebufF6Ds8I3iFGibS06B6v
	GV0ujyA42OnVsgNtr2K7ZFaXfO2eGOGVZwB6x7wLXLbIA8VuKUqRVEarliqEPISck/m7+BerGMq9t
	fL6xFg/l/M8IbKSa0yHYAo4hJxlPmKQEjb0WzXVrkbyN5N8ywMFF4Pn20NCIDEwRIZkQVPaP9xswn
	fW/8t0WkqO1qLC6sUTqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTRLC-003DUh-05;
	Tue, 08 Aug 2023 18:21:58 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTRL9-003DTe-2E
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 18:21:57 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-56401f1da3dso3429173a12.0
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691518913; x=1692123713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmyLEGU8GSveXQW4ZwKDzQ9yMdM7AfBAEdQ4m4LJOnQ=;
        b=abrxRrd0sYsjaDd1GRFKwJ9nlXO94DqGiXr7ZuKo+O01p4pxbRXCrBUFBLE1aDmbQ3
         wsY30SOQzfkNzCj/bCy9Xt9DI51lUoBHtGGM3JQsYlVsay/aEPrVmh+N2zbcFjhoL01U
         QkRjaFpVb1xh95xm8xeq9ILUL05tHSizKuNgaoQ1IKIOSYY1gCVmaHqUawsleyjGbQp5
         1NMyoBj+bpqFpT0oflORFjNhiXRIZJ22UIbUa4WvKepS/SuimNUV5cWrxAXCP9qNiTc1
         70F0VrWks96BEVtPx3J5dYiY5oE/LzDGQ6l/JHo8VUMC+YYQcRpfrDgRFiqhPMMPwVeO
         35ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691518913; x=1692123713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmyLEGU8GSveXQW4ZwKDzQ9yMdM7AfBAEdQ4m4LJOnQ=;
        b=Kv1KtfwJWGr/rUejxgV/ylYU8+3Yzu/7Vq3bsA+7CZdR3okTNOeNn6TjEQ/kkzL59k
         ZuXoxl/VqKVlc1gh/DxnwBgNjukzao3HfDbQYqoIsNDsr6L3uKi0H7nXnmDjAvPCmi+y
         iwTsrS09kX2rSXXIdfP8wJ6gt+CwIugv4JPycJ+XpqeK+W1ozXuEEx+Hzkzu5ehwfI5Q
         L5eICO7ot/cYsn4z3Aoq5n39UT48PZ7tQ+xVDQMgx1O8wyFOYBI1+MfaTYaHe6SjKwYt
         HCCJ0OVNmDyG/CU2yx2vVMigzdpzfSOC2lFy9iJj/eRC2w3IUFkuXV7wPG4RXUrIOorc
         RXLw==
X-Gm-Message-State: AOJu0YzsxQohvxYlc4weXiPTbqaPyVBMeN37R6HqkgGytzEMYL4UJGX7
	ymKVV3PezTRuWZ6k/zLpcRtlg/CzBRP41dc6Vc1Zvw==
X-Google-Smtp-Source: AGHT+IG/n51ocBB6FRywFFitnfbQeW9iCANzsfD18QE1l0UvN+OO0XnZsX2w3M7ClY3FnmZNCDy5EA==
X-Received: by 2002:a05:6a00:14d6:b0:686:7621:5494 with SMTP id w22-20020a056a0014d600b0068676215494mr242443pfu.27.1691518912493;
        Tue, 08 Aug 2023 11:21:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78d05000000b0065e154bac6dsm8365280pfe.133.2023.08.08.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:21:52 -0700 (PDT)
Date: Tue, 8 Aug 2023 11:21:47 -0700
From: Nick Desaulniers <ndesaulniers@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 2/2] UML: use obj-y to descend into arch/um/*/
Message-ID: <ZNKHu4+MlO3L6wUl@google.com>
References: <20230721171857.3612639-1-masahiroy@kernel.org>
 <20230721171857.3612639-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230721171857.3612639-2-masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_112155_734973_A79C8AE1 
X-CRM114-Status: GOOD (  16.96  )
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

On Sat, Jul 22, 2023 at 02:18:57AM +0900, Masahiro Yamada wrote:
> The single build rule does not work with the core-y syntax. [1]
> 
> Use the standard obj-y syntax.
> 
> [1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m7bc402e1e038f00ebcf2e92ed7fcb8a52fc1ea44
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This resolves an issue I reported (but doesn't seem to be on lore
for linux-kbuild...)

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> 
> Changes in v2:
>   - Rephase the commit log
> 
>  arch/um/Kbuild   | 2 ++
>  arch/um/Makefile | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/Kbuild b/arch/um/Kbuild
> index a4e40e534e6a..6cf0c1e5927b 100644
> --- a/arch/um/Kbuild
> +++ b/arch/um/Kbuild
> @@ -1 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-y += kernel/ drivers/ os-Linux/
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 1735a562453d..82f05f250634 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -22,10 +22,6 @@ ARCH_DIR := arch/um
>  # features.
>  SHELL := /bin/bash
>  
> -core-y			+= $(ARCH_DIR)/kernel/		\
> -			   $(ARCH_DIR)/drivers/		\
> -			   $(ARCH_DIR)/os-Linux/
> -
>  MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
>  
>  HEADER_ARCH 	:= $(SUBARCH)
> -- 
> 2.39.2
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
