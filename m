Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016A0E95A95
	for <linux-um@archiver.kernel.org>; Mon,  9 Oct 2023 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=muW1/22UVN5v1E00RcouHmf13v6ln/28szZv/ww1CaA=; b=DMI6J8LuXNPT42
	hqffVY1dsb31l0OI5ZrTEvRLv/0lFVCDSnPKtsb346CqLSlKW+78f4dyzU3CKvwe3xpegcsYVkoxz
	s5WDqQ9bMeLNcqiJugq98vFWNpBBmwMhpNlJPdiWyC+oSRMrF60CFR7frEuew2Brur2iFC018FHAR
	LaL7tzLahza1bF0HCTgZY8Gsx20+8qR1kXh1tzTNzSx1bZimJFTdz4CiPYYvJLeU/HwvaREwAmy20
	2mtsYhBYcNakI7d22nUJB4F5euzw/Eupolo7zs/WXdK5lImQCS+XakC7UW/lGUklDbl/ZFn7Qv21G
	RuhAXyvUWGG4/fNWfluA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qps03-00B2At-2j;
	Mon, 09 Oct 2023 15:16:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qprzy-00B291-38;
	Mon, 09 Oct 2023 15:16:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F133D611F2;
	Mon,  9 Oct 2023 15:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0510C433C8;
	Mon,  9 Oct 2023 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696864605;
	bh=gyjT+k3AHCiRmdkHp4cLqbLW9JDEEgp8ck+rIXkHvJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YJGiEP+weJoUqeSv3oPzBGav0eFeFLFN82uF7EZyUcIhjA1EyjtYEuvkTlDrGhT0u
	 /V6nqwJvEQiqK7quVzb9Mqx6BtYpts9uQj3DVjcVXHHivYIhQ8ORfVnqzTdkWRU/v3
	 wRVA8NX3ZkKN/h5XCbjRIjaE1hm1JmzPLBMtM4y2Gk9/cEEB1mNGHUHod+l4SFMh87
	 ENpghqeBL286Kg9eUYfedeZX8BZqcVmxCDaPAm36D7+yzAV2vClCWTidtcI5CjIMGr
	 Iaf2JFtfAf0CPD/R07NCGZNx8VciV8lRbmV+YXEK/ywMrYBtVO7HWBOJg77NV1ICFl
	 AhwayJmx43TWQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so8394932a12.2;
        Mon, 09 Oct 2023 08:16:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YzoE99q3B7IQVT6RgfwCG8DVtOKaQtB7scy7StPJM8b1jc5GGtD
	htXRa6t8A0/VAItRfqVUasP5woGSt3jGAvyXx14=
X-Google-Smtp-Source: AGHT+IGSLEtp8/ZbK1MsosRqbvxV8azkLSHz9Otz3nXZ+lvSbGwGVYiT2aLKFzSbqavypW8JCUPmWuuVmeizyQ6W5pM=
X-Received: by 2002:a05:6402:3445:b0:52f:a5d4:1f5b with SMTP id
 l5-20020a056402344500b0052fa5d41f5bmr12782747edc.9.1696864604058; Mon, 09 Oct
 2023 08:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org>
In-Reply-To: <20231009124210.1064021-1-masahiroy@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 9 Oct 2023 23:16:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQxiCEyGiGieHJMBK0Hmj49f8mdcm1TwsTZbgbvxVxGcw@mail.gmail.com>
Message-ID: <CAJF2gTQxiCEyGiGieHJMBK0Hmj49f8mdcm1TwsTZbgbvxVxGcw@mail.gmail.com>
Subject: Re: [PATCH 1/5] csky: remove unused cmd_vdso_install
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_081647_073591_1CA2D877 
X-CRM114-Status: GOOD (  15.68  )
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCA4OjQy4oCvUE0gTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGly
b3lAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBZb3UgY2Fubm90IHJ1biB0aGlzIGNvZGUgYmVjYXVz
ZSBhcmNoL2Nza3kvTWFrZWZpbGUgZG9lcyBub3QgZGVmaW5lIHRoZQo+IHZkc29faW5zdGFsbCB0
YXJnZXQuCj4KPiBJdCBhcHBlYXJzIHRoYXQgdGhpcyBjb2RlIHdhcyBibGluZGx5IGNvcGllZCBm
cm9tIGFub3RoZXIgYXJjaGl0ZWN0dXJlLgpZZXMsIEkgZG8gdGhhdC4gVGh4IGZvciBwb2ludGlu
ZyBpdCBvdXQuCgpBY2tlZC1ieTogR3VvIFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+Cgo+Cj4gUmVt
b3ZlIHRoZSBkZWFkIGNvZGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1h
c2FoaXJveUBrZXJuZWwub3JnPgo+IC0tLQo+Cj4gIGFyY2gvY3NreS9rZXJuZWwvdmRzby9NYWtl
ZmlsZSB8IDEwIC0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvY3NreS9rZXJuZWwvdmRzby9NYWtlZmlsZSBiL2FyY2gvY3Nr
eS9rZXJuZWwvdmRzby9NYWtlZmlsZQo+IGluZGV4IDI5OWU0ZTQxZWJjNS4uZGRmNzg0YTYyYzEx
IDEwMDY0NAo+IC0tLSBhL2FyY2gvY3NreS9rZXJuZWwvdmRzby9NYWtlZmlsZQo+ICsrKyBiL2Fy
Y2gvY3NreS9rZXJuZWwvdmRzby9NYWtlZmlsZQo+IEBAIC01OCwxMyArNTgsMyBAQCBxdWlldF9j
bWRfdmRzb2xkID0gVkRTT0xEICAkQAo+ICAjIHRoYXQgY29udGFpbnMgdGhlIHNhbWUgc3ltYm9s
cyBhdCB0aGUgc2FtZSBvZmZzZXRzLgo+ICBxdWlldF9jbWRfc28ycyA9IFNPMlMgICAgJEAKPiAg
ICAgICAgY21kX3NvMnMgPSAkKE5NKSAtRCAkPCB8ICQoc3JjdHJlZSkvJChzcmMpL3NvMnMuc2gg
PiAkQAo+IC0KPiAtIyBpbnN0YWxsIGNvbW1hbmRzIGZvciB0aGUgdW5zdHJpcHBlZCBmaWxlCj4g
LXF1aWV0X2NtZF92ZHNvX2luc3RhbGwgPSBJTlNUQUxMICRACj4gLSAgICAgIGNtZF92ZHNvX2lu
c3RhbGwgPSBjcCAkKG9iaikvJEAuZGJnICQoTU9ETElCKS92ZHNvLyRACj4gLQo+IC12ZHNvLnNv
OiAkKG9iaikvdmRzby5zby5kYmcKPiAtICAgICAgIEBta2RpciAtcCAkKE1PRExJQikvdmRzbwo+
IC0gICAgICAgJChjYWxsIGNtZCx2ZHNvX2luc3RhbGwpCj4gLQo+IC12ZHNvX2luc3RhbGw6IHZk
c28uc28KPiAtLQo+IDIuMzkuMgo+CgoKLS0gCkJlc3QgUmVnYXJkcwogR3VvIFJlbgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
