Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2228C7EE43
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 21:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hnopGfbHgFetCJ/7ipz+Z1juROxJAp9d34iyWIJGmb4=; b=rr9cG6KQ14LJph
	VRSI/jZM3HdMEFljpQTMBl7wZohhUHNzIG6PdbL5M7V8h+DD6EYuWycXkTBB2PMZo9JcxNmWNb9ce
	OtVAuLA2yBcX9G854j1kfGvo9Ku5JNzMsqLocQelL0Ia1pzB190vI5sQCVVquZM+qfuLv1KprY0yJ
	w+PF9a/Od55QlYDxjoN0Q8zdesTRJnRGTeS43D/A/+NdqWovNVpLRpzsx42lLpXjOQ0yfb6rn0QVD
	j9T9kE4hs7Kr/LUDuViYqO7DUy7O9I0fF1qfQK8y5W/XENFXVXTLA++lOxCp8Qhda3UMf2UCjco9S
	adMsz5sNRh3r8+B+5weA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7jaz-00EIoT-1U;
	Fri, 09 Jun 2023 21:24:33 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7jaw-00EIlB-0S
	for linux-um@lists.infradead.org;
	Fri, 09 Jun 2023 21:24:31 +0000
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-78caeb69125so285728241.3
        for <linux-um@lists.infradead.org>; Fri, 09 Jun 2023 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686345861; x=1688937861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdR22/Dn+oev7vk8t/Tr492RL20kdJqWTXPUPVdb0hc=;
        b=h9Pl7EDgw/Oko95ySXm+jEVrLDh6BI0Mz9RBRez1O17wSPKof+RGRKEuBxXijTHsg9
         KbHURV/X4usXW336ls6rI03yl5Gc2aTSGqpfR9M9Y1x7U5PTAYccFxxjJ5zWkyumLRC8
         v4N0cdigRRSgQ/IPnouF2x/UBBUAwqW+tiQBYnhdMZKFdJq5Us8bO7PPLc7MFSnALLHM
         JC3BOyAjeeVzIn8IhXT7T4u4iBer+G9UyvUmTv9NPNfTHbNuV2QiBz7PB9tEbAWLya/8
         fzCqkdlTl12uaUIc0GRwrtb4URRNgDEHw5cHmE/msKYWYcK+rRt4azPCdoQzZC0cHRvo
         U7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686345861; x=1688937861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdR22/Dn+oev7vk8t/Tr492RL20kdJqWTXPUPVdb0hc=;
        b=OzV+4+8xuavPIh025frljxXPK/4bZtLO3etOgAcz19BuZxIHAt6yvxnkAjRDlDq4Eh
         jf5RucOjyXQF68BMvk2eMZoKoEc2a0vLieU2Ku1S3gbpvwlTwejZOVvOLKdZIxGqxNSS
         DFS+i50RRqHz7QVA1BbF6BJ7n2mXChiqSaAr6h8d1gBA26UZNWwto+Savvhdh8C1KaBF
         rWg99AZNzp3W8UXe7QJ098FbaNyxa9Td6pdDBwRmM/RWZHTa37WBG2JsGy1Q9mPzS1f4
         iSu9hCVa742GiXgaj/VnjzOryJYoUid89Nub7fTzD2kb2iXbiyHAbQtu6KzVC9Jzphan
         6t5w==
X-Gm-Message-State: AC+VfDxMJpYV/jqSv6So2N0rSNX2oStvj9oGIjO+xa9zMljTGRV9vbPN
	lwvVBLHRzuIk8J6kl/c/9r6PJQjlJZKr2MEg3OI7JA==
X-Google-Smtp-Source: ACHHUZ5OXoFL30kGabu8C3ICNTZRa+j1RaV03HiGdItV9KOMMZLD5Lt7ZJOLWtozoUcQeacTby9geMSyvFoSBzASxqk=
X-Received: by 2002:a67:efd4:0:b0:43b:131f:1b50 with SMTP id
 s20-20020a67efd4000000b0043b131f1b50mr2184071vsp.24.1686345860593; Fri, 09
 Jun 2023 14:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-2-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-2-masahiroy@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Jun 2023 14:23:02 -0700
Message-ID: <CAKwvOdnvxxPFbJ3bPu9-WqrQD4nS2vd2X-5=mgeruTrgTPm=zw@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] Revert "[PATCH] uml: export symbols added by GCC hardened"
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_142430_181377_B5CE178F 
X-CRM114-Status: GOOD (  27.26  )
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCA3OjI04oCvQU0gTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGly
b3lAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBUaGlzIHJldmVydHMgY29tbWl0IGNlYWQ2MWE2NzE3
YTk4NzM0MjZiMDhkNzNhMzRhMzI1ZTM1NDZmNWQuCj4KPiBJdCBleHBvcnRlZCBfX3N0YWNrX3Nt
YXNoX2hhbmRsZXIgYW5kIF9fZ3VhcmQsIHdoaWxlIHRoZXkgbWF5IG5vdCBiZQo+IGRlZmluZWQg
YnkgYW55b25lLgo+Cj4gVGhlIGNvZGUgKmRlY2xhcmVzKiBfX3N0YWNrX3NtYXNoX2hhbmRsZXIg
YW5kIF9fZ3VhcmQuIEl0IGRvZXMgbm90Cj4gY3JlYXRlIHdlYWsgc3ltYm9scy4gV2hlbiB0aGUg
c3RhY2stcHJvdGVjdG9yIGlzIGRpc2FibGVkLCB0aGV5IGFyZQo+IGxlZnQgdW5kZWZpbmVkLCBi
dXQgeWV0IGV4cG9ydGVkLgo+Cj4gSWYgYSBsb2FkYWJsZSBtb2R1bGUgdHJpZXMgdG8gYWNjZXNz
IG5vbi1leGlzdGluZyBzeW1ib2xzLCBiYWQgdGhpbmdzCj4gKGEgcGFnZSBmYXVsdCwgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlLCBldGMuKSB3aWxsIGhhcHBlbi4gU28sIHRoZQo+IGN1cnJlbnQg
Y29kZSBpcyB3cm9uZy4KPgo+IElmIHRoZSBjb2RlIHdlcmUgd3JpdHRlbiBhcyBmb2xsb3dzLCBp
dCB3b3VsZCAqZGVmaW5lKiB0aGVtIGFzIHdlYWsKPiBzeW1ib2xzIHNvIG1vZHVsZXMgd291bGQg
YmUgYWJsZSB0byBnZXQgYWNjZXNzIHRvIHRoZW0uCj4KPiAgIHZvaWQgKCpfX3N0YWNrX3NtYXNo
X2hhbmRsZXIpKHZvaWQgKikgX19hdHRyaWJ1dGVfXygod2VhaykpOwo+ICAgRVhQT1JUX1NZTUJP
TChfX3N0YWNrX3NtYXNoX2hhbmRsZXIpOwo+Cj4gICBsb25nIF9fZ3VhcmQgX19hdHRyaWJ1dGVf
Xygod2VhaykpOwo+ICAgRVhQT1JUX1NZTUJPTChfX2d1YXJkKTsKPgo+IEluIGZhY3QsIG1vZHBv
c3QgZm9yYmlkcyBleHBvcnRpbmcgdW5kZWZpbmVkIHN5bWJvbHMuIEl0IHNob3dzIGFuIGVycm9y
Cj4gbWVzc2FnZSBpZiBpdCBkZXRlY3RzIHN1Y2ggYSBtaXN0YWtlLgo+Cj4gICBFUlJPUjogbW9k
cG9zdDogIi4uLiIgWy4uLl0gd2FzIGV4cG9ydGVkIHdpdGhvdXQgZGVmaW5pdGlvbgo+Cj4gVW5m
b3J0dW5hdGVseSwgaXQgaXMgY2hlY2tlZCBvbmx5IHdoZW4gdGhlIGNvZGUgaXMgYnVpbHQgYXMg
bW9kdWxhci4KPiBUaGUgcHJvYmxlbSBkZXNjcmliZWQgYWJvdmUgaGFzIGJlZW4gdW5ub3RpY2Vk
IGZvciBhIGxvbmcgdGltZSBiZWNhdXNlCj4gYXJjaC91bS9vcy1MaW51eC91c2VyX3N5bXMuYyBp
cyBhbHdheXMgYnVpbHQtaW4uCj4KPiBXaXRoIGEgcGxhbm5lZCBjaGFuZ2UgaW4gS2J1aWxkLCBl
eHBvcnRpbmcgdW5kZWZpbmVkIHN5bWJvbHMgd2lsbCBhbHdheXMKPiByZXN1bHQgaW4gYSBidWls
ZCBlcnJvciBpbnN0ZWFkIG9mIGEgcnVuLXRpbWUgZXJyb3IuIEl0IGlzIGEgZ29vZCB0aGluZywK
PiBidXQgd2UgbmVlZCB0byBmaXggdGhlIGJyZWFrYWdlIGluIGFkdmFuY2UuCj4KPiBPbmUgZml4
IGlzIHRvICpkZWZpbmUqIHdlYWsgc3ltYm9scyBhcyBzaG93biBhYm92ZS4gQW4gYWx0ZXJuYXRp
dmUgaXMKPiB0byBleHBvcnQgdGhlbSBjb25kaXRpb25hbGx5IGFzIGZvbGxvd3M6Cj4KPiAgICNp
ZmRlZiBDT05GSUdfU1RBQ0tQUk9URUNUT1IKPiAgIGV4dGVybiB2b2lkIF9fc3RhY2tfc21hc2hf
aGFuZGxlcih2b2lkICopOwo+ICAgRVhQT1JUX1NZTUJPTChfX3N0YWNrX3NtYXNoX2hhbmRsZXIp
Owo+Cj4gICBleHRlcm5hbCBsb25nIF9fZ3VhcmQ7Cj4gICBFWFBPUlRfU1lNQk9MKF9fZ3VhcmQp
Owo+ICAgI2VuZGlmCj4KPiBUaGlzIGlzIHdoYXQgb3RoZXIgYXJjaGl0ZWN0dXJlcyBkbzsgRVhQ
T1JUX1NZTUJPTChfX3N0YWNrX2Noa19ndWFyZCkKPiBpcyBndWFyZGVkIGJ5ICNpZmRlZiBDT05G
SUdfU1RBQ0tQUk9URUNUT1IuCj4KPiBIb3dldmVyLCBhZGRpbmcgdGhlICNpZmRlZiBndWFyZCBp
cyBub3Qgc2Vuc2libGUgYmVjYXVzZSBVTUwgY2Fubm90Cj4gZW5hYmxlIHRoZSBzdGFjay1wcm90
ZWN0b3IgaW4gdGhlIGZpcnN0IHBsYWNlISAoUGxlYXNlIG5vdGUgVU1MIGRvZXMKPiBub3Qgc2Vs
ZWN0IEhBVkVfU1RBQ0tQUk9URUNUT1IgaW4gS2NvbmZpZy4pCj4KPiBTbywgdGhlIGNvZGUgaXMg
YWxyZWFkeSBicm9rZW4gKGFuZCB1bnVzZWQpIGluIG11bHRpcGxlIHdheXMuCj4KPiBKdXN0IHJl
bW92ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhpcm95QGtlcm5l
bC5vcmc+CgpUaGFua3MgZm9yIHRoZSBwYXRjaCEKUmV2aWV3ZWQtYnk6IE5pY2sgRGVzYXVsbmll
cnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPgoKPiAtLS0KPgo+IENoYW5nZXMgaW4gdjc6Cj4g
ICAtIE5ldyBwYXRjaAo+Cj4gIGFyY2gvdW0vb3MtTGludXgvdXNlcl9zeW1zLmMgfCA3IC0tLS0t
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvYXJj
aC91bS9vcy1MaW51eC91c2VyX3N5bXMuYyBiL2FyY2gvdW0vb3MtTGludXgvdXNlcl9zeW1zLmMK
PiBpbmRleCA5YjYyYTlkMzUyYjMuLmEzMTBhZTI3YjQ3OSAxMDA2NDQKPiAtLS0gYS9hcmNoL3Vt
L29zLUxpbnV4L3VzZXJfc3ltcy5jCj4gKysrIGIvYXJjaC91bS9vcy1MaW51eC91c2VyX3N5bXMu
Ywo+IEBAIC0zNywxMyArMzcsNiBAQCBFWFBPUlRfU1lNQk9MKHZzeXNjYWxsX2VoZHIpOwo+ICBF
WFBPUlRfU1lNQk9MKHZzeXNjYWxsX2VuZCk7Cj4gICNlbmRpZgo+Cj4gLS8qIEV4cG9ydCBzeW1i
b2xzIHVzZWQgYnkgR0NDIGZvciB0aGUgc3RhY2sgcHJvdGVjdG9yLiAqLwo+IC1leHRlcm4gdm9p
ZCBfX3N0YWNrX3NtYXNoX2hhbmRsZXIodm9pZCAqKSBfX2F0dHJpYnV0ZV9fKCh3ZWFrKSk7Cj4g
LUVYUE9SVF9TWU1CT0woX19zdGFja19zbWFzaF9oYW5kbGVyKTsKPiAtCj4gLWV4dGVybiBsb25n
IF9fZ3VhcmQgX19hdHRyaWJ1dGVfXygod2VhaykpOwo+IC1FWFBPUlRfU1lNQk9MKF9fZ3VhcmQp
Owo+IC0KPiAgI2lmZGVmIF9GT1JUSUZZX1NPVVJDRQo+ICBleHRlcm4gaW50IF9fc3ByaW50Zl9j
aGsoY2hhciAqc3RyLCBpbnQgZmxhZywgc2l6ZV90IGxlbiwgY29uc3QgY2hhciAqZm9ybWF0KTsK
PiAgRVhQT1JUX1NZTUJPTChfX3NwcmludGZfY2hrKTsKPiAtLQo+IDIuMzkuMgo+CgoKLS0gClRo
YW5rcywKfk5pY2sgRGVzYXVsbmllcnMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K
