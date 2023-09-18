Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1111CCD13D2
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8G+AE66G2B+spT39TgokfNO5X/BIZLEyy5ECSzkNu0E=; b=l/v/w9JTsYMXBp
	6S/C90EHlShefn8X0Ueeb9KkflBBeDA7IdiNPtvJ+b/rlmI2cQY/I05PbHgA62NelkM9xsMb1yW1E
	9c41sS/a/rehqlSlmyN5hsqK88WkyqJmcWd0aw+VqeIwOwaVdKVGExDO4V914Ich74+agrhwSAv2B
	4lWEnlA42Y4foCheZQLuQq50ACwTwnPQD5tvZQwTkrYLL48Z3SSwnJFl3O7o7+pn/e6JZkZgV6GnO
	uiNEINoPI5mEeKaqCiokeyvcE/GD3lnj1Hi3uud7qnkxjYrK54yplZGlUwmRFM12omj7apx9/EZ/0
	Ygpwplc9tXOMWdZBwzZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHAb-00FsXP-2q;
	Mon, 18 Sep 2023 16:32:21 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHAT-00FsW1-2h
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 16:32:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 468B121D11;
	Mon, 18 Sep 2023 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695054728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65viRQYpB50dold0K4n5XzmsPEOTnLbffREamdAK1tQ=;
	b=2QwSrhbDUIp5/TQREiRUVkEyjBl+gfB80m2OcJdPAl2M3FpoSeTejfBRq0Rn6xvipQ5EYf
	F2yW5VECNNxjlp7qf60mnz1SYtY8iwM+OWdse4ZRfXxtAUSHjUwnhXNcZmGVVfcoX+c8MF
	RnqPC+zRffsJnd+K6h7mORl1YtDtgFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695054728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65viRQYpB50dold0K4n5XzmsPEOTnLbffREamdAK1tQ=;
	b=Pxgaal1PBWSS/Hac9Ux2fgXyaGG+k92ZBcLPSNgtabneSAz5Zd78iUFSV27CVkELMCaNbV
	kAGjIUaTvxKqfLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3737513480;
	Mon, 18 Sep 2023 16:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CeR4DYh7CGU1fQAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 16:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F95CA0759; Mon, 18 Sep 2023 18:32:07 +0200 (CEST)
Date: Mon, 18 Sep 2023 18:32:07 +0200
From: Jan Kara <jack@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan Kara <jack@suse.cz>, Peter Lafreniere <peter@n8pjl.ca>,
	linux-um@lists.infradead.org, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH RESEND] um: Remove CONFIG_REISERFS_FS from defconfig
Message-ID: <20230918163207.3e2hev3zxnr3bakj@quack3>
References: <20230910232640.113938-1-peter@n8pjl.ca>
 <20230918125744.4342-1-peter@n8pjl.ca>
 <20230918132614.zmmuc72purc2psik@quack3>
 <CAMuHMdWzN0Gs2FTQDFeBLz2498dv3ZYCBL2xOvL5YdHAveaH9g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWzN0Gs2FTQDFeBLz2498dv3ZYCBL2xOvL5YdHAveaH9g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_093214_037087_6EC0F0DB 
X-CRM114-Status: GOOD (  21.55  )
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

T24gTW9uIDE4LTA5LTIzIDE2OjU4OjA1LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4gSGkg
SmFuLAo+IAo+IE9uIE1vbiwgU2VwIDE4LCAyMDIzIGF0IDM6MjbigK9QTSBKYW4gS2FyYSA8amFj
a0BzdXNlLmN6PiB3cm90ZToKPiA+IE9uIE1vbiAxOC0wOS0yMyAxMjo1ODoyNiwgUGV0ZXIgTGFm
cmVuaWVyZSB3cm90ZToKPiA+ID4gUmVpc2VyRlMgaGFzIGJlZW4gZGVwcmVjYXRlZCBmb3IgYSB5
ZWFyIGFuZCBhIGhhbGYsIHlldCBpcyBzdGlsbCBidWlsdAo+ID4gPiBhcyBwYXJ0IG9mIGEgZGVm
Y29uZmlnIFVNTCBrZXJuZWwuCj4gPiA+Cj4gPiA+IEFjY29yZGluZyB0byBjb21taXQgZWIxMDNh
NTE2NDBlICgicmVpc2VyZnM6IERlcHJlY2F0ZSByZWlzZXJmcyIpLCB0aGUKPiA+ID4gZmlsZXN5
c3RlbSBpcyBzbGF0ZWQgdG8gYmUgcmVtb3ZlZCBpbiAyMDI1LiBSZW1vdmUgaXQgZnJvbSB0aGUg
ZGVmY29uZmlnCj4gPiA+IHByb2ZpbGUgbm93LCBhcyBwYXJ0IG9mIGl0cyBkZXByZWNhdGlvbiBw
cm9jZXNzLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBMYWZyZW5pZXJlIDxwZXRl
ckBuOHBqbC5jYT4KPiA+Cj4gPiBNYWtlcyBzZW5zZSBidXQgSSd2ZSBub3RpY2VkIHRoZXJlIGFy
ZSBtYW55IG1vcmUgYXJjaGl0ZWN0dXJlcyB0aGF0IGRlZmluZQo+ID4gQ09ORklHX1JFSVNFUkZT
X0ZTIGluIHRoZWlyIGRlZmNvbmZpZyAoc2gsIHBvd2VycGMsIG1pcHMsIG02OGssIGlhNjQsIGFy
bSwKPiA+IGFscGhhKS4gU28gcGVyaGFwcyB3ZSBzaG91bGQgZG8gdGhpcyBmb3IgYWxsIG9mIHRo
ZW0gd2hlbiB3ZSBhcmUgYXQgaXQ/Cj4gCj4gVGhlIHBvbGljeSBmb3IgdGhlIG02OGsgZGVmY29u
ZmlncyBpcyB0byBlbmFibGUgYWxsIGF2YWlsYWJsZSBleG90aWMKPiBmaWxlIHN5c3RlbXMgYXMg
bW9kdWxlcywgc28gc3VwcG9ydCBmb3IgdGhlbSBpcyBhdmFpbGFibGUgd2hlbiBuZWVkZWQuCj4g
Cj4gUGxlYXNlIGxldCBtZSBrbm93IHdoeSB0aGlzIHNob3VsZCBiZSBjaGFuZ2VkLCBhcyBsb25n
IGFzIFJlaXNlckZTIGlzCj4gc3RpbGwgYXZhaWxhYmxlIGluIHRoZSB1cHN0cmVhbSBrZXJuZWwu
CgpUaGVyZSdzIG5vIG5lZWQgdG8gY2hhbmdlIGlmIHlvdSBkb24ndCB3YW50IHRvLiBJIGNhbiBq
dXN0IGltYWdpbmUgaG93IGZvcgpvdGhlciBhcmNocyB3aGljaCBzZWVtIHRvIGVuYWJsZSBvbmx5
ICJ1c2VmdWwiIGZpbGVzeXN0ZW1zIGluIGRlZmNvbmZpZwpkaXNhYmxpbmcgYSBkZXByZWNhdGVk
IGZpbGVzeXN0ZW0gbWFrZXMgc2Vuc2UuCgoJCQkJCQkJCUhvbnphCi0tIApKYW4gS2FyYSA8amFj
a0BzdXNlLmNvbT4KU1VTRSBMYWJzLCBDUgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC11bQo=
