Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D146C44506
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=; b=N20le6ULygLlIlxBVJqfrAJnza
	KtPdnwWypPAl1WOyIR8NSGQQwRymsw2wMglQumzANFy94SCtfFpzsI0L/C9P9njhuLKjHdKFsARSE
	tCiLbzrjVKb+K4Tp34gsZZ2+YPe8NuW5KEFwv/8WljRCxp3Y2rdT/zgTyQvp0KFCR/6hCiGXo5pCc
	wGjwo/8IT0eOz27eB+e0A6UcLXLfpuPwbu1Jegribsr9X0Dkoja/3ghwjZVNP3wjBhjf90atlKcq7
	cmvuM2/96007VdYDhuzf9JprGP1pSvosoPeyWx4D3dGz5TOxaFhxbr2OFTqRehwu0e6JpewLadBR3
	Cr04ah3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtYI-00000003E4d-1rEp;
	Thu, 09 Jul 2026 18:32:50 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtYG-00000003E39-0FQR
	for linux-um@lists.infradead.org;
	Thu, 09 Jul 2026 18:32:49 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-381ed661712so265058a91.2
        for <linux-um@lists.infradead.org>; Thu, 09 Jul 2026 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621967; x=1784226767; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
        b=J0KAxhJDv2kNfjx3GdO2hkLWImCvJe7/0MKAx1JEMoKwzT1Fj9DPP5LH5AEioYSu1r
         Anpyb/cY5+9Hih8yaAS/kr1D/XvuAXzSCdFV4v1pv/VXFJSN3JTN5WQYu3dGHPXgqvlp
         Rb5vqp3fx//SZaCq3/mWQdfgFboZYf6dnt46D50Oija3dLPRVX+h7OF4b2hRtbjnnpaF
         FZU/PdxJSOqJ+bLigblIlKfol0Z2eZB7t9p7ENfJN1jnBzVkyeWgeeJ3EvBHc1EXAYDd
         7JlzjWGZy+rLA77pikm2m1SNm3cy6HMHhhETbfQSCIytwTpn+wQEb3ndY/J24QVblXWM
         hKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621967; x=1784226767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
        b=nvOK4dcKEK78H+gwGo7yR0v9i4LhGKH3m3IwEDycnh2pgNMkoaG7DFiTBSi/WEThfM
         PjpCx4bS4EbokqZAA0REB8Rbrq7RoFC4Xhdlie4RLW3aKQUC6IAyE883xS/o3iJeaaTK
         rPejYFaUhBT1b5joymee4b6mKJKh9LeE0Y6F7yrYY01r/ysJmLra6QQh6ILklGIpzPHD
         NgSK/DyYUJUiii2Zv0wjOKi5XpO8FLuxv9j0rKVdS+48CgnzvF2re4ah3TYcTEBplJ0Y
         C8Gg1d9JLbeWP/mjiGKdKaN3kzDCXiQCqaxmG58DCQITtNjFg9lqeDCiCdiaPPNQlHvU
         ryPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHMgWNNs0C4PlHasvNSdf16IONl7gZl2lacvoT087ubUWPIy8j43SUA8f204pXSHnEG91Wyb+Xgw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9Gw00X+W2PeNyHPHF91dRRbUt05QE0s92ZvzF6Eml/icB7cFR
	HxCBXTJXHl9+d2BNRDf0SvaPhdsQTJMjv0Tz3cPTWrE3HkgDJLaR+nkd
X-Gm-Gg: AfdE7clHyWDiIMQLWRpMDseTDq+j+Yyt0QywWDtVFvRSv448g/Bg8oWiFh3tA8V6CX6
	qwZbgWoJLjb3LX2Qi2RALpvVGZYIyWZ3JifBKUVGBRxoRUNItTNtMzxqxjY6Gko8zd9RIDMHcDs
	IuTDlfm6Ajgy35UdGDkZa8d8m6aYw71gW4fFSN6dm/FED011toDqPLNdF66DYLa5w069RBOE02X
	zC0yHmVDJjWPysgDRi8fF86UWqVbyCKhmlF5sm0KGwcBJQ43vXQd+Se1a703ZIEBz2LoA68Y9Id
	myk3jsQr3b3dldMTkowAN2xgaEPfYHE3MieeMnv2Igyupo53aFLXXDYCPjdcBPBrstGRcXiT+OS
	T1HwHW7CYTtJH0CJv9hWHtZWpZpz8R9W7/wuL2yAkI8fAFk+btCU4DCX3Hcp5q2ZfjimtBAyrmu
	1LaHzIbE7qKi9ajDLWfT+hWrRStT5YXpKrXGESPHqkk4+eVUFH8OQcZ+GH1S8x2RNLNnIXWEQ=
X-Received: by 2002:a05:6a21:3295:b0:3c0:9c18:d5a7 with SMTP id adf61e73a8af0-3c0bd1c4948mr10580989637.68.1783621966489;
        Thu, 09 Jul 2026 11:32:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm55669365c88.14.2026.07.09.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:32:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:02:27 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
Message-ID: <ak_pE64J_xnLQBMd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.718191130@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.718191130@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_113248_105033_4019E7B3 
X-CRM114-Status: GOOD (  10.85  )
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

On Tue, Jul 07, 2026 at 09:05:58PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
> 
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org

Thanks for fixing this.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

[...]

