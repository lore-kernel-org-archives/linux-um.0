Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndz2f-00AEJI-RN
 for linux-um@lists.infradead.org; Mon, 11 Apr 2022 18:45:39 +0000
Date: Mon, 11 Apr 2022 20:45:24 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1287561645.244713.1649702724736.JavaMail.zimbra@nod.at>
In-Reply-To: <YlRp9KR1mp3/4Txo@thelio-3990X>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
 <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
 <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
 <YlRp9KR1mp3/4Txo@thelio-3990X>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Zhen Lei <thunder.leizhen@huawei.com>, Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, regressions <regressions@lists.linux.dev>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIk5hdGhhbiBDaGFuY2VsbG9y
IiA8bmF0aGFuQGtlcm5lbC5vcmc+Cj4gSSBhdHRlbXB0ZWQgdG8gcHJpbnQgb3V0IHRoZSBlcnJv
ciBjb2RlIGJ1dCBpdCBzZWVtcyBsaWtlIHRoZXJlIGlzIG5vCj4gb3V0cHV0IGluIHRoZSBjb25z
b2xlIGFmdGVyICJyZWJvb3Q6IFN5c3RlbSBoYWx0ZWQiLiBJZiBJIGFkZCBhbgo+IHVuY29uZGl0
aW9uYWwgcHJpbnQgcmlnaHQgYmVmb3JlIHRoZSBjYWxsIHRvIG9zX3NldF9mZF9ibG9jaygpLCBJ
IHNlZSBpdAo+IGR1cmluZyBzdGFydCB1cCBidXQgSSBkbyBub3Qgc2VlIGl0IGR1cmluZyBzaHV0
ZG93bi4gSXMgdGhlcmUgc29tZSB3YXkKPiB0byBzZWUgdGhhdCBjb25zb2xlIG91dHB1dCBkdXJp
bmcgc2h1dGRvd24/CgpJIHRoaW5rIGluIHRoaXMgY2FzZSB0aGUgZWFzaWVzdCB3YXkgaXMgYXR0
YWNoaW5nIGdkYiB3aXRoIGEgYnJlYWtwb2ludC4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5n
IGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

