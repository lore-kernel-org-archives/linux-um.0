Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36093606EE85
	for <linux-um@archiver.kernel.org>; Mon,  9 Nov 2026 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jffS+vhn;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026102901 header.b=STYSFCwU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=g/8jOmDZ6O2v3DIcsJf17bpPmbV7/1B4PITOught4ZA=; b=jffS+vhnIoppIO
	odKeuwItH+CIPxEUxJKinrYbNYcVOVuLz2C7DTbFUd+KVyEVqsDH9LABhWSLr+Az55gJQVLzdPzvT
	1OJ9nPbDpAebtzLUiC2yrsvv6cutsp2sxYmqf9YQCFAX0tegP/QQXHdp+Wh3k/BABfgsC/z4px1Ov
	78x3d6bIbJWfPTdCB2tcmsIV9UhjInI+mPD3YigF1kWjjmgKUXEKLJMnzNuP2E4I3bfHsMqcjhFd1
	Js8dNrEPTrF1whl+6/4yJjVEQ+E0hkMunjNB2I8VPGQKRGss4g5NY/9yAYdi6coGcMi4dyw7vOgo+
	jYp+Mmn9XePX/bAEiwbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQRs4-000000019hf-2msd;
	Mon, 09 Nov 2026 16:05:24 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQRry-000000019gx-38Ci
	for linux-um@lists.infradead.org;
	Mon, 09 Nov 2026 16:05:23 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6A9G4Mbs1330570
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 9 Nov 2026 08:04:22 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6A9G4Mbs1330570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026102901; t=1794240265;
	bh=g/8jOmDZ6O2v3DIcsJf17bpPmbV7/1B4PITOught4ZA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=STYSFCwU60hwC5VLmdj2iO3q3TjrokW29Lku6HSfoxLicegPK8tbVKrbJ0PstmnST
	 MYVTuF3zJTxBX3SEZ2N0OpzEkD9f33F0vwc/a8VOtBM+/4YKlRbWc2hQqaZxFCRXhY
	 q6INlhIAt0VnxZbFBmKfY2W3uwJ5Sm6RoPhuA7FXMjRoq+QSV0pUZrNu6V3QtTMMPy
	 eUmOgyfZVnH9fWF2mNgt0S04x7G8XPcLmXJirAyvtuluJOUDgzu0xyMQMxToFdypm8
	 7id/B2mTpnnUDkzZeugywS0G4/yt0kr98QzcnzvQ7EZkeqsv8q5z0XvHCgcnEPC7S0
	 yzc9teHE81MlQ==
Date: Mon, 09 Nov 2026 08:04:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>,
        =?ISO-8859-1?Q?Lu=EDs_Mendes?= <luis.p.mendes@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Gary Guo <gary@garyguo.net>, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_Some_observations_regarding_the_on?=
 =?US-ASCII?Q?going_x86-32_CPU_configuration_cleanups?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20261109122908.GU2668804@noisy.programming.kicks-ass.net>
References: <CAEzXK1pdhEyOgQ4owkeRmyEP6Pyfhk=OsMHdzU4xwNMCmCsd6g@mail.gmail.com> <20261109122908.GU2668804@noisy.programming.kicks-ass.net>
Message-ID: <773C551D-6AFB-4180-BE2D-629B6C5D020B@zytor.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_080521_171215_C8238887 
X-CRM114-Status: GOOD (  18.99  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On November 9, 2026 4:29:08 AM PST, Peter Zijlstra <peterz@infradead=2Eorg>=
 wrote:
>On Mon, Nov 09, 2026 at 10:34:54AM +0000, Lu=C3=ADs Mendes wrote:
>> Hi everyone,
>>=20
>> First of all i would like to say that i both admire and appreciate all
>> your hard work with this lovely OS=2E I do understand that maintaining
>> some systems can cause additional burden on maintenance, but there are
>> some aspects that i would like you to reconsider=2E
>>=20
>> I am writing because I  believe that some aspects have not been taking
>> into consideration regarding the removal of the 80486 32-bit support
>> from the kernel, namely:
>> - There is this active Linux distribution:https://tinycorelinnux=2Enet/
>> and the Damn Smal Linux DSL (https://damnsmalllinux=2Eorg)=2E
>> - There are also these CPUs: https://www=2Evortex86=2Ecom/products/Vort=
ex86EX
>> - There may be only a few vintage 486 systems still working, but there
>> are also other new x86 CPUs systems, especially in FPGAs like the
>> https://github=2Ecom/MiSTer-devel/ao486_MiSTer which is a 486SX core
>> that operates at 90MHz and can use up to 256MB RAM memory=2E There are
>> plans to update this CPU IP core to become a full 486DX core, by
>> adding a FPU unit to it and would turn this into a usable Desktop
>> system with tineycorelinux=2E There is a considerable retro-computing
>> community that utilizes the AO486 core on the MiSTer FPGA platform=2E
>> There is even a Voodoo 3dfx accelerator card:
>> https://github=2Ecom/victor-fisyuk/voodoo-fpga-public=2E
>>=20
>> Overall i just want to inform you that some new x86 32-bit systems are
>> still being sold brand new and can be utilized with Linux=2E I would
>> like that you consider this with regard to how much 80486 support
>> should be removed from Linux=2E
>>=20
>> Personally i do have plans to extend the AO486 core to have the FPU
>> and would like to be able to run a modern Linux on it=2E It would have
>> entertainment and educational applications=2E With tinycoreinux it can
>> have a usable desktop=2E
>
>I don't realistically see 486 support coming back -- the thing doesn't
>even have TSC=2E Getting rid of all the horrible (and completely untested=
)
>code for no-tsc alone was worth deleting 486 support for=2E
>
>The other option is you actually implementing RDTSC, CPUID (and possibly
>CMPXCHG8B) on your FPGA=2E  I'm sure that's actually a *LOT* simpler than
>doing i487 support=2E
>
>Just add whatever instructions are required to get the bare minimal
>32bit build working=2E

It would be more likely to get x87 emulation back!

Later i486's actually did have CPUID, and implementing TSC and CX8 (in a u=
nicore system) is rather trivial=2E

