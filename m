Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5839C6FD1F
	for <linux-um@archiver.kernel.org>; Sun, 12 Mar 2023 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+oytR3hzweLzmF2tgG920Tk6Q1cacvNPKAnNn39Kjpo=; b=v35ySIDJWXranO
	fRgkB63WAEH8ZW5dzkd/xIaaoiqvwvrQfc2ofLseow42f52NPycm9pLUQgIIsOkxJ6Nr7JzYHen8c
	rIysnwxMqlwh0wqAXt7qww/doPLJbkkT+V81JEZym8yghAHC0C4BFScPRuEdw/RD7bEBrbZglgZ+H
	/tqlw3Ror9jtNOEL01BTJgYtCDiZteubN1Vpwcp9WviUXAvjz3gzLZ4KVodUE+vkaBUkrAR8Ul2iG
	W6TkkOfHB2/SZfeU1riVRfxwEIGRqi7ycZLUG57st8HUiTeX0C6qBpzPJZUX930+Zp2ZtIc0VwEre
	dlmCi00xLAXkaBcQiqdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbK2j-002AcU-2d; Sun, 12 Mar 2023 11:39:13 +0000
Received: from mail-qt1-f174.google.com ([209.85.160.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbK2f-002Aay-Gm
	for linux-um@lists.infradead.org; Sun, 12 Mar 2023 11:39:11 +0000
Received: by mail-qt1-f174.google.com with SMTP id cf14so10507737qtb.10
        for <linux-um@lists.infradead.org>; Sun, 12 Mar 2023 04:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678621145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHsU4w7j+rX05CyivyZKDHXiX4NthxonKHXgo0Q46rs=;
        b=RpZAUfeMW9xkQHHWIglzzucoTnL4xGs3KuNvtMdUhPkwhVlo5aGapijnsKTsgN4ujN
         SgROg5Lx57JSDpz66E7vc/iMs7YXrrdI9RdOQbcxXJ7aXPwoVF9Nb9lJD/WVi+EZ7j99
         UsuUQEZqLT28CRZKbx+n3pdbUOI0nNtwFNqUCMu6PgdX1aDa0av+bhtLsip0rK7zxtwk
         jClyNPC+GvhKY1PiV5yOlldPvPDJT7Z0mR2Cy60r1aiqYtzyNAohGFntxqKL33SXJqos
         YS9lkhoVKhiRbCQGuby4SUayjizb0Lav11sC/7i8iy4ddFDoeCxV+zg4+HALckIsHMgM
         zT6w==
X-Gm-Message-State: AO0yUKXGDaAe7X/2J1WFCED2mYl3Qj4Rsahz+rUxx7G99HQ4LXVck5bE
	sahnURCx2gY0i75MnQQvGQHzWfbS7k9WDQ==
X-Google-Smtp-Source: AK7set/8HdY7Uou18l7VGf84p5IHKhUk+1lpAospsA0D3lAZCogmCrk60tcN8+0xaiX3L2v3fFHp6Q==
X-Received: by 2002:ac8:5b08:0:b0:3bf:d490:f218 with SMTP id m8-20020ac85b08000000b003bfd490f218mr55991275qtw.43.1678621144725;
        Sun, 12 Mar 2023 04:39:04 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id t21-20020a374615000000b0071d0f1d01easm3377604qka.57.2023.03.12.04.39.04
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 04:39:04 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-541a05e4124so2889427b3.1
        for <linux-um@lists.infradead.org>; Sun, 12 Mar 2023 04:39:04 -0700 (PDT)
X-Received: by 2002:a81:ad50:0:b0:541:8a9a:5445 with SMTP id
 l16-20020a81ad50000000b005418a9a5445mr1295851ywk.5.1678621143951; Sun, 12 Mar
 2023 04:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230312052624.8402-1-rdunlap@infradead.org>
In-Reply-To: <20230312052624.8402-1-rdunlap@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 12 Mar 2023 12:38:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXia3d8dV1EyNcmgA=k_osEAkHZkA4ya9xjzyEVO4YjGQ@mail.gmail.com>
Message-ID: <CAMuHMdXia3d8dV1EyNcmgA=k_osEAkHZkA4ya9xjzyEVO4YjGQ@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_cs5536: don't build on UML
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>, linux-ide@vger.kernel.org, 
	linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230312_043909_583584_A61D82DE 
X-CRM114-Status: GOOD (  18.65  )
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

SGkgUmFuZHksCgpPbiBTdW4sIE1hciAxMiwgMjAyMyBhdCA2OjI24oCvQU0gUmFuZHkgRHVubGFw
IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+IFNpbWlsYXIgdG8gMjJlZWJhYTYzMWM0
ICgiYXRhOiBwYXRhX2NzNTUzNTogRG9uJ3QgYnVpbGQgb24gVU1MIiksCj4gcHJldmVudCBwYXRh
X2NzNTUzNiBmcm9tIGJ1aWxkaW5nIG9uIFVNTCBzaW5jZSBpdCByZWZlcmVuY2VzCj4gc3ltYm9s
cyB0aGF0IGFyZSBub3QgcHJlc2VudCB3aGVuIGJ1aWxkaW5nIFg4Nl8zMi9pMzg2IGFsbG1vZGNv
bmZpZy4KPgo+IEVSUk9SOiBtb2Rwb3N0OiAiX190cmFjZXBvaW50X3dyaXRlX21zciIgW2RyaXZl
cnMvYXRhL3BhdGFfY3M1NTM2LmtvXSB1bmRlZmluZWQhCj4gRVJST1I6IG1vZHBvc3Q6ICJkb190
cmFjZV93cml0ZV9tc3IiIFtkcml2ZXJzL2F0YS9wYXRhX2NzNTUzNi5rb10gdW5kZWZpbmVkIQo+
IEVSUk9SOiBtb2Rwb3N0OiAiX190cmFjZXBvaW50X3JlYWRfbXNyIiBbZHJpdmVycy9hdGEvcGF0
YV9jczU1MzYua29dIHVuZGVmaW5lZCEKPiBFUlJPUjogbW9kcG9zdDogImRvX3RyYWNlX3JlYWRf
bXNyIiBbZHJpdmVycy9hdGEvcGF0YV9jczU1MzYua29dIHVuZGVmaW5lZCEKPgo+IFNpZ25lZC1v
ZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPgoKVGhhbmtzIGZvciB5
b3VyIHBhdGNoIQoKPiAtLS0gYS9kcml2ZXJzL2F0YS9LY29uZmlnCj4gKysrIGIvZHJpdmVycy9h
dGEvS2NvbmZpZwo+IEBAIC02NTAsNiArNjUwLDcgQEAgY29uZmlnIFBBVEFfQ1M1NTM1Cj4gIGNv
bmZpZyBQQVRBX0NTNTUzNgo+ICAgICAgICAgdHJpc3RhdGUgIkNTNTUzNiBQQVRBIHN1cHBvcnQi
Cj4gICAgICAgICBkZXBlbmRzIG9uIFBDSSAmJiAoWDg2XzMyIHx8IE1JUFMgfHwgQ09NUElMRV9U
RVNUKQoKSG93IGRvZXMgdGhpcyB3b3JrIG9uIE1JUFM/Ck9oLCB0aGUgTVNSIGZ1bmN0aW9uYWxp
dHkgaW5zaWRlIHRoZSBkcml2ZXIgZGVwZW5kcyBvbiBDT05GSUdfWDg2XzMyLgpQZXJoYXBzIHRo
aXMgY2FuIGJlIGZpeGVkIGJldHRlciBmb3IgYWxsIHVzZXJzIGluc2lkZQphcmNoL3g4Ni9pbmNs
dWRlL2FzbS9tc3IuaD8KCj4gKyAgICAgICBkZXBlbmRzIG9uICFVTUwKPiAgICAgICAgIGhlbHAK
PiAgICAgICAgICAgVGhpcyBvcHRpb24gZW5hYmxlcyBzdXBwb3J0IGZvciB0aGUgQU1EIENTNTUz
Ngo+ICAgICAgICAgICBjb21wYW5pb24gY2hpcCB1c2VkIHdpdGggdGhlIEdlb2RlIExYIHByb2Nl
c3NvciBmYW1pbHkuCgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBi
ZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0
aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3
aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0g
TGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
