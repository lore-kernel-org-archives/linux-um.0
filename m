Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F492EE3F06
	for <linux-um@archiver.kernel.org>; Tue, 12 Sep 2023 20:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VhuYdihend9Y0S3rfOFV9JsFU4QNsd3wTYdSmOr/Bj4=; b=UtG8B4Viu7lemc
	66qakgIrp7sjm8DAjCmcDeZu9AfierhWjqsmToI6vcVyqp1bcXV8klGe1gc1M739ue/a8BEFTMtIU
	rXPevwja+Laq8Um86d4XYYOhs3nMEpbLF3AQa8V+zGssj5sbN+4utgu+IXX+scVeB0NDq0lT9DLsZ
	rrHzrJESJsj2FmvOwECfFc5mTvldsfTbOKxTvfjN/RumEuRoiFYR4s15aqILvNTxLLrVxFtSvvQxz
	MyEbDkbGvjZi1zxq+7lMZFYqzmny2JL/IBe+ca+6oQSN0nA3P+asD2FkBN0nhm17tG+5rIVOvekrb
	CNO38Kg8SoVfIG53q+Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg9kl-0044xY-0l;
	Tue, 12 Sep 2023 20:12:55 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg9ki-0044wr-37
	for linux-um@lists.infradead.org;
	Tue, 12 Sep 2023 20:12:54 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso772281766b.1
        for <linux-um@lists.infradead.org>; Tue, 12 Sep 2023 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694549567; x=1695154367; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dELf8UBwcQIad2hf1gwWWXOeHH/qzD9ZkjJM29lBufQ=;
        b=H4pZtLXWILILhujlNVkjaDWpZa0d7qx77s4xQmMXPVGfrVCVhmUf9inxPUpkU3M/2t
         PTmPrvTjqqqaH3FVJv4QFGPQCnA/zX0GfbzT1uovM5mEzLi+rdNRkb5gbrqsfulIun+i
         QQep/3BmKBOuOjuNMth0F0T+7JO8LtFprTEuz7QfF5HrqHgTZZ5l1DRnFT7uxhK7Ms67
         PeoP98i8zlEEHtX5WEh9CWW/ufgJ16j9hNL/8fHZMBxAofQZdwlszfwuzVDQ70EDtIBi
         sxu4OC5l5dRhy10s/wH50KAqA2+R5LUM/EQ7j5EJInTuw0QlzNn6HGliF0NXQv4XfOhL
         N2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694549567; x=1695154367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dELf8UBwcQIad2hf1gwWWXOeHH/qzD9ZkjJM29lBufQ=;
        b=A07YjEbSlya1Qbx/87+Loy0STOagSffNIB37/B1jZfSdWpQahLlIo83f5oOb6PAV3U
         KcTfjGGJocaYvZuXmVfONjgkdVgcYUnNaln3MNsod8+AdjSH67HRF0emnno++Fn9MkO7
         bsbn7lOMkFtn1er+Y/PW3x0a4R6NzsbL4g+6h1WjdyamGgoDQ8Anp3h0h06Jee6jMDVu
         idEOx3xAZ1HB1C2WLbDGFL0mTfLddBId3Y/0Q1IRWfCynkIgNi1cddR2PE5SFgfVcZwm
         dkUNOGSJCaiKULnD1M5jydeLy/rK8jrWEdYAvAy4VnQ7H2jVtYjOSUJUvI/xy7d3ZUe1
         gDxg==
X-Gm-Message-State: AOJu0YzESau+hTkRDqejwoCUg02Gxz5nzGnCNZweCEOBJB48fnr/iZRp
	rB8JWdR4cIM/ku5fKiILtOP5EaQNMiBlme7x0asi7Q==
X-Google-Smtp-Source: AGHT+IFA71O/TusvmPfckZ425fl5twMGsWNyTgKIYB+dpo1zBfMhnPynfQtMXv5q68jWEe7bLYuGJjBOKblkkuDYSPs=
X-Received: by 2002:a17:907:2cf6:b0:9a9:f09d:7c10 with SMTP id
 hz22-20020a1709072cf600b009a9f09d7c10mr258133ejc.11.1694549566970; Tue, 12
 Sep 2023 13:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
 <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 12 Sep 2023 13:12:35 -0700
Message-ID: <CAFhGd8r9Ow2xmJ++apef0rn2DHBhKm9BvfLooMTqzyaOhqbEgQ@mail.gmail.com>
Subject: Re: [PATCH] um,ethertap: refactor deprecated strncpy
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_131253_008501_D88CFBEE 
X-CRM114-Status: GOOD (  32.68  )
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTI6MzbigK9BTSBHZWVydCBVeXR0ZXJob2V2ZW4KPGdl
ZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToKPgo+IEhpIEp1c3RpbiwKPgo+IFRoYW5rcyBmb3Ig
eW91ciBwYXRjaCEKPgo+IE9uIE1vbiwgU2VwIDExLCAyMDIzIGF0IDc6NTPigK9QTSBKdXN0aW4g
U3RpdHQgPGp1c3RpbnN0aXR0QGdvb2dsZS5jb20+IHdyb3RlOgo+ID4gYHN0cm5jcHlgIGlzIGRl
cHJlY2F0ZWQgZm9yIHVzZSBvbiBOVUwtdGVybWluYXRlZCBkZXN0aW5hdGlvbiBzdHJpbmdzIFsx
XS4KPiA+Cj4gPiBgZ2F0ZV9idWZgIHNob3VsZCBhbHdheXMgYmUgTlVMLXRlcm1pbmF0ZWQgYW5k
IGRvZXMgbm90IHJlcXVpcmUKPiA+IE5VTC1wYWRkaW5nLiBJdCBpcyB1c2VkIGFzIGEgc3RyaW5n
IGFyZyBpbnNpZGUgYW4gYXJndiBhcnJheSBnaXZlbiB0bwo+Cj4gQ2FuIHlvdSBwbGVhc2UgZXhw
bGFpbiB3aHkgaXQgZG9lcyBub3QgcmVxdWlyZSBOVUwtcGFkZGluZz8KPiBJdCBsb29rcyBsaWtl
IHRoaXMgYnVmZmVyIGlzIHBhc3NlZCBldmVudHVhbGx5IHRvIGEgdXNlciBzcGFjZQo+IGFwcGxp
Y2F0aW9uLCB0aHVzIHBvc3NpYmx5IGxlYWtpbmcgdW5pbml0aWFsaXplZCBzdGFjayBkYXRhLgoK
SXQgbG9va3MgbGlrZSBpdCdzIGJlaW5nIHBhc3NlZCBhcyBhIGxpc3Qgb2YgY29tbWFuZC1saW5l
IGFyZ3VtZW50cyBpbgpgcnVuX2hlbHBlcigpYC4gU2hvdWxkIHRoaXMgYmUgTlVMLXBhZGRlZCBk
dWUgdG8gaXRzIGV2ZW50dWFsIHVzZSBpbgp1c2VyIHNwYWNlPyBJZiB3ZSB0aGluayB5ZXMgSSBj
YW4gc2VuZCBhIHYyLiBUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMKb3V0LgoKCj4KPiA+IGBydW5f
aGVscGVyKClgLiBEdWUgdG8gdGhpcywgbGV0J3MgdXNlIGBzdHJzY3B5YCBhcyBpdCBndWFyYW50
ZWVzCj4gPiBOVUwtdGVybWluYXRlZCBvbiB0aGUgZGVzdGluYXRpb24gYnVmZmVyIHByZXZlbnRp
bmcgcG90ZW50aWFsIGJ1ZmZlcgo+ID4gb3ZlcnJlYWRzIFsyXS4KPiA+Cj4gPiBUaGlzIGV4YWN0
IGludm9jYXRpb24gd2FzIGNoYW5nZWQgZnJvbSBgc3RyY3B5YCB0byBgc3RybmNweWAgaW4gY29t
bWl0Cj4gPiA3ODc5YjFkOTRiYWRiICgidW0sZXRoZXJ0YXA6IHVzZSBzdHJuY3B5IikgYmFjayBp
biAyMDE1LiBMZXQncyBjb250aW51ZQo+ID4gaGFyZGVuaW5nIG91ciBgc3RyKmNweWAgYXBpcyBh
bmQgdXNlIHRoZSBuZXdlciBhbmQgc2FmZXIgYHN0cnNjcHlgIQo+ID4KPiA+IExpbms6IHd3dy5r
ZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2RlcHJlY2F0ZWQuaHRtbCNzdHJuY3B5
LW9uLW51bC10ZXJtaW5hdGVkLXN0cmluZ3NbMV0KPiA+IExpbms6IGh0dHBzOi8vbWFucGFnZXMu
ZGViaWFuLm9yZy90ZXN0aW5nL2xpbnV4LW1hbnVhbC00Ljgvc3Ryc2NweS45LmVuLmh0bWwgWzJd
Cj4gPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvOTAKPiA+IENj
OiBsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwub3JnCj4gPiBDYzogS2VlcyBDb29rIDxrZWVz
Y29va0BjaHJvbWl1bS5vcmc+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKdXN0aW4gU3RpdHQgPGp1c3Rp
bnN0aXR0QGdvb2dsZS5jb20+Cj4gPiAtLS0KPiA+ICBhcmNoL3VtL29zLUxpbnV4L2RyaXZlcnMv
ZXRoZXJ0YXBfdXNlci5jIHwgMiArLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3VtL29zLUxpbnV4L2Ry
aXZlcnMvZXRoZXJ0YXBfdXNlci5jIGIvYXJjaC91bS9vcy1MaW51eC9kcml2ZXJzL2V0aGVydGFw
X3VzZXIuYwo+ID4gaW5kZXggOTQ4MzAyMWQ4NmRkLi4zMzYzODUxYTRhZTggMTAwNjQ0Cj4gPiAt
LS0gYS9hcmNoL3VtL29zLUxpbnV4L2RyaXZlcnMvZXRoZXJ0YXBfdXNlci5jCj4gPiArKysgYi9h
cmNoL3VtL29zLUxpbnV4L2RyaXZlcnMvZXRoZXJ0YXBfdXNlci5jCj4gPiBAQCAtMTA1LDcgKzEw
NSw3IEBAIHN0YXRpYyBpbnQgZXRhcF90cmFtcChjaGFyICpkZXYsIGNoYXIgKmdhdGUsIGludCBj
b250cm9sX21lLAo+ID4gICAgICAgICBzcHJpbnRmKGRhdGFfZmRfYnVmLCAiJWQiLCBkYXRhX3Jl
bW90ZSk7Cj4gPiAgICAgICAgIHNwcmludGYodmVyc2lvbl9idWYsICIlZCIsIFVNTF9ORVRfVkVS
U0lPTik7Cj4gPiAgICAgICAgIGlmIChnYXRlICE9IE5VTEwpIHsKPiA+IC0gICAgICAgICAgICAg
ICBzdHJuY3B5KGdhdGVfYnVmLCBnYXRlLCAxNSk7Cj4gPiArICAgICAgICAgICAgICAgc3Ryc2Nw
eShnYXRlX2J1ZiwgZ2F0ZSwgc2l6ZW9mKGdhdGVfYnVmKSk7Cj4gPiAgICAgICAgICAgICAgICAg
YXJncyA9IHNldHVwX2FyZ3M7Cj4gPiAgICAgICAgIH0KPiA+ICAgICAgICAgZWxzZSBhcmdzID0g
bm9zZXR1cF9hcmdzOwo+ID4KPiA+IC0tLQo+ID4gYmFzZS1jb21taXQ6IDJkZGUxOGNkMWQ4ZmFj
NzM1ODc1ZjJlNDk4N2YxMTgxN2NjMGJjMmMKPiA+IGNoYW5nZS1pZDogMjAyMzA5MTEtc3RybmNw
eS1hcmNoLXVtLW9zLWxpbnV4LWRyaXZlcnMtZXRoZXJ0YXBfdXNlci1jLTg1OTE2MGQxM2Y1OQo+
Cj4gR3J7b2V0amUsZWV0aW5nfXMsCj4KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydAo+
Cj4gLS0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9u
ZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCj4KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRp
b25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0Cj4g
d2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBv
ciBzb21ldGhpbmcgbGlrZSB0aGF0Lgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LS0gTGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
