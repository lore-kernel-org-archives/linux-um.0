Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCGot-005oWg-Rg
	for linux-um@lists.infradead.org; Fri, 15 Jul 2022 08:37:09 +0000
Message-ID: <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
Date: Fri, 15 Jul 2022 16:36:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
 <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
In-Reply-To: <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
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

T24gRnJpLCA4IEp1bCAyMDIyIDE0OjIwOjUyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDEwOjAwIEFNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwg
NCBKdWwgMjAyMiAxMTo0NDoxMiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2Yg
dGhlIHJ4IHF1ZXVlcy4KPiA+ID4gPiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3Nz
aWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRoZQo+ID4gPiA+IHF1ZXVlLgo+ID4gPiA+
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIy
ICsrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspCj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gaW5kZXggOWZlMjIyYTM2
NjNhLi42YWIxNmZkMTkzZTUgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gQEAg
LTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+ID4gPiAgICAgY2hh
ciBwYWRkaW5nWzEyXTsKPiA+ID4gPiAgIH07Cj4gPiA+ID4KPiA+ID4gPiArc3RhdGljIHZvaWQg
dmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1
Zik7Cj4gPiA+ID4gKwo+ID4gPiA+ICAgc3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0
cikKPiA+ID4gPiAgIHsKPiA+ID4gPiAgICAgcmV0dXJuICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJ
UlRJT19YRFBfRkxBRzsKPiA+ID4gPiBAQCAtMTg0Niw2ICsxODQ4LDI2IEBAIHN0YXRpYyBuZXRk
ZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYpCj4gPiA+ID4gICAgIHJldHVybiBORVRERVZfVFhfT0s7Cj4gPiA+ID4gICB9Cj4gPiA+
ID4KPiA+ID4gPiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSwKPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJlY2VpdmVf
cXVldWUgKnJxLCB1MzIgcmluZ19udW0pCj4gPiA+ID4gK3sKPiA+ID4gPiArICAgaW50IGVyciwg
cWluZGV4Owo+ID4gPiA+ICsKPiA+ID4gPiArICAgcWluZGV4ID0gcnEgLSB2aS0+cnE7Cj4gPiA+
ID4gKwo+ID4gPiA+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBpKTsKPiA+ID4KPiA+ID4KPiA+
ID4gRG8gd2UgbmVlZCB0byBjYW5jZWwgdGhlIHJlZmlsbCB3b3JrIGhlcmU/Cj4gPgo+ID4KPiA+
IEkgdGhpbmsgbm8sIG5hcGlfZGlzYWJsZSBpcyBtdXR1YWxseSBleGNsdXNpdmUsIHdoaWNoIGVu
c3VyZXMgdGhhdCB0aGVyZSB3aWxsIGJlCj4gPiBubyBjb25mbGljdHMgYmV0d2VlbiB0aGVtLgo+
Cj4gU28gdGhpcyBzb3VuZHMgc2ltaWxhciB0byB3aGF0IEkndmUgZml4ZWQgcmVjZW50bHkuCj4K
PiAxKSBOQVBJIHNjaGVkdWxlIGRlbGF5ZWQgd29yay4KPiAyKSB3ZSBkaXNhYmxlIE5BUEkgaGVy
ZQo+IDMpIGRlbGF5ZWQgd29yayBnZXQgc2NoZWR1bGUgYW5kIGNhbGwgTkFQSSBhZ2Fpbgo+Cj4g
PwoKWWVzLCBidXQgSSBkb24ndCB0aGluayB0aGVyZSBhcmUgYW55IG5lZ2F0aXZlIGVmZmVjdHMu
CgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gPgo+ID4gPiBU
aGFua3MKPiA+ID4KPiA+ID4KPiA+ID4gPiArCj4gPiA+ID4gKyAgIGVyciA9IHZpcnRxdWV1ZV9y
ZXNpemUocnEtPnZxLCByaW5nX251bSwgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYpOwo+ID4g
PiA+ICsgICBpZiAoZXJyKQo+ID4gPiA+ICsgICAgICAgICAgIG5ldGRldl9lcnIodmktPmRldiwg
InJlc2l6ZSByeCBmYWlsOiByeCBxdWV1ZSBpbmRleDogJWQgZXJyOiAlZFxuIiwgcWluZGV4LCBl
cnIpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgaWYgKCF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQ
X0tFUk5FTCkpCj4gPiA+ID4gKyAgICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+
cmVmaWxsLCAwKTsKPiA+ID4gPiArCj4gPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV9lbmFibGUocnEt
PnZxLCAmcnEtPm5hcGkpOwo+ID4gPiA+ICsgICByZXR1cm4gZXJyOwo+ID4gPiA+ICt9Cj4gPiA+
ID4gKwo+ID4gPiA+ICAgLyoKPiA+ID4gPiAgICAqIFNlbmQgY29tbWFuZCB2aWEgdGhlIGNvbnRy
b2wgdmlydHF1ZXVlIGFuZCBjaGVjayBzdGF0dXMuICBDb21tYW5kcwo+ID4gPiA+ICAgICogc3Vw
cG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBz
aG91bGQKPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

