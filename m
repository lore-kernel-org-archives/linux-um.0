Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085D0C77B7A
	for <linux-um@archiver.kernel.org>; Tue,  6 Jun 2023 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Z9tlKzRcSJ6HqLPATMLYBVr1nLrdazaUWI+HGfWU04=; b=d5Gv9TFW7Cr6sy
	mcfxsjHO7hwTWR8ZJ6fWPP4p2NKkj86yOOFTxQFRBQdI/ezx8zD4kBQujkRtX/dKGOe5WxS53HcxI
	5iAux6GoXn/2yFi+sFrI78m/1+g60QYRxYiRJH2xzx77AGpGVUom/t7l6GOokCV8aQOkLA5nPKj9b
	52sMsjzv0IcbZuDIejEktL9D59WB8V4WmD55YqHkj7d95zaRCBBbv4Y3may/i0/IpsDbWiOYFDvtR
	hb5Dn9jLmeR97V6NWNt03+Oa603G9QoIS0yH04FXR1zl9xTmmUUsd23n2LYF2E44nG4EueZpTPDU8
	YKCvCLI8NF+s2OUnAamg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6dv5-003GC6-1t;
	Tue, 06 Jun 2023 21:08:47 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6dv2-003GBM-0E
	for linux-um@lists.infradead.org;
	Tue, 06 Jun 2023 21:08:45 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so3696934f8f.1
        for <linux-um@lists.infradead.org>; Tue, 06 Jun 2023 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686085719; x=1688677719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ+tI/3uLBG3Hm6G+QtfUFEyGE7CCKdik+X8IMe59lQ=;
        b=q+BgJN8G10a0ZuOuN0UDx5Ro+/Sh5n3Z0AV4viAqhr6Es2Jx8P6aWMqFo1i2Tyb4jB
         eUZya8GS6kaJfF30rSFT/CtGWc8jazWug8LN24Yp7JWYmsjMDsZYyrwesFZP7TPaBvHn
         fHKP+9FGUPXlUziO0G6Dpcx1DlAH0mjGGq8ppUlMV4sN+PM1cx3SjokfuL7m7uXpibWh
         pZoVDrnrklHh/fO842OC6731MdoQBNLNy2r6wFpsnsKmoCO+YyrQcEAG8pYVHTZ0yKEF
         zZHOyiAS3zuhP6I16UGDb5YcEtyZQL1/Hd2GsFhnVR0me3SUrY5W3cO+pnD0ncaUfC/A
         LqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686085719; x=1688677719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ+tI/3uLBG3Hm6G+QtfUFEyGE7CCKdik+X8IMe59lQ=;
        b=FkbZWe3iQQT6rA7cS3BTay9+0e0Feja44OZNXzwbNyZzyb/4SqlQEH64lWL5jUjx2Q
         bUvkyGq83eFtaM/uiGIGVjcgxVsdN3OfLEIVYVvbbjtlaFEmggAOXDP9LiffXnty09Va
         JrxqS9JF17rTemQHu1quVhx0t5doDNMQFTnn0RfPwhPcwheNM9DSY3P5RZTxguXpWElp
         3v1qtQmM+yPBtPLgFwzjA9Xqzm3ZFsIJug8anIal09/h2B5QGIYRrpbSU1WRGVej5fJ8
         0JSMbZcRhBG7qdcbwBnLeDZCuGNRzI8DJvIhhhCR5OPibmumYCFdNrrWkqZYsON+jz29
         2MDw==
X-Gm-Message-State: AC+VfDyIFn1Kng8LWqbd1tyXrH6EdCP9pzUCwDSM+D7RJqZtMU4JAPJr
	+ERug0aUPqhwZPWzbxYRF2xMKZfZf0VC3feMbwI=
X-Google-Smtp-Source: ACHHUZ4xNaei4fJzTIQY4dmaevGm8MrT4Rb+z6/77A7OQ1Z4Wj5ccHIIgM9iRtQPNnRd1aFz5BXBANFG8PfPzmhAYVQ=
X-Received: by 2002:a05:6000:1952:b0:309:49e6:d1af with SMTP id
 e18-20020a056000195200b0030949e6d1afmr2609981wry.2.1686085719138; Tue, 06 Jun
 2023 14:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com> <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
In-Reply-To: <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
From: Azeem Shaikh <azeemshaikh38@gmail.com>
Date: Tue, 6 Jun 2023 17:08:27 -0400
Message-ID: <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
Subject: Re: [PATCH v2] uml: Replace strlcpy with strscpy
To: Richard Weinberger <richard@nod.at>
Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-hardening <linux-hardening@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, kernel test robot <lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_140844_129000_87977FBA 
X-CRM114-Status: GOOD (  15.11  )
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

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCA0OjUx4oCvUE0gUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD4gd3JvdGU6Cj4KPiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4g
PiBWb246ICJBemVlbSBTaGFpa2giIDxhemVlbXNoYWlraDM4QGdtYWlsLmNvbT4KPiA+IHN0cmxj
cHkoKSByZWFkcyB0aGUgZW50aXJlIHNvdXJjZSBidWZmZXIgZmlyc3QuCj4gPiBUaGlzIHJlYWQg
bWF5IGV4Y2VlZCB0aGUgZGVzdGluYXRpb24gc2l6ZSBsaW1pdC4KPiA+IFRoaXMgaXMgYm90aCBp
bmVmZmljaWVudCBhbmQgY2FuIGxlYWQgdG8gbGluZWFyIHJlYWQKPiA+IG92ZXJmbG93cyBpZiBh
IHNvdXJjZSBzdHJpbmcgaXMgbm90IE5VTC10ZXJtaW5hdGVkIFsxXS4KPiA+IEluIGFuIGVmZm9y
dCB0byByZW1vdmUgc3RybGNweSgpIGNvbXBsZXRlbHkgWzJdLCByZXBsYWNlCj4gPiBzdHJsY3B5
KCkgaGVyZSB3aXRoIHN0cnNjcHkoKS4KPiA+IE5vIHJldHVybiB2YWx1ZXMgd2VyZSB1c2VkLCBz
byBkaXJlY3QgcmVwbGFjZW1lbnQgaXMgc2FmZS4KPiA+Cj4gPiBbMV0gaHR0cHM6Ly93d3cua2Vy
bmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwjc3RybGNweQo+
ID4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy84OQo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IEF6ZWVtIFNoYWlraCA8YXplZW1zaGFpa2gzOEBnbWFpbC5jb20+Cj4gPiBS
ZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4gPiBDbG9zZXM6
Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMwNTMxMTEzNS56
R01UMWdZUi1sa3BAaW50ZWwuY29tLwo+Cj4gQXJlIHlvdSBzdXJlIFJlcG9ydGVkLWJ5IGFuZCBD
bG9zZXMgbWFrZSBzZW5zZT8KPiBBRkFJSyB0aGUgcmVwb3J0IHdhcyBvbmx5IG9uIHlvdXIgZmly
c3QgcGF0Y2ggYW5kIG5vdGhpbmcgYWdhaW5zdCB1cHN0cmVhbS4KPiBTbyBzdGF0aW5nIHRoaXMg
aW4gdGhlIHVwZGF0ZWQgcGF0Y2ggaXMgaW4gdmFpbi4KCkkgbGVmdCB0aGUgbWV0YWRhdGEgaW4g
b25seSBmb3IgdGhlIHNha2Ugb2YgcG9zdGVyaXR5LiBJZiBpdCdzIG5vdApoZWxwZnVsLCBJJ20g
b2sgd2l0aCByZW1vdmluZyBpdC4KCj4gT3RoZXIgdGhhbiB0aGF0LAo+IEFja2VkLWJ5OiBSaWNo
YXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgoKVGhhbmtzIQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0Cmxp
bnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC11bQo=
