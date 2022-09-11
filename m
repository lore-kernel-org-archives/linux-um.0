Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXD5C-00FbXB-A0
	for linux-um@lists.infradead.org; Sun, 11 Sep 2022 02:52:31 +0000
Subject: Re: [PATCH -next 1/2] um: virt-pci: add __init/__exit annotations to
 module init/exit funcs
From: xiujianfeng <xiujianfeng@huawei.com>
References: <20220911024350.17444-1-xiujianfeng@huawei.com>
Message-ID: <652e3501-3a7c-7806-0bd0-cb2a81db0c1c@huawei.com>
Date: Sun, 11 Sep 2022 10:52:26 +0800
MIME-Version: 1.0
In-Reply-To: <20220911024350.17444-1-xiujianfeng@huawei.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, mst@redhat.com, vincent.whitchurch@axis.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

c29ycnksIGJhZCBwYXRjaCBmb3JtYXQsIGRyb3AgaXQuCgrU2iAyMDIyLzkvMTEgMTA6NDMsIFhp
dSBKaWFuZmVuZyDQtLXAOgo+IEFkZCBtaXNzaW5nIF9faW5pdC9fX2V4aXQgYW5ub3RhdGlvbnMg
dG8gbW9kdWxlIGluaXQvZXhpdCBmdW5jcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBYaXUgSmlhbmZl
bmcgPHhpdWppYW5mZW5nQGh1YXdlaS5jb20+Cj4gLS0tCj4gICBhcmNoL3VtL2RyaXZlcnMvdmly
dC1wY2kuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC91bS9kcml2ZXJzL3ZpcnQtcGNpLmMg
Yi9hcmNoL3VtL2RyaXZlcnMvdmlydC1wY2kuYwo+IGluZGV4IDAyNzg0NzAyMzE4NC4uYWNiNTVi
MzAyYjE0IDEwMDY0NAo+IC0tLSBhL2FyY2gvdW0vZHJpdmVycy92aXJ0LXBjaS5jCj4gKysrIGIv
YXJjaC91bS9kcml2ZXJzL3ZpcnQtcGNpLmMKPiBAQCAtODU3LDcgKzg1Nyw3IEBAIHZvaWQgKnBj
aV9yb290X2J1c19md25vZGUoc3RydWN0IHBjaV9idXMgKmJ1cykKPiAgIAlyZXR1cm4gdW1fcGNp
X2Z3bm9kZTsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgaW50IHVtX3BjaV9pbml0KHZvaWQpCj4gK3N0
YXRpYyBpbnQgX19pbml0IHVtX3BjaV9pbml0KHZvaWQpCj4gICB7Cj4gICAJaW50IGVyciwgaTsK
PiAgIAo+IEBAIC05NDAsNyArOTQwLDcgQEAgc3RhdGljIGludCB1bV9wY2lfaW5pdCh2b2lkKQo+
ICAgfQo+ICAgbW9kdWxlX2luaXQodW1fcGNpX2luaXQpOwo+ICAgCj4gLXN0YXRpYyB2b2lkIHVt
X3BjaV9leGl0KHZvaWQpCj4gK3N0YXRpYyB2b2lkIF9fZXhpdCB1bV9wY2lfZXhpdCh2b2lkKQo+
ICAgewo+ICAgCXVucmVnaXN0ZXJfdmlydGlvX2RyaXZlcigmdW1fcGNpX3ZpcnRpb19kcml2ZXIp
Owo+ICAgCWlycV9kb21haW5fcmVtb3ZlKHVtX3BjaV9tc2lfZG9tYWluKTsKPiAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

