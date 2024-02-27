Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C39C5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvthbOEWI57px7uX0Cq/SvB/Jiq4PKWj3XWiDYpTS5o=; b=PZRshZinQpFbRNCs6Ydw+s1Buw
	dMpsvaNk5kbzqhbuEg+wiUFYX33zAZnXB3ukOFBNd0LEpnVotdfON2tlapL2LlU/LqiQoG1BKVZan
	ncJXQxNJB70R4D3MHKCfErzsHsFrbIbJbD2XzotsAv1IRUPuC3u2zhXDh2ddQheJ8UOYU8ccDKtcI
	Ns/RkZ1JdrlLFDqGuLfsHnOJE1XZ1rFEgQZbODuAL+vLuwRvtHP941ppDk67DSzpvK7rWx1hToMp2
	LO8v6eNIMoTi6dQ78iZWjRlitzYvY8/A4anr33zXVtxKI60MkX5Z95HCWwV6xd/8rF5wwzjB0xlSK
	/56Wh9hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezcK-00000005pUC-2tWx;
	Tue, 27 Feb 2024 15:43:40 +0000
Received: from new4-smtp.messagingengine.com ([66.111.4.230])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezcG-00000005pQy-0AiW;
	Tue, 27 Feb 2024 15:43:37 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 634E9580A1F;
	Tue, 27 Feb 2024 10:43:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 10:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709048615; x=1709055815; bh=RvthbOEWI5
	7px7uX0Cq/SvB/Jiq4PKWj3XWiDYpTS5o=; b=ETPl5htV7hPJGyIFVjM2VDJlRJ
	JywnITINm7820fBfb3Xdg0RotosUKEfkEmxGh1k+JS9kphahurayiI13hznGLeIm
	MbYBqWKV+tP4RurXvAd1ZtPNforvZyb9z/g7ceDiz+h78r4tigeMSbrfwFNXmumH
	fOb9S6gVv3c+KVSaRDBSJ5Jy9abQDxTJL1hwwol+0A5h7wV+HeuevRDckJsJG7I8
	WqU9yoRi3mWoRn0p1BLR+fCwXX1WcoFnCDhz0jcdI7ggVlB3OHffV/iGZaVYIAOA
	1HUD8wJIFUuwEacMn4br7UHdx8Z+dBuKSQk8ZatJtUJOz78cHxKs+MMrHJlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709048615; x=1709055815; bh=RvthbOEWI57px7uX0Cq/SvB/Jiq4
	PKWj3XWiDYpTS5o=; b=NT3iQKQhAWJtF8LpyAbu0f/NJkTT77zJv2vTIHAh557R
	s3yetq/9tlfhtbar0DclfTfRaeq7xkQ+ik4aXUEpTfXPxyCk6oBk8rf1+WzXO13w
	sbMmXJ7/z07mKQO+WWMYLvW+qj5Av6FRqV2SNaMJYCCuMqH1Y3ouHuo+Q1W4NY58
	o7RAS16zuI0wC5ecItjLV8splKg9jzheGY+Sk6ZsWoLLEt5Z6E6UFZo78D2+ULGC
	hUfm1nfzW+s+47M1DgWxSCrGezaUXnqzM70yM0DxsG+XPQAxBiqVUix3/13lyu72
	eVy63lHdCcF9TuLQO0QH+42d2xafCtvmGh0EZCRNOw==
X-ME-Sender: <xms:JwPeZWatQztnTOrjeTLXYpxnKqyIPALPJ3sPFo2X8oTnM0HHrVLd7Q>
    <xme:JwPeZZaUmJ-HHYf3CWZXh-2YOFlWdays-LpGDgdwmnmSO9YP-kFoUL6jkFSiosCH3
    FxGzUCOIOmG0PddvN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JwPeZQ9gHg_e9TU2rmqVDT7C89NGVhl0jLj5gA86W34yTgnP27lyGQ>
    <xmx:JwPeZYrM844Y1piwZ1hoXvq4kob8AwbwFPpB3Tl0qH7ukJsUwZK_gQ>
    <xmx:JwPeZRrXDV8P06sK5xVATdSl45qkxwQgZgJRFS1QUcTyZDudKEvKpQ>
    <xmx:JwPeZR2vDyPGNuT2sbDOqkmm6IqOH7RitzSfnlNxpl1amFz_HmH3Fw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 22FFFB6008D; Tue, 27 Feb 2024 10:43:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
MIME-Version: 1.0
Message-Id: <e1263cfd-bb21-495a-a849-f0ea795a6d9e@app.fastmail.com>
In-Reply-To: <CAMuHMdVCWF50SO1TK5F5Q8sN08THKJ+F6gt9u5pD05gJUZ+E9w@mail.gmail.com>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-2-arnd@kernel.org>
 <CAMuHMdVCWF50SO1TK5F5Q8sN08THKJ+F6gt9u5pD05gJUZ+E9w@mail.gmail.com>
Date: Tue, 27 Feb 2024 16:43:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Helge Deller" <deller@gmx.de>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>, x86@kernel.org,
 "Max Filippov" <jcmvbkbc@gmail.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Jan Kiszka" <jan.kiszka@siemens.com>,
 "Kieran Bingham" <kbingham@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 1/4] arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_074336_174581_FA8AC841 
X-CRM114-Status: UNSURE (   6.51  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Feb 27, 2024, at 09:45, Geert Uytterhoeven wrote:
>
>> +config PAGE_SIZE_4KB
>> +       bool "4KB pages"
>
> Now you got rid of the 4000-byte ("4kB") pages and friends, please
> do not replace these by Kelvin-bytes, and use the official binary
> prefixes => "4 KiB".
>

Done, thanks.

    Arnd

