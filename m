Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C883CCD4F2B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Csi5yk5TAejMo1fCPUOEEBI9fOD6QXF0j+YT3GJL/yc=; b=gIGU/3K/0zXZ8w
	UtSgLl+SLW7QodldCUUWAZ7NdXBiGkYlHGwjXUUqdy9fq7+5QYTI92wyC8HS8gmsztLJNeT6n00M8
	rxA8duFZEIXr4ZdXCB20s1irl14mdxq6sVx4C5Hdc/Ot9skxMU7vi5LV43FuUhFMC3r79tUSPaN4/
	ScZH1idfXrurl8MLD3T4366UyiPmEe+ZlDRgcuZxo8V0ERVOwumKB4v90SZTLktKRR/6789Fu6tsG
	cIvJFDklrhVZWTUZNLamsx6q0kalMHLTw1+IHBnDcKc+5exMvIGCwvbdCd2WSGjboC3lLa24/mQkm
	63r3qRfLh+Kl/NtzZhUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbig-008RW3-2p;
	Fri, 22 Sep 2023 08:41:02 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbid-008RVS-25
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 08:41:01 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjbiZ-002bI3-2v; Fri, 22 Sep 2023 08:40:55 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjbiW-0029CM-CY; Fri, 22 Sep 2023 09:40:54 +0100
Message-ID: <fe1f54c6-cf01-78ef-9afd-174e7c345f7f@cambridgegreys.com>
Date: Fri, 22 Sep 2023 09:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] um: Enable preemption in UML
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_014059_700119_7859E3FF 
X-CRM114-Status: GOOD (  17.22  )
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

Ck9uIDIyLzA5LzIwMjMgMDk6MTMsIEpvaGFubmVzIEJlcmcgd3JvdGU6Cj4gT24gRnJpLCAyMDIz
LTA5LTIyIGF0IDA5OjAxICswMTAwLCBBbnRvbiBJdmFub3Ygd3JvdGU6Cj4+IE15IGZhdm9yaXRl
IHRlc3Qgd2hpY2ggSSBydW4gb24gYWxsIGNoYW5nZXMgaXM6Cj4+Cj4+IGZpbmQgL3VzciAtdHlw
ZSBmIC1leGVjIGNhdCB7fSA+IC9kZXYvbnVsbCBcOwo+Pgo+PiBPbiBEZWJpYW4gdGhpcyBmb3Jr
cyAvYmluL2NhdCBmb3IgZWFjaCBmaWxlIGFuZCBkb2VzIElPIG9uIGl0LiBUaGF0IHRlc3QgcGFz
c2VzIGhlcmUgZXZlcnkgdGltZSA6KAo+IE9oLCBhcGFydCBmcm9tIHRoZSBzcGxhdCwgaXQgYWxs
IF93b3Jrc18gZmluZS4KClRoZSBzcGxhdCBpcyBiZWNhdXNlIG1tIGlzIGNhdXNlZCBieSB0aGlz
OgoKdm9pZCBmb3JjZV9mbHVzaF9hbGwodm9pZCkKewogwqDCoCDCoHN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tID0gY3VycmVudC0+bW07CiDCoMKgIMKgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWE7CiDC
oMKgIMKgVk1BX0lURVJBVE9SKHZtaSwgbW0sIDApOwoKIMKgwqAgwqBtbWFwX3JlYWRfbG9jayht
bSk7CgogwqDCoMKgIF5eXl5eXl5eXl5eXl5eCgogwqDCoMKgIGZvcl9lYWNoX3ZtYSh2bWksIHZt
YSkKIMKgwqAgwqDCoMKgwqAgZml4X3JhbmdlKG1tLCB2bWEtPnZtX3N0YXJ0LCB2bWEtPnZtX2Vu
ZCwgMSk7CiDCoMKgIMKgbW1hcF9yZWFkX3VubG9jayhtbSk7CgogwqDCoMKgIF5eXl5eXl5eXl5e
Xl5eCgp9CgpXZSBpbnZva2UgdGhpcyBvbiBldmVyeSBmb3JrLiBNTSBpcyBub3cgbG9ja2VkICJn
ZW50bHkiIHVzaW5nIGEgc2VtYXBob3JlIGFuZCB0aGF0IGlzIHN1cHBvc2VkIHRvCgpiZSBzbGVl
cGFibGUuIEZyb20gdGhlcmUgb24geW91IGdldCBhIHdhcm5pbmcgaWYgYXRvbWljIHNsZWVwIGlz
IGVuYWJsZWQuCgoKPgo+PiBIb3dldmVyLCBJIGRpZCBub3QgaGF2ZSBkZWJ1ZyB0dXJuZWQgb24u
IFNvLCBJIHdvdWxkIG5vdCBiZSBzdXJwcmlzZWQgaWYgc29tZXRoaW5nIGluIHRoZSBkZWJ1Zwo+
IE9LLgo+Cj4+IHBvcnRpb24gb2YgdGhlIGNvbmZpZyBtYWtlcyB0aGUgY3Jhc2hlcyBtb3JlIGxp
a2VseS4KPiBJdCdzIGp1c3QgYSBkZWJ1ZyB3YXJuaW5nIGZvciBtZSwgbm8gcmVhbCBjcmFzaC4K
Pgo+PiBPdGhlcndpc2UsIGVhY2ggZm9yayBpcyBhIGZvcmNlZCB0bGJfZmx1c2hfYWxsLCBzbyBp
dCBpcyBhIG1hc3NpdmUgdGxiIGV4ZXJjaXNlLiBBbnkgYnVncywgbG9ja2luZywgZXRjIGFyZSBs
aWtlbHkgdG8gc2hvdyB1cC4KPj4KPiBZZXMsIGJ1dCB3aGVuIGRvZXMgdGhlIGZvcmsgYWN0dWFs
bHkgaGFwcGVuPwo+Cj4gVGhhdCBwYXJ0IGNvbmZ1c2VzIG1lIC0gdGhlIGZvcmtfaGFuZGxlcigp
IHNlZW1zIHRvIGJlIGNhbGxlZCBhdCB2YXJpb3VzCj4ga2luZCBvZiByYW5kb20gcG9pbnRzIGlu
IHRpbWUgYWZ0ZXI/CkluZGVlZC4gSSBhbSB0cnlpbmcgdG8gY2hhc2UgaXQgZG93bi4gSXQgc2Vl
bXMgaGFybWxlc3MgYXQgdGhpcyBwb2ludCwgYnV0IGl0IHdvdWxkIGJlIG5pY2UgdG8gdW5kZXJz
dGFuZCB3aGF0IGNhdXNlcyBpdC4KPgo+IGpvaGFubmVzCj4KLS0gCkFudG9uIFIuIEl2YW5vdgpD
YW1icmlkZ2VncmV5cyBMaW1pdGVkLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQuIENvbXBhbnkgTnVt
YmVyIDEwMjczNjYxCmh0dHBzOi8vd3d3LmNhbWJyaWRnZWdyZXlzLmNvbS8KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxp
c3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
