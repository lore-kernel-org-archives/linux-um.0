Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6B9C5AC7C
	for <linux-um@archiver.kernel.org>; Fri,  7 Aug 2026 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:From:Subject:Cc:To:
	Message-Id:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zwDbWjZ+F+dYN5AWbUE6xH1Ki2RHVpIpeS0Dji7EX6s=; b=PmVHzRKirrZQDL2Oa5+cTprFKR
	8HJMBevGp+WSkESrIAWs+09zOUClr5tkOZbhYv3Ujj49y9bc6aAuyg6lnZEEgT85ldI/NiSh212rB
	UCjeoftvdA1tT03ibXplF6EJ6Dp7fF6jIg+YLIjKjtCqCfHJfVlWfj2GTm5w38K907JGPp1V5BQ4b
	lY81A/xCVpae+MHGmsLsrFttNciLT4UM+pq6toHavNXDlk5L5lbBs/GhuDoCT68jGC1Zox/z1TWPy
	+1Bco8+CzfhwHLLfZy8SxV9sDjzUE8oPJTQCLqdfX12mbDSUyc6yiGi2sZcj1gXkPlOFavGY2dQxc
	rJmLpckQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsIbw-00000007qWd-3c19;
	Fri, 07 Aug 2026 11:19:36 +0000
Received: from flow-b7-smtp.messagingengine.com ([202.12.124.142])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsIbt-00000007qUW-1zSt
	for linux-um@lists.infradead.org;
	Fri, 07 Aug 2026 11:19:34 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id B2EA013001B3;
	Fri,  7 Aug 2026 07:19:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Aug 2026 07:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786101569;
	 x=1786105169; bh=zwDbWjZ+F+dYN5AWbUE6xH1Ki2RHVpIpeS0Dji7EX6s=; b=
	FdKyCp1P5OxUffLpK0ALb147bFxYffDPiSyv7zTFQLUQcVDYIiGUb63C8RhLPGsi
	6ex3aD0qbydGQZlrbQxO+JlR4o9Ed/jwhdc06YatDzr7GkjBKgEyEaz0U7XRn6iM
	bVsMO//nXfJYV8+okYPt1Q77irvkcpQpsuqCKXnjqstPjeFei0klhfXMC5PdX88o
	3fnaseK6byDgQ3DJdFwtXLa7xHSPlG/eXLAX41FGUBeRheJ33neOJwEw5J32D68N
	/biwFWUxAeuopQvVdIuRVJPLWKzDV42QRIH0Hyv9qB1P4G+prfIpvplvyhcUKwym
	cjoVokgBN2OwrjTS49si7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786101569; x=
	1786105169; bh=zwDbWjZ+F+dYN5AWbUE6xH1Ki2RHVpIpeS0Dji7EX6s=; b=D
	pDUu1cDpCNMn7NkCAAaPl97mc75kH5BDt/xwqHc1iuDV5vO9wWYgTYwdEfqbTMox
	R6kWYCeRAeuiLBVjrmAPdKFgJGZsm2PhhqFn+W9QACZn3S1W+l/8gjeJsa16ylyQ
	SRvX6Cp8aiRJffPm1l0LvnsjR4VzxdiopqsBbGiQ7JKiVkZ+sFxzApkUDk6ly5x4
	J+y6lloU45/JVR+QOEYlYb3fz64W7tp0sF6WhKFSI4ZR42+87EG24vnXQ1G0wjNC
	tsNa548WZ3vtsvsbxi+RDtX56EI11gWqP/7WL2LnygGMZm1yzC3SW9KrxY5Z0nqv
	bpqLZoe4OMYUTCJDvVLZw==
X-ME-Sender: <xms:QL91aipULUjBhTbgcoaRhxqY24lYomAhVZzjva9TwlbnFrtgC48t3g>
    <xme:QL91ah9DdBXnOeJFkTXXpjZT6gz7kgvD7bLl9MqAs1M2rEyEKib5dXeppcE2khsXJ
    RILrSDjRXnnlf-xXMZ_3xBG-7iwfSPcEdOkHmx4mb4XtMcdRb8a9Bk>
X-ME-Received: <xmr:QL91ar1ykfQavbNTrmp8Wuzd29-q7Ea3xFyR1qonNPqHTy96P0GmWqMkgDgOtD3D_JgN0gwmHHSidoAS3x8nG14a>
X-ME-Proxy-Cause: dmFkZTEdBjjHuWv0Sw9dQDcqqfH4lb+njY4y0fsPCkON3454tsrUpVf+9rxqVq1Ax3NiaS
    hs7s/3eDu6QxL4EqX1BGDBHqx2GqPAgoWnouPOzIZ1dey65QhpvDP/edNs0h0/LAtcMmr/
    LFeHkdrnWJ2PFu2JgTOjVLaYZZLDs+Azh4zCWmXS/CFFlD2t5imOCG+fJXnnw9sWxTJ3d2
    gcsjz7OkrvZDj4bHpb8Cbd2qPVn0IMEB5nuTnU8g9Jf5mmxmI8jy7v/oGYT2n3L9kssXO7
    EfoS+7c1jD8TW1iRciozZ+tsM+gq1j41jo+WHyF+Oc7kb2may6lPxEACafahXe1pg+aGbk
    LNzHY9/osVatmYKpV0HHIL+Vv07ZGyoOYz1tzJbBoxaRA2BN/QzsAY/8782iukwdC9UrGW
    inPbI12VVRczRhy5C67temcGQ2MGIQuD/qOqW5zCm9OE2yaBn6WE9VJPHH5OSRbIHb8wW4
    HvQ5Z9GsP5Sw/p2jVhxYBu5wahFQtfUijkRAk6b2q49bOaFF4zfe4eo34G7c3lUmrwsLln
    dTOGlHwNdefap9rlD2dnG95oqhRwCUXP8bLmEDLOBj1wePhLlgk6pGirINA309fyKpaKzb
    0dELhTzKEb3GRRdXlUTX4At83apsq/EvJjOOeCxKU19m05qb6KFcGXwcsnHQ
X-ME-Proxy: <xmx:QL91aklQ-yWuS5GEID_ZIpKhgJhDB-Si3brRPJP4vYUK1Eco4eJHCw>
    <xmx:QL91ao1ilI0DTTVguVjS4J7JV_CUfD4xfUM2a5mKEp5d3Kzd7gZkBQ>
    <xmx:QL91ajhrIdQbZUZJyGCPJSQ4dLTSSyzQ_w0en9-rXjwxFOasrMh4ZQ>
    <xmx:QL91amU67ZSMNL_1VzvFvj1sff3e_iXjWD0WnqxSkzN_fXhanEKufg>
    <xmx:Qb91as40BQWtSD6o6G4RrgivA0NiJ3DdS684SRwVNT_NxZ5_KtedvXCv>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 07:19:23 -0400 (EDT)
Date: Fri, 07 Aug 2026 20:19:19 +0900 (JST)
Message-Id: <20260807.201919.866808779586212952.tomo@flapping.org>
To: miguel.ojeda.sandonis@gmail.com
Cc: tomo@flapping.org, ojeda@kernel.org, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
 daniel.almeida@collabora.com, gary@garyguo.net, lossin@kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org,
 fujita.tomonori@gmail.com, david@davidgow.net
Subject: Re: [PATCH v1] rust: bug: fix warn_on macro build error on UML
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <CANiq72kzmPnu_UPHryLMSwGMmTruirNUL5H+aD4tMiNUqqRELw@mail.gmail.com>
References: <20260801022501.722493-1-tomo@flapping.org>
	<CANiq72kzmPnu_UPHryLMSwGMmTruirNUL5H+aD4tMiNUqqRELw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_041933_689963_0559AA6B 
X-CRM114-Status: UNSURE (   9.73  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gRnJpLCA3IEF1ZyAyMDI2IDA4OjUyOjM4ICswMjAwDQpNaWd1ZWwgT2plZGEgPG1pZ3VlbC5v
amVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIFNhdCwgQXVnIDEsIDIwMjYg
YXQgNTo0MeKAr0FNIEZVSklUQSBUb21vbm9yaSA8dG9tb0BmbGFwcGluZy5vcmc+IHdyb3RlOg0K
Pj4NCj4+IFVzZSB0aGUgZnJlZSBmdW5jdGlvbiBgYXNfY2hhcl9wdHJfaW5fY29uc3RfY29udGV4
dCgpYCBpbnN0ZWFkLCBhcyBvdGhlciBleHBvcnRlZCBtYWNyb3MgYWxyZWFkeSBkby4NCj4gDQo+
IEkgcmVwcm9kdWNlZCB0aGlzIGFuZCB0aGUgZml4IHdvcmtzIC0tIHRoYW5rcyBUb21vbm9yaSEN
Cj4gDQo+IERvIHdlIG5lZWQgdG8gdXNlIHRoZSBmcmVlIGZ1bmN0aW9uPyBpLmUuIHRoaXMgaXMg
bm90IGEgY29uc3QgY29udGV4dCwNCj4gc28gc2hvdWxkIHdlIGRvIGUuZy4NCj4gDQo+ICAgICAk
Y3JhdGU6OnN0cjo6Q1N0ckV4dDo6YXNfY2hhcl9wdHINCj4gDQo+ID8NCg0KVGhhbmtzLCB5b3Ug
YXJlIHJpZ2h0LiBJJ2xsIHNlbmQgdjIgc2hvcnRseS4NCg0KPiBBbHNvOg0KPiANCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCg0KT2suDQo=

