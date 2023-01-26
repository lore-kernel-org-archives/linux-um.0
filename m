Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FD5C05027
	for <linux-um@archiver.kernel.org>; Thu, 26 Jan 2023 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EgYA6lhtQ+5Cxx9/xb7ZhgWTDPwTalNLQ1Mq/B5NdYY=; b=uoDAla5y9jhd4y
	piBNCZeKHP8nlQvGIDVWiJkwXvl/PaJ7L+b7QDF3HWbGreyEI8CsBnHP2ncO9ieDl5Z40BAndN7Lh
	nwZYtgTWhrfEI1IEqb9lY+352M7o+IkUNk+Xugb7tYTFQCVkBfvRMRsVFVeL+VBb16XexxYHS9LB/
	D6PtXrehxPwORfFON1AXntxqd6cZ/isIOaRSj6PriOTqFU46SoAHFbPIA7OqgI6h3podiD+tT2g12
	RWvdiY+0vR3jtD0gU7w3sYLy72GaNUslC8fq+8OaGLWrKMqsct5hP1wkAF5DRgCi5TceiLUa7KAby
	xGUavAIDKYCVyoGfqRqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKxbU-009yfc-8F; Thu, 26 Jan 2023 08:27:28 +0000
Received: from mail-qv1-f50.google.com ([209.85.219.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKxbO-009yes-PY; Thu, 26 Jan 2023 08:27:24 +0000
Received: by mail-qv1-f50.google.com with SMTP id x18so995469qvl.1;
        Thu, 26 Jan 2023 00:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTLUhLqiktW0lQYPPHgLpL0hyET/yRv7DDBqjk/47Fc=;
        b=HF3Mp/tkUQEt92H+3m9PR8RfC5plw3fnI5O/4A9VdWJl8dt/ClvT4+4jZNz9G15OO4
         j42ue8HC+yDyY+bYiq8sORYFLym/y9nA6hpOMiVyvJNbcZK0F9/LpUqMxszneRVXU3u6
         1D6Zof0CDbCj7X71UoYWaldupTGxFUolqZ2kxfpmbhI4dD1MZxomv7IH4N4rkKLpE+WG
         Z6WS59gTbTXLklHH7H7QXQ2SVeS+tveabns7+EAC0Yfu40yQQ9p1yI2An+xIs0U+JLCG
         PVNFHpAtp4v+5Yvyq93UNsO7FVrDnoFG1Q3FGD0w8VKSlGCZfsPcfbUFwtRxUhDKgqar
         +kkA==
X-Gm-Message-State: AFqh2koVr7IxfsN+NqR/C/otK/cBUmtMIn1XXBApm2JzbK3SOSbe0D0H
	WihQFcFOKBCsR6oH0FafjYaT/YqhaIai9Q==
X-Google-Smtp-Source: AMrXdXuLnoSu1EMzjp+VUp7CW45G9/7r9YIkt5Q0Ty6EZP2cHTyBRB1xO2tYBG6UUPohvNHPrTsHrg==
X-Received: by 2002:a05:6214:3991:b0:51e:a23c:92b7 with SMTP id ny17-20020a056214399100b0051ea23c92b7mr51712201qvb.21.1674721640249;
        Thu, 26 Jan 2023 00:27:20 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id h185-20020a376cc2000000b007069375e0f4sm517527qkc.122.2023.01.26.00.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:27:20 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-4c131bede4bso13727207b3.5;
        Thu, 26 Jan 2023 00:27:20 -0800 (PST)
X-Received: by 2002:a25:9ac1:0:b0:7b4:6a33:d89f with SMTP id
 t1-20020a259ac1000000b007b46a33d89fmr2761883ybo.543.1674721245117; Thu, 26
 Jan 2023 00:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20230125190757.22555-1-rppt@kernel.org> <20230125190757.22555-2-rppt@kernel.org>
In-Reply-To: <20230125190757.22555-2-rppt@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Jan 2023 09:20:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUeuPgkWVjpZ=OM4ofnoYyv2nY1_FGo0JUZCFXYX=K2vw@mail.gmail.com>
Message-ID: <CAMuHMdUeuPgkWVjpZ=OM4ofnoYyv2nY1_FGo0JUZCFXYX=K2vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] m68k: use asm-generic/memory_model.h for both MMU and !MMU
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Dinh Nguyen <dinguyen@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, 
	Richard Weinberger <richard@nod.at>, Stafford Horne <shorne@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux--csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	openrisc@lists.librecores.org, sparclinux@vger.kernel.org, x86@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230126_002722_840831_B8A8BB72 
X-CRM114-Status: GOOD (  18.19  )
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

On Wed, Jan 25, 2023 at 8:08 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> The MMU variant uses generic definitions of page_to_pfn() and
> pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
> good reason.
>
> Include asm-generic/memory_model.h in the common include/asm/page.h and
> drop redundant definitions.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
