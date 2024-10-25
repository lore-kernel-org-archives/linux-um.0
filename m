Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1502D0C609
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dJIsTGhtiS2iqq8JfT76v2wPJtCmgS/6+DY2iPGYeaI=; b=wsgIvzf6JQv+Dw7ne6D/qpH5z/
	XjzM23t7XiJEzu95Y9cnoiDXR4lGKt21VZOnyZ58MUdZpN7Ipx+rNaaudLqQxsSXUZCiQNC/1CUE4
	2BTDLtcEYq4LPMj0Ukozaf3OS40TQpdcfofM6711zEdndEHopblOlISQ0Ve3dnpvik8uunggnUpW3
	LbVguG6VeQcOYk/pkDjs74QEeGx3JI6Xla3Xsqde2EvuueKfH6x6HitoLocx5pbf7tT+H4kaUGBL8
	inx2MYTeebwHPpBZTAOP0zTjDs9nsZYtH0ENj36sJxclODJU3kDWT7V2knv1IKtYg+BFv2rsh7GBH
	iSemRHXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4K5E-00000003lnk-1Niz;
	Fri, 25 Oct 2024 13:10:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4JqX-00000003jhr-3Kf2
	for linux-um@bombadil.infradead.org;
	Fri, 25 Oct 2024 12:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dJIsTGhtiS2iqq8JfT76v2wPJtCmgS/6+DY2iPGYeaI=; b=k+FL71rr0xkw4q6q2QstNiPoju
	h3kz2XrNSlp0IN7HxjqYqQB+50LF075+2nHusd0UgJuPOWRHpXE20ufFkZx3xhTScaYKtvsGPYoqP
	mn4TmdUSJv0PsYjId1230GiK4oLzCNyq4aXszF/3YAoaMRiDlxnp8Xnm5Qb1F9I9ipB7wBmz+wuGc
	SMrfoj5DcTM3nDNONk+FlL6qj2x4rLkfaqxxC93EiJjsqY9WzP7cxYW8M3GUMOYqNNV6oRLTK5Xe4
	OtkXKrUaPSO+Vu786eL9eIeV+mdp1hQU6x5dC6OA2cv/JDQN9nevGSGmKPyEH7R/DaEY3sqFYUXxG
	5b1OZZBA==;
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4JqU-00000008ueY-3FVK
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 12:55:16 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso2155262b3a.0
        for <linux-um@lists.infradead.org>; Fri, 25 Oct 2024 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729860911; x=1730465711; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJIsTGhtiS2iqq8JfT76v2wPJtCmgS/6+DY2iPGYeaI=;
        b=HdPEZwtP87Im9Cn6882sC0GNSTK5yoQz4W2KLnFLUae59QM1xq09dY3rhd0xfC7QjB
         r+JRbggDz6GbyOniooA4gZQMUe8a+joWjM3fsASHqKBzTf/zNF+WKfEV1YbOU0o7OiXK
         /RdTxo3G+/itoxpAE98k8MwqL7quLSx5ET7Dhev2YHb0tFiiXFSq0UCT7fm+E2e+rMQF
         qy1Pp18ZwjFfPoURHjU7vjncIJ3U0KYIe82QHfBFXsKrU7nPxh1gnl6FQ7uYMEIBUR5L
         UP3amGlaXhAC9fj4u7O4jmgyO4B1ipG3pZlVOma1l1FK0bb+TaQeXlZrkVaz8GtpAmCc
         mtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729860911; x=1730465711;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJIsTGhtiS2iqq8JfT76v2wPJtCmgS/6+DY2iPGYeaI=;
        b=kBIIvy/z3zmBT9D4dDElGPlVi8Ggm1XpTd3qgCHhQ9/GdN4NHG05ez2bTG0lOLhsVV
         odQQ+QMJr0FDz/M5omzNUpypABDEwjZk6rI2u8Q0D/YqHx5FHYFkaMun1LnQTKbNReMH
         xSCEqCvn6uhJTm90c4pCHsMaLk7A3qI3wDJ0d3nCDFBeLJt9YpzQjPEHk4S3KcEJELnG
         tytiOHA6EsKcq4+8YBnOAyxOS3goggEAooC5Hkpatpc2A/UShSVkVrsR1UZi5X+uuqPu
         L3hSlgvLsExG36NTDUrJEz0Iz2h8Ft0ua2AjpGEqF5ljK06vyJc+SKyAmcURR0hFiy8N
         hOGg==
X-Gm-Message-State: AOJu0Yy3rCtrSwH3eeyJ92f2oPUS3+/0d+hvMm1juOcFePjKWfee4BFP
	K9QT3ESkZyfWji7DmWUCBWCW3RC0WIfq8nI7ydK/4FUkwDmjXoNO
X-Google-Smtp-Source: AGHT+IEyZdvFveYbU2GoJq747v9dK5w/PhUeywnUN34SdAovfvUKJfJJigcrhIG2ijI0Sw6krivRLg==
X-Received: by 2002:a05:6a00:39a2:b0:71e:4dc5:259a with SMTP id d2e1a72fcca58-72045280660mr9566638b3a.7.1729860911145;
        Fri, 25 Oct 2024 05:55:11 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205794f996sm1023825b3a.93.2024.10.25.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:55:10 -0700 (PDT)
Date: Fri, 25 Oct 2024 21:55:06 +0900
Message-ID: <m2ttd0nxzp.wl-thehajime@gmail.com>
From: Hajime Tazaki<thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	ricarkol@google.com
Subject: Re: [RFC PATCH 03/13] um: nommu: memory handling
In-Reply-To: <d84f04d9a60d4dffa81fe5d0f73646032f1294f1.camel@sipsolutions.net>
References: <cover.1729770373.git.thehajime@gmail.com>
	<304383e5c9b2bba18678598bbdacadc9126d8f74.1729770373.git.thehajime@gmail.com>
	<d84f04d9a60d4dffa81fe5d0f73646032f1294f1.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_135515_041937_6AA1FBED 
X-CRM114-Status: GOOD (  17.73  )
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


On Fri, 25 Oct 2024 18:11:01 +0900,
Johannes Berg wrote:
> 
> (I should say, I'm still reading through this, and haven't formed an
> overall opinion. Just nitpicking on the details as I see them for now)

thanks anyway.  looking forward to any opinions.

> > +#endif
> > +
> >  
> >  #include <asm-generic/mmu_context.h>
> 
> extra newline

will fix it.

> >  /* tlb.c */
> > +#ifdef CONFIG_MMU
> >  extern void report_enomem(void);
> > +#else
> > +static inline void report_enomem(void)
> > +{
> > +}
> > +#endif
> 
> Should that really do _nothing_? Perhaps it's not called at all in no-
> MMU, but then you don't need it, but otherwise it seems it should do
> something even if it's just panic()?

it is called also in !MMU.  I'll think to figure out how the function
is shared.
> 
> >  	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
> > +#ifdef CONFIG_MMU
> >  	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
> > +#else
> > +	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 1);
> > +#endif
> 
> That seems much simpler as
> 
> 	map_memory(.....,
> 		   !IS_ENABLED(CONFIG_MMU));

looks nice, will fix it.

> > +#ifdef UML_CONFIG_MMU
> >  	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED,
> >  		     fd, off);
> > +#else
> > +	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED | MAP_ANONYMOUS,
> > +		     fd, off);
> > +#endif
> 
> Same here,
> 
> 	mmap64(....
> 	       MAP_SHARED | MAP_FIXED |
> 		IS_ENABLED(CONFIG_MMU) ? MAP_ANONYMOUS : 0,
> 	       ...);

since this is part under os-Linux and we cannot use kconfig.h (IIUC)
feature (e.g., IS_ENABLED). but I'll reformat it to simplify instead
of duplicating same lines.

-- Hajime

