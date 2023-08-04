Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EFBC04A94
	for <linux-um@archiver.kernel.org>; Fri,  4 Aug 2023 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CtwY6udk2bkalts7SlqZT/0JD8jecS4yJ7P/SDgJVio=; b=vDvVcd5oFzXZ9+
	E5Zl9LI4+clvsREBRfyNrp/S/x+hkBibLt9cpXUWUfoM72vnCKnhwtCVbwSSlDieqeBMl8TuEAfTJ
	U7ySl2ThkQHJnMqHabBo5NJK31ipzNjBAOo9M2F46G3KidcBTHYbGxRzIq8erXCevuudJqz5H9LZB
	7R1IpYLHTMgzKGycWbM+GqNMuS5g40KyNQZ4xBgEXifilh4M7u8zk5MM2H5vhKzqp/AU3rvMBHjVg
	xxP0qyf1HzaGeVZQqAgIaaiBpT4oQupmvC8K+dG4BcsdHvWVoVeubbmIWUKuyr9Yh9gmxLiaYYMI/
	pP8NSeR0tFKeo9mwipFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRueq-00CTLq-2a;
	Fri, 04 Aug 2023 13:15:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRuen-00CTKj-22
	for linux-um@lists.infradead.org;
	Fri, 04 Aug 2023 13:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691154952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yghE1gT7JEHr9Ft4Ug/jdVqABt7mGQZ6VHMNTdkCnVs=;
	b=Kk9o8svTF7X9e15N5JMbhxFpdazbfxi+MD8yyVELXuTUedisspF9I/AtaAd+UNA59V2mPe
	E4mG4CW0ZE6Oj4E/agi7n4Q0FuqNMbJZapLSJ+L3HSNL2+hq9DmwFEuXZmzB+6YuuFoqla
	xjRbmy0e9fzzX7UOwOS0j2L5HA6Voow=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-Xg2-j3MGMuu5Fe9sSIBYCw-1; Fri, 04 Aug 2023 09:15:47 -0400
X-MC-Unique: Xg2-j3MGMuu5Fe9sSIBYCw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a337ddff03so3450342b6e.0
        for <linux-um@lists.infradead.org>; Fri, 04 Aug 2023 06:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154946; x=1691759746;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yghE1gT7JEHr9Ft4Ug/jdVqABt7mGQZ6VHMNTdkCnVs=;
        b=LCtGxSdysTpQJp9WNbcwqG8pENpW84+U0cmHaYSSGirKxFqS5Sdjv7LEyIK7pPyiiM
         h46a6M1ENwnQxNZ1658omd0pFyrYzJsXkY57qG2awHQ+7HRkACPiiCGGYH2bg2bbOtG9
         VW9A6GdWB4FvdzXklZCZtw/kVkpeBo4ottkfjPH4M1ixJaztq6YU9JzZXJ8WzUIy1oyN
         PRDimbFTyOdDIuuAMvON+hoRFl2yj/oey7jW/NeW73Ro6FzEy8pguxwdRv8oUGKN5ye0
         ss5SEtfS9TP7De4zkLNRiEsr28a6IoIwzdRtkB0XoxGZUjR8DyPAoCC/m241YNKT+arY
         utRQ==
X-Gm-Message-State: AOJu0YyXtIeQWr9TqCy9nPs54pjju63c8Ymb3bAt6p6v+zRPKKk6wU41
	adpAZnkeBG2RysY8ZvjJY1ghVEJCpfVK+MeiEQhN8wfFiagqJgKlEXFnxRg/MwLniI9a9qAqdoc
	fWBPNl2YaQmtEBy8q4T7KX82K
X-Received: by 2002:a05:6808:1307:b0:3a0:5596:efe8 with SMTP id y7-20020a056808130700b003a05596efe8mr2348287oiv.54.1691154946636;
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENWP+4GK74C7AuYHmh+2X37PsqlfaNPjW5MQ5IAf9v1dlH0ambZpvXNVp8pt59GOqaQo2gFA==
X-Received: by 2002:a05:6808:1307:b0:3a0:5596:efe8 with SMTP id y7-20020a056808130700b003a05596efe8mr2348264oiv.54.1691154946400;
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id x16-20020a05680801d000b003a463ded3a3sm939158oic.53.2023.08.04.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Helge Deller
 <deller@gmx.de>, linux-fbdev@vger.kernel.org, linux-um
 <linux-um@lists.infradead.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: Tree for Jul 31 (font problems on UML)
In-Reply-To: <dd29e5f5-d9f7-0103-e602-b98f26c88fb1@infradead.org>
References: <20230731140924.5d45b2b4@canb.auug.org.au>
 <dd29e5f5-d9f7-0103-e602-b98f26c88fb1@infradead.org>
Date: Fri, 04 Aug 2023 15:15:43 +0200
Message-ID: <87y1ireyo0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230804_061553_737930_71C1E615 
X-CRM114-Status: GOOD (  10.64  )
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

Randy Dunlap <rdunlap@infradead.org> writes:

Hello Randy,

Thanks for the report.

> On 7/30/23 21:09, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20230728:
>> 
>
> I don't know if this is related to FONT changes or fbdev build changes.
>
>
> on ARCH=um, SUBARCH=i386:
>
> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>   Selected by [y]:
>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
>

https://lists.freedesktop.org/archives/dri-devel/2023-August/417565.html
should fix this.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
