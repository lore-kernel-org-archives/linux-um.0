Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D18E7717F
	for <linux-um@archiver.kernel.org>; Fri, 13 Dec 2024 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wqLYNgaFsfhCdC6ZHF4qPWqLcHB1iEwLOJKG4uK8Pj0=; b=XKrSZbTasn5UglsUoWZUHCeLD6
	+a1SKr5NfBdFl8+lHIguMHkmY4DHMaZ90jcydCXTHnFzVJ34q6Qff90LqqBMaOE9DoeB3ZlXN32kA
	+kNwTwUc0OMvoedYU9GQ+clhSi3r/0r5cWdRviIKtUHGQkd8A7eLdjdi/N3TZOe59y7LSTHINjLLx
	dZmXrNZdv328RP95rox2YIp1ti2Az0PZkd1g+7YdBa7/dxzNq7t+UR2nb3/jrkNW9ztZ3AfLOoGp+
	nmdBUT0NzI4rQ8Pu3/siK8RZzPEK/5QmjxGxG8ZZLp8ieWDHkTfBN3fwBCefViy9gI4l48Ajxm5JY
	82nFyizg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tME2a-00000005AP8-0PL5;
	Fri, 13 Dec 2024 22:21:44 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tME2X-00000005AOR-2LMN
	for linux-um@lists.infradead.org;
	Fri, 13 Dec 2024 22:21:42 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so1948714a91.1
        for <linux-um@lists.infradead.org>; Fri, 13 Dec 2024 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128501; x=1734733301; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqLYNgaFsfhCdC6ZHF4qPWqLcHB1iEwLOJKG4uK8Pj0=;
        b=IWGXcQuq16qC0Ocdjub2znA0Znw/QqEAIE6M8iCeLebE9VuSKWujQaY+T05B9RWWLO
         6khwqzCZ8VMzOmBbJo1r04XP5TWcBhI/CRF4+AuMekH3Kij4ZQMI+7GQpCqDMsXIrv7R
         DdTO8qKjx8aebfAb++YPo8fg1kzObTHe3Oi/+Pd69pSByxSqwEDKWm0EeLzuwkE+ATp8
         0zTwB8PwIWb0JfKOEbKyWdf35vhbeabm0sSKiYws5UyjPDYhcbx7rDOwrc3aflKH1ebm
         BaNmVbu+tTniiRKdMVbHEQWAi/ggrsoWnAdKV6pn9GxSBHeWnPtn2InhUHgu77t32axw
         Kr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128501; x=1734733301;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqLYNgaFsfhCdC6ZHF4qPWqLcHB1iEwLOJKG4uK8Pj0=;
        b=bt8TQCjDOiIiZI2fHqcl+Upofgo/DgtcI8Mr3dguEMo15k4b2c8Plr0+yCQuyhrwfm
         RanvxOW9PFeYWesO+Zh+fn3hyuv8EotfnLCgKU2evmWI4J9VzXal7J+ha4I2JbE4aMmz
         zV6dkTJ+aCOXDAdG/68xmCy5CTubR+/lTT8RPW39ipR8WFQ8pBbeMbyyG9dU/CXVt7Tb
         FEVVKSH247TMfEk580Mk2Wjj4XTXQIhBMzVJSiWrbRZn541svWxi8tmDGfRfwSn66lp3
         h4Ehr2UXp1MK5BGizJs4YiiSatHjRII3S0qjAucPfGUjbYFREm+V5hyW9+HJw7aaoCrk
         kpIg==
X-Gm-Message-State: AOJu0YzbG2HfaRpByyLsmuCOQ6PEuAk0R93gzA/le5fpDqLmH6kgjabg
	7xvyxrGGgPym2hRn973AHfKE5MaLwlGsB5Cwj7IXbdESRbJPtSAjmIvzDS7b
X-Gm-Gg: ASbGncvvUDFb1uqxfG/O7x5PgIve9dX+nqkNGf6V9Gk1DEWhsbVYdW4NwSOHoCHO6w7
	PvRbqBxfomL96kPuodn1xDh7kC0XJ3fano3gVk+joZgQ/0BWM22Bh44FkAB/0Lksy6kzVuAT45i
	7OGswMFrHnrGgArUQnCd8SbfR/dCXHUsqVR4tdl8Ije4aDEJbS0H7aY886QKGWhDqffSx/KZaii
	8pzm1/Y3WMxrm0Q+b6+ewGlgXv3ibBobfjQ2civUq9w1++T9J2qH3Kq4M2NzTi6DXaZESWXgH1m
	XdvpbNXDRVCVzp09suCqr/ct9q3M1TKkhvjPUK+Rh3Y=
X-Google-Smtp-Source: AGHT+IFhh015tdWX9bBaiS6A5cK5GzjNQ0bQgLvyZteLyIrbh989ImvXOXFjQPgnbCFgKEhMRO+e0w==
X-Received: by 2002:a17:90b:3891:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-2f28fc67526mr8230463a91.12.1734128500702;
        Fri, 13 Dec 2024 14:21:40 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2449c45sm265640a91.46.2024.12.13.14.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:21:39 -0800 (PST)
Date: Sat, 14 Dec 2024 07:21:35 +0900
Message-ID: <m2o71f5imo.wl-thehajime@gmail.com>
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
In-Reply-To: <87r06bz1uf.fsf@email.froward.int.ebiederm.org>
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
	<m2r06c59t9.wl-thehajime@gmail.com>
	<87bjxf1he1.fsf@email.froward.int.ebiederm.org>
	<m2pllv5lb3.wl-thehajime@gmail.com>
	<87r06bz1uf.fsf@email.froward.int.ebiederm.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_142141_595621_1CE1A88D 
X-CRM114-Status: GOOD (  25.60  )
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


On Sat, 14 Dec 2024 06:53:44 +0900,
Eric W. Biederman wrote:

> >  config BINFMT_ELF
> >         bool "Kernel support for ELF binaries"
> > -       depends on MMU
> >         select ELFCORE
> >         default y
> >         help
> > @@ -58,7 +57,7 @@ config ARCH_USE_GNU_PROPERTY
> >  config BINFMT_ELF_FDPIC
> >         bool "Kernel support for FDPIC ELF binaries"
> >         default y if !BINFMT_ELF
> > -       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
> > +       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> >         select ELFCORE
> >         help
> >           ELF FDPIC binaries are based on ELF, but allow the individual load
> 
> You have my apologies I was most definitely confused.  BINFMT_ELF
> currently does not work without an MMU.

no problem.

> >> I just react a little strongly to the assertion that elf_fdpic is
> >> the only path when I don't see why that should be.
> >> 
> >> Especially for an architecture like user-mode-linux where I would expect
> >> it to run the existing binaries for a port.
> >
> > I understand your concern, and will try to work on improving this
> > situation a bit.
> >
> > Another naive question: are there any past attempts to do the similar
> > thing (binfmt_elf without MMU) ?
> 
> At this point what I would recommend is:
> 
> Merge your original patch.  Get nommu UML working with binfmt_elf_fdpic.c.
> I think it is a proper superset of ELF functionality.
> 
> Then I would make it a long term goal to see about removing redundancy
> between binfmt_elf.c and binfmt_elf_fdpic.c with a view to merging them
> in the long term.
> 
> There is a lot of mostly duplicate code between the two and
> binfmt_elf_fdpic.c does not get half the attention and use binfmt_elf.c
> gets.

thanks for the recommendation.  I'll go for this direction.
It would be great if nommu arch (at least) UML can use the regular
binfmt_elf.

-- Hajime

