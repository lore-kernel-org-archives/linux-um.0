Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0135C636CC
	for <linux-um@archiver.kernel.org>; Tue, 31 Jan 2023 22:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oy9qB29PdYTUMMf7QKHZEmB1twMEkUfzJcjdwN6q8aU=; b=R5WeqKBcAeLFMi
	3fFtHL0uwXB00QcfgTgyqC6ZClTvDtGmS1RCbHvI+p0MrXsnxv/U8ggkEedotLgUS6Aa6tVXMK4nF
	Q8E4bn/CXMtRz9HCr5WtDidf7+mZbf1NczBVbLNrOZS/EC8r8ugHLbhHKCWPii1+rZk3Bh/5R3XCx
	dOGSN4f5ysN2EcSmgMgzdX7lFmrbjSq3MSxTgZ1gh0r8ZWz0a0gctlPg7HPPuYKpOP+wSnOeT+TQ4
	AFG8W35q3zWcwXsuNSy5rXk8d6ks1GgWZY6utkEumf9nSazYffR3TYAAIKBlbGWjrlgu4iMKOSkTu
	SwRAQAK+vxTeYwCFN19A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMylF-009TLr-4l; Tue, 31 Jan 2023 22:05:53 +0000
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMylC-009TKb-Fq
	for linux-um@lists.infradead.org; Tue, 31 Jan 2023 22:05:51 +0000
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-163bd802238so9104300fac.1
        for <linux-um@lists.infradead.org>; Tue, 31 Jan 2023 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MyxDjyy2IlJ3p3i03mgTiG6/EEQfhrOoRC/1/YKunrE=;
        b=jklVhsU1uN06i5ESEpD7V3l9NjUozxMd83fs49Vd7DindmvFlRelwkePu4K0/iMOr2
         XwdKWjM1j8mMx3fB8OyLCKTZDnhKG95j+Hfhm7jhJgXvhTEsKhHbf62Zqbsezh9GYweI
         T6r30NHXRaW9xzU22ULKGF04Jvf+NGi12Hyuq3ZyMHCEFzaqdTZyjeFcebVvenRRk0dj
         kqnZsgShLi9+xc7XwzuDyiX2QlRHdKuX45gZSnBHaLTZ7GzsK9xS3FoqBR1ttT6VCqfJ
         EBuUv8D2ii2meYTMDluCnAws3crQXsnz2ULVPKslpD4tRlsYMCK9F5nQiSgMAPM/SSJr
         41Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyxDjyy2IlJ3p3i03mgTiG6/EEQfhrOoRC/1/YKunrE=;
        b=HBVYzG7cvWVpsWryD9s3qSFECIY4CWI09Pno4qFA66biTPxY1/ShfwiKAZ502Z6Obf
         Mf+LepOw7PldlFl2JdJcBwSXOuwcnX/R6bYQGH9TQ5UzgC22D8rSOkTsu1KDp5XuvWIb
         e8wxiK8aH0d/J+U4Wpv7kkBZQ3nd8cNHsMN9rMQbjJBKhVRonjWlWKoFi+QcgvPd2Zuw
         YS2tICsj9CEbVwrT+/8cvM6ganvFcMhPKuWzy7V0V3FOefjicFqkgX8t5k+2FCfTtfM8
         QcVMjvrTEtRtlcMwRK2Oj8VPdHmkoFS8Yaxpoy2PPZbUOGBSJThJBQtZMDRXq2h/pp9F
         mTmg==
X-Gm-Message-State: AO0yUKUFCf4AP1aJ3mrz51U/8ypVmFEqeQfgCdFhXPKsAuaMqGiLTaAG
	mFsQ8Mo6lTGBX69lSdca4Aee6Ix2nvt2ekStUF4=
X-Google-Smtp-Source: AK7set/nF6GZwc2diRD94JiletmKt075rCBFGXp8Si3rgi9KMX5Vd214djm2lv5q2SJjw/Lq475mtwWCTRAg/CgLrlg=
X-Received: by 2002:a05:6870:a714:b0:163:38df:5b65 with SMTP id
 g20-20020a056870a71400b0016338df5b65mr2303256oam.272.1675202747088; Tue, 31
 Jan 2023 14:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20230130221748.5c472da5@crass-HP-ZBook-15-G2> <aa957c80-1aeb-8fde-440e-6e4408c59559@kot-begemot.co.uk>
 <1215849138.84344.1675149765214.JavaMail.zimbra@nod.at> <98f7e8b52dbb222f4d959d5440e27b4257005b93.camel@sipsolutions.net>
In-Reply-To: <98f7e8b52dbb222f4d959d5440e27b4257005b93.camel@sipsolutions.net>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Tue, 31 Jan 2023 14:05:36 -0800
Message-ID: <CABqSeASC1XcvYn0MsakH=pbAySsP_ZNs=JC4rKo7mbrNTS42Rw@mail.gmail.com>
Subject: Re: Using ftrace
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 
	Glenn Washburn <development@efficientek.com>, linux-um <linux-um@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_140550_545510_9F9911A2 
X-CRM114-Status: GOOD (  13.24  )
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

On Tue, Jan 31, 2023 at 1:11 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2023-01-31 at 08:22 +0100, Richard Weinberger wrote:
> >
> > Adding function (and function graph) tracing to UML is possible but a bit of work.
> > You need to find a way to implement all of ftraces mcount hooks for UML.
> >
>
> It feels like it shouldn't be that hard, but I coincidentally looked a
> few days ago and got scared :)

This looks interesting. I might want to take a look too soon. ;)

YiFei Zhu

> johannes
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
