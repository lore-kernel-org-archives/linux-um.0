Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCD3C7EE23
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 04:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u9xcl/DaaBbrO8xj2HGfODg3Hr4ODm4AGwM/uO3Joks=; b=u/Qmg4Ed/j9C0I
	5KzCa1MKYml331as2U7uzQaZML8/G9C6b3irDW2A/7vnCi56NA2vNsEGdQqvdrmLUsGlNj1br3spj
	YaqF3Ni64F4j2zfsYI4mg4IAkNTgAEwFtg8ja24V7QNJVE5D7VFU3XPW6On1qWCir6/NWFF5wWfuE
	MRh0TNy/Zo2o9jmF28wgNf92rBj1FsauGzwlEJk8ogo52iyW6bM0RF1ged+T+Fwx9qZjNCYCYAkoe
	gmBllTZ0JIdisqbGGdKSGsN/9DEpAQTIjqv4iyfwp+EWpuHe1gvTeVXzVGvfIMzquYHj5dwjeoYG4
	Ozq+FcdZIkfObBd3SQzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4a3J-001vtY-0h;
	Thu, 01 Jun 2023 04:36:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4a3F-001vrL-1Q;
	Thu, 01 Jun 2023 04:36:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6B161007;
	Thu,  1 Jun 2023 04:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AECAC433A0;
	Thu,  1 Jun 2023 04:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685594197;
	bh=QZIVYOfQMQfDIruN7rSg689YIbiJbkkfE8AKRfy2n5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XjX+qO5TgZej3fh2HJQIqiOR5PxyL4koYuTQx2qeUwz0mw2WS7S8765bRMbrDCQVG
	 whIGCjOlXBTjeWiN2+LrCx+Or8mSlhjQdHY5MFaYnqKspwUjKhBsJekNkwwwC3A2tK
	 RRJ+PYWLTNVwk2Tc4E1sjjLY66LER3hFT6QIRdlz0YEtfE5QnejkEMpgjlFtCb1L5b
	 jav2+jHQW0E6lB/EBDYRssonNB4dhirDM2pvI3kpcWJ0B9czAKVTkvmbZ2ylsgGsMq
	 x3kGCiBqFY0IqxyFq7Pvs4DJbAWcMeNsAFCqYa1UhLYAOwr6LlCcKM6JbTbj+s1hsP
	 DnX5huppMSCjQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5148f299105so1031966a12.1;
        Wed, 31 May 2023 21:36:37 -0700 (PDT)
X-Gm-Message-State: AC+VfDxjPRk26IhKrD1QK7d8F8f3zCuz1geIPzRCLAta0AU1t7bl5Pcp
	EvJJaCvct0f5zDn0MZX9QQgTyXYx7NdZCDbjGZY=
X-Google-Smtp-Source: ACHHUZ7XdaYihX3P0occ4fimfrY7vXLE/b8sATTjW74eXROnZDFW1BQ/va3F8G7kmqLig8peXPPgGCGmqMpiLEgKGXM=
X-Received: by 2002:a05:6402:3511:b0:4fc:97d9:18ec with SMTP id
 b17-20020a056402351100b004fc97d918ecmr437472edd.21.1685594195535; Wed, 31 May
 2023 21:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com> <20230531213032.25338-23-vishal.moola@gmail.com>
In-Reply-To: <20230531213032.25338-23-vishal.moola@gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 1 Jun 2023 12:36:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSEguewbRMD8w3u3tfSPt-Opy+i=jm_8W2+NtAP1OYSsA@mail.gmail.com>
Message-ID: <CAJF2gTSEguewbRMD8w3u3tfSPt-Opy+i=jm_8W2+NtAP1OYSsA@mail.gmail.com>
Subject: Re: [PATCH v3 22/34] csky: Convert __pte_free_tlb() to use ptdescs
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_213641_538518_BCD85C95 
X-CRM114-Status: GOOD (  15.37  )
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

QWNrZWQtYnk6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPgoKT24gVGh1LCBKdW4gMSwgMjAy
MyBhdCA1OjM04oCvQU0gVmlzaGFsIE1vb2xhIChPcmFjbGUpCjx2aXNoYWwubW9vbGFAZ21haWwu
Y29tPiB3cm90ZToKPgo+IFBhcnQgb2YgdGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJs
ZSBjb25zdHJ1Y3Rvci9kZXN0cnVjdG9ycyB3aXRoCj4gcHRkZXNjIGVxdWl2YWxlbnRzLgo+Cj4g
U2lnbmVkLW9mZi1ieTogVmlzaGFsIE1vb2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwu
Y29tPgo+IC0tLQo+ICBhcmNoL2Nza3kvaW5jbHVkZS9hc20vcGdhbGxvYy5oIHwgNCArKy0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9jc2t5L2luY2x1ZGUvYXNtL3BnYWxsb2MuaCBiL2FyY2gvY3NreS9pbmNs
dWRlL2FzbS9wZ2FsbG9jLmgKPiBpbmRleCA3ZDU3ZTVkYTA5MTQuLjljODRjOTAxMmU1MyAxMDA2
NDQKPiAtLS0gYS9hcmNoL2Nza3kvaW5jbHVkZS9hc20vcGdhbGxvYy5oCj4gKysrIGIvYXJjaC9j
c2t5L2luY2x1ZGUvYXNtL3BnYWxsb2MuaAo+IEBAIC02Myw4ICs2Myw4IEBAIHN0YXRpYyBpbmxp
bmUgcGdkX3QgKnBnZF9hbGxvYyhzdHJ1Y3QgbW1fc3RydWN0ICptbSkKPgo+ICAjZGVmaW5lIF9f
cHRlX2ZyZWVfdGxiKHRsYiwgcHRlLCBhZGRyZXNzKSAgICAgICAgICAgICAgXAo+ICBkbyB7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+IC0gICAg
ICAgcGd0YWJsZV9wdGVfcGFnZV9kdG9yKHB0ZSk7ICAgICAgICAgICAgICAgICAgICAgXAo+IC0g
ICAgICAgdGxiX3JlbW92ZV9wYWdlKHRsYiwgcHRlKTsgICAgICAgICAgICAgICAgICAgICAgXAo+
ICsgICAgICAgcGFnZXRhYmxlX3B0ZV9kdG9yKHBhZ2VfcHRkZXNjKHB0ZSkpOyAgICAgICAgICAg
XAo+ICsgICAgICAgdGxiX3JlbW92ZV9wYWdlX3B0ZGVzYyh0bGIsIHBhZ2VfcHRkZXNjKHB0ZSkp
OyAgXAo+ICB9IHdoaWxlICgwKQo+Cj4gIGV4dGVybiB2b2lkIHBhZ2V0YWJsZV9pbml0KHZvaWQp
Owo+IC0tCj4gMi40MC4xCj4KCgotLSAKQmVzdCBSZWdhcmRzCiBHdW8gUmVuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxp
c3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
