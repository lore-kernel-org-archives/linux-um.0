Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB4E77179
	for <linux-um@archiver.kernel.org>; Fri,  6 Dec 2024 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cDATor5/B9MLO5fmM6e7Dlm6tdjNFHS94obtlWsx7IA=; b=K0PkvQ/PhZ859yz/TW1H4vC7gA
	fP6NXH/LqcI2s58Wcb0QZP/jt/PtZlGNRofaeohs+gZFXp2wwJ4l+GZN+yAiV+T8ERuOV1VUikI69
	1FowMk7nkjSDFVR8Pw4bPUfzPZQ71zMtZliEpNA2mPB4BlJeWNnyCj/o6kWAcu0BzX7cakrLvJG3I
	pnj5ZX9viYdy3diFIRjvzijEVNEo86I9L2X/xBaKQodeDVWZ8sRuSz+QF4atThIs6AP/j5DTd267X
	q47gfP3PeLFUAXqs8hFbMLwrw/X8gMK3J4c4e5LqaWd8mpRLn2Ho4YKCW+f5iCCRCAOGQ7fgLMtrX
	BI2yIfYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJbcb-00000002Fvc-11pm;
	Fri, 06 Dec 2024 16:56:05 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJbbs-00000002FmO-3Z6c
	for linux-um@lists.infradead.org;
	Fri, 06 Dec 2024 16:55:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DEE7EA4430C
	for <linux-um@lists.infradead.org>; Fri,  6 Dec 2024 16:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590CEC4CED1
	for <linux-um@lists.infradead.org>; Fri,  6 Dec 2024 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504119;
	bh=+slD34unIlmjHq4fh/LfbukzF5rFO4dHRAiMM+iU3ks=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hx4flsFJtP69NGHMUasZ0cU1EiT5jKHq4pAcvqmMgO5hF425wjFo05tczsw3FFVIb
	 bAYHk2z9xomcs8dlDDCWmLmOxqLI3MyBQymaT7YHlUTkJoq8w/FDPhc93uQMAWjb98
	 mqEaDRVtjR2qwlgXBzwLXig0EhCba00sRPSqI685RPiK58sFbeEPEpVl8v+665x+KU
	 tQoiwZHxLCQ+84Zk0vYTzI2ZVTm8AGo+9aZVsgEFhA5o/17wu+8I08hrvEoqljrRu3
	 fDdFWrNC3VNfZiAH/3lK5Es5IAkErvKNq68lsQ+OLBfV+uiufhVGmWr78giUy1KP3I
	 tRm/GUyxgzzyQ==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 70C0F1200043;
	Fri,  6 Dec 2024 11:55:18 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Dec 2024 11:55:18 -0500
X-ME-Sender: <xms:dixTZ_OCPcFwM92xFsZew6bOupFB7uZ_5614lTScwASl3cNnu2A_Ag>
    <xme:dixTZ58v0URz5jLlLdPGJb1TzMxMlhj1nyVu0hP2NpUtRIX8vJDZ6RIoroSOnZ9Zm
    1S1P0LkljQJEUDLHhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpedufeejteetlefhgedukefhteffheethfdtveek
    heefgfdtheehgefhkedtkedvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhi
    hsrdgtohhmpdhrtghpthhtohepjhgrnhhirdhnihhkuhhlrgesihhnthgvlhdrtghomhdp
    rhgtphhtthhopehluhgtrghsrdguvghmrghrtghhihesihhnthgvlhdrtghomhdprhgtph
    htthhopehinhhtvghlqdigvgeslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhumheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehjohhhrghn
    nhgvshesshhiphhsohhluhhtihhonhhsrdhnvght
X-ME-Proxy: <xmx:dixTZ-R4zv3M822zFHAg1cgng02oZkFPY4Z-klc_108ssxulBB1DCw>
    <xmx:dixTZzu9mQDJadMoVgJWI9RFcDGVmmsAWmrP3dvXkIM3Egg2alokjQ>
    <xmx:dixTZ3dYIDpsvcu-KQj66pkU4rZA-V4B95pmM_ehTxlqxUADd4bNXA>
    <xmx:dixTZ_0w2w89kpOH0H9HxUVw5Y6JfOTytHBN9up-hgNlJZfKAh9rnw>
    <xmx:dixTZz-7MLAw7Owb__jW9YF9LpOVf0I3e13qs28neubX5N0l6FktlGYU>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 461792220073; Fri,  6 Dec 2024 11:55:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 17:54:57 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Jani Nikula" <jani.nikula@intel.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: "Lucas De Marchi" <lucas.demarchi@intel.com>,
 intel-xe@lists.freedesktop.org
Message-Id: <cafec036-d476-4bb8-8a23-25fb65943d54@app.fastmail.com>
In-Reply-To: <87ser21ks4.fsf@intel.com>
References: <87ser21ks4.fsf@intel.com>
Subject: =?UTF-8?Q?Re:_um_linux:_no_previous_prototype_for_=E2=80=98ioread64=5Flo?=
 =?UTF-8?Q?=5Fhi=E2=80=99_and_friends?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_085521_020326_E5C65301 
X-CRM114-Status: GOOD (  11.44  )
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

On Thu, Dec 5, 2024, at 11:33, Jani Nikula wrote:
> There's this persistent build warning about missing prototypes with
> ARCH=3Dum:
>
> [12:21:20] Configuring KUnit Kernel ...
> [12:21:20] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=3Dum O=3Dbuild.kunit olddefconfig
> Building with:
> $ make all compile_commands.json ARCH=3Dum O=3Dbuild.kunit --jobs=3D8
> ../lib/iomap.c:156:5: warning: no previous prototype for=20
> =E2=80=98ioread64_lo_hi=E2=80=99 [-Wmissing-prototypes]
>   156 | u64 ioread64_lo_hi(const void __iomem *addr)
>       |     ^~~~~~~~~~~~~~
> ../lib/iomap.c:163:5: warning: no previous prototype for=20
> =E2=80=98ioread64_hi_lo=E2=80=99 [-Wmissing-prototypes]
>   163 | u64 ioread64_hi_lo(const void __iomem *addr)
>       |     ^~~~~~~~~~~~~~
...
> [12:21:24] Elapsed time: 3.945s
>
> I fail at figuring out where to stick an #include or #define readq or
> something to get the prototypes.
>
> Cc: Arnd who seems to have fixed similar issues before on other archs,
> do you have any ideas?

I need to read up on the details again, but I think this is
actually a fundamentally hard problem to solve as we have
conflicting definitions for these functions depending
on the architecture:

- On 32-bit architectures, they are a pair of 32-bit
  MMIO accesses, which may point to PCI PIO space,
  but never a single access. These override the
  normal io{write,read}64{,be} definitions. The normal
  way to call these is through io{write,read}64{,be},
  after including the headers.

- On x86-64 (non-um) it turns into either a pair of 32-bit
  I/O port accesses or a single 64-bit MMIO access,
  depending on the address, but never a pair of 32-bit
  MMIO accesses.

- On other 64-bit architectures, they always turn into
  a pair of 32-bit MMIO access that may point to
  PIO space, but these do not override the native 64-bit
  helpers.

It would be best if we can agree on what semantics we
actually want to support here on all architectures,
and at that point we can implement this for arch/um as
well.

       Arnd

