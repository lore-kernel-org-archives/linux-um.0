Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB86EB64D7
	for <linux-um@archiver.kernel.org>; Fri, 23 Jun 2023 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wpa45BGz2x1gwUQ3SpB3YT9yVE5bz5ujxypQk/FDAO4=; b=gN+0UJF4mntGM6
	bh3SaKIFnpvhks/0qNd8nKKw0afAYoB8f8+vVYmadftU/3Z6DnUIvfLuWymyCFa+4RjrgiGzuhSI/
	kLYZcn/NEJRn0MAYupJc3St5UCl7rSzxVkYGva/jWSym0UPYCMURzvtQCcWgwb5N4tnu0tlkiLSLB
	wRPwha7JmukuZyXqBMX4017JHJbbKHG2CV4l6RijQYQBJNqI6ldbt4Q95vr5ncPYAqysjeaY/vkEf
	14OtwtpS7y4iOs7pDQ4dDbp51/JmoUBNZYMI7U2rKOszELkioOd2ZlSLcc7DEjsKS/AOLFlX0TCBd
	jj7eGJ2TboxCpaXWNkjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCpMM-004lRh-1Y;
	Fri, 23 Jun 2023 22:34:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCpMI-004lR9-2A
	for linux-um@lists.infradead.org;
	Fri, 23 Jun 2023 22:34:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3289260FF5
	for <linux-um@lists.infradead.org>; Fri, 23 Jun 2023 22:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97137C433C8
	for <linux-um@lists.infradead.org>; Fri, 23 Jun 2023 22:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687559663;
	bh=B/G6vWU5G81xQ5RoRlvg/h3tGVQoCHwUQD0XWQdua8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FfsPIk0pv4eW22sWWyw3SR0A+62m7X8mBJCMtleBnk+7xO0UrIB3QPlIebFtSIc7k
	 CH/293bF6F7SGRxbnhZOluX6Vsll28yEapeI1LxbNwE4cIAYR+Eb/wNkh5kSWkfVy0
	 YNz4l4psmgHebZEV2xWZHmcMCjP7ZurSpK6fZCFHaKvavwtcEwNnM1TmZDv6sFn+pP
	 w5zB/VHGUS2ddedYIqSuN30SdA9JCCBCUR5clA3tx2ZH8aF4WMENhjdO65oYMo9VYU
	 e+KTfj0U6HXTuIS1jMzaUmqIgc2fIgrC6mEq309B+yFsoFo3zY8Tne/DNb+RoleJhR
	 38gSbr/aMul3g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b47bfd4e45so19069791fa.0
        for <linux-um@lists.infradead.org>; Fri, 23 Jun 2023 15:34:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDxo3rkIAAl/oFm9Mb+9FM25zlq6CBvaFWba8Z5rnn+3TmA2O1O2
	BM6TmN1CuWLBYp8Ect7YV/O0hZPPZP+/i+rO8Q==
X-Google-Smtp-Source: ACHHUZ4HJZvsXhdXYD7FRpnazU9VuZUTw4n1EHmCO/2QG3T3rq6ZW3aJmm4Cusa9o4kc+rUcFXwCjy6Dz4wsoDAjsqQ=
X-Received: by 2002:a2e:7209:0:b0:2b4:5a0b:9297 with SMTP id
 n9-20020a2e7209000000b002b45a0b9297mr16749317ljc.29.1687559661574; Fri, 23
 Jun 2023 15:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230622192247.GA2278576-robh@kernel.org> <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net>
 <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
In-Reply-To: <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
From: Rob Herring <robh@kernel.org>
Date: Fri, 23 Jun 2023 16:34:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKTb4QQGj6z2LB9tNFpwCRg5avdK=oQ7qzMjw1oWNBrvw@mail.gmail.com>
Message-ID: <CAL_JsqKTb4QQGj6z2LB9tNFpwCRg5avdK=oQ7qzMjw1oWNBrvw@mail.gmail.com>
Subject: Re: UML for arm64
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_153426_818199_75866F0B 
X-CRM114-Status: GOOD (  23.94  )
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

T24gVGh1LCBKdW4gMjIsIDIwMjMgYXQgMjoxNOKAr1BNIEJlbmphbWluIEJlcmcgPGJlbmphbWlu
QHNpcHNvbHV0aW9ucy5uZXQ+IHdyb3RlOgo+Cj4gSGksCj4KPiBPbiBUaHUsIDIwMjMtMDYtMjIg
YXQgMjE6NDEgKzAyMDAsIEpvaGFubmVzIEJlcmcgd3JvdGU6Cj4gPiBPbiBUaHUsIDIwMjMtMDYt
MjIgYXQgMTM6MjIgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOgo+ID4gPiBJJ20gaW50ZXJlc3Rl
ZCBpbiBnZXR0aW5nIFVNTCB3b3JraW5nIG9uIEFybS4gSXMgYW55b25lIGF3YXJlIG9mIGFueQo+
ID4gPiBlZmZvcnRzIHRvIGRvIHRoaXMgYWxyZWFkeT8KPiA+Cj4gPiBOb3QgbWUgLi4uIEJ1dCB5
ZWFoLCBhZ3JlZSB0aGF0IGl0IHNlZW1zIGxpa2VseSB0byByZXF1aXJlIHNvbWUKPiA+IHJlZmFj
dG9yaW5nLCBldmVuIGlmIF9zb21lXyBkZWdyZWUgb2YgYXR0ZW1wdHMgd2VyZSBtYWRlIHRvIGtl
ZXAgYXJjaC0KPiA+IHNwZWNpZmljIHRoaW5ncyB0aGVyZSAuLi4KPiA+Cj4gPiBUaGVyZSBtaWdo
dCBiZSBhIHRvbiBvZiBhcmNoLXNwZWNpZmljIHRoaW5ncyBpbiB0aGUgcHRyYWNlIGNvZGUgdG9v
Cj4KPiBBdCBsZWFzdCBhIGxvdCBvZiB0aGUgcmVnaXN0ZXIgaGFuZGxpbmcsIGJ1dCB0aGF0IHdp
bGwgYWx3YXlzIGJlCj4gc29tZXdoYXQgYXJjaGl0ZWN0dXJlIHNwZWNpZmljLgo+Cj4gPiAuLi4g
LCBzbyBwZXJoYXBzIGl0J2QgYmUgZWFzaWVyIHRvIHN0YXJ0IHdpdGggdGhlIHNlY2NvbXAtYmFz
ZWQgbW9kZWw6Cj4gPgo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xp
bnV4LXVtL2xpc3QvP3Nlcmllcz0zMjk0NjYKPiA+Cj4gPiBCdXQgdGhhdCdzIG5vdCByZWFsbHkg
ZG9uZSB5ZXQgZWl0aGVyLgo+Cj4gWWVzLCB0aG91Z2ggSSBoYXZlIHF1aXRlIHNvbWUgdXBkYXRl
cyBsb2NhbGx5IHRoYXQgc29sdmUgdGhlIHNlY3VyaXR5Cj4gaXNzdWVzIChpLmUuIHByZXZlbnQg
aG9zdCBzeXNjYWxscyBmcm9tIHVzZXJzcGFjZSkuIFNvLCBpdCBkb2VzIG5lZWQKPiByZWJhc2lu
ZyBhbmQgSSBhbSBzdXJlIGJ1Z2ZpeGVzLCBidXQgSSB0aGluayBpdCBpcyBnZXR0aW5nIGludG8g
YQo+IHByZXR0eSBnb29kIHNoYXBlIG92ZXJhbGwuCj4KPiBFaXRoZXIgd2F5LCB0aGUgb2xkIHBh
dGNoc2V0IHdpbGwgZ2l2ZSB5b3UgYSBnb29kIGlkZWEgYWJvdXQgaG93IGl0IGFsbAo+IHdvcmtz
LCB0aGUgY2hhbmdlcyBhcmUgbW9zdGx5IGluIHRoZSBkZXRhaWxzLiBJIGFtIGhhcHB5IHRvIHB1
c2ggb3V0IGEKPiBuZXcgdmVyc2lvbiBzb29uZXIgcmF0aGVyIHRoYW4gbGF0ZXIgaWYgaXQgbWln
aHQgaGVscCB3aXRoIGFueSBlZmZvcnRzCj4gb24geW91ciBzaWRlLgoKRnJvbSBhIHF1aWNrIHNj
YW4sIGl0IGxvb2tzIGxpa2UgdGhlcmUncyBzb21lIGNsZWFudXBzIGluIHRoZSBzZXJpZXMKd2hp
Y2ggd291bGQgYmUgaGVscGZ1bCB3aXRob3V0IHNlY2NvbXAgcGFydHMuIE9uZSBvZiB0aGUgaW5p
dGlhbAppc3N1ZXMgSSd2ZSBmb3VuZCBpcyBVTUwgdXNpbmcgb2xkZXIgcHRyYWNlIGludGVyZmFj
ZXMgd2hpY2ggYXJtNjQKZG9lc24ndCBpbXBsZW1lbnQuIFBUUkFDRV9HRVRSRUdTIGZvciBleGFt
cGxlLgoKUm9iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
