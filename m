Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085CCC05027
	for <linux-um@archiver.kernel.org>; Fri, 17 Feb 2023 10:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HgVJzGqMvwa6a2u69+XaBVZiBZ9hiuaErwOByttYGXA=; b=bvlGeCPcSqLf/i
	NWj/Ec91XfKj2aTg4wH0Oc1nWMDXeqdj/78WWOToOHY07kw/LxvrmmB5K2/5qvkrYQMftgc7pVRFi
	7wt+QJvGzas0twYWAw8x0Pg0kBsbwJESWthmV7M5cBFDzKyNisRedd6Zj6IJYUuCS5BsxcETNAovl
	vu2iy6fCAEJmrPr1GnaFwSNCWrBGRQ4DhoFeAvI6ifctnADmVhmYad9NKi6eAMCG509/kDgyxjraO
	HjIRktevMLXMRSJzy4JXnddj0J9XS+EP3cPfFIVHkJQotl1sKgeiGIpN4mceKGuOFeaSCkdgSEjxw
	Kd/rd/e4M1tuNtl20bZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSxkw-00Ddk2-5u; Fri, 17 Feb 2023 10:14:18 +0000
Received: from mail-qt1-f179.google.com ([209.85.160.179])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSxku-00DdjO-6c
	for linux-um@lists.infradead.org; Fri, 17 Feb 2023 10:14:17 +0000
Received: by mail-qt1-f179.google.com with SMTP id l23so369796qtj.1
        for <linux-um@lists.infradead.org>; Fri, 17 Feb 2023 02:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOGOr6R1+yExuQZ0enpT2uyFd3Cdn1vLWeA0kBTZIIk=;
        b=265oghss75umo/MkTWXETfrPEMPp0H5fiP5YzYweWhEuw1kxfhYJH3fzGiHyQJpf5o
         yt+FRr1ldetgAxvbxus4p6NczaBJCI8nV47S2DrD5O/k3iJ5db0N85rQq0ieD3C/pNtm
         lyORkdpPQirLHPZl0xr49mAeaj6IK6Yl0OsumCq8HQlHEu8g6CcJtdpI6z6jomNYSEkX
         5VfV21mvMv5UBRLq43CN53UWN7PBKJjSTGix9egvQ0fdw/sKyquPm5mjRhlQ73gDs991
         r65tfCpvXDS5FnKwwWUEBUyNPjEJeV7f0VP3kKRu+zZxcf30v2Ua9m6t6Spu5U+BRdBT
         QOeQ==
X-Gm-Message-State: AO0yUKXO3PG3dUVqZjgSj276Rb1tnn8I9Py4WG42C2UuSKmhX9Kh8xUn
	J7UsSBqB4mH1Ou8EIRr7zonyEvIf0NnS4i5v
X-Google-Smtp-Source: AK7set/r3ssEU9oKdYJehqel7Z2wC2S/VhsLhsEE9MfZgCsoVyDY4hbLy+I+PRdjhrHFcQ3BQWPPMA==
X-Received: by 2002:a05:622a:182:b0:3b9:bd77:1971 with SMTP id s2-20020a05622a018200b003b9bd771971mr267137qtw.42.1676628853472;
        Fri, 17 Feb 2023 02:14:13 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id he29-20020a05622a601d00b003bd0f0b26b0sm2202880qtb.77.2023.02.17.02.14.12
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 02:14:12 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-536566d7b16so6407217b3.8
        for <linux-um@lists.infradead.org>; Fri, 17 Feb 2023 02:14:12 -0800 (PST)
X-Received: by 2002:a0d:f347:0:b0:4fc:962d:7dc1 with SMTP id
 c68-20020a0df347000000b004fc962d7dc1mr1018541ywf.301.1676628852471; Fri, 17
 Feb 2023 02:14:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676532759.git.development@efficientek.com>
 <8a22d84e-5cf4-bf41-220e-dc5e48fb2fc3@siemens.com> <20230216144001.e1a9dea15a6c4f93b7b8a442@linux-foundation.org>
 <283287920.144364.1676588078240.JavaMail.zimbra@nod.at> <20230216153309.8b551086ed3a5015a7135957@linux-foundation.org>
In-Reply-To: <20230216153309.8b551086ed3a5015a7135957@linux-foundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Feb 2023 11:14:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWdQH=o9XNAj4YpTA8G7JMKPe+CJSCG2bRf_6H-u50PZg@mail.gmail.com>
Message-ID: <CAMuHMdWdQH=o9XNAj4YpTA8G7JMKPe+CJSCG2bRf_6H-u50PZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Glenn Washburn <development@efficientek.com>, Kieran Bingham <kbingham@kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_021416_292069_46E50D9F 
X-CRM114-Status: GOOD (  21.30  )
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

SGkgQW5kcmV3LAoKT24gRnJpLCBGZWIgMTcsIDIwMjMgYXQgMTI6MzMgQU0gQW5kcmV3IE1vcnRv
bgo8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gT24gVGh1LCAxNiBGZWIgMjAy
MyAyMzo1NDozOCArMDEwMCAoQ0VUKSBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0
PiB3cm90ZToKPiA+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPiA+ID4gVm9uOiAi
QW5kcmV3IE1vcnRvbiIgPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+Cj4gPiA+IFRoYW5rcywg
YnV0IEknbSBub3Qgc3Vic2NyaWJlZCB0byBsaW51eC11bSBhbmQgbXkgdXN1YWwKPiA+ID4gZ2V0
LWl0LWZyb20tbGttbCBkaWRuJ3Qgd29yay4KPiA+ID4KPiA+ID4gQ291bGQgd2UgcGxlYXNlIGhh
dmUgYSByZXNlbmQsIHdpdGggYSBjYyB0byBsaW51eC1rZXJuZWw/Cj4gPgo+ID4gWW91IGNhbiBh
bHNvIGdldCB0aGUgcGF0Y2hlcyBpbiBtYm94IGZvcm1hdCBmcm9tOgo+ID4gaHR0cHM6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXVtL2xpc3QvP3Nlcmllcz0zNDIyMTIKCkFu
ZCBmcm9tIHRoZXJlLCB5b3UgY2FuIGdldCB0aGUgTWVzc2FnZS1JRHMsIGFuZCB1c2UgbG9yZToK
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci82ODNkMTBlNzUyY2Q0ODUyYWM2MmVmM2NjM2U5YTY5
NzJhMDE3YmRmLjE2NzY1MzI3NTkuZ2l0LmRldmVsb3BtZW50QGVmZmljaWVudGVrLmNvbQpvciBi
NDoKYjQgbWJveCA2ODNkMTBlNzUyY2Q0ODUyYWM2MmVmM2NjM2U5YTY5NzJhMDE3YmRmLjE2NzY1
MzI3NTkuZ2l0LmRldmVsb3BtZW50QGVmZmljaWVudGVrLmNvbQpiNCBhbSA2ODNkMTBlNzUyY2Q0
ODUyYWM2MmVmM2NjM2U5YTY5NzJhMDE3YmRmLjE2NzY1MzI3NTkuZ2l0LmRldmVsb3BtZW50QGVm
ZmljaWVudGVrLmNvbQoKPiBUaGFua3MsIGJ1dC4uCj4KPiAtIENhbid0IGRvIHJlcGx5LXRvLWFs
bCBpZiBJIGhhdmUgY29tbWVudHMKPiAtIENhbid0IGNvbGxlY3QgcGVvcGxlJ3MgZm9sbG93dXAg
YWNrcyBhbmQgcmV2aWV3IGNvbW1lbnRzCj4gLSBObyBMaW5rIHRhZwoKR3J7b2V0amUsZWV0aW5n
fXMsCgogICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoKLS0gCkdlZXJ0IFV5dHRlcmhvZXZl
biAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4
ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJ
IGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0
cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QK
bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
