Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C604AC04A6A
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o11kaBzlxDslbyTZ/w1uipaVEdap6F+zKYT73OWtZN0=; b=QPsuqo3IF+NTuQ
	fTpYrYiczwbkmSy1lfUalMl0mr6snAmy1LzxZ+gBT2tJNgCVSrFddXgrS7perufbf6xLXAWQxcEsh
	14Q+zuYm1xmwT8gjlgERqZ+TcHpUNzUmtV13RBhLIqYmNNFLygFmDb+G2UV6Dn+iMxulyv4sQGIkP
	BI+jVRSZlm44n11tHSNIaaopgq4V9O9ywu06YgZnWzqahSigZFr3x2W+a2ralJNABSPQiy8yFFBvY
	gDc6vPOVCNiXcdb6/4rNtO9TdnYyPKWiMLSbTl9GU+avy5JdnlJO7c3SYGFg81pNDQ+MNzzdlF5k2
	RVUs+ybXTLSZqxe6T5qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEE8g-00Dv6H-1H;
	Tue, 27 Jun 2023 19:14:10 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEE8c-00Dv4G-14;
	Tue, 27 Jun 2023 19:14:07 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso2820094b3a.2;
        Tue, 27 Jun 2023 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687893243; x=1690485243;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kvHLvhv1Vboi73O1yp/Tlc9InhlPe7nOe1kq7T+MFRo=;
        b=bM9Je+tOekLovPkvT+/l7nbya5CmvdUQjXrADEm1UMcV4/Dft3yRiRDI0ZDflduo0a
         eCCHc/eGgHA3aTnPLKW75ZP3+msGkQAgAajr0fU475B6t9dnUbkeGDGaGhTQuEs9G8Em
         fP/NIDTeV8LmgxO8Ql0wOGFl7SgfrLikcvULFnS16kiPfzK7oAB1YpIUgqh/lMxpHyod
         tqWpPiE4/bUvsjhZfVbvFSWKmV4p5zoSojTJH1B4PXJkJ5GFHQt4ps0dwXEGoW/rFJ5j
         7OEFRkR/4WYv521gDAmtenL688/6yjI/zD/BFplexhWDCjqz/HwvAM7QaYSh0oWP3Dui
         ALeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687893243; x=1690485243;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvHLvhv1Vboi73O1yp/Tlc9InhlPe7nOe1kq7T+MFRo=;
        b=J27gAVbn0uWSoxFZOMpjgADx3j+Wu4KECd86bNlyX/Xp1AkxnOdojqTPZn1gf+8ZaJ
         PFV34wXmJYWIssZMhAJGHT/Lk+RmyRUVpC7UenJsM/eONZdTm1xi0+TZHoWGZu4pzAkL
         iQ7/JffB/OPmUXTGMffeNZEdZee6C3vkylL70PVm182ncQWBDt5usK4P1WKb8nJDekhn
         UmfKGpzfKrPKpsarbtf76O/JTKCfcjZxfFr4tbLGdY7qmMn1AgfjjDQb7DArHpSto9bI
         8YLRtumFzT7anIM2B6vlF/b4GFLMrLBVAhTCNfeaThM3zJBKseutKeNKE/rh978+0RWM
         x2DA==
X-Gm-Message-State: AC+VfDxhs6nxUm/My1MC8pz+RCw7615BOAXhXVEabxTk7y80ls1wmGny
	6p1YuQMeADRXBh1OYgeaMyQ=
X-Google-Smtp-Source: ACHHUZ7LJIGe+68y+/f7zW8IDz+Iq/yBUPpzssEQrXLR8wKbF9q9Wu20nywq5XNVdfXVbWMgiaxYCw==
X-Received: by 2002:a05:6a00:2490:b0:668:7209:1856 with SMTP id c16-20020a056a00249000b0066872091856mr26446249pfv.14.1687893243046;
        Tue, 27 Jun 2023 12:14:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b0065a1b05193asm5742654pfm.185.2023.06.27.12.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 12:14:02 -0700 (PDT)
Message-ID: <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
Date: Tue, 27 Jun 2023 12:14:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
In-Reply-To: <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_121406_369463_C4522E2B 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gNi8yNy8yMyAxMjoxMCwgR3VlbnRlciBSb2VjayB3cm90ZToKPiBPbiA2LzI3LzIzIDEwOjQy
LCBWaXNoYWwgTW9vbGEgd3JvdGU6Cj4+IE9uIE1vbiwgSnVuIDI2LCAyMDIzIGF0IDEwOjQ34oCv
UE0gR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PiB3cm90ZToKPj4+Cj4+PiBPbiBU
aHUsIEp1biAyMiwgMjAyMyBhdCAwMTo1NzozOFBNIC0wNzAwLCBWaXNoYWwgTW9vbGEgKE9yYWNs
ZSkgd3JvdGU6Cj4+Pj4gUGFydCBvZiB0aGUgY29udmVyc2lvbnMgdG8gcmVwbGFjZSBwZ3RhYmxl
IGNvbnN0cnVjdG9yL2Rlc3RydWN0b3JzIHdpdGgKPj4+PiBwdGRlc2MgZXF1aXZhbGVudHMuCj4+
Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgPHZpc2hhbC5tb29s
YUBnbWFpbC5jb20+Cj4+Pj4gQWNrZWQtYnk6IE1pa2UgUmFwb3BvcnQgKElCTSkgPHJwcHRAa2Vy
bmVsLm9yZz4KPj4+Cj4+PiBUaGlzIHBhdGNoIGNhdXNlcyBhbGwgbmlvczIgYnVpbGRzIHRvIGZh
aWwuCj4+Cj4+IEl0IGxvb2tzIGxpa2UgeW91IHRyaWVkIHRvIGFwcGx5IHRoaXMgcGF0Y2ggb24g
aXRzIG93bi4gVGhpcyBwYXRjaCBkZXBlbmRzCj4+IG9uIHBhdGNoZXMgMDEtMTIgb2YgdGhpcyBw
YXRjaHNldCB0byBjb21waWxlIHByb3Blcmx5LiBJJ3ZlIGNyb3NzLWNvbXBpbGVkCj4+IHRoaXMg
YXJjaGl0ZWN0dXJlIGFuZCBpdCB3b3JrZWQsIGJ1dCBsZXQgbWUga25vdyBpZiBzb21ldGhpbmcg
ZmFpbHMKPj4gd2hlbiBpdHMgYXBwbGllZCBvbiB0b3Agb2YgdGhvc2UgcGF0Y2hlcyAob3IgdGhl
IHJlc3Qgb2YgdGhlIHBhdGNoc2V0KS4KPiAKPiAKPiBObywgSSBkaWQgbm90IHRyeSB0byBhcHBs
eSB0aGlzIHBhdGNoIG9uIGl0cyBvd24uIEkgdHJpZWQgdG8gYnVpbGQgeWVzdGVyZGF5J3MKPiBw
ZW5kaW5nLWZpeGVzIGJyYW5jaCBvZiBsaW51eC1uZXh0Lgo+IAoKQSBxdWljayBjaGVjayBzaG93
cyB0aGF0IHRoZSBidWlsZCBmYWlscyB3aXRoIG5leHQtMjAyMzA2MjcuIFNlZSBsb2cgYmVsb3cu
CgpHdWVudGVyCgotLS0KCiQgZ2l0IGRlc2NyaWJlCm5leHQtMjAyMzA2MjcKJCBnaXQgZGVzY3Jp
YmUgLS1tYXRjaCAndionCnY2LjQtMTI2MDEtZzUzY2RmODY1ZjkwYgoKQnVpbGQgcmVmZXJlbmNl
OiB2Ni40LTEyNjAxLWc1M2NkZjg2NWY5MGIKQ29tcGlsZXIgdmVyc2lvbjogbmlvczItbGludXgt
Z2NjIChHQ0MpIDExLjQuMApBc3NlbWJsZXIgdmVyc2lvbjogR05VIGFzc2VtYmxlciAoR05VIEJp
bnV0aWxzKSAyLjQwCgpCdWlsZGluZyBuaW9zMjphbGxub2NvbmZpZyAuLi4gZmFpbGVkCi0tLS0t
LS0tLS0tLS0tCkVycm9yIGxvZzoKPHN0ZGluPjoxNTE5OjI6IHdhcm5pbmc6ICN3YXJuaW5nIHN5
c2NhbGwgY2xvbmUzIG5vdCBpbXBsZW1lbnRlZCBbLVdjcHBdCkluIGZpbGUgaW5jbHVkZWQgZnJv
bSBtbS9tZW1vcnkuYzo4NjoKbW0vbWVtb3J5LmM6IEluIGZ1bmN0aW9uICdmcmVlX3B0ZV9yYW5n
ZSc6CmFyY2gvbmlvczIvaW5jbHVkZS9hc20vcGdhbGxvYy5oOjMzOjE3OiBlcnJvcjogaW1wbGlj
aXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ3BhZ2V0YWJsZV9wdGVfZHRvcic7IGRpZCB5b3Ug
bWVhbiAncGd0YWJsZV9wdGVfcGFnZV9kdG9yJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24t
ZGVjbGFyYXRpb25dCiAgICAzMyB8ICAgICAgICAgICAgICAgICBwYWdldGFibGVfcHRlX2R0b3Io
cGFnZV9wdGRlc2MocHRlKSk7ICAgICAgICAgICAgICAgICAgIFwKICAgICAgIHwgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgppbmNsdWRlL2FzbS1nZW5lcmljL3RsYi5oOjY2Njox
Nzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdfX3B0ZV9mcmVlX3RsYicKICAgNjY2IHwg
ICAgICAgICAgICAgICAgIF9fcHRlX2ZyZWVfdGxiKHRsYiwgcHRlcCwgYWRkcmVzcyk7ICAgICAg
ICAgICAgIFwKICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+Cm1tL21lbW9y
eS5jOjE5NDo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ3B0ZV9mcmVlX3RsYicKICAg
MTk0IHwgICAgICAgICBwdGVfZnJlZV90bGIodGxiLCB0b2tlbiwgYWRkcik7CiAgICAgICB8ICAg
ICAgICAgXn5+fn5+fn5+fn5+CmFyY2gvbmlvczIvaW5jbHVkZS9hc20vcGdhbGxvYy5oOjMzOjM2
OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ3BhZ2VfcHRkZXNjJyBb
LVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgIDMzIHwgICAgICAgICAg
ICAgICAgIHBhZ2V0YWJsZV9wdGVfZHRvcihwYWdlX3B0ZGVzYyhwdGUpKTsgICAgICAgICAgICAg
ICAgICAgXAogICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+CmluY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmg6NjY2OjE3OiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8gJ19fcHRlX2ZyZWVfdGxiJwogICA2NjYgfCAgICAgICAgICAgICAgICAgX19w
dGVfZnJlZV90bGIodGxiLCBwdGVwLCBhZGRyZXNzKTsgICAgICAgICAgICAgXAogICAgICAgfCAg
ICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn4KbW0vbWVtb3J5LmM6MTk0Ojk6IG5vdGU6IGlu
IGV4cGFuc2lvbiBvZiBtYWNybyAncHRlX2ZyZWVfdGxiJwogICAxOTQgfCAgICAgICAgIHB0ZV9m
cmVlX3RsYih0bGIsIHRva2VuLCBhZGRyKTsKICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn4K
YXJjaC9uaW9zMi9pbmNsdWRlL2FzbS9wZ2FsbG9jLmg6MzQ6MTc6IGVycm9yOiBpbXBsaWNpdCBk
ZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAndGxiX3JlbW92ZV9wYWdlX3B0ZGVzYyc7IGRpZCB5b3Ug
bWVhbiAndGxiX3JlbW92ZV9wYWdlX3NpemUnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1k
ZWNsYXJhdGlvbl0KICAgIDM0IHwgICAgICAgICAgICAgICAgIHRsYl9yZW1vdmVfcGFnZV9wdGRl
c2MoKHRsYiksIChwYWdlX3B0ZGVzYyhwdGUpKSk7ICAgICAgXAogICAgICAgfCAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgppbmNsdWRlL2FzbS1nZW5lcmljL3RsYi5oOjY2
NjoxNzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdfX3B0ZV9mcmVlX3RsYicKICAgNjY2
IHwgICAgICAgICAgICAgICAgIF9fcHRlX2ZyZWVfdGxiKHRsYiwgcHRlcCwgYWRkcmVzcyk7ICAg
ICAgICAgICAgIFwKICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+Cm1tL21l
bW9yeS5jOjE5NDo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ3B0ZV9mcmVlX3RsYicK
ICAgMTk0IHwgICAgICAgICBwdGVfZnJlZV90bGIodGxiLCB0b2tlbiwgYWRkcik7CiAgICAgICB8
ICAgICAgICAgXn5+fn5+fn5+fn5+CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFz
IGVycm9ycwptYWtlWzNdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQzOiBtbS9tZW1v
cnkub10gRXJyb3IgMQptYWtlWzNdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgptYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDc3OiBtbV0gRXJyb3IgMgpt
YWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlWzFdOiAqKiog
W01ha2VmaWxlOjIwMjI6IC5dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToyMjY6IF9fc3Vi
LW1ha2VdIEVycm9yIDIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
