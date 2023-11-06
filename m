Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07335C4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0RsqTr+/5fOYK36f25I74vZ3orznrXscJXVJPuaw+J0=; b=eoqhQbjLdpmsFg
	vBq+EEbVD3abNQeDa4ZXmCwBdWDefrFXpN2Jwl3kkN53OSsxNNDaQ9VgsVBYIzqSB1VHTMslubvlp
	qloxW8WCdufI5qjNpRDbzcvG+PCqFEZ33WHoFPApcDrs/1hKZrfxzradLRZshLO9Q2wtBu619aDSO
	JjWacpBBAs13IJJtKUDZN796Sj9noUduEL3rZIAat0RCdzOgQ/KzxF05/AOShjs74N5QME9nJLtgl
	r7HPJhgE8hhMT3KcFdcKMsLA75fyIR/exDxnTOP2d4G1Om7JxbhXYcLlrZhQm+xRFU9IyZQp9HQD2
	A3sNkkxNOnSUBXxI2fiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qzxrB-00GOVn-2R;
	Mon, 06 Nov 2023 11:33:25 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qzxr9-00GOVG-1D
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 11:33:24 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so31228335e9.1
        for <linux-um@lists.infradead.org>; Mon, 06 Nov 2023 03:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699270401; x=1699875201; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUKg4uVi4S/dFZ17di9VmvoE4aPOO4c2Mhi3gOlXYIY=;
        b=Mcze9bxVXI2uCix/LiV84LCZkpGdgne4pp2fSXc2OP9W82UXzJOz6rP2SKyFwcnXkb
         9NXc48QNVo70wj6bGAosxZlp+yWsR53Pp2OokhpsvMUbklaEIBKUnNbLwYjFepG5t6Nh
         cLEkCUUYX0juT0nABLnMap8xo0XXO4mwmwAtzpCvC3AcBud/g1F8SOYI/sUH5b6trTWu
         bwjzUYYorzH98mXNYJgmdCW61Cj8pGHT+GHBZbJySiRMJnOHinM0ZWNyizTKo/otbjAU
         Bgqb2KidKAxTrcOb97T6YskgbrzKtJBPmptirmHxWoMjM0jQp+VRSiQn0SKxZ0+64tb8
         GBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699270401; x=1699875201;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUKg4uVi4S/dFZ17di9VmvoE4aPOO4c2Mhi3gOlXYIY=;
        b=mPfOA+F+0r1puGOliPP1WCI33Fd6tai+5q/AmBGjLHpdL9JVOOI1ix0X3e0KD4rv2A
         AsUHRwqbINUG4LoMMsNbe4jfUb+ls0eDIVhlgnCpRVrAaCYlI5DMvDzJ172lQaT/LVPI
         R6rw/ICoXllVFGMsfA5Vj55RdGRrlLtACuyCz9COrnxg0jzv7hwTDq1rBGx2vIIH74I1
         bl6ZY2yizZMO9adtfZ+EcgJO/U4Jju3eoEX4XVboZD+JmuMf9MJHZotQL70Sb2MEaSzb
         9me3OrfNUhZ5acWfvL3s3eTsSG/rE/okwqVXLEeIPGgpJcp1K08jS7eU2rOk0hknDhJ4
         AZTw==
X-Gm-Message-State: AOJu0Yx0AOOr3aoizt7YEaTZWF4r2LyBpdF26u+h4tu5Y/vYj7pniiTk
	Rd4YDAB1ZX3k5Nbo+/jdTiI=
X-Google-Smtp-Source: AGHT+IE2f8JmuTi8owPpBOZcT3du3yeq7e//eJgkT8TBc4/LbLa7lzX8PxyD4XIK6sHGvxBMtIDwwA==
X-Received: by 2002:a7b:c851:0:b0:3fe:d67d:5040 with SMTP id c17-20020a7bc851000000b003fed67d5040mr11252842wml.5.1699270400711;
        Mon, 06 Nov 2023 03:33:20 -0800 (PST)
Received: from smtpclient.apple ([77.137.74.70])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b004068de50c64sm12045548wmb.46.2023.11.06.03.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2023 03:33:20 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Missing clobber on alternative use on Linux UM 32-bit
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <41cac2e7ad9341259f356e1b3cf5f418@AcuMS.aculab.com>
Date: Mon, 6 Nov 2023 13:33:08 +0200
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
 Richard Weinberger <richard@nod.at>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-Id: <9D03E2C9-0571-418E-9075-6DD39DBA724F@gmail.com>
References: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
 <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
 <1616BF59-5C18-46C7-86AB-92604B683652@gmail.com>
 <41cac2e7ad9341259f356e1b3cf5f418@AcuMS.aculab.com>
To: David Laight <David.Laight@aculab.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_033323_429936_BF328C39 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
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



> On Nov 5, 2023, at 5:47 PM, David Laight <David.Laight@aculab.com> wrote:
> 
> gcc always assumes that inline asm changes "cc" - there is no need
> to add a 'clobber' for it.

Thanks. I was unaware of this behavior.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
