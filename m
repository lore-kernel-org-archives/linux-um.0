Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE33CA0ED3
	for <linux-um@archiver.kernel.org>; Mon,  2 Sep 2024 06:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4QRHpO2u5pbpxFjPI4wQ+JqY+Z37bYljgBG+DFxhCvw=; b=R7mmEKoJg4murkOlon+ephabOp
	ws3GqFKz4UYjI2OrririRuQJvB19YcESUmzsF1UX8M6xOcWEaXDNnNYyG4qbsEacnpJTxrtSAVa4r
	PuIwsAErcN2hoAH5hu+lqN5Y/Hxb0h6Gw1twweTin1vK4b0bEOBzX2m9SR8R+OKRPzBwLYywBIJ74
	RQ+slZ5SYUq1rxcJ9MvTzIzoYEotAO6Zebk+BOTXajJP3caRgnerdSjfk3N8E2jt7RdDhVzVn9uyl
	Wmozisf9IPxVKG0og1Xz/x3IQQYUzmag978/AzgOiQveeL004YwgO+fCYYZsK+5gzLYSy7zU/Olqs
	/s1ZasGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl0bg-0000000D9tN-1rX0;
	Mon, 02 Sep 2024 06:32:08 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl0al-0000000D9jh-2kEi
	for linux-um@lists.infradead.org;
	Mon, 02 Sep 2024 06:31:13 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-7cd80d28743so440619a12.3
        for <linux-um@lists.infradead.org>; Sun, 01 Sep 2024 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1725258670; x=1725863470; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4QRHpO2u5pbpxFjPI4wQ+JqY+Z37bYljgBG+DFxhCvw=;
        b=v9zVU63Bi+DzWTbq8w2wDUIno0Ti6JO1MdaRq/m6uDaRW3COAnp/AK1PDczrRMc0sh
         XvS0bUiuRlXmvPMHRDKM9dQUxcNkeRfzUcQi0gp6GcCBEm0D3KI6S6IPoELl8rrzIaIE
         S36QTKJnI/V1BQAg7cWsnRobJcobz2ABfjkTRCjtcl8JIRTv03P9MooYUw2O/QzDpN/+
         wRh+dBEnqfkF4wikVKS/akaOEz8SU6ivTugE5mYRu0y/lNcoqeBwORR0ZqWie1e3UKrR
         qPki8YkiRtYHoK2TTAxe0DejKkPAxFhIWdpBvQp3sPNwiqkA6+zt6vbf3chCaJqHx4jq
         /XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725258670; x=1725863470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QRHpO2u5pbpxFjPI4wQ+JqY+Z37bYljgBG+DFxhCvw=;
        b=eOAM7ZAVCHkx3bFZ4DUYJnXUPygZvN+YOSKfYqiTRVXBmHrPdIcdIryd6BLDSNL/A1
         RIiErZ6fEo23vfwStRQMJq+47Iryhffuh8lu/CpYxopqmEi84YgTdj9kYF1ZgqA8cgEq
         BqnQlA5uFlFdJirMnhmRksTRzKviXRj+zEwTadlXnwImP735wlvvQFtg416r3DH+CH6w
         Inw6DYdy59cKZd7kK4fJ1el0AbLZNvtZ+BXx0xEunxzhIFJgGWSf+FwXAt/NYa+LgAxY
         SA+wCrB/RfhTEtSw3Jv0VJtU8n0ow1db+gXzP87iUtkJopnbEwP5BuuBhTq/hdJmEyBC
         k/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXp5cXhJbr/UmByPZqfDuvbpWAEMPV/kW23eTSyVTk0huqhircDguvXELNSbZMZ+EE6APGOeL1EPw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyY7C8lnSCxFeCJfnsiwJtOl7wlLCLbwYiY41hNb+nFJoj9kaKb
	H7XWpcz2OK32nBp5llDjlCfzR7AI8CG0ici7npSDI9qZ3Qnl4Tkt8BzvMblYG08=
X-Google-Smtp-Source: AGHT+IEamVmuc71sTYPdHjFxuF/z2Kir18akAJnclZjSyzrG4uveb/oGnmnZ8wSmLeO97ZW2P5fb1A==
X-Received: by 2002:a17:902:da86:b0:1fb:1ae6:6aa7 with SMTP id d9443c01a7336-2052750795amr58817315ad.3.1725258670426;
        Sun, 01 Sep 2024 23:31:10 -0700 (PDT)
Received: from telecaster ([2601:602:8980:9170::901f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515542350sm59747515ad.213.2024.09.01.23.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 23:31:09 -0700 (PDT)
Date: Sun, 1 Sep 2024 23:31:08 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] mm: make copy_to_kernel_nofault() not fault on user
 addresses
Message-ID: <ZtVbrM4rQsGFJo_t@telecaster>
References: <cover.1725223574.git.osandov@fb.com>
 <5fa50d78-6764-4f99-87b3-7bd7edbeea5a@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fa50d78-6764-4f99-87b3-7bd7edbeea5a@csgroup.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240901_233111_716075_D929C546 
X-CRM114-Status: GOOD (  17.68  )
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

On Mon, Sep 02, 2024 at 08:19:33AM +0200, Christophe Leroy wrote:
> 
> 
> Le 02/09/2024 à 07:31, Omar Sandoval a écrit :
> > [Vous ne recevez pas souvent de courriers de osandov@osandov.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Hi,
> > 
> > I hit a case where copy_to_kernel_nofault() will fault (lol): if the
> > destination address is in userspace and x86 Supervisor Mode Access
> > Prevention is enabled. Patch 2 has the details and the fix. Patch 1
> > renames a helper function so that its use in patch 2 makes more sense.
> > If the rename is too intrusive, I can drop it.
> 
> The name of the function is "copy_to_kernel". If the destination is a user
> address, it is not a copy to kernel but a copy to user and you already have
> the function copy_to_user() for that. copy_to_user() properly handles SMAP.

I'm not trying to copy to user. I am (well, KDB is) trying to copy to an
arbitrary address, and I want it to return an error instead of crashing
if the address is not a valid kernel address. As far as I can tell, that
is the whole point of copy_to_kernel_nofault().

Thanks,
Omar

