Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAD3E77180
	for <linux-um@archiver.kernel.org>; Fri, 13 Dec 2024 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/vScXgcTqsyhMOd0iR3wquLB4CKZKhnJgSRF2gJO3wY=; b=VumUGSy118PLzr7sKwV63M+Jpu
	1RidQUC9TzJ0JrmtVurDAOY0Zwyzeo29AAcvj6LjCu4Bd4ZAqd6HV4OiFFd3qAeVTPVPBM6DGR47p
	RvpS11FRg5p9B3qe0uQHTcMe484L8SUlhtyYtBTvkb3A9t38IPvCUli/9TwMQT74IDJUOhyFU+x1i
	ySEGa0ninFz/GNZ/JzCD8AQYLoKKiLAsqVnwvMtqxEPA5rvEGxf1WRGK+ox3ynOn+LYFMEnTNW1dq
	0q8aEsqzNwKpB748GA8V0h28k3NFiHcFtSEyxk1q6VyiRekgk/wgUx3Wiay75/2Av3g1m0KoJvOOV
	BSAX+5TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLzxr-00000002wxK-1KTR;
	Fri, 13 Dec 2024 07:19:55 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLzxo-00000002ww9-1VLf
	for linux-um@lists.infradead.org;
	Fri, 13 Dec 2024 07:19:53 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-725ef0397aeso1250563b3a.2
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 23:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734074391; x=1734679191; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vScXgcTqsyhMOd0iR3wquLB4CKZKhnJgSRF2gJO3wY=;
        b=DgnCsVMFwuwhNhrQirLxzwUcPIU6b7KobjNwZGjqyXfbmheqI6jPrsxU3LpQjDUPeV
         2K8rp5IbEKU+hH4d6pXS306UFAt26AAXeJw3139sdKQxcEhvnEkGDletWCZ4HVaA1GQI
         +erfJ9CmJ17ToUMY/LJf4SLvjT/DBbLjAblSlXpW8t7NwjTzHOQ6C84m7ovu2RxkuGn4
         KvmQKKXPk/fCIEQzuf0olMApoKt16AM2IWklswh7WcydwXcZsitLuyWmyisGywgIBjzm
         CyZBTmGpe9DrpNQXSp/4QD8NDy89kfE57Y+B4hOx+K6AnV+H1MqeTsCMWXumy2xkyGQR
         Xqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734074391; x=1734679191;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vScXgcTqsyhMOd0iR3wquLB4CKZKhnJgSRF2gJO3wY=;
        b=nkt7i9rT0+MBZ4qdKbuvfAUWgYZNzyK3BpXEQrutn80wLmz6G/3d6lBQyJ+qStI8Ht
         VMouSvniW8VRi6bMhgLKCuoDH0TllMIVHyzLyJZ6c4gx6IZL4g4XxRNypViVsXuWb8gz
         bEWHjO1I1mZnhwAsakMcWsCU7TaMvorabjFCgdmx3TfAA/BLxpTTSp3CyPtyZ+rYecaQ
         y5DNrKeuh8adrO6Myc2/84hvQeqLlxoZ9elMuUKO6JImhdgoMDOPgYUfRQuQzZTV0gRX
         JOrzRl9KYbqMdkc3cRWr70EhO9MYz33D/c9O4YhgsOsEz9gvoqNb7Re/JcdVq+ND6CY7
         jeNw==
X-Gm-Message-State: AOJu0YwesE3BhLA9Mtahjoane+cWsvieek6mDlnUoUAqzQfsmrXYTpT4
	nPKs9lhD9ZcUG5g2f5OlZGX7SvptTpvgs25mIU+dduIWu739ZWxi
X-Gm-Gg: ASbGnctfNFa2ib8Hltnij8cFWWPZ2YyOsAMhWzkddHf156gE5mqUmin5xUNt8a5uOMb
	E/VGVpT1Mdyb9KSfSBuowNpRK0rPN5Ed4To/9xucsemSkfpCuzOBF7Nw5/TDQZgELmgQ83024V9
	+Kn4jWfXylnYE/Rq+UaGcoSNkzFafVCzCyUbk3q1o5TBGKHAgzWCoatW27J3L5Gt6KM5wCFxtNP
	QqoctUaS3TA80DTkTwcfceVHnvyRe9ILpTKrLM0BVqStujbUESfW8FTQ3nwhLmpOtYCbTigZr0h
	iCQ5To+di71eD76g0BS9N2W8Gq+zr9nrU1ni3vYIZgMq2hlq
X-Google-Smtp-Source: AGHT+IHIc+AAtt3sr4T1GtwqdHMtSVSWX5aosI17cxg3x5s92xDXSiqKxcV+dY6R+QBB/DcfnPzLHA==
X-Received: by 2002:a05:6a21:3a94:b0:1e1:b014:aec9 with SMTP id adf61e73a8af0-1e1dfe6a0c9mr2940346637.29.1734074391232;
        Thu, 12 Dec 2024 23:19:51 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d899efe4sm10403960b3a.161.2024.12.12.23.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 23:19:50 -0800 (PST)
Date: Fri, 13 Dec 2024 16:19:46 +0900
Message-ID: <m2r06c59t9.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ebiederm@xmission.com
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <87r06d0ymg.fsf@email.froward.int.ebiederm.org>
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_231952_400090_69801077 
X-CRM114-Status: GOOD (  21.18  )
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


Hello Eric,

thanks for the feedback.

On Thu, 12 Dec 2024 23:22:47 +0900,
Eric W. Biederman wrote:
> 
> Hajime Tazaki <thehajime@gmail.com> writes:
> 
> > As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
> > loader, FDPIC ELF loader.  In this commit, we added necessary
> > definitions in the arch, as UML has not been used so far.  It also
> > updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
> 
> Why does the no mmu case need an alternative elf loader?

I was simply following the way how other nommu architectures (riscv,
etc) did.

> Last time I looked the regular binfmt_elf works just fine
> without an mmu.  I looked again and at a quick skim the
> regular elf loader still looks like it will work without
> an MMU.

I'm wondering how you looked at it and how you see that it works
without MMU.

> You would need ET_DYN binaries just so they will load and run
> in a position independent way.  But even that seems a common
> configuration even with a MMU these days.

Yes, our perquisite for this nommu port is to use PIE binaries so,
ET_DYN assumption works fine for the moment.

> There are some funny things in elf_fdpic where it departs
> from the ELF standard and is no fun to support unless it
> is necessary.  So I am not excited to see more architectures
> supporting ELF_FDPIC.

I understand.

I also wish to use the regular binfmt_elf, but it doesn't allow me to
compile with !CONFIG_MMU right now.

I've played a little bit with touching binfmt_elf.c, but not finished
yet with a trivial attempt.

sorry, i'm not familiar with this part but wish to fix it for
nommu+ET_EYN if possible with a right background information.

-- Hajime

