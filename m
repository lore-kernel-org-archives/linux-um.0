Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7AFC64EC4
	for <linux-um@archiver.kernel.org>; Sat,  4 Mar 2023 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DU50HNZaYUqyfaTV6KlwgbFuL+ynPrtKBiFN6QI+8gw=; b=XS8S66dOjmVrWj
	v4BPg7ff+kf3rADZvn4xmjd0aFD5UHLw8H81jyj8Wmk/GdCtumYWuq/w4usiARRDAsmoloU29UTMP
	PkI2Se8lv0vrj+3YHDjLScdIM4QpemUZ7R9plIjVj/RPNp8DNAUMTd9WpxGq6mGI0quoZJy5SRas7
	ls+K33FKxhw31NZ0i/Ckf4c0YhvLO1Ju7bzPfdAplBeOjJ9E7eUBWpTYq0D37VldWyG6DQFSd8NHd
	10fiBdQ5oampnlqFLE0Dla96i0e4y7rMd7xL2dSaPLGNMBfXsaxjm49PGF5ZB5J5uUn9fJenxfdpM
	CDLE8ZP3FJQF2MaL+nww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTC2-0098nT-8f; Sat, 04 Mar 2023 14:49:02 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTBy-0098m4-PN
	for linux-um@lists.infradead.org; Sat, 04 Mar 2023 14:49:00 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id op8so3681735qvb.11
        for <linux-um@lists.infradead.org>; Sat, 04 Mar 2023 06:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677941336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsKKHJ0/GD+1zuzNsuCdWtAJjvxya3Twz8P8LNYqCwY=;
        b=o0XqqF9KH2cTPnL75tHljXD8nVLW6wpV2NwV7X4XXX+8CRd/3AiCnKdEDZYSwR76vS
         z8DZ8fDxhR9+Ldwet6gfGkh2EsHwkG4Dy7dIJF9dPCMa6YH7fOTsxGPuSPTCkAS8XnXz
         OfwYYEu30tPOkw33e6UktE/vuadPB2J8SBzRq91ZzIsoBzpFT+a/OEoRYN3MxofBSzE3
         n2D3eHQaHuIWSse1usU0WLHDT0VedC2vd3YjKYqeoWc8J/YzpCrNaTcZorTn2ZaYobKj
         vcDaPFP2HtRgLwcyZQk40ii3Uxz5WJNVJ4F+7fU5RfFO0z0TzUrHE3mMAIJLs5FvwND4
         pCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677941336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsKKHJ0/GD+1zuzNsuCdWtAJjvxya3Twz8P8LNYqCwY=;
        b=l9ForYRFIJQuixaVsaJ7VieMPcu6QgWlnv6C+2pkcH90uYMMdD2TMc6AVf6fKD0Kus
         2MV/j8bb0tgz58OJnnVgegh5+tCK0YZpdWilRDE8eKpM6nSaa3rrS+j/is7hyMlAxzlg
         i5N4miISHAGPugx8MGVfFMn+qg2CfHcPWP6OD/hUnI26at7A8W8mjZ9IoiCZUfOwZkzt
         VcRZB73BIROOURCrTQICAQmTYMoU6hAgUh1watYMprK7wqmi8t8sfL/AfVcEj1UhuQQL
         h1hG/O4zA7uNbqpjq4qKgokOocYNhlZNCJj54OAZbXa/kQKtrI3yEu0XptQgmeDFeVZm
         a5IA==
X-Gm-Message-State: AO0yUKUdBE2h+mFF+vIBKuP5sLLGyAiFUvtW5JqL6qC8a44QKfzXB7I3
	qQYrMgrgujlBQEieIeIkU2Y=
X-Google-Smtp-Source: AK7set/lpTeE6jSzoh7eLRmNQ2aPTpe64xLeLcMiiEyIor3lA8OcSo+NeLshc41rysf1tZHsq/I8fQ==
X-Received: by 2002:a05:6214:23c8:b0:583:a07b:554c with SMTP id hr8-20020a05621423c800b00583a07b554cmr2306311qvb.40.1677941335935;
        Sat, 04 Mar 2023 06:48:55 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id d82-20020a376855000000b007419eb86df0sm3835899qkc.127.2023.03.04.06.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 06:48:55 -0800 (PST)
Message-ID: <6668e83c-eb2c-7ac9-7b6f-2c8146c2175d@gmail.com>
Date: Sat, 4 Mar 2023 08:48:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>, David Gow <davidgow@google.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-um@lists.infradead.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_064858_870941_C624EEDE 
X-CRM114-Status: GOOD (  30.53  )
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

T24gMy8yLzIzIDExOjMyLCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBUaHUsIE1hciAyLCAyMDIz
IGF0IDI6MTTigK9BTSBEYXZpZCBHb3cgPGRhdmlkZ293QGdvb2dsZS5jb20+IHdyb3RlOgo+Pgo+
PiBPbiBUaHUsIDIgTWFyIDIwMjMgYXQgMDk6MzgsIFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVs
Lm9yZz4gd3JvdGU6Cj4+Pgo+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyB1bml0IHRlc3RzIGZv
ciB0aGUgY2xrIGZpeGVkIHJhdGUgYmFzaWMgdHlwZSBhbmQKPj4+IHRoZSBjbGsgcmVnaXN0cmF0
aW9uIGZ1bmN0aW9ucyB0aGF0IHVzZSBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhLiBUbyBnZXQKPj4+
IHRoZXJlLCB3ZSBhZGQgc3VwcG9ydCBmb3IgbG9hZGluZyBhIERUQiBpbnRvIHRoZSBVTUwga2Vy
bmVsIHRoYXQncwo+Pj4gcnVubmluZyB0aGUgdW5pdCB0ZXN0cyBhbG9uZyB3aXRoIHByb2Jpbmcg
cGxhdGZvcm0gZHJpdmVycyB0byBiaW5kIHRvCj4+PiBkZXZpY2Ugbm9kZXMgc3BlY2lmaWVkIGlu
IERULgo+Pj4KPj4+IFdpdGggdGhpcyBzZXJpZXMsIHdlJ3JlIGFibGUgdG8gZXhlcmNpc2Ugc29t
ZSBvZiB0aGUgY29kZSBpbiB0aGUgY29tbW9uCj4+PiBjbGsgZnJhbWV3b3JrIHRoYXQgdXNlcyBk
ZXZpY2V0cmVlIGxvb2t1cHMgdG8gZmluZCBwYXJlbnRzIGFuZCB0aGUgZml4ZWQKPj4+IHJhdGUg
Y2xrIGNvZGUgdGhhdCBzY2FucyBkZXZpY2V0cmVlIGRpcmVjdGx5IGFuZCBjcmVhdGVzIGNsa3Mu
IFBsZWFzZQo+Pj4gcmV2aWV3Lgo+Pj4KPj4KPj4gVGhhbmtzIFN0ZXBoZW4gLS0gdGhpcyBpcyBy
ZWFsbHkgbmVhdCEKPj4KPj4gVGhpcyB3b3JrcyB3ZWxsIGhlcmUsIGFuZCBJIGxvdmUgYWxsIG9m
IHRoZSB0ZXN0cyBmb3IgdGhlCj4+IEtVbml0L2RldmljZS10cmVlIGludGVncmF0aW9uIGFzIHdl
bGwuCj4+Cj4+IEknbSBzdGlsbCBsb29raW5nIHRocm91Z2ggdGhlIGRldGFpbHMgb2YgaXQgKGFs
YXMsIEkndmUgbW9zdGx5IGxpdmVkCj4+IGluIHg4Ni1sYW5kLCBzbyBteSBkZXZpY2UtdHJlZSBr
bm93bGVkZ2UgaXMsIHVoLCBzcG90dHkgdG8gc2F5IHRoZQo+PiBsZWFzdCksIGJ1dCBhcGFydCBm
cm9tIHBvc3NpYmx5IHJlbmFtaW5nIHNvbWUgdGhpbmdzIG9yIHNpbWlsYXJseQo+PiBtaW5vciB0
d2Vha3MsIEkndmUgbm90IGdvdCBhbnkgcmVhbCBzdWdnZXN0aW9ucyB0aHVzIGZhci4KPj4KPj4g
SSBkbyB3b25kZXIgd2hldGhlciB3ZSdsbCB3YW50LCBvbiB0aGUgS1VuaXQgc2lkZSwgdG8gaGF2
ZSBzb21lIHdheSBvZgo+PiBzdXBwb3J0aW5nIEtVbml0IGRldmljZSB0cmVlcyBvbiBub24tVU1M
IGFyY2hpdGVjY3R1cmVzIChlLmcuLCBpZiB3ZQo+PiBuZWVkIHRvIHRlc3Qgc29tZXRoaW5nIGFy
Y2hpdGVjdHVyZS1zcGVjaWZpYywgb3Igb24gYSBiaWctZW5kaWFuCj4+IHBsYXRmb3JtLCBldGMp
LCBidXQgSSB0aGluayB0aGF0J3MgYSBxdWVzdGlvbiBmb3IgdGhlIGZ1dHVyZSwgcmF0aGVyCj4+
IHRoYW4gc29tZXRoaW5nIHRoYXQgYWZmZWN0cyB0aGlzIHNlcmllcy4KPiAKPiBJJ2xsIHNheSB0
aGF0J3MgYSByZXF1aXJlbWVudC4gV2Ugc2hvdWxkIGJlIGFibGUgdG8gc3RydWN0dXJlIHRoZQo+
IHRlc3RzIHRvIG5vdCBpbnRlcmZlcmUgd2l0aCB0aGUgcnVubmluZyBzeXN0ZW0ncyBEVC4gVGhl
IERUIHVuaXR0ZXN0Cj4gZG9lcyB0aGF0Lgo+IAo+IEFzIGEgc2lkZSB0b3BpYywgSXMgYW55b25l
IGxvb2tpbmcgYXQgZ2V0dGluZyBVTUwgdG8gd29yayBvbiBhcm02ND8KPiBJdCdzIHN1cnByaXNp
bmcgaG93IG11Y2ggeDg2IHN0dWZmIHRoZXJlIGlzIHdoaWNoIGlzIEkgZ3Vlc3Mgb25lCj4gcmVh
c29uIGl0IGhhc24ndCBoYXBwZW5lZC4KPiAKPj4gU2ltaWxhcmx5LCBJIHdvbmRlciBpZiB0aGVy
ZSdzIHNvbWV0aGluZyB3ZSBjb3VsZCBkbyB3aXRoIGRldmljZSB0cmVlCj4+IG92ZXJsYXlzLCBp
biBvcmRlciB0byBtYWtlIGl0IHBvc3NpYmxlIGZvciB0ZXN0cyB0byBzd2FwIG5vZGVzIGluIGFu
ZAo+PiBvdXQgZm9yIHRlc3RpbmcuCj4gCj4gWWVzLCB0aGF0J3MgaG93IHRoZSBEVCB1bml0dGVz
dCB3b3Jrcy4gQnV0IGl0IGlzIHByZXR0eSBtdWNoIG9uZSBiaWcKPiBvdmVybGF5IChpZ25vcmlu
ZyB0aGUgb3ZlcmxheSB0ZXN0cykuIEl0IGNvdWxkIHByb2JhYmx5IGJlIG1vcmUKPiBtb2R1bGFy
IHdoZXJlIGl0IGlzIGFwcGx5IG92ZXJsYXksIHRlc3QsIHJlbW92ZSBvdmVybGF5LCByZXBlYXQu
CgpBY3R1YWxseSwgbm8sIHRoZSBidWxrIG9mIHRoZSBEVCB1bml0dGVzdCBkZXZpY2V0cmVlIGRh
dGEgaXMgX25vdF8gYW4Kb3ZlcmxheS4gIEl0IGlzIGFuIEZEVCB0aGF0IGlzIGxvYWRlZCB2aWEg
b2ZfZmR0X3VuZmxhdHRlbl90cmVlKCkgaW5zdGVhZApvZiB0aGUgb3ZlcmxheSBsb2FkIEFQSS4g
IE5vdGUgdGhhdCB0aGUgYmFzZSBEVCB1bml0dGVzdCBydW5zIHdpdGgKICBDT05GSUdfT0ZfRFlO
QU1JQz1uCiAgQ09ORklHX09GX09WRVJMQVk9bgpzbyB0aGUgb3ZlcmxheSBzdXBwb3J0IGNvZGUg
aXMgbm90IGV2ZW4gcHJlc2VudCBpbiB0aGUgYnVpbHQga2VybmVsLgoKT25lIGNhbiB0aGVuIGVu
YWJsZSBDT05GSUdfT0ZfRFlOQU1JQyB0byB0ZXN0IHRoZSBkeW5hbWljIGNvZGUuCgpPbmUgY2Fu
IGZ1cnRoZXIgZW5hYmxlIENPTkZJR19PRl9PVkVSTEFZIHRvIHRlc3QgdGhlIG92ZXJsYXkgY29k
ZQoodGhpcyB3aWxsIGluIHR1cm4gc2VsZWN0IENPTkZJR19PRl9EWU5BTUlDIGlmIG5vdCBhbHJl
YWR5IGVuYWJsZWQpLgoKSSB3b3VsZCBzdHJvbmdseSBkaXNjb3VyYWdlIHVzZSBvZiB0aGUgb3Zl
cmxheSBBUElzIGZvciBrdW5pdCB0ZXN0cywKdW5sZXNzIHRoZSBwb2ludCBvZiB0aGUga3VuaXQg
dGVzdCBpcyB0byB0ZXN0IHRoZSBvdmVybGF5IEFQSS4gIEJhc2ljCnRlc3RzIHNob3VsZCBhbHdh
eXMgYmUgcGVyZm9ybWVkIHdpdGggZGV2aWNldHJlZSBkYXRhIHRoYXQgaGFzIGJlZW4KcG9wdWxh
dGVkIGJ5IHRoZSBub3JtYWwgcHJvY2Vzc2luZyBvZiBhbiBGRFQgZHVyaW5nIGVhcmx5IGJvb3Qu
ICBJZgpvbmUgd2FudCB0byB0ZXN0IHByb3BlciBvdmVybGF5IGluZnJhc3RydWN0dXJlIGZ1bmN0
aW9uYWxpdHksIHRoZW4KdGhvc2UgKGVzc2VudGlhbGx5KSBzYW1lIGJhc2ljIHRlc3RzIGNvdWxk
L3Nob3VsZCBiZSByZXBlYXRlZCB3aXRoCmRldmljZXRyZWUgZGF0YSB0aGF0IGhhcyBiZWVuIHBv
cHVsYXRlZCBieSBsb2FkaW5nIGFuIG92ZXJsYXkuCgo+IAo+IFJvYgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K
