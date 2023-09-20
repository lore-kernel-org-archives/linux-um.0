Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415F0C0031C
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YNuDuZhIB8Wmdvpa/JRwq6/ov0SO5iLbBCfFpr86pG8=; b=P+DnT9T5BpmZX3
	qM+p1FBEcxDNDEF+58u5vEf0LUqOpxlWHgoKOC5/VScVOUl6nkeMb9aPaVkLtpEodY0q1VYAdx1PC
	vN5z+Q6DrYPs0SNTIINCVQsLSrkIvZkLsb9J6zGGiVx1PPV6ISxl047lZ7//a5w2vFmD8+/tYI1ea
	uCQ9x6aeCNh213qygKJHpjUQcQeAe3ShuDCeG/86z/pvm8vDrcWOaPunXvh+eiYqNQMwHihQ7E5BH
	tRUdal2pKsNZSBzuryNm2CzIJmznF2U4jllcam/pE/CsDd0lhGU/tSOqEGNgdKSHut4hZndX1ZG0l
	5+hjfX9NSExDuIMYiTGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qj0Vl-003gG3-31;
	Wed, 20 Sep 2023 16:57:14 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qj0Vi-003gEa-0f;
	Wed, 20 Sep 2023 16:57:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54B642017D;
	Wed, 20 Sep 2023 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695229020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arrJUNtqjU/izONia38ns6kqz5a2Ljs8vzyYYK7Z784=;
	b=B5zucAFR4XyR8/5tRFN24icRoW3Li46w9AYROy5fgeQHJjHHmWe1VBSTJAgJzltxBUTQfj
	A2xO9YmlmCUAHIhnO6bcsmBlTch94Tqw9Zrs2J99gUVXgRrg7N5SnwIhK/ADmsG7DqDXb5
	NyDsDzox8Vmqa0S6njAX9jt6GCL7qPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695229020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arrJUNtqjU/izONia38ns6kqz5a2Ljs8vzyYYK7Z784=;
	b=TEI3317KDo5yb9aq6yYTvDHKSUd5zcn5XGrWvmgB48JFj1/RVX24vTZ5l0fScD+mlAMJpN
	CaN28xdVs9HUPMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 420581333E;
	Wed, 20 Sep 2023 16:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id s1QXEFwkC2UDdgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 16:57:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE8E8A077D; Wed, 20 Sep 2023 18:56:59 +0200 (CEST)
Date: Wed, 20 Sep 2023 18:56:59 +0200
From: Jan Kara <jack@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Lafreniere <peter@n8pjl.ca>, segher@kernel.crashing.org,
	anton.ivanov@cambridgegreys.com, ink@jurassic.park.msu.ru,
	jack@suse.cz, johannes@sipsolutions.net,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org, linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org,
	richard.henderson@linaro.org, richard@nod.at,
	tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230920165659.coe7d2lydiaatoby@quack3>
References: <20230918175529.19011-1-peter@n8pjl.ca>
 <20230918234108.GN19790@gate.crashing.org>
 <20230919000026.7409-1-peter@n8pjl.ca>
 <20230919151630.GO19790@gate.crashing.org>
 <20230919155832.4179-1-peter@n8pjl.ca>
 <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_095710_412431_9CB44F60 
X-CRM114-Status: GOOD (  17.73  )
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

T24gVHVlIDE5LTA5LTIzIDE4OjAyOjM5LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4gSGkg
UGV0ZXIsCj4gCj4gT24gVHVlLCBTZXAgMTksIDIwMjMgYXQgNTo1OOKAr1BNIFBldGVyIExhZnJl
bmllcmUgPHBldGVyQG44cGpsLmNhPiB3cm90ZToKPiA+ICAyKSBTdG9wcyBidWlsZGluZyBhbiBv
YnNvbGV0ZSBhbmQgbGFyZ2VseS11bnVzZWQgZmlsZXN5c3RlbSB1bm5lY2Vzc2FyaWx5Lgo+ID4g
ICAgIFNvbWUgaG9iYnlpc3QgdGFyZ2V0cyBsaWtlIG02OGsgYW5kIGFscGhhIG1heSBwcmVmZXIg
dG8ga2VlcCBhbGwgZmlsZXN5c3RlbXMKPiA+ICAgICBhdmFpbGFibGUgdW50aWwgdG90YWwgcmVt
b3ZhbCwgYnV0IG90aGVycyBsaWtlIGFybSBhbmQgVU1MIGhhdmUgbm8gbmVlZCBmb3IKPiA+ICAg
ICBSZWlzZXJGUyB0byBiZSBidWlsdCB1bmxlc3Mgc3BlY2lmaWNhbGx5IGNvbmZpZ3VyZWQuCj4g
Cj4gQXMgVU1MIGlzIHVzZWQgYSBsb3QgZm9yIHRlc3RpbmcsIGlzbid0IGl0IGFjdHVhbGx5IGNv
dW50ZXItcHJvZHVjdGl2ZQo+IHRvIHJlbW92ZSBSZWlzZXJGUyBmcm9tIHRoZSBVTUwgZGVmY29u
ZmlnPyAgVGhlIGxlc3MgdGVzdGluZyBpdAo+IHJlY2VpdmVzLCB0aGUgaGlnaGVyIHRoZSBjaGFu
Y2Ugb2YgaW50cm9kdWNpbmcgcmVncmVzc2lvbnMuCgpUaGUgb25seSB0ZXN0aW5nIEkga25vdyBh
Ym91dCBmb3IgcmVpc2VyZnMgKGJlc2lkZXMgYnVpbGQgdGVzdGluZykgaXMKc3l6Ym90LiBBbmQg
cmVnYXJkaW5nIHRoZSBwZW9wbGUgLyBib3RzIGRvaW5nIGZpbGVzeXN0ZW0gdGVzdGluZyBJIGtu
b3cKbm9uZSBvZiB0aGVtIHVzZXMgVU1MLiBSYXRoZXIgaXQgaXMgeDg2IFZNcyB0aGVzZSBkYXlz
IHdoZXJlIHJlaXNlcmZzIGlzCmRpc2FibGVkIGluIHRoZSBkZWZjb25maWcgZm9yIGEgKmxvbmcq
IHRpbWUgKG1hbnkgeWVhcnMpLiBBbHNvIHdoZW4geW91IGRvCmZpbGVzeXN0ZW0gdGVzdGluZywg
eW91IHVzdWFsbHkganVzdCB0ZXN0IHRoZSBmZXcgZmlsZXN5c3RlbXMgeW91IGNhcmUKYWJvdXQg
YW5kIGZvciB3aGljaCB5b3UgaGF2ZSBhbGwgdGhlIHRvb2xzIGluc3RhbGxlZC4gU28gZnJhbmts
eSBJIGRvbid0CnNlZSBhIGdvb2QgcmVhc29uIHRvIGxlYXZlIHJlaXNlcmZzIGVuYWJsZWQgaW4g
ZGVmY29uZmlncy4gQnV0IHN1cmUgaWYKbTY4ayBvciBvdGhlciBhcmNoIHdhbnRzIHRvIGtlZXAg
cmVpc2VyZnMgaW4gaXQncyBkZWZjb25maWcgZm9yIHNvbWUKY29uc2lzdGVuY3kgcmVhc29ucywg
SSdtIGZpbmUgd2l0aCBpdC4gSSBqdXN0IHN1c3BlY3QgdGhhdCBmb3IgbW9zdCBhcmNocwp0aGlz
IGlzIGp1c3QgYSBoaXN0b3JpY2FsIHJlYXNvbi4KCgkJCQkJCQkJSG9uemEKLS0gCkphbiBLYXJh
IDxqYWNrQHN1c2UuY29tPgpTVVNFIExhYnMsIENSCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==
