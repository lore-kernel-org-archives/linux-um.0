Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out199-15.us.a.mail.aliyun.com ([47.90.199.15])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDMbL-00BwyP-O4
	for linux-um@lists.infradead.org; Mon, 18 Jul 2022 08:59:41 +0000
Message-ID: <1658134695.4666655-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
Date: Mon, 18 Jul 2022 16:58:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
 <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
 <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEtF5NSXh-=nnsniLqy0pX2Tpyh413S5Bu5vZ6h=d+aHTA@mail.gmail.com>
In-Reply-To: <CACGkMEtF5NSXh-=nnsniLqy0pX2Tpyh413S5Bu5vZ6h=d+aHTA@mail.gmail.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jason Wang <jasowang@redhat.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, kangjie.xu@linux.alibaba.com, virtualization <virtualization@lists.linux-foundation.org>

T24gTW9uLCAxOCBKdWwgMjAyMiAxNjo1NjoyNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBKdWwgMTUsIDIwMjIgYXQgNDozNyBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmks
IDggSnVsIDIwMjIgMTQ6MjA6NTIgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiBPbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDEwOjAwIEFNIFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24g
TW9uLCA0IEp1bCAyMDIyIDExOjQ0OjEyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiDlnKggMjAyMi82LzI5IDE0OjU2LCBY
dWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJl
c2l6ZSBmdW5jdGlvbiBvZiB0aGUgcnggcXVldWVzLgo+ID4gPiA+ID4gPiBCYXNlZCBvbiB0aGlz
IGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRoZQo+
ID4gPiA+ID4gPiBxdWV1ZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
WHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gPiA+ID4gLS0tCj4g
PiA+ID4gPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrKwo+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gaW5kZXggOWZlMjIyYTM2
NjNhLi42YWIxNmZkMTkzZTUgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+
ID4gPiA+ID4gQEAgLTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+
ID4gPiA+ID4gICAgIGNoYXIgcGFkZGluZ1sxMl07Cj4gPiA+ID4gPiA+ICAgfTsKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0
cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpOwo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+
ICAgc3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ID4gPiA+ID4gICB7Cj4g
PiA+ID4gPiA+ICAgICByZXR1cm4gKHVuc2lnbmVkIGxvbmcpcHRyICYgVklSVElPX1hEUF9GTEFH
Owo+ID4gPiA+ID4gPiBAQCAtMTg0Niw2ICsxODQ4LDI2IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBz
dGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4g
PiA+ID4gPiA+ICAgICByZXR1cm4gTkVUREVWX1RYX09LOwo+ID4gPiA+ID4gPiAgIH0KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gK3N0YXRpYyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmksCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiByaW5nX251bSkKPiA+ID4gPiA+ID4gK3sKPiA+ID4g
PiA+ID4gKyAgIGludCBlcnIsIHFpbmRleDsKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArICAg
cWluZGV4ID0gcnEgLSB2aS0+cnE7Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAgIG5hcGlf
ZGlzYWJsZSgmcnEtPm5hcGkpOwo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBEbyB3ZSBu
ZWVkIHRvIGNhbmNlbCB0aGUgcmVmaWxsIHdvcmsgaGVyZT8KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4gSSB0aGluayBubywgbmFwaV9kaXNhYmxlIGlzIG11dHVhbGx5IGV4Y2x1c2l2ZSwgd2hpY2gg
ZW5zdXJlcyB0aGF0IHRoZXJlIHdpbGwgYmUKPiA+ID4gPiBubyBjb25mbGljdHMgYmV0d2VlbiB0
aGVtLgo+ID4gPgo+ID4gPiBTbyB0aGlzIHNvdW5kcyBzaW1pbGFyIHRvIHdoYXQgSSd2ZSBmaXhl
ZCByZWNlbnRseS4KPiA+ID4KPiA+ID4gMSkgTkFQSSBzY2hlZHVsZSBkZWxheWVkIHdvcmsuCj4g
PiA+IDIpIHdlIGRpc2FibGUgTkFQSSBoZXJlCj4gPiA+IDMpIGRlbGF5ZWQgd29yayBnZXQgc2No
ZWR1bGUgYW5kIGNhbGwgTkFQSSBhZ2Fpbgo+ID4gPgo+ID4gPiA/Cj4gPgo+ID4gWWVzLCBidXQg
SSBkb24ndCB0aGluayB0aGVyZSBhcmUgYW55IG5lZ2F0aXZlIGVmZmVjdHMuCj4KPiBBbiBpbmZp
bml0ZSB3YWl0IG9uIHRoZSBuYXBpX2Rpc2FibGUoKT8KClllcy4KClRoYW5rcy4KCgo+Cj4gVGhh
bmtzCj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAgIGVyciA9IHZpcnRx
dWV1ZV9yZXNpemUocnEtPnZxLCByaW5nX251bSwgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYp
Owo+ID4gPiA+ID4gPiArICAgaWYgKGVycikKPiA+ID4gPiA+ID4gKyAgICAgICAgICAgbmV0ZGV2
X2Vycih2aS0+ZGV2LCAicmVzaXplIHJ4IGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVk
XG4iLCBxaW5kZXgsIGVycik7Cj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gKyAgIGlmICghdHJ5
X2ZpbGxfcmVjdih2aSwgcnEsIEdGUF9LRVJORUwpKQo+ID4gPiA+ID4gPiArICAgICAgICAgICBz
Y2hlZHVsZV9kZWxheWVkX3dvcmsoJnZpLT5yZWZpbGwsIDApOwo+ID4gPiA+ID4gPiArCj4gPiA+
ID4gPiA+ICsgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiA+ID4g
PiA+ID4gKyAgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ICsKPiA+ID4g
PiA+ID4gICAvKgo+ID4gPiA+ID4gPiAgICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRyb2wg
dmlydHF1ZXVlIGFuZCBjaGVjayBzdGF0dXMuICBDb21tYW5kcwo+ID4gPiA+ID4gPiAgICAqIHN1
cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywg
c2hvdWxkCj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgt
dW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXVtCg==

