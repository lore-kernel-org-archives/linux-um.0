Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2079DC46467
	for <linux-um@archiver.kernel.org>; Wed,  4 Jan 2023 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u/P+ouPll4+T3t0AuaB6GHutqstIZwOljFbr0eh7JFE=; b=sOCeqJ4l8nSEIm
	g/bcuzUSrrXQOQ3Y38EHEULmbx+9djaWBd67ZsAMTIHaWsgD4Uyl6yQ/gjLhB7ZGcqUW7Qchh8M9r
	v6gYWo5tpBhWhBqCWagcJ1P56x8+J4bMA86aLcOaYduI1Fc6ZoXIl7+nlEUc4FCawuUWOxgJFWyQE
	PQI/XUyvhatZANIZ6Jt203zcy4k/c1Dswapc+g9sDk92uvDxRvkBvbkk50lDT0vMsXPT6XQFhWF07
	9EsnPkXXfMlS+ky9uniZkez4SzzHyMKO55Ko1Pj1HqG+OwUxzdpxTw08jVeuw8JYZ/qTzoxeb7uk8
	4kvK8QRHayAbkhSV3sjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD5Xl-00A30c-DW; Wed, 04 Jan 2023 15:19:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD5E5-009tcT-Rj; Wed, 04 Jan 2023 14:58:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5FBAB61738;
	Wed,  4 Jan 2023 14:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DEBC43392;
	Wed,  4 Jan 2023 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672844324;
	bh=X1AAIn1JCwOQYsbeGXY+bK+m5zW1QQ+OXoCh04OSGhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsWfbzf6UpefT3nvlAW2+mmoBZrvwGHtzuXTpJea+7S8F1k14QDJtXD3pDFtSR6Ri
	 nQKqkkzHY9XYQ0LRMdhZEab7uq7ZRguwsS4V9o6ZOn09ynNhaOZqHXZiDXTKBJvWIJ
	 QEfIhnNjk0Lhsbcw169G+inpEOZjPBgMctZi3PgoOR0+Ovfnk1YTzCy1k17H4YIVot
	 phl0bc/AeGj3Hlyx3vhJT7xqbsK5IxJLdWTCfv0TIX7rEkZUaVYY2WCFM7lAPa2m3Z
	 W3w6yCaukh7TK7SsxE57XdRGg8K5hc1+pucJiNpMVjljGf2yJ5jRvSQVb83rtOT1ZY
	 4YyP56K2uDI7Q==
Date: Wed, 4 Jan 2023 14:58:39 +0000
From: Lee Jones <lee@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org,
	Andres Salomon <dilinger@queued.net>,
	linux-geode@lists.infradead.org
Subject: Re: [PATCH] mfd: cs5535: don't build on UML
Message-ID: <Y7WUHyHiJbAgXcaM@google.com>
References: <20221201012541.11809-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221201012541.11809-1-rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_065846_181060_19C00C4D 
X-CRM114-Status: GOOD (  14.99  )
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

T24gV2VkLCAzMCBOb3YgMjAyMiwgUmFuZHkgRHVubGFwIHdyb3RlOgoKPiBUaGUgY3M1NTM1LW1m
ZCBkcml2ZXIgdXNlcyBDUFUtc3BlY2lmaWMgZGF0YSB0aGF0IGlzIG5vdCBhdmFpbGFibGUKPiBm
b3IgQVJDSD11bSBidWlsZHMsIHNvIGRvbid0IGFsbG93IGl0IHRvIGJlIGJ1aWx0IGZvciBVTUwu
Cj4gCj4gUHJldmVudHMgdGhlc2UgYnVpbGQgZXJyb3JzOgo+IAo+IEluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAuLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9vbHBjLmg6NywKPiAgICAgICAgICAgICAgICAg
IGZyb20gLi4vZHJpdmVycy9tZmQvY3M1NTM1LW1mZC5jOjE3Ogo+IC4uL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2dlb2RlLmg6IEluIGZ1bmN0aW9uIOKAmGlzX2dlb2RlX2d44oCZOgo+IC4uL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6MTY6MzE6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191
beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4Nl92ZW5kb3LigJkKPiAgICAxNiB8ICAgICAg
ICAgcmV0dXJuICgoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfTlNDKSAm
Jgo+IC4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6MTY6NDY6IGVycm9yOiDigJhYODZf
VkVORE9SX05TQ+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRp
ZCB5b3UgbWVhbiDigJhYODZfVkVORE9SX0FOWeKAmT8KPiAgICAxNiB8ICAgICAgICAgcmV0dXJu
ICgoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfTlNDKSAmJgo+IC4uL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6MTc6MzE6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5m
b191beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4NuKAmQo+ICAgIDE3IHwgICAgICAgICAg
ICAgICAgIChib290X2NwdV9kYXRhLng4NiA9PSA1KSAmJgo+IC4uL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2dlb2RlLmg6MTg6MzE6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKAmSBoYXMgbm8g
bWVtYmVyIG5hbWVkIOKAmHg4Nl9tb2RlbOKAmQo+ICAgIDE4IHwgICAgICAgICAgICAgICAgIChi
b290X2NwdV9kYXRhLng4Nl9tb2RlbCA9PSA1KSk7Cj4gLi4vYXJjaC94ODYvaW5jbHVkZS9hc20v
Z2VvZGUuaDogSW4gZnVuY3Rpb24g4oCYaXNfZ2VvZGVfbHjigJk6Cj4gLi4vYXJjaC94ODYvaW5j
bHVkZS9hc20vZ2VvZGUuaDoyMzozMTogZXJyb3I6IOKAmHN0cnVjdCBjcHVpbmZvX3Vt4oCZIGhh
cyBubyBtZW1iZXIgbmFtZWQg4oCYeDg2X3ZlbmRvcuKAmQo+ICAgIDIzIHwgICAgICAgICByZXR1
cm4gKChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQpICYmCj4gLi4v
YXJjaC94ODYvaW5jbHVkZS9hc20vZ2VvZGUuaDoyMzo0NjogZXJyb3I6IOKAmFg4Nl9WRU5ET1Jf
QU1E4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBt
ZWFuIOKAmFg4Nl9WRU5ET1JfQU5Z4oCZPwo+ICAgIDIzIHwgICAgICAgICByZXR1cm4gKChib290
X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQpICYmCj4gLi4vYXJjaC94ODYv
aW5jbHVkZS9hc20vZ2VvZGUuaDoyNDozMTogZXJyb3I6IOKAmHN0cnVjdCBjcHVpbmZvX3Vt4oCZ
IGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYeDg24oCZCj4gICAgMjQgfCAgICAgICAgICAgICAgICAg
KGJvb3RfY3B1X2RhdGEueDg2ID09IDUpICYmCj4gLi4vYXJjaC94ODYvaW5jbHVkZS9hc20vZ2Vv
ZGUuaDoyNTozMTogZXJyb3I6IOKAmHN0cnVjdCBjcHVpbmZvX3Vt4oCZIGhhcyBubyBtZW1iZXIg
bmFtZWQg4oCYeDg2X21vZGVs4oCZCj4gICAgMjUgfCAgICAgICAgICAgICAgICAgKGJvb3RfY3B1
X2RhdGEueDg2X21vZGVsID09IDEwKSk7Cj4gCj4gRml4ZXM6IDY4ZjVkM2YzYjY1NCAoInVtOiBh
ZGQgUENJIG92ZXIgdmlydGlvIGVtdWxhdGlvbiBkcml2ZXIiKQo+IFNpZ25lZC1vZmYtYnk6IFJh
bmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPgo+IENjOiBKb2hhbm5lcyBCZXJnIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IENjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hh
cmRAbm9kLmF0Pgo+IENjOiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IEFuZHJl
cyBTYWxvbW9uIDxkaWxpbmdlckBxdWV1ZWQubmV0Pgo+IENjOiBsaW51eC1nZW9kZUBsaXN0cy5p
bmZyYWRlYWQub3JnCj4gQ2M6IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+Cj4gLS0tCj4gIGRy
aXZlcnMvbWZkL0tjb25maWcgfCAgICAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspCgpBcHBsaWVkLCB0aGFua3MKCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
