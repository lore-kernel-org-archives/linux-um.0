Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D103EB64D9
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w33iX6JMy7dRVqVUyL+WkWdC0ox5bimuuVFBiDB1HLA=; b=AhPKlX750BS5sy
	dQT7ymASLq5GDwGx5O08aJUoEGMFJ0cNaaF0T7RsDlXxc7IrI3/IWsc8nNfsoaHkBs20YA+3cV1Ln
	zOXG5+r8bC/Qm5apSwcWJEfAdjWg1W+mWoZrObvkrEzbKR9AtTkkFIjTf3o11pr2hNUyOsV7mZ3s5
	9MRHRQrCDWzewl/bWMilHA1scSecvq3IkABwI4XusLdUCkuKr9FUduGLb0yc8xxo5AeZJdMiKJOgf
	RVOLmnFyfeAnt9thF/D2jZnjnv/phofWlvMIYHsq7wOGfj5RWqVfYXL7xUWOxvCh627J3OMZRdSOy
	YB7EX6DjiRPusYTwY26w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEChu-00Dkad-13;
	Tue, 27 Jun 2023 17:42:26 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEChq-00DkYH-1S;
	Tue, 27 Jun 2023 17:42:23 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5702116762fso52300127b3.3;
        Tue, 27 Jun 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687887739; x=1690479739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i618d6TBDc9eRPjFDJkpeqKfOfbO3uM7uCEV9XLltFk=;
        b=HvOjTHjCD8itMm1xp5AnK/TmYH5tQiF1El2gyMO5zpqTY4wM1G2ir3ku6089UY1inQ
         ilXwuLjIDRYIMPHiQPHPbFQRy/hIa9oVwH0QYqAm53mZsyIpL6HgYzNNL/NNLIh2SC53
         /Joi55NqQPacIQIaSPLnjCH7o6qvV31ICWbCQ8IiY+RsTUhqfYiVoVRzcNBSzvMpURs/
         f/RKmZePqghHrHdV5n1so0lsBS2EaZX77ICe7eDI+jllhbMiPBHJhxnD9h+Hh+PnGjAo
         7epexu03a+N5aJGPnt128CQw+E8IVZS3OeUo6R0hlPLkskRaMfOu6WUJJOIpsapTfYI9
         tHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887739; x=1690479739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i618d6TBDc9eRPjFDJkpeqKfOfbO3uM7uCEV9XLltFk=;
        b=kTvm71UxO1g6QLZptZSij6eisMwpfcX/ppP1z99x25PQyJNeZY2z93n8RHhc6HZyr4
         Kcpk8vAX3bsHx4Qv6/pmer4se7YDwquvrJBj71QdTexKuyvcmVQG7859Wb5wkAGJQ7QP
         LmB1MQV+GrbnRQJj/IWVXxS+aaupLUeqwgB1v2sGPnN99cUmoBl3iqrx+N9pPeFALZbY
         tmj7wC+6t2AY3HFa06OsSnCz1sexp5MlMCQkw4UmNhzJYTnDrOkx/X0zP/matOqo1vTD
         p+pFxVz1rteCpZP3AfiMVTtCGn63S7Eo7kcR9xaB4UXApqt+Z/d9x2wAtlV5d86nxV0K
         gclQ==
X-Gm-Message-State: AC+VfDw0Cy5KQ98gnHvnUymewIS0cqLWqqSR5DBQwp1NQjBBe/Xqu5Mk
	NkyxjCg2g12nEmnRbwICvbA3RD2GXF6fnDQC7ks=
X-Google-Smtp-Source: ACHHUZ5ixDfcfZvsP+Sk9Q2uIR96dLCuXZPewVmRsckC25R1Wt8J/1BC8EjmOgQOvqL4+PjmfxQNP2ok9/vuUSXcV8M=
X-Received: by 2002:a25:86c8:0:b0:c16:ba32:1b1c with SMTP id
 y8-20020a2586c8000000b00c16ba321b1cmr8446597ybm.58.1687887738923; Tue, 27 Jun
 2023 10:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com> <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
In-Reply-To: <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 27 Jun 2023 10:42:07 -0700
Message-ID: <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>, Mike Rapoport <rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_104222_488691_8150F0C7 
X-CRM114-Status: GOOD (  12.26  )
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

T24gTW9uLCBKdW4gMjYsIDIwMjMgYXQgMTA6NDfigK9QTSBHdWVudGVyIFJvZWNrIDxsaW51eEBy
b2Vjay11cy5uZXQ+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdW4gMjIsIDIwMjMgYXQgMDE6NTc6MzhQ
TSAtMDcwMCwgVmlzaGFsIE1vb2xhIChPcmFjbGUpIHdyb3RlOgo+ID4gUGFydCBvZiB0aGUgY29u
dmVyc2lvbnMgdG8gcmVwbGFjZSBwZ3RhYmxlIGNvbnN0cnVjdG9yL2Rlc3RydWN0b3JzIHdpdGgK
PiA+IHB0ZGVzYyBlcXVpdmFsZW50cy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9v
bGEgKE9yYWNsZSkgPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+Cj4gPiBBY2tlZC1ieTogTWlrZSBS
YXBvcG9ydCAoSUJNKSA8cnBwdEBrZXJuZWwub3JnPgo+Cj4gVGhpcyBwYXRjaCBjYXVzZXMgYWxs
IG5pb3MyIGJ1aWxkcyB0byBmYWlsLgoKSXQgbG9va3MgbGlrZSB5b3UgdHJpZWQgdG8gYXBwbHkg
dGhpcyBwYXRjaCBvbiBpdHMgb3duLiBUaGlzIHBhdGNoIGRlcGVuZHMKb24gcGF0Y2hlcyAwMS0x
MiBvZiB0aGlzIHBhdGNoc2V0IHRvIGNvbXBpbGUgcHJvcGVybHkuIEkndmUgY3Jvc3MtY29tcGls
ZWQKdGhpcyBhcmNoaXRlY3R1cmUgYW5kIGl0IHdvcmtlZCwgYnV0IGxldCBtZSBrbm93IGlmIHNv
bWV0aGluZyBmYWlscwp3aGVuIGl0cyBhcHBsaWVkIG9uIHRvcCBvZiB0aG9zZSBwYXRjaGVzIChv
ciB0aGUgcmVzdCBvZiB0aGUgcGF0Y2hzZXQpLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC11bQo=
