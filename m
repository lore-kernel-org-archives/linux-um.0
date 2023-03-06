Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E37C61DA4
	for <linux-um@archiver.kernel.org>; Mon,  6 Mar 2023 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qTtUIBXwg8r500YUXYa5G1PpGCIcHR25rXSyTJLSeww=; b=aKqZQWbkDpNqZM
	JDosOs+RyaY3wOv3j7uONH6AciVZ4I8WURBKqF2473hjF3QS5ViPZTzZxzvk+jqY8AdqIj1CN6SII
	Fy/NKvaVggftJhUaLxnaKMzSa3H5rsnapEsee19ncnUjfUY1CW2545RuQCpkFh00GrgYzQHUOHsMv
	MsaoBT4wZtKys1sXSzWEgw5ZYkzje7bzveyZECYq9OR2EeVZs+2zHKdFV4h3f0YscA1qiJ16rnhv4
	ijedVF5GuwnePIKLCThKjiJpXCtK8kvmUyN8VAwsdFjz/FIXmDaN8CkftwaDlmz2SzlLt02HLHI8p
	O/X9zRbFoH+nkgbW+JHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZEHx-00E3FH-0u; Mon, 06 Mar 2023 17:06:17 +0000
Received: from frasgout11.his.huawei.com ([14.137.139.23])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZEHt-00E3Cw-29
	for linux-um@lists.infradead.org; Mon, 06 Mar 2023 17:06:15 +0000
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PVl9p1Rfnz9v7gn
	for <linux-um@lists.infradead.org>; Tue,  7 Mar 2023 00:57:18 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAn+2FpHQZkvth1AQ--.18405S2;
	Mon, 06 Mar 2023 18:05:53 +0100 (CET)
Message-ID: <1512772f4938c86d886540fb6ac394f444cc4a9f.camel@huaweicloud.com>
Subject: Re: Cannot compile UML in Ubuntu 20.04.5 anymore
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: David Gow <davidgow@google.com>
Cc: linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>
Date: Mon, 06 Mar 2023 18:05:42 +0100
In-Reply-To: <CABVgOSm1t3_mcUUu0A8eG-zAA4q0d-dmi6Ceb3TFtoUt1i3gTQ@mail.gmail.com>
References: <6df2ecef9011d85654a82acd607fdcbc93ad593c.camel@huaweicloud.com>
	 <CABVgOSm1t3_mcUUu0A8eG-zAA4q0d-dmi6Ceb3TFtoUt1i3gTQ@mail.gmail.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwAn+2FpHQZkvth1AQ--.18405S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyxtr4kWr4rGr1fXF1rCrg_yoW8tF48pF
	ZxCan5Gr4UKFyFkFs2yrZ8W3WjyrZ0kw4FqF93WryDX34UXr93uF4Sy3ya9FsxWanrCFy0
	9FsI9r9xJrW8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
	1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4pAXAACso
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_090613_411697_A803C7EC 
X-CRM114-Status: GOOD (  20.69  )
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

T24gU2F0LCAyMDIzLTAzLTA0IGF0IDEyOjM1ICswODAwLCBEYXZpZCBHb3cgd3JvdGU6Cj4gT24g
RnJpLCAzIE1hciAyMDIzIGF0IDE2OjM3LCBSb2JlcnRvIFNhc3N1Cj4gPHJvYmVydG8uc2Fzc3VA
aHVhd2VpY2xvdWQuY29tPiB3cm90ZToKPiA+IEhpCj4gPiAKPiA+IGl0IGxvb2tzIGxpa2Ugb25l
IHJlY2VudCBjb21taXQgY2F1c2VzIHRoZSBrZXJuZWwgYnVpbGQgdG8gYnJlYWsuCj4gPiAKPiA+
ICAgR0VOICAgICBzY3JpcHRzL2dkYi9saW51eC9jb25zdGFudHMucHkKPiA+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUvc3RkbGliLmg6MTAxMywKPiA+ICAgICAgICAgICAgICAg
ICAgZnJvbSBhcmNoL3VtL29zLUxpbnV4L2hlbHBlci5jOjY6Cj4gPiAvdXNyL2luY2x1ZGUveDg2
XzY0LWxpbnV4LWdudS9iaXRzL3N0ZGxpYi1mbG9hdC5oOiBJbiBmdW5jdGlvbiDigJhhdG9m4oCZ
Ogo+ID4gL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy9zdGRsaWItZmxvYXQuaDoy
NjoxOiBlcnJvcjogU1NFIHJlZ2lzdGVyIHJldHVybiB3aXRoIFNTRSBkaXNhYmxlZAo+ID4gICAg
MjYgfCB7Cj4gPiAgICAgICB8IF4KPiA+ICAgQ0MgICAgICBpbml0L25vaW5pdHJhbWZzLm8KPiA+
IAo+ID4gSXQgd29ya3MgYWdhaW4gYnkgcmV2ZXJ0aW5nIGNvbW1pdCA4ODQ5ODE4Njc5NDcgKCJy
dXN0OiBhcmNoL3VtOgo+ID4gRGlzYWJsZSBGUC9TSU1EIGluc3RydWN0aW9uIHRvIG1hdGNoIHg4
NiIpLgo+ID4gCj4gPiAkIGNhdCAvcHJvYy9jcHVpbmZvCj4gPiAKPiA+IFsuLi5dCj4gPiAKPiA+
IHByb2Nlc3NvciAgICAgICA6IDMxCj4gPiB2ZW5kb3JfaWQgICAgICAgOiBBdXRoZW50aWNBTUQK
PiA+IGNwdSBmYW1pbHkgICAgICA6IDIzCj4gPiBtb2RlbCAgICAgICAgICAgOiA0OQo+ID4gbW9k
ZWwgbmFtZSAgICAgIDogQU1EIFJ5emVuIFRocmVhZHJpcHBlciBQUk8gMzk1NVdYIDE2LUNvcmVz
Cj4gPiAKPiA+IFRoYW5rcwo+ID4gCj4gPiBSb2JlcnRvCj4gPiAKPiAKPiBZdXAsIHRoaXMgaXMg
ZGVmaW5pdGVseSBjYXVzZWQgYnkgODg0OTgxODY3OTQ3ICgicnVzdDogYXJjaC91bToKPiBEaXNh
YmxlIEZQL1NJTUQgaW5zdHJ1Y3Rpb24gdG8gbWF0Y2ggeDg2IikuCj4gCj4gSXQgbG9va3MgbGlr
ZSBHQ0MgZml4ZWQgdGhpcyB1cHN0cmVhbSBpbiBHQ0MgMTE6Cj4gaHR0cHM6Ly9nY2MuZ251Lm9y
Zy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9OTk2NTIKPiAKPiBFcXVhbGx5IHRob3VnaCwgbm90
IGhhdmluZyB0aGlzIGNoYW5nZSBicmVha3Mgb2xkZXIgdmVyc2lvbnMgb2YgTExWTSwKPiBzbyBJ
IHRoaW5rIGl0J3MgYmVzdCB0byBub3QgdG90YWxseSByZXZlcnQgaXQuCj4gCj4gU29tZXRoaW5n
IGxpa2UgdGhpcyBzaG91bGQgd29yazoKPiAtLS0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvTWFr
ZWZpbGUudW0gYi9hcmNoL3g4Ni9NYWtlZmlsZS51bQo+IGluZGV4IGQyZTk1ZDFkNGRiNy4uMWFh
NjQ4NDZlNTM5IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L01ha2VmaWxlLnVtCj4gKysrIGIvYXJj
aC94ODYvTWFrZWZpbGUudW0KPiBAQCAtMyw5ICszLDE0IEBAIGNvcmUteSArPSBhcmNoL3g4Ni9j
cnlwdG8vCj4gCj4gIwo+ICMgRGlzYWJsZSBTU0UgYW5kIG90aGVyIEZQL1NJTUQgaW5zdHJ1Y3Rp
b25zIHRvIG1hdGNoIG5vcm1hbCB4ODYKPiArIyBUaGlzIGlzIHJlcXVpcmVkIHRvIHdvcmsgYXJv
dW5kIGlzc3VlcyBpbiBvbGRlciBMTFZNIHZlcnNpb25zLCBidXQgYnJlYWtzCj4gKyMgR0NDIHZl
cnNpb25zIDwgMTEuIFNlZToKPiArIyBodHRwczovL2djYy5nbnUub3JnL2J1Z3ppbGxhL3Nob3df
YnVnLmNnaT9pZD05OTY1Mgo+ICMKPiAraWZlcSAoJChDT05GSUdfQ0NfSVNfQ0xBTkcpLHkpCj4g
S0JVSUxEX0NGTEFHUyArPSAtbW5vLXNzZSAtbW5vLW1teCAtbW5vLXNzZTIgLW1uby0zZG5vdyAt
bW5vLWF2eAo+IEtCVUlMRF9SVVNURkxBR1MgKz0KPiAtQ3RhcmdldC1mZWF0dXJlPS1zc2UsLXNz
ZTIsLXNzZTMsLXNzc2UzLC1zc2U0LjEsLXNzZTQuMiwtYXZ4LC1hdngyCj4gK2VuZGlmCj4gCj4g
aWZlcSAoJChDT05GSUdfWDg2XzMyKSx5KQo+IFNUQVJUIDo9IDB4ODA0ODAwMAo+IC0tLQo+IAo+
IFRob3VnaCB0aGUgbW9yZSBjb3JyZWN0IHNvbHV0aW9uIHdvdWxkIGJlIHRvIGp1c3QgY2hlY2sK
PiBnY2MtbWluLXZlcnNpb24gfHwgY2xhbmcuIFRoYXQgcHJvYmFibHkgcmVxdWlyZXMgYSBiaXQg
bW9yZQo+IG1ha2VmaWxlLWZ1IHRvIGRvIGNsZWFubHksIHRob3VnaC4KClRoYW5rcywgd29ya3Mg
Zm9yIG1lLgoKUm9iZXJ0bwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
