Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA73CD4F27
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 07:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YaCiUZALqxlcs2tVKLyPIJwD+XRnABLTCt1r7IETowM=; b=bLCQskQBcjU2S8I0zOYQb/8NKQ
	b4T2F6PfektP4s1xf/CIigMetjK6uBZntn6FvKbP8kmY44eZdKHF/47Q2yJNRyeRCmetmxkaZ8hWk
	7cM6tyTJyZtGPfQBQD7WmgJAw60TEy+TczmdQpqmzvkMzdUi/HzFmM8q2+vCSlPYoHsdrxsyW3i9C
	wMcSVvzmyw+IcQRULAm5XGve9CJnxW83DrdIxumkL1nNZnuvHJPaKybJ3w5im1q++NiJmGQDa2tUn
	09zdIt6LXnGUW+PPpY8bSKOxBoKWYre5mK5YnHqu9153hk+kCZ2ux1NYQPg2BiYNxxEYDoojHkVrh
	nGHBUItg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjaZZ-008BtL-3A;
	Fri, 22 Sep 2023 07:27:33 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjaZV-008BsL-32
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 07:27:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7A06662348A4;
	Fri, 22 Sep 2023 09:27:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id VmYxgAp1faCa; Fri, 22 Sep 2023 09:27:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D315F62348A7;
	Fri, 22 Sep 2023 09:27:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R2Q2VhrF4n-G; Fri, 22 Sep 2023 09:27:23 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B225B62348A4;
	Fri, 22 Sep 2023 09:27:23 +0200 (CEST)
Date: Fri, 22 Sep 2023 09:27:23 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Message-ID: <1938743835.68560.1695367643504.JavaMail.zimbra@nod.at>
In-Reply-To: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v5] um: Enable preemption in UML
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Enable preemption in UML
Thread-Index: lk8PtPgAO6FZyfuTBsQhjKqL6a3x2g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_002730_130257_A1142595 
X-CRM114-Status: UNSURE (   8.80  )
X-CRM114-Notice: Please train this message.
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQW46ICJsaW51eC11bSIgPGxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmc+Cj4gQ0M6ICJKb2hhbm5lcyBCZXJnIiA8am9oYW5uZXNAc2lw
c29sdXRpb25zLm5ldD4sICJyaWNoYXJkIiA8cmljaGFyZEBub2QuYXQ+LCAiYW50b24gaXZhbm92
Igo+IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+IEdlc2VuZGV0OiBGcmVpdGFn
LCAyMi4gU2VwdGVtYmVyIDIwMjMgMDg6NTI6MTIKPiBCZXRyZWZmOiBbUEFUQ0ggdjVdIHVtOiBF
bmFibGUgcHJlZW1wdGlvbiBpbiBVTUwKCj4gRnJvbTogQW50b24gSXZhbm92IDxhbnRvbi5pdmFu
b3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+IAo+IFByZWVtcHRpb24gcmVxdWlyZXMgc2F2aW5nL3Jl
c3RvcmluZyBGUFUgc3RhdGUuIFRoaXMgcGF0Y2gKPiBhZGRzIHN1cHBvcnQgZm9yIGl0IHVzaW5n
IEdDQyBpbnRyaW5zaWNzLgoKQ2FuIHlvdSBwbGVhc2Ugc3RhdGUgaW4gZnV0dXJlIHBhdGNoZXMg
d2hhdCB5b3UgaGF2ZSBjaGFuZ2VkIHNpbmNlIHRoZSBsYXN0IG9uZT8KIAo+IFNpZ25lZC1vZmYt
Ynk6IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBkaWZm
IC0tZ2l0IGEvYXJjaC91bS9rZXJuZWwvdGxiLmMgYi9hcmNoL3VtL2tlcm5lbC90bGIuYwo+IGlu
ZGV4IDdkMDUwYWIwZjc4YS4uMzRlYzhlNjc3ZmI5IDEwMDY0NAo+IC0tLSBhL2FyY2gvdW0va2Vy
bmVsL3RsYi5jCj4gKysrIGIvYXJjaC91bS9rZXJuZWwvdGxiLmMKPiBAQCAtMzYyLDYgKzM2Miw5
IEBAIHN0YXRpYyBpbnQgZmx1c2hfdGxiX2tlcm5lbF9yYW5nZV9jb21tb24odW5zaWduZWQgbG9u
Zwo+IHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCkKPiAKPiAJbW0gPSAmaW5pdF9tbTsKPiAJaHZj
ID0gSU5JVF9IVkMobW0sIGZvcmNlLCB1c2Vyc3BhY2UpOwo+ICsKPiArICAgIHByZWVtcHRfZGlz
YWJsZSgpOwo+ICsKCkRvZXMgdGhpcyBhZGRyZXNzIHRoZSBib290dXAgc3BsYXQgSSd2ZSByZXBv
cnRlZCB5ZXN0ZXJkYXk/CgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K
