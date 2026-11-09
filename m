Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE2606A330
	for <linux-um@archiver.kernel.org>; Mon,  9 Nov 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j2FOARll;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026102901 header.b=Ga4QCJmN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2oUG5RL4oF9Bagom1950zIho2zdDaGXSCPdxbH30cMs=; b=j2FOARll8KhimG
	qt1DwyxVEupleEaD5bCEHCqjscIdsHVP+itqYBDYtZOThlDN1rfYPwWn7SuL4Z919e3AOHzqsK2eB
	pECt5MM8OTEVfOGtzwKX/J1v2vYkgLko1QhS50ypton/rwLKeuTZnuqkBvdnA/pwK/cA9CGEulsHW
	xXEb7qNETtJOr34jsfGgG568xmoHDkAraOgEtPTuN8nkQkr7wt5Foxbv7TBS+QCuNS9q7cKgOYr48
	85BtHG5cv13ri4fNi16N16TT/zxhWqVYsFld+NDO8J5n/7sUNuzjKZfEwDglhd/4WboG16U7stq7O
	gv0oCMhwbMfx9BgkhKug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUAd-00000001TR2-3mXI;
	Mon, 09 Nov 2026 18:32:43 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUAa-00000001TQU-2w7R
	for linux-um@lists.infradead.org;
	Mon, 09 Nov 2026 18:32:42 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6A9IW9cc1598047
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 9 Nov 2026 10:32:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6A9IW9cc1598047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026102901; t=1794249132;
	bh=2oUG5RL4oF9Bagom1950zIho2zdDaGXSCPdxbH30cMs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Ga4QCJmNe8Bep6WEaJPZUYp85meRO157IBBvHPDLv55L3PLMGiBIyHW4w+pGgFjs1
	 2Gf7H44LmrswwhYxVyMwLgxchbBhQ+UXDPi5Yh4mpiy7NsO62QPWJGIoRac/HfpC+p
	 VE1kqXgsezZlWqho62sLvw9hQ1KZYxw7wQUtIfR1gLGvOLdXEjN3BH+b/N3buqPjck
	 JxyZqRbuAxD4uLzj8kHywBfQolcfYS080GS1ssHhJ00nCQGWI1ruY56DMDITuvFe13
	 HtAklBbXjRpyVliI5ss8a5EYT7XH1QfCMX1loJMEZzUd9sVKQwd4Qsg/XOxHFm3me8
	 TYS4q4In0jscw==
Date: Mon, 09 Nov 2026 10:32:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC: Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Anthony L Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 7/7] x86: simplify 32-bit instruction set selection
User-Agent: K-9 Mail for Android
In-Reply-To: <eaeec453-892d-4ddb-9d42-0510db8b9c88@app.fastmail.com>
References: <20261105163440.2381661-1-arnd@kernel.org> <20261105163440.2381661-8-arnd@kernel.org> <4207CA81-6023-4DFC-8FBF-2C5C8C036CCC@zytor.com> <eaeec453-892d-4ddb-9d42-0510db8b9c88@app.fastmail.com>
Message-ID: <D58976E3-E2A3-4577-BC64-5845CF4F82C6@zytor.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_103240_755412_9E49E505 
X-CRM114-Status: GOOD (  17.37  )
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On November 5, 2026 2:01:40 PM PST, Arnd Bergmann <arnd@arndb=2Ede> wrote:
>On Thu, Nov 5, 2026, at 21:17, H=2E Peter Anvin wrote:
>> On November 5, 2026 8:34:38 AM PST, Arnd Bergmann <arnd@kernel=2Eorg> w=
rote:
>>>From: Arnd Bergmann <arnd@arndb=2Ede>
>>>
>>>The -march=3D compiler flags select both instruction set and tuning for
>>>a particular CPU, which works well when building a kernel that can only
>>>run on this one type, but has some counterintuitive effects because it
>>>is not always clear which models are compatible=2E
>>>
>>>E=2Eg=2E building for Geode LX results in a kernel that can work on all=
 on
>>>all 686-class CPUs but crashes on CPUs without the CMOV instructions=2E
>>>Building a kernel for 686 could work on Geode LX and Crusoe but fails
>>>because of the CPU generation check that detects these as 585-class=2E
>=2E=2E=2E
>>
>> Crusoe (TM3xxx/TM5xxx) do have a handful of compiler/user space visible=
=20
>> items that are missing from i686, as I recall notably the long nop=20
>> instructions and *possibly* fcomi (I *think* we caught that one, but=20
>> I'm not 100% sure=2E)
>>
>> As a result, it reports correctly as family 5=2E
>
>I don't know about fcomi, but the P6 long NOP hasn't been used
>in 32-bit kernels since your 2008 commit 14469a8dd236 ("x86:
>disable static NOPLs on 32 bits")=2E From that point, I believe
>we effectively treated Geode LX and Crusoe as 686-compatible=2E
>
>binutils apparently uses the same definition and emits long
>nops for -march=3Dpentiumpro but not for -march=3Di686 in modern
>versions=2E
>
>You are of course correct that this remains inconsistent:
>a kernel with CONFIG_MCRUSOE is still built with -march=3Di686
>and CONFIG_X86_MINIMUM_CPU_FAMILY=3D5, so it will fail to run
>on 586-class CPUs without CMOV=2E
>
>I'll fold in this patch to make a MCRUSOE kernel actually compatible
>with all i586-class CPUs, unless you have a better idea:
>
>diff --git a/arch/x86/Makefile_32=2Ecpu b/arch/x86/Makefile_32=2Ecpu
>index 1735a5f95d33=2E=2E9a3a1b1c2452 100644
>--- a/arch/x86/Makefile_32=2Ecpu
>+++ b/arch/x86/Makefile_32=2Ecpu
>@@ -21,7 +21,7 @@ cflags-$(CONFIG_MK6)		+=3D -march=3Di586 $(call tune,k6=
)
> # Please note, that patches that add -march=3Dathlon-xp and friends are =
pointless=2E
> # They make zero difference whatsosever to performance at this time=2E
> cflags-$(CONFIG_MK7)		+=3D -march=3Di686 $(call tune,athlon)
>-cflags-$(CONFIG_MCRUSOE)	+=3D -march=3Di686 $(align)
>+cflags-$(CONFIG_MCRUSOE)	+=3D -march=3Di586 $(call tune,i686) $(align)
> cflags-$(CONFIG_MEFFICEON)	+=3D -march=3Di686 $(call tune,pentium3) $(al=
ign)
> cflags-$(CONFIG_MCYRIXIII)	+=3D -march=3Di586 $(call tune,i486) $(align)
> cflags-$(CONFIG_MVIAC3_2)	+=3D -march=3Di686
>
>     Arnd

Yeah, the problem isn't the kernel, but user space=2E

