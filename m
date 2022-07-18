Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDMYV-00BvhX-1M
	for linux-um@lists.infradead.org; Mon, 18 Jul 2022 08:56:44 +0000
Received: by mail-lf1-f70.google.com with SMTP id t2-20020a19dc02000000b0048a097cd904so4045963lfg.17
        for <linux-um@lists.infradead.org>; Mon, 18 Jul 2022 01:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com> <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com> <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
 <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1657874178.9766078-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Jul 2022 16:56:24 +0800
Message-ID: <CACGkMEtF5NSXh-=nnsniLqy0pX2Tpyh413S5Bu5vZ6h=d+aHTA@mail.gmail.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
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
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>, "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>, kangjie.xu@linux.alibaba.com, virtualization <virtualization@lists.linux-foundation.org>

T24gRnJpLCBKdWwgMTUsIDIwMjIgYXQgNDozNyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgOCBKdWwgMjAyMiAxNDoyMDo1MiArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUsIEp1
bCA1LCAyMDIyIGF0IDEwOjAwIEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBNb24sIDQgSnVsIDIwMjIgMTE6NDQ6MTIgKzA4MDAs
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4g
5ZyoIDIwMjIvNi8yOSAxNDo1NiwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gPiA+IFRoaXMgcGF0
Y2ggaW1wbGVtZW50cyB0aGUgcmVzaXplIGZ1bmN0aW9uIG9mIHRoZSByeCBxdWV1ZXMuCj4gPiA+
ID4gPiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhl
IHJpbmcgbnVtIG9mIHRoZQo+ID4gPiA+ID4gcXVldWUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4g
PiA+IC0tLQo+ID4gPiA+ID4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyMiArKysrKysr
KysrKysrKysrKysrKysrCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25z
KCspCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gaW5kZXggOWZlMjIyYTM2
NjNhLi42YWIxNmZkMTkzZTUgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+
ID4gQEAgLTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+ID4gPiA+
ICAgICBjaGFyIHBhZGRpbmdbMTJdOwo+ID4gPiA+ID4gICB9Owo+ID4gPiA+ID4KPiA+ID4gPiA+
ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwgdm9pZCAqYnVmKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICAgc3RhdGljIGJvb2wgaXNf
eGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ID4gPiA+ICAgewo+ID4gPiA+ID4gICAgIHJldHVybiAo
dW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gPiA+ID4gPiBAQCAtMTg0Niw2
ICsxODQ4LDI2IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZm
ICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gPiAgICAgcmV0dXJuIE5FVERF
Vl9UWF9PSzsKPiA+ID4gPiA+ICAgfQo+ID4gPiA+ID4KPiA+ID4gPiA+ICtzdGF0aWMgaW50IHZp
cnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgdTMyIHJpbmdfbnVt
KQo+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ICsgICBpbnQgZXJyLCBxaW5kZXg7Cj4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiArICAgcWluZGV4ID0gcnEgLSB2aS0+cnE7Cj4gPiA+ID4gPiArCj4gPiA+ID4g
PiArICAgbmFwaV9kaXNhYmxlKCZycS0+bmFwaSk7Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IERv
IHdlIG5lZWQgdG8gY2FuY2VsIHRoZSByZWZpbGwgd29yayBoZXJlPwo+ID4gPgo+ID4gPgo+ID4g
PiBJIHRoaW5rIG5vLCBuYXBpX2Rpc2FibGUgaXMgbXV0dWFsbHkgZXhjbHVzaXZlLCB3aGljaCBl
bnN1cmVzIHRoYXQgdGhlcmUgd2lsbCBiZQo+ID4gPiBubyBjb25mbGljdHMgYmV0d2VlbiB0aGVt
Lgo+ID4KPiA+IFNvIHRoaXMgc291bmRzIHNpbWlsYXIgdG8gd2hhdCBJJ3ZlIGZpeGVkIHJlY2Vu
dGx5Lgo+ID4KPiA+IDEpIE5BUEkgc2NoZWR1bGUgZGVsYXllZCB3b3JrLgo+ID4gMikgd2UgZGlz
YWJsZSBOQVBJIGhlcmUKPiA+IDMpIGRlbGF5ZWQgd29yayBnZXQgc2NoZWR1bGUgYW5kIGNhbGwg
TkFQSSBhZ2Fpbgo+ID4KPiA+ID8KPgo+IFllcywgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlcmUgYXJl
IGFueSBuZWdhdGl2ZSBlZmZlY3RzLgoKQW4gaW5maW5pdGUgd2FpdCBvbiB0aGUgbmFwaV9kaXNh
YmxlKCk/CgpUaGFua3MKCj4KPiBUaGFua3MuCj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4g
PiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICBlcnIgPSB2aXJ0cXVldWVfcmVzaXplKHJxLT52cSwg
cmluZ19udW0sIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKTsKPiA+ID4gPiA+ICsgICBpZiAo
ZXJyKQo+ID4gPiA+ID4gKyAgICAgICAgICAgbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVzaXplIHJ4
IGZhaWw6IHJ4IHF1ZXVlIGluZGV4OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7Cj4gPiA+
ID4gPiArCj4gPiA+ID4gPiArICAgaWYgKCF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5F
TCkpCj4gPiA+ID4gPiArICAgICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZpLT5yZWZp
bGwsIDApOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyAgIHZpcnRuZXRfbmFwaV9lbmFibGUocnEt
PnZxLCAmcnEtPm5hcGkpOwo+ID4gPiA+ID4gKyAgIHJldHVybiBlcnI7Cj4gPiA+ID4gPiArfQo+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gICAvKgo+ID4gPiA+ID4gICAgKiBTZW5kIGNvbW1hbmQgdmlh
IHRoZSBjb250cm9sIHZpcnRxdWV1ZSBhbmQgY2hlY2sgc3RhdHVzLiAgQ29tbWFuZHMKPiA+ID4g
PiA+ICAgICogc3VwcG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVh
dHVyZSBiaXRzLCBzaG91bGQKPiA+ID4gPgo+ID4gPgo+ID4KPgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtdW0K

