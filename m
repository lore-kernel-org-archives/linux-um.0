Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrvoA-00AiEL-3f
 for linux-um@lists.infradead.org; Fri, 20 May 2022 06:08:19 +0000
Message-ID: <e9597cbc-cabb-facf-deb6-662d40cf16a3@leemhuis.info>
Date: Fri, 20 May 2022 08:08:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
Content-Language: en-US
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
 <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
 <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
 <YlRp9KR1mp3/4Txo@thelio-3990X>
 <1287561645.244713.1649702724736.JavaMail.zimbra@nod.at>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <1287561645.244713.1649702724736.JavaMail.zimbra@nod.at>
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
To: Richard Weinberger <richard@nod.at>, Nathan Chancellor <nathan@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Zhen Lei <thunder.leizhen@huawei.com>, Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, regressions <regressions@lists.linux.dev>

T24gMTEuMDQuMjIgMjA6NDUsIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToKPiAtLS0tLSBVcnNw
csO8bmdsaWNoZSBNYWlsIC0tLS0tCj4+IFZvbjogIk5hdGhhbiBDaGFuY2VsbG9yIiA8bmF0aGFu
QGtlcm5lbC5vcmc+Cj4+IEkgYXR0ZW1wdGVkIHRvIHByaW50IG91dCB0aGUgZXJyb3IgY29kZSBi
dXQgaXQgc2VlbXMgbGlrZSB0aGVyZSBpcyBubwo+PiBvdXRwdXQgaW4gdGhlIGNvbnNvbGUgYWZ0
ZXIgInJlYm9vdDogU3lzdGVtIGhhbHRlZCIuIElmIEkgYWRkIGFuCj4+IHVuY29uZGl0aW9uYWwg
cHJpbnQgcmlnaHQgYmVmb3JlIHRoZSBjYWxsIHRvIG9zX3NldF9mZF9ibG9jaygpLCBJIHNlZSBp
dAo+PiBkdXJpbmcgc3RhcnQgdXAgYnV0IEkgZG8gbm90IHNlZSBpdCBkdXJpbmcgc2h1dGRvd24u
IElzIHRoZXJlIHNvbWUgd2F5Cj4+IHRvIHNlZSB0aGF0IGNvbnNvbGUgb3V0cHV0IGR1cmluZyBz
aHV0ZG93bj8KPiAKPiBJIHRoaW5rIGluIHRoaXMgY2FzZSB0aGUgZWFzaWVzdCB3YXkgaXMgYXR0
YWNoaW5nIGdkYiB3aXRoIGEgYnJlYWtwb2ludC4KCkkgbm90aWNlZCB0aGlzIGluIG15IGxpc3Qg
b2Ygb3BlbiByZWdyZXNzaW9ucy4gSXQgc2VlbXMgdGhlcmUgd2Fzbid0IGFueQpwcm9ncmVzcyB0
byBnZXQgdGhpcyByZWdyZXNzaW9uIGZpeGVkIChwbGVhc2UgbGV0IG1lIGtub3cgaW4gY2FzZSBJ
Cm1pc3NlZCBzb21ldGhpbmcpLCBidXQgSSBndWVzcyBub2JvZHkgY29uc2lkZXJlZCBpdCB1cmdl
bnQgd2hpY2ggaXMKbGlrZWx5IG5vdCB0aGF0IG11Y2ggb2YgYSBwcm9ibGVtIGluIHRoaXMgY2Fz
ZS4gSGVuY2UgSSdtIG1vdmluZyB0aGlzIHRvCnRoZSBiYWNrLWJ1cm5lcjoKCiNyZWd6Ym90IGJh
Y2tidXJuZXI6IHNwZWNpYWwgY2FzZSBhbmQgVU1MIGEgbGVpc3VyZSBwdXJzdWl0IGZvciB0aGUK
bWFpbnRhaW5lcgoKQ2lhbywgVGhvcnN0ZW4gKHdlYXJpbmcgaGlzICd0aGUgTGludXgga2VybmVs
J3MgcmVncmVzc2lvbiB0cmFja2VyJyBoYXQpCgpQLlMuOiBBcyB0aGUgTGludXgga2VybmVsJ3Mg
cmVncmVzc2lvbiB0cmFja2VyIEkgZGVhbCB3aXRoIGEgbG90IG9mCnJlcG9ydHMgYW5kIHNvbWV0
aW1lcyBtaXNzIHNvbWV0aGluZyBpbXBvcnRhbnQgd2hlbiB3cml0aW5nIG1haWxzIGxpa2UKdGhp
cy4gSWYgdGhhdCdzIHRoZSBjYXNlIGhlcmUsIGRvbid0IGhlc2l0YXRlIHRvIHRlbGwgbWUgaW4g
YSBwdWJsaWMKcmVwbHksIGl0J3MgaW4gZXZlcnlvbmUncyBpbnRlcmVzdCB0byBzZXQgdGhlIHB1
YmxpYyByZWNvcmQgc3RyYWlnaHQuCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==

