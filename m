Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74F8D116FC
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 06:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fW4m5+Alc5+U/bpiXfBbEwyDvB1oVdKKXqHaL1Wh1jQ=; b=tz6Yk9MFonr19gHcpBlQPZAYTv
	KdGHdVdkOH0M+K0mo3tiTzSK2hPZYSwZphZ0xukyDkPDiHnGmQKKCrQQK+e/451mE4rXD5j8OTBF5
	4mmBQqHefD8sXAKs6J+PsV3A8l1l3GOlhGhtw52MQMbXXKZLPuO9fT7E7D7gjRXjZVPrvu4pY7vTN
	wxlp0Xl+3dK7oeKOV4Ie+g2vX8oCHpgw5fB5hLBho7Y9E36HyR81n/eSX1bSjK/oloVLsKjG9Pf3n
	13BPwOT44RlH9drHsMexhhn3wtQaAeA9KpNavaeht9JCIypRbYVvLsGJTDGtxso1G5PEQR+9FIeDO
	YsKMCvoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4De8-00000002f7n-0vHj;
	Fri, 25 Oct 2024 06:18:04 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4DcB-00000002eoF-3rAQ
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 06:16:05 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so16687471fa.1
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729836962; x=1730441762; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fW4m5+Alc5+U/bpiXfBbEwyDvB1oVdKKXqHaL1Wh1jQ=;
        b=Y5l7ciS781NoyflbE5v9qTp9eyvFS2wrC8UL4gQ4l4wOIF1Ym96tO7WhxXsdA3Z/Fz
         u1m/FvgSvfJnbrLs7f/kGIer3mJqxIyMsKXTdGNJM9ZlB4AlM9cOui4hQ1/QNqw0FAZq
         MkqVsg9duy6IuS3z9uIYk8BAMm23YWP/mhxcgO/9Wa9MViX11PTmsEpjljeAmJuwDG/e
         VRmr5GUerH4K8r/j5zJnGE7waJFGrNZoheTiI0t7M8dPamPqqluo3TDwWJVifcYTDV95
         g9ddsPD86dpijtTLa9drDjEWShv2lE/i6xUcTJeK6vYDlBim05Rm0t50CmEI8WcpJrs3
         +pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836962; x=1730441762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW4m5+Alc5+U/bpiXfBbEwyDvB1oVdKKXqHaL1Wh1jQ=;
        b=TsmRu8F9hT6tyixk0brQKYZ7l3QMQphaHUPxrTUNFntdkW3SNdK9nV/sK3n+gMYY7X
         85A6n42BaPrGUwi+plTtIcANrFuqo3wZo4sV+ebqcr9KGhI7V6qfCcTBIMsnCd5SjnR2
         GLW9kC5YZ+fu2R2w7GbIrqPTVxnRS8Ah94EJihUFHBnUXona2onEY0t4w612M0Dynnce
         cLpwrSM3uzRPa9EbHf9tsaeE9XR6SHa/LO/LadbDabU8UN5kECSxQXSuuOlPJud5hlpC
         CuqhqySxBZdf9oLCVDuTbtH0kjEtqu6YQUND9Z/qhSnx8OWzZ75kEATVcxSsT5wTZ+Jv
         ja6w==
X-Forwarded-Encrypted: i=1; AJvYcCWsRhEcnKfsQ1L5lmGKz0ZUwo+Jk0eifN38Eymm4rhSmDBReyKBcNUyCjlM815GsoDfT0vA8bFa/A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLnCLh90O1/kmZXmOlVUFrwGmAl4qcNIF9eUAPYm1K+lG+EZl3
	ZCwHlQoXWDGdc9NWIN/JrAWYho4PBAyO2Jsh2aUuW3mT88e5LPx19GIiGU6azEtzjDkoUAQJGCi
	g
X-Google-Smtp-Source: AGHT+IH1R1a5paHiMJuZWc2VC76niPOAzN1UkvOY+GuCu2Vas+9MsuU8FAL2cFI+5QVsPyLimIOW9g==
X-Received: by 2002:a2e:b816:0:b0:2fb:5060:7037 with SMTP id 38308e7fff4ca-2fca828bd24mr21472121fa.41.1729836961690;
        Thu, 24 Oct 2024 23:16:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb453ea75sm662871fa.67.2024.10.24.23.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:16:00 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:15:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: shaojiedong <quic_shaojied@quicinc.com>
Cc: Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] um: Remove double zero check
Message-ID: <qstfwrz6kvjfldw2lisgcrtvlhi7ltuyc32ygsqtoqfykwxmae@irofaqfjjg3a>
References: <20241025-upstream_branch-v2-1-072009bfa7d0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-upstream_branch-v2-1-072009bfa7d0@quicinc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_231603_995956_5084E3CC 
X-CRM114-Status: GOOD (  16.83  )
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

On Fri, Oct 25, 2024 at 02:03:32PM +0800, shaojiedong wrote:
> free_pages() performs a parameter null check inside
> previous code also does zero check as following
>     if (stack == 0)
>         goto out;
> 
>     to_mm->id.stack = stack;
> 
> therefore remove double zero check here.
> 
> Signed-off-by: shaojiedong <quic_shaojied@quicinc.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.

Clearly NAK

> - Link to v1: https://lore.kernel.org/r/20241025-upstream_branch-v1-1-4829506c7cdb@quicinc.com
> ---
>  arch/um/kernel/skas/mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
> index d3fb506d5bd6084046cf5903c629432cd42b5ab3..0eb5a1d3ba70134f75d9b2af18544fca7248c6d6 100644
> --- a/arch/um/kernel/skas/mmu.c
> +++ b/arch/um/kernel/skas/mmu.c
> @@ -46,8 +46,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
>  	return 0;
>  
>   out_free:
> -	if (new_id->stack != 0)
> -		free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
> +	free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
>   out:
>  	return ret;
>  }
> 
> ---
> base-commit: fd21fa4a912ebbf8a6a341c31d8456f61e7d4170
> change-id: 20241025-upstream_branch-06a9ea92948d
> 
> Best regards,
> -- 
> shaojiedong <quic_shaojied@quicinc.com>
> 

-- 
With best wishes
Dmitry

