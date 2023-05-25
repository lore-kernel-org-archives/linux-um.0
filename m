Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9148C77B7E
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kV9vLz7yc9iajRPNc5oW9LSOJ4QXRdwmVETOWjRSjek=; b=r3S2KybDn8239+
	OSEdIhYmV5XlhYVvOQzvMkjFmyazh6+/IwMauvDS2/FZ8EF1j31z5k1p/xTr07ZifcQJFgqA5tFmx
	Pr+jC0bloPlYIVQUF1JKIpCr9XGgGn7epW0isCWU0N9TpRNPwR6HkHFhoPwZDpyfl/gY6oT0/vR7k
	SdmQPym+wJh5A57PySqG0ffAguGwPu1t1PJuEjnDibHZgivTt63tx0L6xanul/CqCABf+Y4VQFy2l
	o90mczAG04lz2TmfYrY1ar7qyygqA43g7CNUFcHMCKRORv+yTTx58L1uc4z7Eo6CVsKlKZ/rL6hEy
	30A9DXABCGmv+MiLUpMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2EKS-00H9mp-35;
	Thu, 25 May 2023 17:00:44 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2EKO-00H9kv-2o;
	Thu, 25 May 2023 17:00:42 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba81031424dso1165562276.2;
        Thu, 25 May 2023 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685034035; x=1687626035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHrTsqL0nqeqxBvVw7n3mE3d9UFJpL2j8If6jZFByTc=;
        b=VEXX4D+/ehgygAWm5BmRxKMQVayX+huiD86BmHpUJbQZIavyZk8MqgFgBVJCgltW8G
         DGf1XLm8HhYD7C5Ltu5hncRV4xkFiRLvjnKAKUZAVqhHyZU7uDae6IK3C5qSD3GFgpGy
         OqLSmV63QlFHc9BLqOH+z3/46t/qsNvryv2gOmzRQJTarAzeFF3wkmaawd/u1vYzudf+
         2OoFyE7ArYkSpPwfiPG4wUCBT5egkmxxlXwXAVhzZYomT8xAIzGjfTrChNVAlbK2FaKO
         3t03QrSsNM3MzVGbAgb9jEqdKkZ/GGbY36ZIzPCKupNWpFQuCEQc+t41/FAd5d9jW5uu
         ry0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034035; x=1687626035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHrTsqL0nqeqxBvVw7n3mE3d9UFJpL2j8If6jZFByTc=;
        b=knXPZGNwHjkyXKJzWQVjaa2DVbyYcyorpX1fXaHt81OR33PIC/za1MxgaFsO5jYWLQ
         hrUR60k53mN3zsAGWnikMi4fRMRXi1o98+N7zn4VmeOBPr8A0pCCaqpIuK6Hvp7mt4Sf
         6d3wT+pAUU2RsdbCSDzcmuXjpufAoLeJHTtj9pTpEMvffXICIE5Epn2XUqjA8H1p89wv
         kess3b92IV5eA0sonNrdGr1+0RULvscQtW8ovarOmesZ2/+Sgkn0/wbtZniKJA4XDgG4
         /xQSGOdsxBzIZuqVdNB/x/pTRg43eR6I9xAh51c0mXPT1pTRRt/8LTPGRWmy1xDhop/7
         SR+w==
X-Gm-Message-State: AC+VfDzxqKCAwcX3ekflBAQ8ReXFixDlEXldgFK3osi8ETeymJFkBQ0O
	tuz8r8W15yoQnR97ydt2bJIG1puA91B7wlJw3A0=
X-Google-Smtp-Source: ACHHUZ47ymCJWriUjad8DQ05hIMcCKin/PTMMU7nNv3HHwEyV9e0xB3DhHdcf1Fkkg8cgW7lAUtL7p6ayG4dp+Ur5MI=
X-Received: by 2002:a25:2487:0:b0:ba8:5ded:13f3 with SMTP id
 k129-20020a252487000000b00ba85ded13f3mr4152229ybk.17.1685034034679; Thu, 25
 May 2023 10:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-2-vishal.moola@gmail.com> <20230525085555.GV4967@kernel.org>
In-Reply-To: <20230525085555.GV4967@kernel.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 25 May 2023 10:00:23 -0700
Message-ID: <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
Subject: Re: [PATCH v2 01/34] mm: Add PAGE_TYPE_OP folio functions
To: Mike Rapoport <rppt@kernel.org>
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
X-CRM114-CacheID: sfid-20230525_100040_906844_A91C05DE 
X-CRM114-Status: GOOD (  10.33  )
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMTo1NuKAr0FNIE1pa2UgUmFwb3BvcnQgPHJwcHRAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBIaSwKPgo+IE9uIE1vbiwgTWF5IDAxLCAyMDIzIGF0IDEyOjI3
OjU2UE0gLTA3MDAsIFZpc2hhbCBNb29sYSAoT3JhY2xlKSB3cm90ZToKPiA+IE5vIGZvbGlvIGVx
dWl2YWxlbnRzIGZvciBwYWdlIHR5cGUgb3BlcmF0aW9ucyBoYXZlIGJlZW4gZGVmaW5lZCwgc28K
PiA+IGRlZmluZSB0aGVtIGZvciBsYXRlciBmb2xpbyBjb252ZXJzaW9ucy4KPgo+IENhbiB5b3Ug
cGxlYXNlIGVsYWJvcmF0ZSB3aHkgd291bGQgd2UgbmVlZCBmb2xpb3MgZm9yIHBhZ2UgdGFibGUg
ZGVzY3JpcHRvcnM/CgpUaGFua3MgZm9yIHRoZSByZXZpZXchCgpUaGVzZSBtYWNyb3MgYXJlIGZv
ciBjYWxsZXJzIHRoYXQgY2FyZSBhYm91dCB0aGUgcGFnZSB0eXBlLCBpLmUuIFRhYmxlIGFuZApC
dWRkeS4gQXNpZGUgZnJvbSBhY2NvdW50aW5nIGZvciB0aG9zZSBjYXNlcywgdGhlIHBhZ2UgdGFi
bGVzIGRvbid0IHVzZSBmb2xpb3MuClRoZXNlIGFyZSBtb3JlIGZvciB0aGUgY2xlYW5saW5lc3Mg
b2YgdGhvc2UgY2FsbGVycy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
