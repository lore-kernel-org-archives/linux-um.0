Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB32C001E0
	for <linux-um@archiver.kernel.org>; Mon, 23 Oct 2023 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yj/x9bAdgQn+6B/sVrX/i8G9rIBahGDxcFtd5Z1SBbw=; b=WSNaV+nKgLeYAd
	3y9gm4KEQMO9NXECv8sLwBA9CppOY05nACGbnPSomnDoZq5DJH+lYNmvaLQ9eIbpHDb49PbPqzbuJ
	ARqAR7TlEgG1S2vM4zYjuRV32IqQWJtfhfRrItLYLZU7hPNUl9DaBcNFhbFX5lokJTIj3EAfwUnrM
	AHHA4j93ZXk+MMn2Hp2Y6DQtWM0ri4fFTUo44TMTrNZ0Awb24gisxdGnDShBGgyeVSTWIzqbDULe9
	oSXLF63tRGI254zqTweSmM0Au0lmAW8rGIS8eGx6BcNpJ7U7IOVjg9g4dfLNhH2mMQYeMW7VoEz+E
	hmkhb8lJIMJsdPu4Rpqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quwOY-007ddk-0f;
	Mon, 23 Oct 2023 14:59:06 +0000
Received: from mx1.riseup.net ([198.252.153.129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quwOV-007dcE-1X
	for linux-um@lists.infradead.org;
	Mon, 23 Oct 2023 14:59:04 +0000
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4SDdcc1yfdzDqNf;
	Mon, 23 Oct 2023 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1698073136; bh=0EwVX4x8/C/wp6TVJp3GOQOulro1hRYNPscctE5kWGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=duF/zOC4tRpvihCIOFQ1Azq7UG/6zbCxA2sQjcuPPm3C55okjUmgXHl6GFHFvbpp8
	 wUxRSoX9PGbZh+27k+LwPOow/yAtWKoKE6azytvFl2N7LTzsDR80G6JUcQJEyrg7Rd
	 tVZoe9T1vY6/UzTMYLQoy5u8e7WbBBgKe0kYn+5s=
X-Riseup-User-ID: 78D5FF85C1AECE59B001A8F588ABCF4E6B83636AF5BBC44C7A4D11F0DD8AA434
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4SDdcW0H5gzFpWN;
	Mon, 23 Oct 2023 14:58:50 +0000 (UTC)
Message-ID: <80904787-def1-424d-abd7-e49e671b502f@riseup.net>
Date: Mon, 23 Oct 2023 11:58:47 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] um: kunit: Add Clang support for CONFIG_GCOV
Content-Language: en-US
To: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 llvm@lists.linux.dev, linux-um@lists.infradead.org,
 linux-doc@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org
Cc: Tom Rix <trix@redhat.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>,
 David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>
References: <20231020092159.2486063-1-michal.winiarski@intel.com>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <20231020092159.2486063-1-michal.winiarski@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_075903_600400_D31374E0 
X-CRM114-Status: GOOD (  12.22  )
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

CgpPbiAyMC8xMC8yMyAwNjoyMSwgTWljaGHFgiBXaW5pYXJza2kgd3JvdGU6Cj4gQ2xhbmcgdXNl
cyBhIGRpZmZlcmVudCBzZXQgb2YgQ0xJIGFyZ3MgZm9yIGNvdmVyYWdlLCBhbmQgdGhlIG91dHB1
dAo+IG5lZWRzIHRvIGJlIHByb2Nlc3NlZCBieSBhIGRpZmZlcmVudCBzZXQgb2YgdG9vbHMuCj4g
VXBkYXRlIHRoZSBNYWtlZmlsZSBhbmQgYWRkIGFuIGV4YW1wbGUgb2YgdXNhZ2UgaW4ga3VuaXQg
ZG9jcy4KCkdyZWF0IGNoYW5nZSEgSXQncyBncmVhdCBub3QgdG8gcmVseSBvbiBvbGRlciB2ZXJz
aW9ucyBvZiBHQ0MgZm9yCnRoYXQuCgpJIHdhcyBhYmxlIHRvIGdlbmVyYXRlIGNvdmVyYWdlIHJl
cG9ydHMsIGJ1dCBJIGhhdmUgYSBmZXcgb2YgdGhpbmdzIHRvCm5vdGU6CgpXaGVuIEkgcmFuIHRo
ZSBrdW5pdC5weSBpdCBnZW5lcmF0ZWQgdGhpcyB3YXJuaW5nIHNldmVyYWwgdGltZXM6CgpXQVJO
SU5HOiBtb2Rwb3N0OiB2bWxpbnV4IChfX2xsdm1fY292ZnVuKTogdW5leHBlY3RlZCBub24tYWxs
b2NhdGFibGUgc2VjdGlvbi4KRGlkIHlvdSBmb3JnZXQgdG8gdXNlICJheCIvImF3IiBpbiBhIC5T
IGZpbGU/Ck5vdGUgdGhhdCBmb3IgZXhhbXBsZSA8bGludXgvaW5pdC5oPiBjb250YWlucwpzZWN0
aW9uIGRlZmluaXRpb25zIGZvciB1c2UgaW4gLlMgZmlsZXMuCgpNYXliZSBpdCB3b3VsZCBiZSBn
cmVhdCB0byBrbm93IHdoeSB0aGlzIGlzIGhhcHBlbmluZy4KCkFsc28sIHRoZSBsaW5rZXIgY29u
c3VtZWQgYSBsb3Qgb2YgUkFNIHRvIGJ1aWxkIHRoZSBrZXJuZWwgd2l0aCB0aG9zZQphZGRpdGlv
bmFsIGZsYWdzLCBidXQgbWF5YmUgdGhpcyBpcyBleHBlY3RlZCA6UC4KCkJlc3QgUmVnYXJkcywK
fkFydGh1ciBHcmlsbG8KCj4gCj4gTWljaGHFgiBXaW5pYXJza2kgKDIpOgo+ICAgYXJjaDogdW06
IEFkZCBDbGFuZyBjb3ZlcmFnZSBzdXBwb3J0Cj4gICBEb2N1bWVudGF0aW9uOiBrdW5pdDogQWRk
IGNsYW5nIFVNTCBjb3ZlcmFnZSBleGFtcGxlCj4gCj4gIERvY3VtZW50YXRpb24vZGV2LXRvb2xz
L2t1bml0L3J1bm5pbmdfdGlwcy5yc3QgfCAxMSArKysrKysrKysrKwo+ICBhcmNoL3VtL01ha2Vm
aWxlLXNrYXMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysrKysKPiAgMiBmaWxlcyBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXVtCg==
