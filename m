Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CAFCA0FEC
	for <linux-um@archiver.kernel.org>; Fri,  1 Sep 2023 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TWaE0IRSvhkKdiLTaqfV+JFcRkzpFtew6+aqEW5j6oM=; b=1dFqrTzHOHZtZR
	68lVbgc/FmBIDnmBFbPUR8tby7iyFKK8irdEd2HbRcPbQ/6Tc6d/6rAcKhmhV9fcNfeMNQmVoVxBP
	vqGKafip3PIuatgPXge9aDPflCewZN9dSvcYh70FvivimnIoBK+c0GFCkgNnmsNkdZywfypl97DNO
	nSi91KjvmdlB9sEggvzwZ3Tj9IuI8UxId+DJ+wTNlGC8BkPoouMnhDYCieHJOmYGa1SeymXIDhCey
	aZSJvFIJc4yt1rZA7kGLwa+c+jrpYPnDxxT8dV2qTbWg4G4SM5IeA7P0yo1FwsLR4QtxKMXLjKgCD
	d75HEg7x39Kta09dOpkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc7z3-000EnG-34;
	Fri, 01 Sep 2023 17:31:01 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc7z0-000EmM-2D;
	Fri, 01 Sep 2023 17:31:00 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7927f36120cso81094839f.1;
        Fri, 01 Sep 2023 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693589457; x=1694194257; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7Ic2JgCifJ9BR0gJc8OX6iWRD9HNnkepfgcfad3kDo=;
        b=sLZF/V/CWX6hYu3RoUlIz4g9H8W1zD9QKSA31RkuJXjg/8xdAPn0jJfI1dDPnrkPhp
         bS8Lbt/564h1Mxis/v5Dzk33TNdChXafrxQmOpD1QeTELpJDqATDnnqgYZlKWz7vbI8y
         6BMMJ3mSm8uUYjudeyQ43gHIcowlopMhtM6pw8RiHDGVOmroI8Td4Nvhw4k8Xxe4NKsi
         rwYZnQSW2cIrA7mxXQ0pNchYFzmliwW1wYHNM8o/fp2SJcIc2z8C6mcJn8I0v2AVA/pX
         i2aD5202UYaks+rytvcoqKkm3kUSulC7PV2ey1fvIBiRttLcGzJ7DqZVniOhF/H7A7Gw
         BL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693589457; x=1694194257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7Ic2JgCifJ9BR0gJc8OX6iWRD9HNnkepfgcfad3kDo=;
        b=kMV1NXSVY/2HkyW/UYPSxf4hkbRbshwTZ1BQh9jUPWeBCv2KDGc3bfxPWlgvuVfdvW
         126YLkLD8WLGUMRmg9zgU/5wz4W+U2lJkR6vRU2gzt3GrbADQMTDYwSd+5NF+sYhncE2
         GmSnbprtEHc9KWPwVWC4QRchnm5JAO3FIF50O13zVRr7HcvDcZnG1yIbycFD4a6xX+YU
         j5Mfb5fymf/OYAZVE6/egCaAQDbdyyl1Hm1Prt/KSAHRgvdtiSa9KqQ6/tp/M5wJ1LLl
         LNsK9EbztLGVTH5BRLQCLOsUnu3957/8QAliM7W8+B9XPgLFl9CbGnDJ64YxYXJ/XhRC
         zSsQ==
X-Gm-Message-State: AOJu0YzGb292IILaBPCddrLEOzEIcx5w+ePbDE747YCcnHJ51lGmaJWI
	yg47LnNt2BnyddbZlv4SlBs=
X-Google-Smtp-Source: AGHT+IG60rEwPMClyUpLxgIkdetUrkTvd12OeZpQuEmA5mPuJPh251Y1toBygAxAyHVb0OiLVFUbUA==
X-Received: by 2002:a6b:7f46:0:b0:791:2db5:c779 with SMTP id m6-20020a6b7f46000000b007912db5c779mr3826112ioq.10.1693589457075;
        Fri, 01 Sep 2023 10:30:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f23-20020a056602039700b007836252a084sm1178665iov.48.2023.09.01.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 10:30:56 -0700 (PDT)
Date: Fri, 1 Sep 2023 10:30:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Richard Henderson <richard.henderson@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chris Zankel <chris@zankel.net>,
	Tom Lendacky <thomas.lendacky@amd.com>, semenzato@google.com
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
Message-ID: <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230613224545.902376621@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_103058_731994_BED47E70 
X-CRM114-Status: GOOD (  17.80  )
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

Hi,

On Wed, Jun 14, 2023 at 01:39:46AM +0200, Thomas Gleixner wrote:
> Initializing the FPU during the early boot process is a pointless
> exercise. Early boot is convoluted and fragile enough.
> 
> Nothing requires that the FPU is set up early. It has to be initialized
> before fork_init() because the task_struct size depends on the FPU register
> buffer size.
> 
> Move the initialization to arch_cpu_finalize_init() which is the perfect
> place to do so.
> 
> No functional change.
> 
> This allows to remove quite some of the custom early command line parsing,
> but that's subject to the next installment.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

The backport of this patch into chromeos-5.10 and chromeos-5.15 via stable
relase merges is causing various Chromebooks (not all of them) to crash
early during boot. Subsequent fixes have not addressed the problem for us,
so we already reverted the patch from chromeos-5.15 and will revert it
from chromeos-5.10 as well.

I don't know if this is a Chromebook specific problem, or if it affects
mainline, so this is just a heads-up in case others experience similar
problems.

Thanks,
Guenter

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
