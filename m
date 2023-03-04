Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B113DC678DB
	for <linux-um@archiver.kernel.org>; Sat,  4 Mar 2023 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M6vSqumezOIvXlQMjAsBGe3tWNRV9Mi7oLjU/eDIJEU=; b=XHTrUCOYNlriW8
	iNB20rgeO6iwR7GwnX6Y9FL1k/y97ZaEg+ERRturF6Edxe3x0Fg/2fUcgpwQcIi024sHCRi+PyxYO
	q1R2+boFLZd1oFYQXKWeKYRHaULbRRSPDrdgH6v0rXwMy/oNZ+sFXSPDQ+EfTZOMxnbxfRTXsr/5q
	uknJUAByeC6x/uXVJHMLhOKSs2zZ6Pyrk0Pr4kEeoRT/90enDXoHSJD/W3It937g4AKlQ93FEK7FL
	VkQxQKh8od+Nwqd6v1gBL4DhV8mIIKz8k06rkdGgFYsAEou8I/jDfS9n1WYQgVY2Ylt+qSUM/WZHU
	7ymJSMOIj3BahUoLSKgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTRP-0099vU-Se; Sat, 04 Mar 2023 15:04:55 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTRL-0099uc-FO
	for linux-um@lists.infradead.org; Sat, 04 Mar 2023 15:04:53 +0000
Received: by mail-qt1-x82b.google.com with SMTP id c19so6007478qtn.13
        for <linux-um@lists.infradead.org>; Sat, 04 Mar 2023 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677942290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pu+adi69s8qFQuNWXMk5FXEup8uqRErroiF1b4Qu8ZQ=;
        b=jjwwn3Maiet7+ZIgdUXkyoKDgvraa1RGIHpDVqs6VgyIS8V+UhsVnKubicV++yqKT6
         eVgMRaJhxPnmHmjaz/o6oOemO0EU9u7TEKLv4kI20d8vvr2irc1PZ31aYaL3yjunZTnC
         juNCsy/uThYMHtVemSG3dKB62LPEhdTNvWjaHkyBQld2VCgWx9EpBVBc6pQpCuwz3u+K
         oUDDAAsk1bxkDiZFBzATsv6kDJBxFmHg9Qs0JRTQl8e9jqlqMyOWjFyiMGfFCqU6Lpyx
         UuCQhGxd/o5gBXxhHwYltHoOeLSOmFwcZcT9DjWvMd82HPvsUiWbVw0vSacphmZyzijZ
         uz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677942290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu+adi69s8qFQuNWXMk5FXEup8uqRErroiF1b4Qu8ZQ=;
        b=0i/vZjTwSLAYy67K9UTuoQSYiS/L1J5hVm/AKIdggsfw+ntyP5GrIMCFmlH7X0ryy0
         +b8huZPQybawjon6VShVnsdUbfar2Qe2GRNhgOL/3SPwtUlluxq+6r+208Qfk6QoZYeU
         /hoTGq8jmmDP2UBIvaMe2CGjXh/Tv5ROOAQk8dYJh7G3SgVoD48IUomAtiY9ldzSE/GR
         1iehvYVCz3Lr84juqSuaUHKglSAf9emsfstdbIBN0O1PH0VQeeEx0+pvYcc4NvmxAlCh
         4lNLFnjt5YVpOU9kI2dgubPiNaNsI3cZdPQVYPE72TwT/3a5NduPaSPvY9YF6VffMXZ8
         Cr6Q==
X-Gm-Message-State: AO0yUKUOCzEb6kNYbb052JX5yxn4lWrviS06MRqP9TPsZWhckIT5SN7a
	haS91YvlpG6pQY8VcMhLQkI=
X-Google-Smtp-Source: AK7set9m7wI62m3NP2RoiyavT6E9DhvS2HzzjCtYnoNK7sgFFZNyQRKVCnuzrK3aiBHpkdifiKe4Uw==
X-Received: by 2002:a05:622a:1aa4:b0:3bf:c69c:e31c with SMTP id s36-20020a05622a1aa400b003bfc69ce31cmr9175282qtc.13.1677942290016;
        Sat, 04 Mar 2023 07:04:50 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id q1-20020ac87341000000b003bfa2c512e6sm3873388qtp.20.2023.03.04.07.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 07:04:49 -0800 (PST)
Message-ID: <5e26a786-400a-cd6c-8771-d94a8020839d@gmail.com>
Date: Sat, 4 Mar 2023 09:04:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, David Gow <davidgow@google.com>,
 Rob Herring <robh+dt@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J.Wysocki" <rafael@kernel.org>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-um@lists.infradead.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
 <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_070451_576119_A61730B8 
X-CRM114-Status: GOOD (  40.85  )
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

T24gMy8yLzIzIDEzOjI3LCBTdGVwaGVuIEJveWQgd3JvdGU6Cj4gUXVvdGluZyBSb2IgSGVycmlu
ZyAoMjAyMy0wMy0wMiAwOTozMjowOSkKPj4gT24gVGh1LCBNYXIgMiwgMjAyMyBhdCAyOjE04oCv
QU0gRGF2aWQgR293IDxkYXZpZGdvd0Bnb29nbGUuY29tPiB3cm90ZToKPj4+Cj4+PiBPbiBUaHUs
IDIgTWFyIDIwMjMgYXQgMDk6MzgsIFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3Jv
dGU6Cj4+Pj4KPj4+PiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHVuaXQgdGVzdHMgZm9yIHRoZSBj
bGsgZml4ZWQgcmF0ZSBiYXNpYyB0eXBlIGFuZAo+Pj4+IHRoZSBjbGsgcmVnaXN0cmF0aW9uIGZ1
bmN0aW9ucyB0aGF0IHVzZSBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhLiBUbyBnZXQKPj4+PiB0aGVy
ZSwgd2UgYWRkIHN1cHBvcnQgZm9yIGxvYWRpbmcgYSBEVEIgaW50byB0aGUgVU1MIGtlcm5lbCB0
aGF0J3MKPj4+PiBydW5uaW5nIHRoZSB1bml0IHRlc3RzIGFsb25nIHdpdGggcHJvYmluZyBwbGF0
Zm9ybSBkcml2ZXJzIHRvIGJpbmQgdG8KPj4+PiBkZXZpY2Ugbm9kZXMgc3BlY2lmaWVkIGluIERU
Lgo+Pj4+Cj4+Pj4gV2l0aCB0aGlzIHNlcmllcywgd2UncmUgYWJsZSB0byBleGVyY2lzZSBzb21l
IG9mIHRoZSBjb2RlIGluIHRoZSBjb21tb24KPj4+PiBjbGsgZnJhbWV3b3JrIHRoYXQgdXNlcyBk
ZXZpY2V0cmVlIGxvb2t1cHMgdG8gZmluZCBwYXJlbnRzIGFuZCB0aGUgZml4ZWQKPj4+PiByYXRl
IGNsayBjb2RlIHRoYXQgc2NhbnMgZGV2aWNldHJlZSBkaXJlY3RseSBhbmQgY3JlYXRlcyBjbGtz
LiBQbGVhc2UKPj4+PiByZXZpZXcuCj4+Pj4KPj4+Cj4+PiBUaGFua3MgU3RlcGhlbiAtLSB0aGlz
IGlzIHJlYWxseSBuZWF0IQo+Pj4KPj4+IFRoaXMgd29ya3Mgd2VsbCBoZXJlLCBhbmQgSSBsb3Zl
IGFsbCBvZiB0aGUgdGVzdHMgZm9yIHRoZQo+Pj4gS1VuaXQvZGV2aWNlLXRyZWUgaW50ZWdyYXRp
b24gYXMgd2VsbC4KPj4+Cj4+PiBJJ20gc3RpbGwgbG9va2luZyB0aHJvdWdoIHRoZSBkZXRhaWxz
IG9mIGl0IChhbGFzLCBJJ3ZlIG1vc3RseSBsaXZlZAo+Pj4gaW4geDg2LWxhbmQsIHNvIG15IGRl
dmljZS10cmVlIGtub3dsZWRnZSBpcywgdWgsIHNwb3R0eSB0byBzYXkgdGhlCj4+PiBsZWFzdCks
IGJ1dCBhcGFydCBmcm9tIHBvc3NpYmx5IHJlbmFtaW5nIHNvbWUgdGhpbmdzIG9yIHNpbWlsYXJs
eQo+Pj4gbWlub3IgdHdlYWtzLCBJJ3ZlIG5vdCBnb3QgYW55IHJlYWwgc3VnZ2VzdGlvbnMgdGh1
cyBmYXIuCj4+Pgo+Pj4gSSBkbyB3b25kZXIgd2hldGhlciB3ZSdsbCB3YW50LCBvbiB0aGUgS1Vu
aXQgc2lkZSwgdG8gaGF2ZSBzb21lIHdheSBvZgo+Pj4gc3VwcG9ydGluZyBLVW5pdCBkZXZpY2Ug
dHJlZXMgb24gbm9uLVVNTCBhcmNoaXRlY2N0dXJlcyAoZS5nLiwgaWYgd2UKPj4+IG5lZWQgdG8g
dGVzdCBzb21ldGhpbmcgYXJjaGl0ZWN0dXJlLXNwZWNpZmljLCBvciBvbiBhIGJpZy1lbmRpYW4K
Pj4+IHBsYXRmb3JtLCBldGMpLCBidXQgSSB0aGluayB0aGF0J3MgYSBxdWVzdGlvbiBmb3IgdGhl
IGZ1dHVyZSwgcmF0aGVyCj4+PiB0aGFuIHNvbWV0aGluZyB0aGF0IGFmZmVjdHMgdGhpcyBzZXJp
ZXMuCj4+Cj4+IEknbGwgc2F5IHRoYXQncyBhIHJlcXVpcmVtZW50LiBXZSBzaG91bGQgYmUgYWJs
ZSB0byBzdHJ1Y3R1cmUgdGhlCj4+IHRlc3RzIHRvIG5vdCBpbnRlcmZlcmUgd2l0aCB0aGUgcnVu
bmluZyBzeXN0ZW0ncyBEVC4gVGhlIERUIHVuaXR0ZXN0Cj4+IGRvZXMgdGhhdC4KPiAKPiBUaGF0
IGNvdWxkIGJlIGFub3RoZXIgY2hvaWNlIGluIHRoZSB1bml0IHRlc3QgY2hvaWNlIG1lbnUuCj4g
Q09ORklHX09GX0tVTklUX05PVF9VTUwgdGhhdCBpbmplY3RzIHNvbWUgYnVpbHQtaW4gRFRCIG92
ZXJsYXkgb24gYW4KPiBhcmNoaXRlY3R1cmUgdGhhdCB3YW50cyB0byBydW4gdGVzdHMuCj4gCj4+
Cj4+IEFzIGEgc2lkZSB0b3BpYywgSXMgYW55b25lIGxvb2tpbmcgYXQgZ2V0dGluZyBVTUwgdG8g
d29yayBvbiBhcm02ND8KPj4gSXQncyBzdXJwcmlzaW5nIGhvdyBtdWNoIHg4NiBzdHVmZiB0aGVy
ZSBpcyB3aGljaCBpcyBJIGd1ZXNzIG9uZQo+PiByZWFzb24gaXQgaGFzbid0IGhhcHBlbmVkLgo+
IAo+IEkndmUgbm8gaWRlYSBidXQgaXQgd291bGQgYmUgbmljZSBpbmRlZWQuCj4gCj4+Cj4+PiBT
aW1pbGFybHksIEkgd29uZGVyIGlmIHRoZXJlJ3Mgc29tZXRoaW5nIHdlIGNvdWxkIGRvIHdpdGgg
ZGV2aWNlIHRyZWUKPj4+IG92ZXJsYXlzLCBpbiBvcmRlciB0byBtYWtlIGl0IHBvc3NpYmxlIGZv
ciB0ZXN0cyB0byBzd2FwIG5vZGVzIGluIGFuZAo+Pj4gb3V0IGZvciB0ZXN0aW5nLgo+Pgo+PiBZ
ZXMsIHRoYXQncyBob3cgdGhlIERUIHVuaXR0ZXN0IHdvcmtzLiBCdXQgaXQgaXMgcHJldHR5IG11
Y2ggb25lIGJpZwo+PiBvdmVybGF5IChpZ25vcmluZyB0aGUgb3ZlcmxheSB0ZXN0cykuIEl0IGNv
dWxkIHByb2JhYmx5IGJlIG1vcmUKPj4gbW9kdWxhciB3aGVyZSBpdCBpcyBhcHBseSBvdmVybGF5
LCB0ZXN0LCByZW1vdmUgb3ZlcmxheSwgcmVwZWF0Lgo+Pgo+IAo+IEkgZGlkbid0IHdhbnQgdG8g
cmVseSBvbiB0aGUgb3ZlcmxheSBjb2RlIHRvIGluamVjdCBEVCBub2Rlcy4gSGF2aW5nCj4gdGVz
dHMgd3JpdHRlbiBmb3IgdGhlIGZha2UgS1VuaXQgbWFjaGluZSBpcyBzaW1wbGUuIEl0IGNsb3Nl
bHkgbWF0Y2hlcwo+IGhvdyBjbGsgY29kZSBwcm9iZXMgdGhlIERUQiBhbmQgaG93IG5vZGVzIGFy
ZSBjcmVhdGVkIGFuZCBwb3B1bGF0ZWQgb24KPiB0aGUgcGxhdGZvcm0gYnVzIGFzIGRldmljZXMu
IENMS19PRl9ERUNMQVJFKCkgd291bGQgbmVlZCB0aGUgb3ZlcmxheSB0bwo+IGJlIGFwcGxpZWQg
ZWFybHkgdG9vLCB3aGljaCBkb2Vzbid0IGhhcHBlbiBvdGhlcndpc2UgYXMgZmFyIGFzIEkga25v
dy4KPiAKPiBCdXQgcGVyaGFwcyB0aGlzIGRlc2lnbiBpcyB0b28gbXVjaCBvZiBhbiBlbmQtdG8t
ZW5kIHRlc3QgYW5kIG5vdCBhIHVuaXQKPiB0ZXN0PyBJbiB0aGUgc3Bpcml0IG9mIHVuaXQgdGVz
dGluZyB3ZSBzaG91bGRuJ3QgY2FyZSBhYm91dCBob3cgdGhlIG5vZGUKPiBpcyBhZGRlZCB0byB0
aGUgbGl2ZSBkZXZpY2V0cmVlLCBqdXN0IHRoYXQgdGhlcmUgaXMgYSBkZXZpY2V0cmVlIGF0IGFs
bC4KPiAKPiBTdXBwb3J0aW5nIG92ZXJsYXlzIHRvIG1vcmUgZWFzaWx5IHRlc3QgY29tYmluYXRp
b25zIHNvdW5kcyBsaWtlIGEgZ29vZAo+IGlkZWEuIFByb2JhYmx5IHNvbWUga3VuaXRfKigpIHBy
ZWZpeGVkIGZ1bmN0aW9ucyBjb3VsZCBiZSB1c2VkIHRvCgpJbiBhbiBpbWFnaW5hcnkgd29ybGQg
d2hlcmUgb3ZlcmxheSBzdXBwb3J0IHdhcyBjb21wbGV0ZWQsIHRoZW4gX21heWJlXy4KClRvIG1l
LCB0aGUgbW9zdCBpbXBvcnRhbnQgIGVudmlyb25tZW50IHRvIHRlc3QgaXMgd2hlcmUgdGhlIGRl
dmljdHJlZQpkYXRhIGlzIHBvcHVsYXRlZCBpbiBlYXJseSBib290IGZyb20gYW4gRkRULiAgVGhp
cyBpcyB0aGUgZW52aXJvbm1lbnQKdGhhdCBkcml2ZXJzIGN1cnJlbnRseSBleGlzdCBpbi4KClBv
cHVsYXRpbmcgZGV2aWNldHJlZSBkYXRhIHZpYSBhbiBvdmVybGF5IGFkZHMgaW4gdGhlIGZ1bmN0
aW9uaW5nIG9mIHRoZQpvdmVybGF5IGFwcGx5IGNvZGUgKGFuZCBob3cgdGhlIHJ1bGVzIGJlaGlu
ZCB0aGF0IGZ1bmN0aW9uaW5nIG1heSBkaWZmZXIKZnJvbSBkZXZpY2V0cmVlIGRhdGEgcG9wdWxh
dGVkIGluIGVhcmx5IGJvb3QgZnJvbSBhbiBGRFQpLgoKSW4gYW4gaWRlYWwgd29ybGQgd2hlcmUg
b3ZlcmxheSBzdXBwb3J0IHdhcyBjb21wbGV0ZWQsIG1vc3Qgb3IgYWxsIG9mIHRoZQpkZXZpY2V0
cmVlIHRlc3RzIHRoYXQgd2VyZSBwZXJmb3JtZWQgYWdhaW5zdCB0aGUgZGV2aWNldHJlZSBkYXRh
IHBvcHVsYXRlZAppbiBlYXJseSBib290IGZyb20gYW4gRkRUIHdvdWxkIGJlIHJlcGVhdGVkLCBi
dXQgYWdhaW5zdCBjb21wYXJhYmxlCmRldmljZXRyZWUgZGF0YSBwb3B1bGF0ZWQgdmlhIGFuIG92
ZXJsYXkgbG9hZC4gIFRoZSB0ZXN0cyB3aXRoIHRoZSBvdmVybGF5CmRhdGEgbWF5IGhhdmUgdG8g
YmUgYXdhcmUgb2Ygc29tZSBkaWZmZXJlbmNlcyBpbiBob3cgYW4gb3ZlcmxheSBsb2FkCnByb2Nl
c3NlcyBhbiBGRFQgdnMgaG93IHRoZSBlYXJseSBib290IHByb2Nlc3Npbmcgb2YgYW4gRkRUIGJl
aGF2ZXMuClRoaXMgZXh0cmEgdGVzdGluZyB3b3VsZCB2ZXJpZnkgdGhhdCB0aGUgb3ZlcmxheSBl
bnZpcm9ubWVudCBiZWhhdmVzCnRoZSBzYW1lIGFzIHRoZSBub24tb3ZlcmxheSBlbnZpcm9ubWVu
dCAod2l0aCBzb21lIGtub3duIGV4Y2VwdGlvbnMKZHVlIHRvIG92ZXJsYXkgcG9saWNpZXMpLgoK
T3ZlcmxheSBzdXBwb3J0IGlzIG5vdCBjb21wbGV0ZToKCiAgIGh0dHBzOi8vZWxpbnV4Lm9yZy9E
ZXZpY2VfVHJlZV9SZWZlcmVuY2UjTWFpbmxpbmVfTGludXhfU3VwcG9ydAoKICAgaHR0cHM6Ly9l
bGludXgub3JnL0ZyYW5rJTI3c19Fdm9sdmluZ19PdmVybGF5X1Rob3VnaHRzCgotRnJhbmsKCj4g
YXBwbHkgYSB0ZXN0IG1hbmFnZWQgb3ZlcmxheSBhbmQgYXV0b21hdGljYWxseSByZW1vdmUgaXQg
d2hlbiB0aGUgdGVzdAo+IGlzIG92ZXIgd291bGQgd29yay4gVGhlIGNsayByZWdpc3RyYXRpb24g
dGVzdHMgY291bGQgdXNlIHRoaXMgQVBJIHRvCj4gaW5qZWN0IGFuIG92ZXJsYXkgYW5kIHRoZW4g
bWFudWFsbHkgY2FsbCB0aGUgb2ZfcGxhdGZvcm1fcG9wdWxhdGUoKQo+IGZ1bmN0aW9uIHRvIGNy
ZWF0ZSB0aGUgcGxhdGZvcm0gZGV2aWNlKHMpLiBUaGUgb3ZlcmxheSBjb3VsZCBiZSBidWlsdCBp
bgo+IGRyaXZlcnMvY2xrLyB0b28gYW5kIHRoZW4gcHJvYmFibHkgc29tZSBtYWNyb2lzaCBmdW5j
dGlvbiBjYW4gZmluZCB0aGUKPiBibG9iIGFuZCBhcHBseSBpdC4KPiAKPiBJcyB0aGVyZSBzb21l
IHdheSB0byBkZWxldGUgdGhlIHBsYXRmb3JtIGRldmljZXMgdGhhdCB3ZSBwb3B1bGF0ZSBmcm9t
Cj4gdGhlIG92ZXJsYXk/IEknZCBsaWtlIHRoZSB0ZXN0cyB0byBiZSBoZXJtZXRpYy4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
