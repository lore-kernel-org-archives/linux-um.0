Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7473FC4321E
	for <linux-um@archiver.kernel.org>; Wed, 30 Nov 2022 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x0LiadDo/mnRCyevdQCv5Q89blrgTEcSNEJg1ROOg7I=; b=XirdMZ3aOTkIzT
	xP8dLhbEsRfoObrC6pzOEFXhekjbsO2QFg5lTIi5EjajOo+d/bNP3gRZgnNm7wjbnTZCxtfS5RpHW
	yvzC3Z6hc2fLBEV5r0YAURseMHBvL8eow5zKSFrs6iTNAiiiy7/rCJ4WJdcGDOVRmyetmLzq+S54+
	V26C1EZe1fFkykeJPuhCQAHLPaoY0cbPT907mJ4C9uyhqYKr8dJ59AeQmyHtptbHi1Yo2A/e88zzA
	YgMUemB4f6n5zVYg4s1y/qrIi9D3SB0st+dj4J3ySiL7CmLH7AB3DzNIVGeHQwoUgF0IfWow1MPU/
	Qq8ixnzc1csRMc7XVbyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0WQi-003CW2-EQ; Wed, 30 Nov 2022 23:23:52 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0WJN-0039J3-DH
	for linux-um@lists.infradead.org; Wed, 30 Nov 2022 23:16:19 +0000
Received: by mail-pl1-x633.google.com with SMTP id jl24so722085plb.8
        for <linux-um@lists.infradead.org>; Wed, 30 Nov 2022 15:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI4oe9f9CJ36Kp9mJv1gCGk1ojeGZwXUPKDrYbhDj4k=;
        b=UVR8LpN1aCq4PBkeoinaOtXdDTMRH+RSulkUIjjbH1VEtqx3WlY0N816NC3l4XGdZQ
         deZFVpTfMZloq63bb+cMsor+078WnOOAMg+4Itrf0bXUcRVjr8cARcdbIE0AE6QRNdqm
         AJvR/abVLCwjQmu76DuT+7lT88knfBiSMu+g1xqzXcA6OIeYnBjWoSRP7udLz2nMlXuA
         bAmJkuhfkutXKRLaJYDhvzYcwvWscu48qjRT1h/GPSBW5OlDs38VPv79RkAOF5u+Q36q
         /YHHkNTUnG7HZfpaqHumPFTCGNSeLZSlYrKYSzflbmfqojCWPRN+a4Lg+WrbO7n3oLRs
         tbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI4oe9f9CJ36Kp9mJv1gCGk1ojeGZwXUPKDrYbhDj4k=;
        b=iHZteljKsEygYHxRq3bJuvVnWS9xunDPlwC1iGc6bL6THrWdIlxIVTs5D7McjVx5pW
         3IzSV+ifEIHYY8xAG0D6fBxzDFEdEZVny3H20HE6xMVJa/YhUEb6j8/mytOOx2u3/hqm
         srLW0LNGhdZvQGco8aW3qNE4u6+NYJxxwBDWAtItdyaL6U4FIAMmrE8Jf9FzOjN1kqJf
         9DYGlXdMy8yTKpVsRXfz1HPhgiRmW9DAdpA9gEEP5bSHwLYSbc0pfHt5totzqmVxJReK
         WK/mp2v4T3bo3WIRHF9KbpjUrXEVkTRSohybPx+RqUsk1a6kbRq5Hrm8VcZAGpOIsVPm
         viUQ==
X-Gm-Message-State: ANoB5pnKVzbkVZJ023ZqsATNSZUeyINlawlic4J4YYxFp2vBy2mgmN0H
	Hs+7vO7jJYuJBjxCnQtjEdI=
X-Google-Smtp-Source: AA0mqf5bQhX1KOZl7ZuLYypPGnOmCEf/iMe9H+mgCFFH7lLQUvqJXOKgfns+n8I09yS1nrd9RZ5HBA==
X-Received: by 2002:a17:90a:bd11:b0:206:64cd:4797 with SMTP id y17-20020a17090abd1100b0020664cd4797mr67221140pjr.103.1669850171343;
        Wed, 30 Nov 2022 15:16:11 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:360e:7e9f:b234:c094])
        by smtp.gmail.com with ESMTPSA id f23-20020aa79697000000b005742ee3bf71sm1905211pfk.20.2022.11.30.15.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 15:16:10 -0800 (PST)
Date: Wed, 30 Nov 2022 15:16:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>, Miloslav Trmac <mitr@volny.cz>,
	linux-input@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH] input/misc: wistron_btns: disable on UML
Message-ID: <Y4fkNy9URvaW+AtN@google.com>
References: <20221130161604.1879-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221130161604.1879-1-rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_151617_521884_7082CF55 
X-CRM114-Status: GOOD (  10.50  )
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

On Wed, Nov 30, 2022 at 08:16:04AM -0800, Randy Dunlap wrote:
> The wistron_btns driver calls rtc_cmos_read(), which isn't
> available with UML builds, so disable this driver on UML.
> 
> Prevents this build error:
> 
> ld: drivers/input/misc/wistron_btns.o: in function `poll_bios':
> wistron_btns.c:(.text+0x4be): undefined reference to `rtc_cmos_read'
> 
> Fixes: 0bbadafdc49d ("um: allow disabling NO_IOMEM") # v5.14+
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Miloslav Trmac <mitr@volny.cz>
> Cc: linux-input@vger.kernel.org
> Cc: linux-um@lists.infradead.org

Applied, thank you.

-- 
Dmitry

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
