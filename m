Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773DECDB465
	for <linux-um@archiver.kernel.org>; Sat, 14 Oct 2023 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K1z6pDl9kAcoTpOHknZgeRW+0F+qNcRYdV+99knAAmo=; b=IkGwH/Wiyq8qMS
	Eh0oS/nHyuOgBbjDP5UwlqasjY7VvHbIgdRteVF1Alv5q/416dQsGznrsz/JxTwni5S9K9XM5JyqY
	/l7jq3dtbwJyuyePDM5Aqc6pWDL6VdQGiPmgsat/+XI0JHrWrkZV/1E2PHpJKUnU8B7X3QgmHI3+t
	V3y2cgjt+s/t/ZBS4y1vpw6sctAlFYTfdUltc/F7Hc1u4Ivzc+t1rzmETY60S0n8zHN7tfry/jdG3
	tbj68AxGLdX/mAIdViOX+3ng0ij91xmMRXtaaMQLkbvirV1ToYErvR+O8YsAB8YO2LSLJurGaKoqI
	DV6WGwWSDo55X5VGAEkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrafM-005190-0q;
	Sat, 14 Oct 2023 09:10:36 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qraeX-00515t-24;
	Sat, 14 Oct 2023 09:10:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 484ABB80092;
	Sat, 14 Oct 2023 09:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1AEC433C7;
	Sat, 14 Oct 2023 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697274556;
	bh=QMKGeVOd3CQqoQwVajdhLaEh2KmBVSf8R3WFPYadptc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HZWvF6fhPJyRBXJV6sf2vMWNoPu/ZNCKgiUmo0OQXjc/z03PSmpR6MbeNUKEdo1w4
	 m8QBx2FruJm9mxg+hHrr6iGRH1hB/t61ooXfrX8ZKg2vICkEBGpyBHJSXPP7pNVf8P
	 /Nv1p7C0+uXxUjchzbq98DaDOoQcTu9SkfzuaTJwIf6JwPx3/dmQugsWZqfDx77sVv
	 L2B3sqkAwG12YedKz3eeTDZcqR+B+eIVo06uwynAjrqQFqsVwza8dzmdhq3n5hpCxH
	 O2BHBQAx05gFteBHw94KFS986YvVFSjOlg2SRCQXiWF4MkjoSCwGINQSDuMzAldz+3
	 VCq8BYKf+YD3Q==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e9db321ed1so908723fac.3;
        Sat, 14 Oct 2023 02:09:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyrRQoc1IV/Rp9HJKCl2lIoL9y2WFvSJHdHduRhX0I2zlZS7cy5
	82eVYbvUp1toAHU96teFZk1hCJHz3FTnXGfVx14=
X-Google-Smtp-Source: AGHT+IHedrA3UMSJSZgJvBvP0ejVRXx5lRC+UJuOuF1WIWquOiHBeVkX9c2aoRHTFlsXmzRC+2SAleIJLiufg2NmOCc=
X-Received: by 2002:a05:6870:a99a:b0:1d5:c417:503e with SMTP id
 ep26-20020a056870a99a00b001d5c417503emr32560193oab.57.1697274556176; Sat, 14
 Oct 2023 02:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org> <CAJF2gTQxiCEyGiGieHJMBK0Hmj49f8mdcm1TwsTZbgbvxVxGcw@mail.gmail.com>
In-Reply-To: <CAJF2gTQxiCEyGiGieHJMBK0Hmj49f8mdcm1TwsTZbgbvxVxGcw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 14 Oct 2023 18:08:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQPupf+iMNxs7gNAAm15Y1Eg8eXuZTWwVai23heZE8FjA@mail.gmail.com>
Message-ID: <CAK7LNAQPupf+iMNxs7gNAAm15Y1Eg8eXuZTWwVai23heZE8FjA@mail.gmail.com>
Subject: Re: [PATCH 1/5] csky: remove unused cmd_vdso_install
To: Guo Ren <guoren@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231014_021031_591211_C2765347 
X-CRM114-Status: UNSURE (   9.43  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTI6MTbigK9BTSBHdW8gUmVuIDxndW9yZW5Aa2VybmVs
Lm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIE9jdCA5LCAyMDIzIGF0IDg6NDLigK9QTSBNYXNhaGly
byBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBZb3UgY2Fubm90
IHJ1biB0aGlzIGNvZGUgYmVjYXVzZSBhcmNoL2Nza3kvTWFrZWZpbGUgZG9lcyBub3QgZGVmaW5l
IHRoZQo+ID4gdmRzb19pbnN0YWxsIHRhcmdldC4KPiA+Cj4gPiBJdCBhcHBlYXJzIHRoYXQgdGhp
cyBjb2RlIHdhcyBibGluZGx5IGNvcGllZCBmcm9tIGFub3RoZXIgYXJjaGl0ZWN0dXJlLgo+IFll
cywgSSBkbyB0aGF0LiBUaHggZm9yIHBvaW50aW5nIGl0IG91dC4KPgo+IEFja2VkLWJ5OiBHdW8g
UmVuIDxndW9yZW5Aa2VybmVsLm9yZz4KCgpBcHBsaWVkIHRvIGxpbnV4LWtidWlsZC4KCgoKCi0t
IApCZXN0IFJlZ2FyZHMKTWFzYWhpcm8gWWFtYWRhCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==
