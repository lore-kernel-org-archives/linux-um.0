Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C93606A31C
	for <linux-um@archiver.kernel.org>; Mon,  9 Nov 2026 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RdukOzYL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZe+9h8w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cm01sMqqIj/OrXGDnKJivC+LXfRPbTA7ayzBKhFeqVQ=; b=RdukOzYLGik0Kp
	gYfKnwrre+kwyFhHaRdL8NCEf0WhypRxGFjK7PgsQNmCV2bNvvQ7jH4mVksfaj4lpjJr2Umr5nXnx
	pk1nIrGG0obAf+nXL8sHM4AgF803/XNNSTlmbNNcceDFo1OCpnvNDe/GNvxfmsAPSD7qWma80NKPb
	PKAaiBks2uup0b5W7XrvrhR4NQHUkHfl5jUmDtMPFpEVpdi0Y6wLc1cZjYZQkBnhwcw/3c9pBfr8Q
	04Uq/A5u2cbhRaiF35G3QjtX7umb/ddAm4tmDR9D4AprDjARU4QiJUEbMlskzGl5aznUXvYIhKi5E
	/NFnlAX/meaCHwKYIBlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQZ7w-00000001xzd-1RdD;
	Mon, 09 Nov 2026 23:50:16 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQZ7l-00000001xya-11cj
	for linux-um@lists.infradead.org;
	Mon, 09 Nov 2026 23:50:15 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2ed0e2015aaso6028785ad.3
        for <linux-um@lists.infradead.org>; Mon, 09 Nov 2026 15:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794268204; cv=none;
        d=google.com; s=arc-20260327;
        b=m1xbCg80S2zrCDOSbLQyBCw+LoP1NcltvOU97HkdMZJc2EntGFR5H0zdVTWbYPqHbu
         3j6QjSqGiMPR/teAraM3TlR7uwIo8FjqL3SITkETBlJyXjAnex24Ya3A1FvdrKLo3PBc
         zllFUZ4jkw3v9d8b67DIN/eu0lP+rWbFxhwGXwkB65FAKndbxf1Ez2gI4Gx37NteRPO7
         HL3AHw4j3m/QyAr9YTcl8vaCXD8pEgnDs20oFEPdI8lZhjopaUDgkZtfChyitLIHL76U
         t0/ZabvOkT1jQNpSNzuXIbCO04hP8ppg/qNdwg3QemcOh1JRcbsUf08Aze7stNCKoCsY
         urnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cm01sMqqIj/OrXGDnKJivC+LXfRPbTA7ayzBKhFeqVQ=;
        fh=qN/a2doyOwb5KCDTkjwjyB6D04eYNrG1jOeucqffQNE=;
        b=Qj2DobLAe1/bMHzFPj2+qfhpb13AWJ5E+gkq7HRFs1a2mL0l32R18d02KTVJVlJe/4
         n+0hUDnOHgfg6yYOv6BYlz24bn7IG8SijaIvzWpRkJgU5BSX5dpedknap1bAwSiRIG9j
         uUonTx0cKWNo4tuxXP69n4p6r/XDl+Shh0WYQ4NpoxUvtvB34biqLsG+lFm5lErg2RW+
         jC67RIYEWIsBhCWE92jREA1RGswPNfRDjRNIlh1ns6fL0nZF7vYnkna0xbDp+gNdhwJL
         klwjB0CBNaLxcT0toxD0nQoi3yizvdTzrykD6918QadACAabd//KQVgeDM0Hz6ODKubS
         EX1Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268204; x=1794873004; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cm01sMqqIj/OrXGDnKJivC+LXfRPbTA7ayzBKhFeqVQ=;
        b=zZe+9h8wgkSPZZ6azFCDGX3RQCUAoQFUhbrQ9KLde0U711nZNX4jMU/6C/9PqYW3Fz
         5qbM2K/+LxPMsbrUREVkzFMl2ArU1JKQm24jA6E0jnLb3XaiI0RpUKyYwGn4yKwouTQl
         Qo/P0KxnC/VnVbnrOAC/HxJwib07YgEeIyzMjMkIIJIg6SYcytXS6gYeRcvY4Wa69BSg
         uDbCD6bIUyr2LLl0LIjK9XQrbDzHAQxLETfhwkzgg52mOKyE+7wYEGcGVW/knsHI1YV2
         RQ3SSOKkXtTlY2jxR3fxmOynPEOZ+TzDT/yY1YvahZnZ1jElnGMIyfInlGobIJkiiLwd
         LpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268204; x=1794873004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cm01sMqqIj/OrXGDnKJivC+LXfRPbTA7ayzBKhFeqVQ=;
        b=F1m6zu2ijKfgzrScyWe8wdJ1DRf/dfohKuK1WG+XJ1rAeQ8nEncRx9t8IOcDpMwP1r
         uwhSMo1ErauCp/uwpQYeO/aktZmWM1oJ0plPTesUKfCJfkp7t1sP/cgOUw8OCGyo11eC
         EadMiXgbBmpiCKjPYdHM1dP2vuSvWYSTq1zHSm547TLBk65BKaTEneWw5oZEKHpXA0uA
         PGKhFCB4qSjcMQvB9/RaALLS46o6nvk21UjaYPJWxlZMMPUCsEf5C1+GN0pw2yULZpjl
         f8lC+WmvmVqZL+w5jcG+NRGqXNOkBNMbyKPXtrvVq3FjlrbRBVIvmJjV5Sc/MwuTZOPL
         Gamw==
X-Forwarded-Encrypted: i=1; AL+hErGr2dVmhTOhFSubUY7N0OInNXIF/uO1x8qqwGoV6TMcID4+7TB+CU6LWQwN8vXHzHAyYnyMw6VT3A==@lists.infradead.org
X-Gm-Message-State: APuU4Z8iDzkxVvBGc4JauGY6g50us3l9czmbnM1txZRXF7CGGgcLAWy7
	yEOlZIZOBN/RSxiTEcsGoUYPz3T1C8mlPfeWLLXu+87GyyaV4uc9QMzrQq5d+zNlNWZ11WZ9ysk
	iTo5G72FYZu8vKF9PYKBQzjhezMbJos8=
X-Gm-Gg: AYBFou0wWQ0qz249EyZ3x61WwW45OmXZzkAvyFcF0vVaDfC8tQxZoH/UAio039eZ4qi
	lRlDN8qL7iD8iwKc3huy6QnHThdte3sqfnEcaGSNeUOiJPEbPqdbmfLgUAAZNfyta/JwuO585KB
	92Xlb1Pm3f6s4y9z6VUb2zpHumR/Y7+sF5blsH5xOJQevGRpzGJD4roBz5jCQsvF9+QLJmAjySK
	sPmazqqN78vQtJ4/tevt4aINdiZEu4/GpxJ+DbEI2hipSyg2F6/hol29qJ19CLAG007bWMJEwU8
	qiS1uEXuYnNR01e/F+uSmz6GnAr8WmnmGSCU8SeFpS8SawPz6tixjG9OAsYX2cGVjShvQck7E6j
	FzZWXKYJg5GCk23pp0HJti3vpVAye1UAJTC0IbXUorQ0zRL+QYQszutrJE/RhxJhIHIfe
X-Received: by 2002:a17:903:320b:b0:2e9:401f:f0f8 with SMTP id
 d9443c01a7336-2edb9253939mr6212195ad.53.1794268204263; Mon, 09 Nov 2026
 15:50:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAEzXK1pdhEyOgQ4owkeRmyEP6Pyfhk=OsMHdzU4xwNMCmCsd6g@mail.gmail.com>
 <20261109122908.GU2668804@noisy.programming.kicks-ass.net>
 <773C551D-6AFB-4180-BE2D-629B6C5D020B@zytor.com> <CAEzXK1p3SZdGHDxj9bnRU4NzK6Z8b2qFwg2z_Hz9yY2ntB10sQ@mail.gmail.com>
In-Reply-To: <CAEzXK1p3SZdGHDxj9bnRU4NzK6Z8b2qFwg2z_Hz9yY2ntB10sQ@mail.gmail.com>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Mon, 9 Nov 2026 23:49:53 +0000
X-Gm-Features: AclHuK_pcx1MdpHVb2en-3CYgD-Cgz3_Dr3poSXVr6gLqXCbiqAFBW0V94L_bDY
Message-ID: <CAEzXK1rOrTEKDWojwFOf1ZBxhdVriZzotou=p+7Etskcp9zqmg@mail.gmail.com>
Subject: Re: Some observations regarding the ongoing x86-32 CPU configuration cleanups
To: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_155005_312373_9A86FADF 
X-CRM114-Status: GOOD (  29.96  )
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Yes, thanks for your suggestions, yes ading CPUID, TSC and CX8 should
not be much of a burden.

On Mon, Nov 9, 2026 at 4:04=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On November 9, 2026 4:29:08 AM PST, Peter Zijlstra <peterz@infradead.org>=
 wrote:
> >On Mon, Nov 09, 2026 at 10:34:54AM +0000, Lu=C3=ADs Mendes wrote:
> >> Hi everyone,
> >>
> >> First of all i would like to say that i both admire and appreciate all
> >> your hard work with this lovely OS. I do understand that maintaining
> >> some systems can cause additional burden on maintenance, but there are
> >> some aspects that i would like you to reconsider.
> >>
> >> I am writing because I  believe that some aspects have not been taking
> >> into consideration regarding the removal of the 80486 32-bit support
> >> from the kernel, namely:
> >> - There is this active Linux distribution:https://tinycorelinnux.net/
> >> and the Damn Smal Linux DSL (https://damnsmalllinux.org).
> >> - There are also these CPUs: https://www.vortex86.com/products/Vortex8=
6EX
> >> - There may be only a few vintage 486 systems still working, but there
> >> are also other new x86 CPUs systems, especially in FPGAs like the
> >> https://github.com/MiSTer-devel/ao486_MiSTer which is a 486SX core
> >> that operates at 90MHz and can use up to 256MB RAM memory. There are
> >> plans to update this CPU IP core to become a full 486DX core, by
> >> adding a FPU unit to it and would turn this into a usable Desktop
> >> system with tineycorelinux. There is a considerable retro-computing
> >> community that utilizes the AO486 core on the MiSTer FPGA platform.
> >> There is even a Voodoo 3dfx accelerator card:
> >> https://github.com/victor-fisyuk/voodoo-fpga-public.
> >>
> >> Overall i just want to inform you that some new x86 32-bit systems are
> >> still being sold brand new and can be utilized with Linux. I would
> >> like that you consider this with regard to how much 80486 support
> >> should be removed from Linux.
> >>
> >> Personally i do have plans to extend the AO486 core to have the FPU
> >> and would like to be able to run a modern Linux on it. It would have
> >> entertainment and educational applications. With tinycoreinux it can
> >> have a usable desktop.
> >
> >I don't realistically see 486 support coming back -- the thing doesn't
> >even have TSC. Getting rid of all the horrible (and completely untested)
> >code for no-tsc alone was worth deleting 486 support for.
> >
> >The other option is you actually implementing RDTSC, CPUID (and possibly
> >CMPXCHG8B) on your FPGA.  I'm sure that's actually a *LOT* simpler than
> >doing i487 support.
> >
> >Just add whatever instructions are required to get the bare minimal
> >32bit build working.
>
> It would be more likely to get x87 emulation back!
>
> Later i486's actually did have CPUID, and implementing TSC and CX8 (in a =
unicore system) is rather trivial.

