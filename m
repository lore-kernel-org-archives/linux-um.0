Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9FAEB64DA
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 06:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HdvaYH4f/59yKZr6mLabi5Fd1AZ3X0c5/FajLU0bZDQ=; b=IFLqCm0mHccOjX
	trLAddtTfeFn+K4k2FUfBSgIvv3UywOhzr6QMA3cAiuAnagPWPXaveXWEsp5XavSkfurWnd4dJk+b
	QiXwJc15W/eUIqLsJHfrit+7H256zvx50ecJydltu4quSoKgvq4eS6dK7EfZxqIREZuElizI+p8Ka
	xjsZ6/vRAtcS5Oi4sw8EJS/DYhG7PIWgn6KkQmjHsWJN9zeCp9JDX1JtjUIH9IhiTbgd0UlX5ZFE5
	aNDFi4l45n0zQECQaFcv+YXa2nblbAo23f3Yh+jM77FYCygJoPK5FCNkZojXoFfv9wp0qlWUBwe3y
	a30g4G5d5N1sT2UeeSoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jlp-00ANjq-1n;
	Wed, 14 Jun 2023 06:14:17 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jln-00ANhg-17
	for linux-um@lists.infradead.org;
	Wed, 14 Jun 2023 06:14:16 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8d65ecdbbso1642435e9.0
        for <linux-um@lists.infradead.org>; Tue, 13 Jun 2023 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686723251; x=1689315251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrMiA/tC+fxE5mDARnTcw4ms3upNNvUiArk5dZHjQRk=;
        b=UEu47kI5BYKterLbgXk6yn5h3lFN3p948gwTWT/PhIRzwv83SpBb49D/jS0ykSITA7
         1h/631nx8uRXLal8IBavUCSx3KzLlv3fbEDijTmoNqLy61OosXICTPXimuEd+wbjtY5V
         yW/RHp9NmwTRTmhkbU/n+i8HSxp3bJGw+ljf/jQ9fePGt0N2Rxhesq/6Z2VMlxurZlgE
         q54hLVpA6pRzjY3vS/UFv3aPA5C+k2j5ugmq3VTR0a6O3LTlkLat8K7sK7GNDwe/o/7L
         XaTQ5BVagcyQTZz7dfT5PzAa8HIWGBx6KqHhEp27PijMbE9LIT7CUsDeGV/RKXs/+hzL
         obKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686723251; x=1689315251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrMiA/tC+fxE5mDARnTcw4ms3upNNvUiArk5dZHjQRk=;
        b=GWUtV1CO/oyDwo4jveH5+Mv9dJo2guFWiKjhbw5vKXcswBNqtUGVev0r03cCBLthtI
         cqx188c985twGt/zriiIYj5BHFOkZ3VcheouiEllueULFjqDiMBW06TmS5Ih9I239Qab
         vI+JqaP3pZwrrsj3efOhU17F1iB44VQmdd9YP0uvGaUR7uhtuk10l9WrRVvmx0+1ZrjR
         +6LyDr0pDpKRcWs9/zaJiMhq/59UPIUGCgly0Ct5qmJGPKrTLeWXrtdYtdSuDPaCsJp5
         28ltElyv4Z5IGtAQ6sS1ls69KOCL5h+UZlHG/oazdJ9lPNnJtagQTR0VhwD60xIfWp8f
         Dnxg==
X-Gm-Message-State: AC+VfDzw6iZpketiQ3p1C7vT3y6+bq8UknY3se6CoL5DQl9DYxQPDOB6
	CAx7vVUwGjbKclawPei4q9LgPQ==
X-Google-Smtp-Source: ACHHUZ5sRS5Fyz/k0P/IDiQ9BD0qSNJ2ZIH5A2yLae6xAaPbBztuD6ZaTrtzPOYbyGo7mO5pBjnUww==
X-Received: by 2002:a05:600c:2059:b0:3f6:2ce:caa8 with SMTP id p25-20020a05600c205900b003f602cecaa8mr8959147wmg.29.1686723251172;
        Tue, 13 Jun 2023 23:14:11 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003f4248dcfcbsm16551765wmj.30.2023.06.13.23.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 23:14:10 -0700 (PDT)
Message-ID: <75d63a28-bb33-ffd0-a0e5-282ec7c3dbed@linaro.org>
Date: Wed, 14 Jun 2023 08:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [patch 11/17] init: Remove check_bugs() leftovers
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.553215951@linutronix.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230613224545.553215951@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_231415_382908_11BFD2FE 
X-CRM114-Status: GOOD (  10.40  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 6/14/23 01:39, Thomas Gleixner wrote:
> Everything is converted over to arch_cpu_finalize_init(). Remove the
> check_bugs() leftovers including the empty stubs in asm-generic, alpha,
> parisc, powerpc and xtensa.
> 
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> Cc: Richard Henderson<richard.henderson@linaro.org>
> Cc: "James E.J. Bottomley"<James.Bottomley@HansenPartnership.com>
> Cc: Michael Ellerman<mpe@ellerman.id.au>
> Cc: Chris Zankel<chris@zankel.net>
> ---
>   arch/alpha/include/asm/bugs.h   |   20 --------------------
>   arch/parisc/include/asm/bugs.h  |   20 --------------------
>   arch/powerpc/include/asm/bugs.h |   15 ---------------
>   arch/xtensa/include/asm/bugs.h  |   18 ------------------
>   include/asm-generic/bugs.h      |   11 -----------
>   init/main.c                     |    5 -----
>   6 files changed, 89 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
