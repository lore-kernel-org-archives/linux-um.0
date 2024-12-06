Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D1BE7716E
	for <linux-um@archiver.kernel.org>; Fri,  6 Dec 2024 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRjrelvuTYuWFRbxQ9wk7RNISln30ZKSFPuEUMSXiwo=; b=WWdx1WSCR/TUgouLOWjOi0F5UV
	KOwOTkpDug+rb9HPocw17s/qRnVw5sCmSjFin1/RGL+JPmWwzXPn0q4QG/XdJ11tz6X6aJNzgTy4i
	Fi9le1HUJGun+Ak3IZ1qSNyn9/3+Yl//K+ArbCncgJbyQB03K/WTaoi3sKAjGiUMJSRCgCJ7UUt8C
	tWPN4xy0lxSyvc/aGbi/b1peg6yqCoYfzV3eMmIekFQ6Uv04C6RHmVXWG4z8Da1h474oGUQ6VT6R9
	JxkGBE8L3ViuIsgQhB77WtOr7KpwioeDUbhkFYAlKzoS0q1V8gQOP0kf+MprrtjZ5j6SsdiDWvZXH
	nqkq4lfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJORD-00000000Mze-3J5w;
	Fri, 06 Dec 2024 02:51:27 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJORA-00000000MzA-3Ih0
	for linux-um@lists.infradead.org;
	Fri, 06 Dec 2024 02:51:25 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-7fd17f231a7so978861a12.0
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 18:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733453484; x=1734058284; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRjrelvuTYuWFRbxQ9wk7RNISln30ZKSFPuEUMSXiwo=;
        b=GpwhBpeGWr+sNVmtP1+2FLmbwEn9wZouWundmhgphbh7Pgo1n9RvDHdyz0WwXhqugL
         9aCkyn7iFNsnGlh52UhSjbQuJV7QxcE+izDQ+lXYDoLHFzNr2CURpxvDs7g+l+J88fV1
         DjvlvoZxZPASrZBfCMIBwYASz7th3lJPh+1EeUbA11IKR6+ga9s164Vo5vuAXc0y7uWK
         px6MtoQddvMuvYf0fL9YMlqsiwPBSBPbdVeF/a4ximGyZ+XHOPEK2B6ghSUOMTpNQ+Gr
         Rs2+4EDEZTGSqkzwzOuYvWEBkz2mFItC01YBqRbH6NNgxbyN72LGGgJj8PC4ZpTcnTD+
         QMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733453484; x=1734058284;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRjrelvuTYuWFRbxQ9wk7RNISln30ZKSFPuEUMSXiwo=;
        b=GKT5ZWek6yUv89Vtq7WQ/t5FSUhaIN9i2ZZAmSP3AsZQ88efjXTa9mhyzn7VK0QcxS
         tF3q8VYZpwl0FK64PktlCJmM+CKNjh25GZ3ocywj33a+vpWeYg25YexjBHUU8gy5omrR
         URAbKcAfRvC03GRzKC4NAWwu6/cuSmWjQ1/z0Wys5KdT3HmhV3vUhlCAGi5PKxKAKSiB
         IFkFT7Z05J+BaDBjpLGg0FaSYmkoq2DWZ8EwgRSk7fLWSzm27R9eivQwoTVc+o5fNdlb
         VflFC86rfbug3/di/WiL5jZfmQUOrZYIwpGKsR+awrYSUtEVXE+5IjDg/R66YZjgI6ls
         443Q==
X-Gm-Message-State: AOJu0Yx0kuw0u3ovUpeqE9gnFCXA0yn4QX0BZKG8IHCqm/Yf7+gQnoTe
	XLP5wSnmhbcbjOSDMoatXWSfcC8gFxp4bThplvHIZbwnETfUcMp6
X-Gm-Gg: ASbGncspnb++PYNUq2zxBcKvzY+/UIdxVWc8EWFPLUuR01m2u8WlTer6IvsmokyCqL0
	dfnPvmWqweXMQaPjvN058g0tC1J7BIdz0Zt/xJHa3dRq+kB/yyKV98VT7ATSxTjD4gM7BUgne02
	ueYty8pG5rcrPsalZuNvvs/l8rfy70SIFd1r7a9Teyap745GcEzjhVmMS+OAwy1Jczhg3QSmAgx
	gIjxRh5boS1NginhYee8eee3mnzUT56b6agJQ10qPgVbkxcUvN9Vitkz8VMHi5mDFnLIz+YThL+
	/HOT814tlADe49xSIunLbX4v0iQvRMGyC+9W
X-Google-Smtp-Source: AGHT+IHNwfWbWegL3BAOZkrtXfjiRZwpucttytQ9PYCjGjuSi4glr3CnbbPXuM47qJHxQF0shMNZew==
X-Received: by 2002:a05:6a21:9985:b0:1e0:c247:21d2 with SMTP id adf61e73a8af0-1e1870c43bdmr2025833637.23.1733453483558;
        Thu, 05 Dec 2024 18:51:23 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157acd35sm2017754a12.61.2024.12.05.18.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 18:51:22 -0800 (PST)
Date: Fri, 06 Dec 2024 11:51:20 +0900
Message-ID: <m2wmgdv80n.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	kenichi.yasukata@gmail.com
Subject: Re: [PATCH v3 06/13] um: nommu: syscalls handler from userspace by seccomp filter
In-Reply-To: <09c2f373dadbdc7f369742662ab43d6b5af66698.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime@gmail.com>
	<c5c8a72aa008fd23fd1c7f64def54e94253b3016.camel@sipsolutions.net>
	<m234j2w83v.wl-thehajime@gmail.com>
	<09c2f373dadbdc7f369742662ab43d6b5af66698.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_185124_822779_3070D335 
X-CRM114-Status: GOOD (  14.79  )
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


On Thu, 05 Dec 2024 22:54:21 +0900,
Johannes Berg wrote:
> 
> On Thu, 2024-12-05 at 22:51 +0900, Hajime Tazaki wrote:
> > > 
> > > I don't understand why this behaves differently with and without
> > > zpoline, it seems it shouldn't need to. Anyway, still think zpoline is
> > > future work.
> > 
> > I will remove the zpoline part.
> > When zpoline is used, SIGSYS signal is a sign of unexpected syscall
> > invocation, and raise this signal to userspace (with printing
> > message).
> > 
> 
> But why? We already established that zpoline cannot translate
> everything, e.g. JIT code and similar. So even if you have zpoline you
> can just have seccomp handle the syscall as a fallback, to catch cases
> like that rather than failing, no?

You have better understandings on this part than me; yes the fallback
option should be the way to go.

thanks,
-- Hajime

