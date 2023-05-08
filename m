Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7361DC7EE2A
	for <linux-um@archiver.kernel.org>; Mon,  8 May 2023 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xb5YrhKFWtsrQ3YKf002R+07+Wwjl8nkuplLnUmVhPE=; b=iLOUAt4SR4XtOC
	DYANPuvDj49K5ujVHxBZLSxoFnstQM7LFk+1nifAEbcSz9z74zuUDFQrGWrsupFS/AZQqG1TSAsqI
	idH9q7JtOGOAHSZ/WO16TU3dJsyBIY+NRMwyoAQNNjXk79mqr++/sZRfjrBaNYtBLGZXGCzjuQX56
	z6VxlNDEaqEcoS6m2ceiHMU0SwNF9/K+LVneeDVvsFZOdl8VwNY60/z36+vSw/Ak/q10dtJggL8WW
	zisC+cwHX/1D6vKcvvGq2GJGNaWV2F3l726lkkwyhPRgMcQCQqSzYPGAJF7+nhMD5Aa5pvEWN96bQ
	S1pxddaucibhBNqPIXlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pw2rT-000sCn-2P;
	Mon, 08 May 2023 15:33:15 +0000
Received: from mail-yw1-f170.google.com ([209.85.128.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pw2rP-000sBL-1K;
	Mon, 08 May 2023 15:33:14 +0000
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-55a00da4e53so83802937b3.0;
        Mon, 08 May 2023 08:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683559989; x=1686151989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X96dgxdvJ9o915QcPKTh2Rv+glavrTF5xrnJD83Sv1c=;
        b=ZV1rsZBlJUGN+3j/3ur6AhBC/1YbeaL+LSJPvfpRyThRRZ3aJADHg0v7e0/jChC4bJ
         SJeQLztFDK5zuIsVTJ+sKc+8+64sxkbCJwsIh8giwKld48ZjSvgK7hwSpo1/DDi77nrP
         nRCzXfQsVcDGSqNMOVq7AWqo2RvQ3BcHt3HGQ7ra1yq7/KZFqwwXcyKmJlo/lLE03oFy
         VhBOahyrAnKot+unHOA1dyh3Yk/vqsj8ohWqPDDYWp1ikQwXRWB64bh/usZ8ge6VzR5I
         rgp9NdMdtygboQcTpE/GGgxiqCN1p+MLqdctJKEqrXfB0ZjHjUbvJz7T/m3z4tcgQsiI
         hyuw==
X-Gm-Message-State: AC+VfDzRfxKErieuqFEyZ9mE0ipqZr/pbKWqf7tF65/xXKkkdftNa6LE
	7q/gisRoJMqwugBNDvBb+CfHCcuMc73Zdg==
X-Google-Smtp-Source: ACHHUZ6hbZyur0o7WJhOQgmDTS1+4vxrVS+rlcfLxXNiPdLMuZFpBgAXLt1crtqg0tjCenEaZUS2ZQ==
X-Received: by 2002:a0d:d691:0:b0:539:1b13:3d64 with SMTP id y139-20020a0dd691000000b005391b133d64mr11231919ywd.48.1683559989409;
        Mon, 08 May 2023 08:33:09 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id k205-20020a816fd6000000b0055a3420b256sm2579169ywc.55.2023.05.08.08.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 08:33:07 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso7293508276.1;
        Mon, 08 May 2023 08:33:05 -0700 (PDT)
X-Received: by 2002:a25:5015:0:b0:ba2:6aea:2b8 with SMTP id
 e21-20020a255015000000b00ba26aea02b8mr5025776ybb.3.1683559985056; Mon, 08 May
 2023 08:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
 <20230508115727.2597864-1-geert@linux-m68k.org> <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
 <mafs035466ebk.fsf@amazon.de>
In-Reply-To: <mafs035466ebk.fsf@amazon.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 May 2023 17:32:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVaeS_j5=o7Nu5oh8pOY4uggTpy2yd9P9yGMu6iNWiEWQ@mail.gmail.com>
Message-ID: <CAMuHMdVaeS_j5=o7Nu5oh8pOY4uggTpy2yd9P9yGMu6iNWiEWQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.4-rc1
To: Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Darrick J. Wong" <djwong@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	linux-um@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
	sparclinux@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_083311_452018_DFD8B328 
X-CRM114-Status: GOOD (  23.93  )
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

SGkgUHJhdHl1c2gsCgpPbiBNb24sIE1heSA4LCAyMDIzIGF0IDU6MTnigK9QTSBQcmF0eXVzaCBZ
YWRhdiA8cHJhdHl1c2hAa2VybmVsLm9yZz4gd3JvdGU6Cj4gT24gTW9uLCBNYXkgMDggMjAyMywg
R2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+ID4gT24gTW9uLCA4IE1heSAyMDIzLCBHZWVydCBV
eXR0ZXJob2V2ZW4gd3JvdGU6Cj4gPj4gQmVsb3cgaXMgdGhlIGxpc3Qgb2YgYnVpbGQgZXJyb3Iv
d2FybmluZyByZWdyZXNzaW9ucy9pbXByb3ZlbWVudHMgaW4KPiA+PiB2Ni40LXJjMVsxXSBjb21w
YXJlZCB0byB2Ni4zWzJdLgo+ID4+Cj4gPj4gU3VtbWFyaXplZDoKPiA+PiAgLSBidWlsZCBlcnJv
cnM6ICs5Ly0xNgo+ID4+ICAtIGJ1aWxkIHdhcm5pbmdzOiArMS8tMTQzOQo+ID4+Cj4gPj4gSGFw
cHkgZml4aW5nISA7LSkKPiA+Pgo+ID4+IFRoYW5rcyB0byB0aGUgbGludXgtbmV4dCB0ZWFtIGZv
ciBwcm92aWRpbmcgdGhlIGJ1aWxkIHNlcnZpY2UuCj4gPj4KPiA+PiBbMV0gaHR0cDovL2tpc3Nr
Yi5lbGxlcm1hbi5pZC5hdS9raXNza2IvYnJhbmNoL2xpbnVzL2hlYWQvYWM5YTc4NjgxYjkyMTg3
NzUxODc2M2JhMGU4OTIwMjI1NDM0OWQxYi8gKGFsbCAxNTIgY29uZmlncykKPiA+PiBbMl0gaHR0
cDovL2tpc3NrYi5lbGxlcm1hbi5pZC5hdS9raXNza2IvYnJhbmNoL2xpbnVzL2hlYWQvNDU3Mzkx
YjAzODAzMzVkNWU5YTViYWJkZWM5MGFjNTM5MjhiMjNiNC8gKGFsbCAxNTIgY29uZmlncykKPiA+
Pgo+ID4+Cj4gWy4uLl0KPiA+Cj4gPj4gICsgL2tpc3NrYi9zcmMvZHJpdmVycy9tdGQvc3BpLW5v
ci9zcGFuc2lvbi5jOiBlcnJvcjogJ29wJyBpcyB1c2VkIHVuaW5pdGlhbGl6ZWQgWy1XZXJyb3I9
dW5pbml0aWFsaXplZF06ICA9PiA0OTU6MjcsIDM2NDoyNwo+Cj4gSG1tLCBJIGRvbid0IGdldCB3
aHkgd2UgZ2V0IHRoaXMgd2FybmluZy4gTGluZSA0OTUgaXMgaW4KPiBzMjVmczI1NnRfcG9zdF9i
ZnB0X2ZpeHVwKCkuIEl0IGRlY2xhcmVzICdvcCcgYW5kIHRoZW4gaXQgZG9lcwo+Cj4gICAgIG9w
ID0gKHN0cnVjdCBzcGlfbWVtX29wKQo+ICAgICAgICAgQ1lQUkVTU19OT1JfUkRfQU5ZX1JFR19P
UChub3ItPnBhcmFtcy0+YWRkcl9tb2RlX25ieXRlcywKPiAgICAgICAgICAgICAgICAgICAgICAg
U1BJTk9SX1JFR19DWVBSRVNTX0FSQ0ZOLCAxLAo+ICAgICAgICAgICAgICAgICAgICAgICBub3It
PmJvdW5jZWJ1Zik7Cj4gICAgIHJldCA9IHNwaV9ub3JfcmVhZF9hbnlfcmVnKG5vciwgJm9wLCBu
b3ItPnJlZ19wcm90byk7Cj4KPgo+IHdoaWNoIGluaXRpYWxpemVzICdvcCcgYmVmb3JlIHVzaW5n
IGl0LiBTYW1lIHdpdGggbGluZSAzNjQgd2hpY2ggaXMgaW4KPiB0aGUgZnVuY3Rpb24gY3lwcmVz
c19ub3Jfc2V0X2FkZHJfbW9kZV9uYnl0ZXMoKS4KCkkgc3VzcGVjdCBnY2MtMTIgYmVjYW1lIHN0
cmljdGVyLCBhbmQgbm90IGFsbCBtZW1iZXJzIG9mIHRoZSB1bmlvbgphcmUgaW5pdGlhbGl6ZWQu
Cgo+IEV2ZW4gdGhlIGNvbXBpbGVyIHdhcm5pbmdzIFswXSBkb24ndCBzZWVtIHRvIG1ha2UgbXVj
aCBzZW5zZSB0byBtZToKPgo+ICAgICAva2lzc2tiL3NyYy9kcml2ZXJzL210ZC9zcGktbm9yL3Nw
YW5zaW9uLmM6IEluIGZ1bmN0aW9uICdzMjVmczI1NnRfcG9zdF9iZnB0X2ZpeHVwJzoKPiAgICAg
L2tpc3NrYi9zcmMvZHJpdmVycy9tdGQvc3BpLW5vci9zcGFuc2lvbi5jOjQ5NToyNzogZXJyb3I6
ICdvcCcgaXMgdXNlZCB1bmluaXRpYWxpemVkIFstV2Vycm9yPXVuaW5pdGlhbGl6ZWRdCj4gICAg
IDQ5NSB8ICAgICAgICAgc3RydWN0IHNwaV9tZW1fb3Agb3A7Cj4gICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXn4KPiAgICAgL2tpc3NrYi9zcmMvZHJpdmVycy9tdGQvc3BpLW5v
ci9zcGFuc2lvbi5jOjQ5NToyNzogbm90ZTogJ29wJyBkZWNsYXJlZCBoZXJlCj4gICAgIDQ5NSB8
ICAgICAgICAgc3RydWN0IHNwaV9tZW1fb3Agb3A7Cj4gICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXn4KPgo+IFswXSBodHRwOi8va2lzc2tiLmVsbGVybWFuLmlkLmF1L2tpc3Nr
Yi9idWlsZHJlc3VsdC8xNDkyMjA1Ny8KCkdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAg
ICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3Rz
IG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25h
bCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhh
Y2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJv
Z3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC11bQo=
