Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2451E7D0B9
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 06:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DDCm+ZjoocrboXip3SjXrmodHjZX4xkvB7K338+uouA=; b=z6CprLvSwUX7SqHKDekIEIFUkt
	4ALzTII6en6zNPWlxXrxvgPVmUZFqsHr4RMGtvc5KISu7qu4iB5w0Uq9ssF2n/i2gM5vrAvFb2lvL
	azWfqTdNN/cCu6U6paxhatf5jxeSdXKf97S9c0TiSoNqwcme1ZML/BShWFVGbduV1YQhO/DX6SAb0
	PJ4UR4agmz1WGOcyAUpvBkvJ2cCFTcMLH2zkUqlUbCXpumKRalHa2jiy0liCNx3gTts3s5db+JSky
	mAas58ChDnG0LqPbkDSWd9WIZ2UUiz5LOVfiT/2wO187t7Sxi6ONX0YUHrAcjWtIaXsVrmml7bQmw
	x8LWzWtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjZhC-0083F0-17;
	Fri, 22 Sep 2023 06:31:22 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjZh9-0083DK-1N
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 06:31:21 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qjZh2-002auG-0c
	for linux-um@lists.infradead.org; Fri, 22 Sep 2023 06:31:12 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qjZgz-0020ev-6x
	for linux-um@lists.infradead.org; Fri, 22 Sep 2023 07:31:11 +0100
Message-ID: <22f59852-d58e-00d4-3733-cddcc9d1e7e4@kot-begemot.co.uk>
Date: Fri, 22 Sep 2023 07:31:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] um: Enable preemption in UML
Content-Language: en-US
To: linux-um@lists.infradead.org
References: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
 <992345997.66924.1695330124883.JavaMail.zimbra@nod.at>
 <ac09760c-90fd-2209-a85c-5f33380238fc@cambridgegreys.com>
 <1842425402.67064.1695333308356.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1842425402.67064.1695333308356.JavaMail.zimbra@nod.at>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_233119_462509_05B7371C 
X-CRM114-Status: GOOD (  13.13  )
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

Ck9uIDIxLzA5LzIwMjMgMjI6NTUsIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToKPiAtLS0tLSBV
cnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4+IFZvbjogImFudG9uIGl2YW5vdiIgPGFudG9uLml2
YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4+IEFuOiAicmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0
Pgo+PiBDQzogImxpbnV4LXVtIiA8bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZz4sICJKb2hh
bm5lcyBCZXJnIiA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4KPj4gR2VzZW5kZXQ6IERvbm5l
cnN0YWcsIDIxLiBTZXB0ZW1iZXIgMjAyMyAyMzo0MToxNgo+PiBCZXRyZWZmOiBSZTogW1BBVENI
IHY0XSB1bTogRW5hYmxlIHByZWVtcHRpb24gaW4gVU1MCj4+IE9uIDIxLzA5LzIwMjMgMjI6MDIs
IFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToKPj4+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwg
LS0tLS0KPj4+PiBWb246ICJhbnRvbiBpdmFub3YiIDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3Jl
eXMuY29tPgo+Pj4+IEFuOiAibGludXgtdW0iIDxsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Pgo+Pj4+IENDOiAiSm9oYW5uZXMgQmVyZyIgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+LCAi
cmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0PiwKPj4+PiAiYW50b24gaXZhbm92Igo+Pj4+IDxhbnRv
bi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+Pj4+IEdlc2VuZGV0OiBEb25uZXJzdGFnLCAy
MS4gU2VwdGVtYmVyIDIwMjMgMTc6NTU6MjIKPj4+PiBCZXRyZWZmOiBbUEFUQ0ggdjRdIHVtOiBF
bmFibGUgcHJlZW1wdGlvbiBpbiBVTUwKPj4+PiBGcm9tOiBBbnRvbiBJdmFub3YgPGFudG9uLml2
YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4+Pj4KPj4+PiBQcmVlbXB0aW9uIHJlcXVpcmVzIHNh
dmluZy9yZXN0b3JpbmcgRlBVIHN0YXRlLiBUaGlzIHBhdGNoCj4+Pj4gYWRkcyBzdXBwb3J0IGZv
ciBpdCB1c2luZyBHQ0MgaW50cmluc2ljcy4KPj4+IFRoaXMgcGF0Y2ggdHJpZ2dlcnMgaGVyZSB0
aGUgZm9sbG93aW5nIHNwbGF0Ogo+PiBBY2suIEkgd2lsbCBsb29rIGludG8gaXQgdG9tb3Jyb3cu
Cj4gVGh4IQo+IEkgaGFkIGEgYnJpZWYgbG9vaywgVU1MJ3MgaW5pdF9JUlEoKSBzZWVtcyB0byBy
ZXR1cm4gbm93IHdpdGggaW50ZXJydXB0cyBlbmFibGVkLgo+IER1bm5vIHdoeSwgSSBuZWVkIHNv
bWUgc2xlZXAgbm93LgoKVGxiLiBMb29raW5nIGF0IG90aGVyIGFyY2hpdGVjdHVyZXMgKGFuZCBz
cGVjaWZpY2FsbHkgeDg2KSBpdCBuZWVkcyBwcmVlbXB0X2Rpc2FibGUvZW5hYmxlIGFyb3VuZCBj
cml0aWNhbCBzZWN0aW9ucy4KCiBGcm9tIHRoZXJlIHlvdSBtYXkgZW5kIHVwIGluIHRoZSB3cm9u
ZyBzdGF0ZSBhY3Jvc3MgdGhlIGJvYXJkLgoKPgo+PiBUaGVyZSB3aWxsIGJlIHBsYWNlcyB3aGVy
ZSBpdCB3aWxsIGJvbWIgb3V0LiBGLkUuIEkgYW0gY2hhc2luZyBvbmUgaXMKPj4gdHJpZ2dlcmVk
IGJ5IHRoZSBORlMgc2VydmVyIChpdCBtYXkgYmUgdGhlIHNhbWUgYXMgaW4gdGhpcyB0cmFjZSAt
IGl0Cj4+IGhhcHBlbnMgYXJvdW5kIHRoZSBlbmQgb2YgdGhlIGluaXRpYWwgc2V0dXApLgo+Pgo+
PiBBbGwgaW4gYWxsIGl0IGxvb2tzIGJldHRlciB0aGFuIEkgZXhwZWN0ZWQuCj4gVHJ1ZSB0aGF0
ISA6LSkKPgo+IFRoYW5rcywKPiAvL3JpY2hhcmQKPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gbGludXgtdW0gbWFpbGluZyBsaXN0Cj4gbGludXgt
dW1AbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtdW0KCi0tIApBbnRvbiBSLiBJdmFub3YKaHR0cHM6Ly93d3cua290
LWJlZ2Vtb3QuY28udWsvCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
