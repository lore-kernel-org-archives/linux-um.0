Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48291CD5BAC
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMXW462J7KBbP+UVAeTru+CXG+zxI7UyNGTZP4jTGXE=; b=ff40XAJrUTFsaxXVepQvQGyGp0
	6KKi4HSqyihzly9yjL2WfYOnnJeKhHfe38yBmgwaQfiLuO7aPwJrdsDI1wwqyp5xzyXWmDu/g9UAc
	NjeNxHxrSFWv/Mpjy7mkZXnjs8qZ0mq49ARttd6hJ1z6EQPqL7o4+MS7nDS7ltG2AhJFivvg1bhrA
	DXws6/6R44XRdVozwVmkyGuFa6arCeKysPpiag6/OYA4+nCxT0WIci0xP7LxFX9bWu8g3g0Qrvo7A
	zACBVNUW7dxfeiz6Tiv/9A26NgaiR0k3lLLwphcqPbmdOoOBNBONVazmpGdid8T+DWAcpuNhdPcIk
	uaTjc3DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQV25-0000000BiuJ-0AV5;
	Fri, 22 May 2026 18:55:41 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQV22-0000000BitX-1C64
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 18:55:39 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 11EDCEC00AD;
	Fri, 22 May 2026 14:55:35 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 22 May 2026 14:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779476135;
	 x=1779562535; bh=jMXW462J7KBbP+UVAeTru+CXG+zxI7UyNGTZP4jTGXE=; b=
	m0WRxH8gPKnMGKTehv5pWGzNgH/vFtWYCuAGDZHkhQUzdw6U3K+E+XuQhO2rIiYQ
	BW80k2nTLbqTKd6ASEGfAbi6cQ7rRbrmtGB7YFRrP6Wq/UtVGD+KdOCFw8uP+ESL
	d6D31+OrZBULIENzCOOLBXY60qePLgcHJme91yDkq5DV8d228UyuQmQmX8wLVVdm
	gEhFQeYcow1L4tC/OfGn9RIXMAJwaaFHceZZIwyIcCwx8oABUXy7Box65JGFWHZI
	h8KTmAR5/Hczlj0aA7TEgy2ePoQG9KqaY3XXvLggYRNM3FXXQa50cLblPwjUxlrm
	5JyfgRAhRgJLboEa8mt9Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779476135; x=
	1779562535; bh=jMXW462J7KBbP+UVAeTru+CXG+zxI7UyNGTZP4jTGXE=; b=V
	KZn8lmRoelTFcwYYv7Z6NRmQ44ns8C9RMRmVEBremn94ZDxt0Eu6rs/0SzMWpXrc
	qh8QEmLXKTZ9wBjk5UhEnwB531Flek9GC+L3XVXUGwRk0GO9WIGmFwhTt+V792IK
	xN5ntNuK+jTsHsCH7Yr3xu58pvxUgKtuBIHpKp+OP19o9xI+Lz5b/WiZ+73RSh4h
	YHwkBk0OAcSewYNhiuUSlUZ16Z/2G+nl3oHZMdC+YNbD86omFsyU70yh0dR/hH3L
	tHJ/yJrhgt7dW31J28dEW/ke5zXyKKSDPtAFIUijeYhI7O3IZGdoOFaHNCzUgqya
	lb9hM8SlNmtJWl1xeQxrA==
X-ME-Sender: <xms:pKYQagdDsCUSAUId2TAS0Etlx_W_aVaDDSf_5PbQmusj4md0IGn6OQ>
    <xme:pKYQatCnRyDzEccls8nWEBv0M-uSpN8_xTKCObt9JuabiDOEHKOGnU5veZROe7hhG
    9aIVdGsa-N8MiO_UOKuYKOUkVeRcFX10dujzou0NWHSHTkyq5KQjG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegrnhhtohhnrd
    hivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohephihurhihrdhnohhrohhvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprghlvgigrghnuggvrhdruhhshihskhhinhesihhnthgvlhdrtghomh
    dprhgtphhtthhopegrnhhthhhonhihrdhlrdhnghhuhigvnhesihhnthgvlhdrtghomhdp
    rhgtphhtthhopehprhiivghmhihslhgrfidrkhhithhsiigvlhesihhnthgvlhdrtghomh
    dprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pKYQai4B6SRV6VrDyiDz_rWl425WqFfu-tZIVoJtihF4SBb1sQt6rg>
    <xmx:pKYQand7vs6GyJmO1VDO2nAVukNvUVgXTRwYaDtUsFfUvwQShCRKTQ>
    <xmx:pKYQahcYtvvCr352a7w8xA03W3PcXlosNS-03ROVeHYbw6xOqNPXDA>
    <xmx:pKYQakHfse8XiswH0zhjTvYU7pCkzheQuVzFYnqjXifGvcKQSRahGQ>
    <xmx:p6YQanXWbCaKTmkS4Sv5XAANdiwI678AD-i4rTAktYOijvPf67oZJCoO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 656DC182007E; Fri, 22 May 2026 14:55:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AMu38ZBA5kDN
Date: Fri, 22 May 2026 20:54:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Juergen Gross" <jgross@suse.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>
Cc: "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Alexander Usyskin" <alexander.usyskin@intel.com>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Message-Id: <caee6c86-00ee-4f91-b449-f91606d03942@app.fastmail.com>
In-Reply-To: <57e5a8e2-d277-459b-a10f-48c5f1b5f0cf@suse.com>
References: <20260522141959.1071595-1-arnd@kernel.org>
 <20260522141959.1071595-6-arnd@kernel.org>
 <57e5a8e2-d277-459b-a10f-48c5f1b5f0cf@suse.com>
Subject: Re: [PATCH 5/8] x86: remove dependencies on CONFIG_M... CPU options
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_115538_536863_D8009CEF 
X-CRM114-Status: GOOD (  11.51  )
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

On Fri, May 22, 2026, at 17:46, Juergen Gross wrote:
> On 22.05.26 16:19, Arnd Bergmann wrote:
>>
>> --- a/arch/x86/xen/Kconfig
>> +++ b/arch/x86/xen/Kconfig
>> @@ -10,8 +10,7 @@ config XEN
>>   	select X86_HV_CALLBACK_VECTOR
>>   	select HIBERNATE_CALLBACKS
>>   	depends on X86_64 || (X86_32 && X86_PAE)
>> -	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MATOM)
>> -	depends on X86_LOCAL_APIC && X86_TSC
>> +	depends on X86_LOCAL_APIC
>
> This is problematic. See commit 93cd05976498.
>
> Maybe use "depends on X86_LOCAL_APIC && X86_L1_CACHE_SHIFT >= 6" instead?

After patch 6/8, this is always true, so I suppose it would
if that came first, right?

On a related note, are there still remaining Xen users on new
32-bit guest kernels? I understand that one could still run
modern kernels on 32-bit Xen-4.2 (EOL in 2015), and that 64-bit
Xen still supports older 32-bit guest operating systems for
compatibility, but I'm not sure if there is any reason to
legitimately run a 32-bit linux-7.x kernel on a 64-bit Xen
instead of running a better supported 64-bit guest kernel.

     Arnd

