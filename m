Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1A2C7EE29
	for <linux-um@archiver.kernel.org>; Tue, 23 May 2023 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dO3TUZNYqe0+GErXG9n1K+bOgegFEbyw88NYZBOt5fA=; b=Lrg7O5hAYyIOuy
	d/acbkxVh7rtcYVaF42Ad22GAdfu/xw51QLQt8QifWmOfAHg7SmADY1YXsWvdvU7Sx0uwm6kfoIfh
	In6iBctsr4LthHA3l/Pn3rahhOwCKffoAD01GLtjCygE/tjz/1yXa9dJ9QW7op4zN2CditfbdpmlO
	rXqddRcN8OwNNyQRumTPoMn0M3M7CbHi+bXNNFJizsgiywE0n1wAr9TbsFpRMxwJuPMeu+WRjPo1w
	kGb1yAC6f1jY5fLaMdjFkJ5X6smGXnW3GPq3FOPVnPULtqFXdScvRpO+I4BUT5m7Joevbm1Ofstrt
	4wWMFdob32yD+wmHanUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1PiN-00A0Kc-0F;
	Tue, 23 May 2023 10:58:03 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1PiI-00A0IE-38;
	Tue, 23 May 2023 10:58:00 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-456d9652c24so3200733e0c.1;
        Tue, 23 May 2023 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684839472; x=1687431472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPZGzse+EwoYxx5aP+jOlzsmNfWXOwQHS1xYrgjsec4=;
        b=dOQwlVtHCe09Vk6RBJyv4UlmNvYYMnzQdN2fEZMcAJCu/TvLE+aT6q3cEIc8MDOmBx
         HP4ow/lRyQjX5ou5gynKDIgwRGlxnKP17GdXlnjq6uz1ijUiCnacny3Md+zs9HDXlWpd
         /vJJE9f2AKfUpQCBaZ86Lp475NcG+d8oj3/lzlNgDDkfbpoahI9iEBZqgJGax+ZttcuR
         gxFYk69/1/g6u8rT0LmqyntNq4QgPOiylA448Fmme9hwmf33rBx4ObygcWDs9zyaVSfI
         o7vxmAgMbJLQQXRgL/2ax63tRT4pKoFENMaUoAU0k0zcTFUWAtxubuxDUMY5St7Chco4
         J29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684839472; x=1687431472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPZGzse+EwoYxx5aP+jOlzsmNfWXOwQHS1xYrgjsec4=;
        b=BSBfq6a26TcyWTdCXSrnZFWWzMJJ9ePAfpH0QEesEpnbr2Qo8Fhs4vsNvtkLkEEylE
         eavV+QG1UsYvK1543AH48T6LILRDy3pG9etL1QiY2Pkj5sZ4wYXMhSqZ8h2nQ/lkOZX5
         10EIr8GSa99pnAwZSNAux0AyQNJtD/di1SleT8T+VfeOlTjpn/Taz7F2H8ZV2yTpkbun
         w5RtXOlapNkiVUtrbS3yCP98utKOJYbiObj4PQtOjEmjcHB0Lmx2JPQzu1GiLq7dCD2v
         awO2+YBabQvRXwv4KWjdEbnIFtaAUxjd3uXwWvdxnSytjPYfyru9w7zOeviWoXBuepIo
         s39Q==
X-Gm-Message-State: AC+VfDzCTjczz3CGrTnflVYMAMp9gsDUk14NmQztOIO6fr3i6sj6iuQU
	gxT/Y5JBcN1r2v6hbg9qCIan2V2LXg2bBR/p6vM=
X-Google-Smtp-Source: ACHHUZ5BnP3gkAdc5bGRbbNu8BA4XYUOvijVFedQabDgzPfHyqbd3wbCe7zKvL1rqhCSR6cTKzJAQSc6wb3cCiUjneM=
X-Received: by 2002:a1f:2cce:0:b0:440:4c82:6508 with SMTP id
 s197-20020a1f2cce000000b004404c826508mr4142026vks.3.1684839472183; Tue, 23
 May 2023 03:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230523091139.21449-1-vbabka@suse.cz>
In-Reply-To: <20230523091139.21449-1-vbabka@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 23 May 2023 19:58:03 +0900
Message-ID: <CAB=+i9RycsnDbJ1f1jTiJ6fXnGUmH95h23G37Ss6XNAA3VJ3_w@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: rename CONFIG_SLAB to CONFIG_SLAB_DEPRECATED
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Qin Jian <qinjian@cqplus1.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_035759_010681_CF18F3F8 
X-CRM114-Status: GOOD (  18.79  )
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

T24gVHVlLCBNYXkgMjMsIDIwMjMgYXQgNjoxMuKAr1BNIFZsYXN0aW1pbCBCYWJrYSA8dmJhYmth
QHN1c2UuY3o+IHdyb3RlOgo+Cj4gQXMgZGlzY3Vzc2VkIGF0IExTRi9NTSBbMV0gWzJdIGFuZCB3
aXRoIG5vIG9iamVjdGlvbnMgcmFpc2VkIHRoZXJlLAo+IGRlcHJlY2F0ZSB0aGUgU0xBQiBhbGxv
Y2F0b3IuIFJlbmFtZSB0aGUgdXNlci12aXNpYmxlIG9wdGlvbiBzbyB0aGF0Cj4gdXNlcnMgd2l0
aCBDT05GSUdfU0xBQj15IGdldCBhIG5ldyBwcm9tcHQgd2l0aCBleHBsYW5hdGlvbiBkdXJpbmcg
bWFrZQo+IG9sZGNvbmZpZywgd2hpbGUgbWFrZSBvbGRkZWZjb25maWcgd2lsbCBqdXN0IHN3aXRj
aCB0byBTTFVCLgo+Cj4gSW4gYWxsIGRlZmNvbmZpZ3Mgd2l0aCBDT05GSUdfU0xBQj15IHJlbW92
ZSB0aGUgbGluZSBzbyB0aG9zZSBhbHNvCj4gc3dpdGNoIHRvIFNMVUIuIFJlZ3Jlc3Npb25zIGR1
ZSB0byB0aGUgc3dpdGNoIHNob3VsZCBiZSByZXBvcnRlZCB0bwo+IGxpbnV4LW1tIGFuZCBzbGFi
IG1haW50YWluZXJzLgo+Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC80YjlmYzlj
Ni1iNDhjLTE5OGYtNWY4MC04MTFhNDQ3MzdlNWZAc3VzZS5jei8KPiBbMl0gaHR0cHM6Ly9sd24u
bmV0L0FydGljbGVzLzkzMjIwMS8KPgo+IFNpZ25lZC1vZmYtYnk6IFZsYXN0aW1pbCBCYWJrYSA8
dmJhYmthQHN1c2UuY3o+Cj4gLS0tCgo8c25pcD4KCj4gZGlmZiAtLWdpdCBhL21tL0tjb25maWcg
Yi9tbS9LY29uZmlnCj4gaW5kZXggNzY3MmEyMjY0N2I0Li5iNTM3YzQ0MzZkMTggMTAwNjQ0Cj4g
LS0tIGEvbW0vS2NvbmZpZwo+ICsrKyBiL21tL0tjb25maWcKPiBAQCAtMjE4LDExICsyMTgsMTgg
QEAgY2hvaWNlCj4gICAgICAgICBoZWxwCj4gICAgICAgICAgICBUaGlzIG9wdGlvbiBhbGxvd3Mg
dG8gc2VsZWN0IGEgc2xhYiBhbGxvY2F0b3IuCj4KPiAtY29uZmlnIFNMQUIKPiAtICAgICAgIGJv
b2wgIlNMQUIiCj4gK2NvbmZpZyBTTEFCX0RFUFJFQ0FURUQKPiArICAgICAgIGJvb2wgIlNMQUIg
KERFUFJFQ0FURUQpIgo+ICAgICAgICAgZGVwZW5kcyBvbiAhUFJFRU1QVF9SVAo+ICAgICAgICAg
c2VsZWN0IEhBVkVfSEFSREVORURfVVNFUkNPUFlfQUxMT0NBVE9SCj4gICAgICAgICBoZWxwCj4g
KyAgICAgICAgIERlcHJlY2F0ZWQgYW5kIHNjaGVkdWxlZCBmb3IgcmVtb3ZhbCBpbiBhIGZldyBj
eWNsZXMuIFJlcGxhY2VkIGJ5Cj4gKyAgICAgICAgIFNMVUIuCj4gKwo+ICsgICAgICAgICBJZiB5
b3UgY2Fubm90IG1pZ3JhdGUgdG8gU0xVQiwgcGxlYXNlIGNvbnRhY3QgbGludXgtbW1Aa3ZhY2su
b3JnCj4gKyAgICAgICAgIGFuZCB0aGUgcGVvcGxlIGxpc3RlZCBpbiB0aGUgU0xBQiBBTExPQ0FU
T1Igc2VjdGlvbiBvZiBNQUlOVEFJTkVSUwo+ICsgICAgICAgICBmaWxlLCBleHBsYWluaW5nIHdo
eS4KPiArCj4gICAgICAgICAgIFRoZSByZWd1bGFyIHNsYWIgYWxsb2NhdG9yIHRoYXQgaXMgZXN0
YWJsaXNoZWQgYW5kIGtub3duIHRvIHdvcmsKPiAgICAgICAgICAgd2VsbCBpbiBhbGwgZW52aXJv
bm1lbnRzLiBJdCBvcmdhbml6ZXMgY2FjaGUgaG90IG9iamVjdHMgaW4KPiAgICAgICAgICAgcGVy
IGNwdSBhbmQgcGVyIG5vZGUgcXVldWVzLgo+IEBAIC0yNDAsNiArMjQ3LDExIEBAIGNvbmZpZyBT
TFVCCj4KPiAgZW5kY2hvaWNlCj4KPiArY29uZmlnIFNMQUIKPiArICAgICAgIGJvb2wKPiArICAg
ICAgIGRlZmF1bHQgeQo+ICsgICAgICAgZGVwZW5kcyBvbiBTTEFCX0RFUFJFQ0FURUQKPiArCj4g
IGNvbmZpZyBTTFVCX1RJTlkKPiAgICAgICAgIGJvb2wgIkNvbmZpZ3VyZSBTTFVCIGZvciBtaW5p
bWFsIG1lbW9yeSBmb290cHJpbnQiCj4gICAgICAgICBkZXBlbmRzIG9uIFNMVUIgJiYgRVhQRVJU
Cj4gLS0KPiAyLjQwLjEKClRoYW5rIHlvdSBmb3IgdGhlIHdvcmshCkl0IGxvb2tzIGdvb2QgdG8g
bWUuCmxldCdzIHNlZSBzb21lIHVzZXJzIHJhaXNlIHRoZWlyIHZvaWNlLgoKQWNrZWQtYnk6IEh5
ZW9uZ2dvbiBZb28gPDQyLmh5ZXlvb0BnbWFpbC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==
