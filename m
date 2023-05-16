Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E00C77B7A
	for <linux-um@archiver.kernel.org>; Tue, 16 May 2023 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7IZok6+9tRvNvsxl1+3AfeKnNrM1R9V4Ky5yNXdZrbo=; b=BZBj97QAI7wNCS
	uLZs360seHc3fQCpCVdpac63hef8FFU0upR8ICs+BMPLNHb6BIfePrDt4NoQZWP87//WH/eI50hbu
	MFzA4jKjcRYB7hLS/WbMyaWko8errZIAjrl2cjOn7kqx6czwrSYMbm+Fj4BhLShT4bndrmwZc2NZH
	7+UljhhBrXwOCK4D6+KPfueaPfWr/YNQKp+8x9DebhiIiN1us7UcWVbfgy3u6I0EGoNWLp0RJnMfm
	HjkEa9+1IXIiyKfEjqnx3gZNMvj3fyiVBf/glvYl68T2vCxIkldESV4xNHonWIvYrWHtOc3tVysLv
	liGE+JPsRwou0auhf/pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyqLE-004uvY-2g;
	Tue, 16 May 2023 08:47:32 +0000
Received: from mail-yw1-f170.google.com ([209.85.128.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyqLC-004utc-1h
	for linux-um@lists.infradead.org;
	Tue, 16 May 2023 08:47:31 +0000
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-55a829411b5so127782747b3.1
        for <linux-um@lists.infradead.org>; Tue, 16 May 2023 01:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684226846; x=1686818846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5Fr1JqN2Ov4AHR8zy4YwIGPB2ZpmLeycQl8ETfUv/E=;
        b=X+s+1rC9DOy1WZNzxYrmcisG1EDRhX/xCn2Llt9d1u3P+e78PYmOvPfVS4hUb6YbeA
         oES+epc4vzvLH77T2tKvVKq8/XCbQMa2L5qhAvV814YXYFdyQgPrguiD75qPgiqGPKwP
         mDkKLP8PYqsyAvrVTu1A5qyEFh3maJ90UdQY3GA0HmtWYS1ztAqFmmxZD7VIIeuF3zaO
         eQl2Ym45basSJTaSBq9JsyFFMb8fL1lyn4r6vSP9cpxl8mfAIuqw62yHfnObH4HRmwg5
         nP1IKHBlEtpH5qyLikEeYz6fSRM9ZwvRZIODCrgAQID0TrJUHIBrcqE91HpAIhyQXqkE
         x2xA==
X-Gm-Message-State: AC+VfDzBWIG0SP5Zl+k2XeH0IDAnjiqJWowvS0uOi3vVo9geLVcGYgVG
	5FkbIZX+Gl/ZC95SF3jWZDdjXRwPuyjk2w==
X-Google-Smtp-Source: ACHHUZ4Q5VfLtq1lm+IjO6ebD5G0N3kz4LI6eLYZM51QoMpTbPQoJAh90zqT2BSdikOWqiBd6oURrA==
X-Received: by 2002:a0d:ddd7:0:b0:55a:4bd3:f73b with SMTP id g206-20020a0dddd7000000b0055a4bd3f73bmr37696787ywe.10.1684226846040;
        Tue, 16 May 2023 01:47:26 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id o8-20020a817308000000b00559f9e9eabcsm448041ywc.98.2023.05.16.01.47.24
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:47:25 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-55a829411b5so127782407b3.1
        for <linux-um@lists.infradead.org>; Tue, 16 May 2023 01:47:24 -0700 (PDT)
X-Received: by 2002:a0d:d4c3:0:b0:55a:9d84:2e4e with SMTP id
 w186-20020a0dd4c3000000b0055a9d842e4emr32699001ywd.18.1684226844519; Tue, 16
 May 2023 01:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161707.203549282@linuxfoundation.org> <20230515161707.460071056@linuxfoundation.org>
In-Reply-To: <20230515161707.460071056@linuxfoundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 May 2023 10:47:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjkZ-FAKrwQkoyZRHLpyvaVYT0NvAUwaCs+30qC2VZmA@mail.gmail.com>
Message-ID: <CAMuHMdWjkZ-FAKrwQkoyZRHLpyvaVYT0NvAUwaCs+30qC2VZmA@mail.gmail.com>
Subject: Re: [PATCH 4.19 007/191] IMA: allow/fix UML builds
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, Fabio Estevam <festevam@gmail.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Mimi Zohar <zohar@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_014730_560930_93C588DB 
X-CRM114-Status: GOOD (  21.87  )
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

SGkgR3JlZywKCk9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDY6MznigK9QTSBHcmVnIEtyb2FoLUhh
cnRtYW4KPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPiBGcm9tOiBSYW5keSBE
dW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KPgo+IGNvbW1pdCA2NDRmMTc0MTJmNWFjZjAx
YTE5YWY5ZDA0YTkyMTkzN2EyYmM4NmM2IHVwc3RyZWFtLgo+Cj4gVU1MIHN1cHBvcnRzIEhBU19J
T01FTSBzaW5jZSAwYmJhZGFmZGM0OWQgKHVtOiBhbGxvdyBkaXNhYmxpbmcKPiBOT19JT01FTSku
CgowYmJhZGFmZGM0OWQgaXMgaW4gdjUuMTQuCldhcyBpdCBiYWNrcG9ydGVkIHRvIG9sZGVyIHZl
cnNpb25zPwoKPgo+IEN1cnJlbnQgSU1BIGJ1aWxkIG9uIFVNTCBmYWlscyBvbiBhbGxtb2Rjb25m
aWcgKHdpdGggVENHX1RQTT1tKToKPgo+IGxkOiBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9x
dWV1ZS5vOiBpbiBmdW5jdGlvbiBgaW1hX2FkZF90ZW1wbGF0ZV9lbnRyeSc6Cj4gaW1hX3F1ZXVl
LmM6KC50ZXh0KzB4MmQ5KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdHBtX3Bjcl9leHRlbmQn
Cj4gbGQ6IHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2luaXQubzogaW4gZnVuY3Rpb24gYGlt
YV9pbml0JzoKPiBpbWFfaW5pdC5jOiguaW5pdC50ZXh0KzB4NDNmKTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgdHBtX2RlZmF1bHRfY2hpcCcKPiBsZDogc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9p
bWFfY3J5cHRvLm86IGluIGZ1bmN0aW9uIGBpbWFfY2FsY19ib290X2FnZ3JlZ2F0ZV90Zm0nOgo+
IGltYV9jcnlwdG8uYzooLnRleHQrMHgxMDQ0KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdHBt
X3Bjcl9yZWFkJwo+IGxkOiBpbWFfY3J5cHRvLmM6KC50ZXh0KzB4MTBkOCk6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYHRwbV9wY3JfcmVhZCcKPgo+IE1vZGlmeSB0aGUgSU1BIEtjb25maWcgZW50
cnkgc28gdGhhdCBpdCBzZWxlY3RzIFRDR19UUE0gaWYgSEFTX0lPTUVNCj4gaXMgc2V0LCByZWdh
cmRsZXNzIG9mIHRoZSBVTUwgS2NvbmZpZyBzZXR0aW5nLgo+IFRoaXMgdXBkYXRlcyBUQ0dfVFBN
IGZyb20gPW0gdG8gPXkgYW5kIGZpeGVzIHRoZSBsaW5rZXIgZXJyb3JzLgo+Cj4gRml4ZXM6IGY0
YTAzOTFkZmE5MSAoImltYTogZml4IEtjb25maWcgZGVwZW5kZW5jaWVzIikKPiBDYzogU3RhYmxl
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY1LjE0KwoKInY1LjE0KyIKCj4gU2lnbmVkLW9m
Zi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4gQ2M6IEZhYmlvIEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD4KPiBDYzogQW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3Jl
eXMuY29tPgo+IENjOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+
IENjOiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gU2lnbmVkLW9mZi1ieTogTWltaSBa
b2hhciA8em9oYXJAbGludXguaWJtLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhh
cnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgo+IC0tLQo+ICBzZWN1cml0eS9pbnRl
Z3JpdHkvaW1hL0tjb25maWcgfCAgICAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+Cj4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9LY29u
ZmlnCj4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9LY29uZmlnCj4gQEAgLTcsNyArNyw3
IEBAIGNvbmZpZyBJTUEKPiAgICAgICAgIHNlbGVjdCBDUllQVE9fSE1BQwo+ICAgICAgICAgc2Vs
ZWN0IENSWVBUT19TSEExCj4gICAgICAgICBzZWxlY3QgQ1JZUFRPX0hBU0hfSU5GTwo+IC0gICAg
ICAgc2VsZWN0IFRDR19UUE0gaWYgSEFTX0lPTUVNICYmICFVTUwKPiArICAgICAgIHNlbGVjdCBU
Q0dfVFBNIGlmIEhBU19JT01FTQo+ICAgICAgICAgc2VsZWN0IFRDR19USVMgaWYgVENHX1RQTSAm
JiBYODYKPiAgICAgICAgIHNlbGVjdCBUQ0dfQ1JCIGlmIFRDR19UUE0gJiYgQUNQSQo+ICAgICAg
ICAgc2VsZWN0IFRDR19JQk1WVFBNIGlmIFRDR19UUE0gJiYgUFBDX1BTRVJJRVMKCkdye29ldGpl
LGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0
ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxp
bnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBl
b3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91
cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
