Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C751CC531C9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 06:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ECAq2HHkx64xjQNq4vcplIK5gaCkU9CTmJdsLvKXm0A=; b=DKVpLLHKZMifkXBlz8815w2xV7
	MVCGUGPwojp/IgLlX6reuVChcUTnRc6Sup6pQAZDC2fW8tzNwIt/Q+IvS054KsqBImPL8JW8T08mP
	hi3fvdtekeKn/A0mKON29RrCIScTCvKlNHnjNoMntYtAMdLSi8PZDd8UTfohQzybYqAoeQpLykVVm
	7zOQrPLjL3CWTY+/6Q3htVkl65RlGIdBLWdAiHhj1loohU2uC6AKFvUNdX7WhiPCl4HMjKzdggaQi
	JNGiEXZwmESbwelh8siUd1+Ka/6H+CWW3JMmGfIx9MAWpGHH0WnohnSzuoDkKz5kW/S6PPQBbXOLX
	cP9rDHtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9jk-0000000Fdcm-2NOT;
	Fri, 24 Jul 2026 06:50:24 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9ji-0000000FdcN-0Pvz
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 06:50:23 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso810690a12.0
        for <linux-um@lists.infradead.org>; Thu, 23 Jul 2026 23:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784875821; x=1785480621; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ECAq2HHkx64xjQNq4vcplIK5gaCkU9CTmJdsLvKXm0A=;
        b=j+OZd75IbgQFEKP+s+Qbbcu1WF+9zJDYgj1HtxaQbPx/MWRqA1oVUL8aoC7QDQDjcM
         iWTOAJtk8S3nyIZokKctLZZxqEjOSuJ39spcUOWEOvKJ/CKVipz6WGC926OxbYdZXpHh
         0xRK6WDtICIbeR9WASKh1G5PanIQglm/FJKUBw/1hw4F8k0D0TncEJSRINmgEuai5oSC
         p2UQyyUXMTEpmZw89ErCQAAnZUGIWRfUBr41azWzYw1FEb44ZaxCdq+K0DmDyAL8WCOW
         YYwCyUCK6emX87GzJP47uSAS88O9E7ORkXZZCcRLHna3DCf1XM5FNEVdfqy557fR0PRJ
         Sh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784875821; x=1785480621;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ECAq2HHkx64xjQNq4vcplIK5gaCkU9CTmJdsLvKXm0A=;
        b=KBFYZ+AceGsqJCtpM2tvBQY//AtashkamCKYd4++/byJ1r8snuXXNCV1g0jj6CHsrS
         KFTB/YUG8WfilpZlIXvGFbLpmAVVsaLklIK/S0FoY+3UVQTPVSsYjbHqhXEdn1ST6tqk
         Omgc9Rqp1nN9XIiDLI1PZ61rNujaCxad5UTByDS6dcLNzlkyUvqhJQefeOlwNLhUz3CK
         xggJGyTBmg4QPPtbVdJXE/rjtaiVO9qQzeSZftyg5m6F+JruXMF5DEDUzrVtXE+pySc0
         DWuFFJne5IjzqpL2TBxmKMMZT6wh/c3BdENt2sTxOpcS6OToIZn8T/8x+zYchJnN9EeR
         gUGg==
X-Gm-Message-State: AOJu0Yy/Ntw5R9QZuOYim4VuwtxyVpQwheNAmqKfTwRU80Eqle6RnlZv
	swj8luWC9wFLTwXpEjI8PAPxEbjPirk4MtMte2tNnZ6xngoSy/sUqMvo
X-Gm-Gg: AR+sD11FSv2NrTNxP0GwbWsINUvjdtEZJmhPlnTAu2SrxFVGjUkt2BbaJZFMVpvyPmd
	A01diaJfmZCIucRqWqTkKEXQOgQtBdJiAAC8x0LXtE48tm2F9OHyeueHAw5UFH+XTIqEpOfI5P9
	zmBF3SPDhTpARF9Fi7JODc1w4l94g8SwkluMVHsLvD8lbXvVLHfkSdp5RnB5SPfdOI7ThNe8GQt
	RrUS6w3+6vL9dQ8WBtomhvr6F2x9VEjrPTOfzvlYnav/ipbla//BO2pM8JjneCsIkUH+OAd+ELN
	Ey8RoVCpSqkVbntosY7sHa8TFq9spmorfe/JsOK6RuuqdqQmNAhyL60SJ68RppMQpYIsIZbAQR+
	/aAJlf0LOwOF18EJunZF1vglodFUOeqaghDkYlfWaTERpb+z96INpEPJgst633iDeChe1DZCW20
	8uGxi149XwC99IMg/yPRsSFSp2+wTTExSvxV+2iZa93K8VfWncwFhBa5373IVfMPZax+RVSnJHE
	5fxUKJfbhCMqdnuOEFt
X-Received: by 2002:a05:6a21:6e86:b0:3a3:adea:83bc with SMTP id adf61e73a8af0-3c44c9b25cemr6542196637.15.1784875821022;
        Thu, 23 Jul 2026 23:50:21 -0700 (PDT)
Received: from jupiter.local.gmail.com (179.62.31.150.dy.iij4u.or.jp. [150.31.62.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0d7c16sm3745642a12.5.2026.07.23.23.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:50:19 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:50:15 +0900
Message-ID: <m1ecgs9908.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	liam@infradead.org,
	ljs@kernel.org,
	ricarkol@google.com
Subject: Re: [PATCH v2 04/10] um: change machine name for uname output
In-Reply-To: <20260723113633.bcaf234695c5.I226381aaaf6dd46c559b0e694b29370d0102ce3f@changeid>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
	<20260723113633.bcaf234695c5.I226381aaaf6dd46c559b0e694b29370d0102ce3f@changeid>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_235022_146858_D59BDB11 
X-CRM114-Status: GOOD (  17.26  )
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


On Thu, 23 Jul 2026 18:35:45 +0900,
Johannes Berg wrote:
> 
> From: Hajime Tazaki <thehajime@gmail.com>
> 
> This commit tries to display MMU/!MMU mode from the output of uname(2)
> so that users can distinguish which mode of UML is running right now.
> 
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> [remove / to fix regression with systemd userspace]
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: regression fix

I'd like to know what kind of regression did you see.

> ---
>  arch/um/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 937639edc295..1f85b73d4abb 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -148,6 +148,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
>  CLEAN_FILES += linux x.i gmon.out
>  MRPROPER_FILES += $(HOST_DIR)/include/generated
>  
> +ifeq ($(CONFIG_MMU),y)
> +UTS_MACHINE := "um"
> +else
> +UTS_MACHINE := "um\(nommu\)"
> +endif
> +

with only this diff, there is no visible changes with uname command on
UML (both mmu/nommu), as setup_machinename() overwrite this.

maybe we could drop this patch if we cannot put a name 'um' in the
machine name ?

-- Hajime

