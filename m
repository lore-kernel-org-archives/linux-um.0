Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Bhi-003UBQ-Bz
	for linux-um@lists.infradead.org; Mon, 04 Jul 2022 02:20:52 +0000
Message-ID: <1656900812.860175-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 21/40] virtio_ring: packed: introduce virtqueue_resize_packed()
Date: Mon, 4 Jul 2022 10:13:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-22-xuanzhuo@linux.alibaba.com>
 <de7cf56d-acbd-1a2b-2226-a9fdd89afb78@redhat.com>
In-Reply-To: <de7cf56d-acbd-1a2b-2226-a9fdd89afb78@redhat.com>
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
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com, virtualization@lists.linux-foundation.org

T24gRnJpLCAxIEp1bCAyMDIyIDE3OjI3OjQ4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiB2aXJ0aW8gcmluZyBwYWNrZWQgc3VwcG9ydHMgcmVzaXplLgo+ID4KPiA+IE9ubHkg
YWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgYWxsb2NhdGVkIGJhc2VkIG9uIHRo
ZSBuZXcgbnVtLAo+ID4gd2Ugd2lsbCByZWxlYXNlIHRoZSBvbGQgdnJpbmcuIEluIGFueSBjYXNl
LCBhbiBlcnJvciBpcyByZXR1cm5lZCwKPiA+IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3Rp
bGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcuCj4gPgo+ID4gSW4gdGhlIGNhc2Ugb2YgYW4gZXJy
b3IsIHJlLWluaXRpYWxpemUoYnkgdmlydHF1ZXVlX3JlaW5pdF9wYWNrZWQoKSkgdGhlCj4gPiB2
aXJ0cXVldWUgdG8gZW5zdXJlIHRoYXQgdGhlIHZyaW5nIGNhbiBiZSB1c2VkLgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAt
LS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCA2NTBmNzAxYTU0ODAuLjQ4NjA3ODcyODZk
YiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC0yMDQyLDYgKzIwNDIsMzUgQEAg
c3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+
ID4gICAJcmV0dXJuIE5VTEw7Cj4gPiAgIH0KPiA+Cj4gPiArc3RhdGljIGludCB2aXJ0cXVldWVf
cmVzaXplX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4gPiArewo+ID4g
KwlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3BhY2tlZCB2cmluZyA9IHt9Owo+ID4gKwlzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gKwlzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldiA9IF92cS0+dmRldjsKPiA+ICsJaW50IGVycjsKPiA+ICsKPiA+ICsJaWYgKHZy
aW5nX2FsbG9jX3F1ZXVlX3BhY2tlZCgmdnJpbmcsIHZkZXYsIG51bSkpCj4gPiArCQlnb3RvIGVy
cl9yaW5nOwo+ID4gKwo+ID4gKwllcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9wYWNrZWQo
JnZyaW5nKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCWdvdG8gZXJyX3N0YXRlX2V4dHJhOwo+ID4g
Kwo+ID4gKwl2cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4gKwo+ID4gKwl2aXJ0cXVldWVfaW5pdCh2
cSwgdnJpbmcudnJpbmcubnVtKTsKPiA+ICsJdmlydHF1ZXVlX3ZyaW5nX2F0dGFjaF9wYWNrZWQo
dnEsICZ2cmluZyk7Cj4gPiArCXZpcnRxdWV1ZV92cmluZ19pbml0X3BhY2tlZCh2cSk7Cj4gPiAr
Cj4gPiArCXJldHVybiAwOwo+ID4gKwo+ID4gK2Vycl9zdGF0ZV9leHRyYToKPiA+ICsJdnJpbmdf
ZnJlZV9wYWNrZWQoJnZyaW5nLCB2ZGV2KTsKPiA+ICtlcnJfcmluZzoKPiA+ICsJdmlydHF1ZXVl
X3JlaW5pdF9wYWNrZWQodnEpOwo+Cj4KPiBTbyBkZXNjX3N0YXRlIGFuZCBkZXNjX2V4dHJhIGhh
cyBiZWVuIGZyZWVkIHZyaW5nX2ZyZWVfcGFja2VkKCkgd2hlbgo+IHZyaW5nX2FsbG9jX3N0YXRl
X2V4dHJhX3BhY2tlZCgpIGZhaWxzLiBXZSBtaWdodCBnZXQgdXNlLWFmdGVyLWZyZWUgaGVyZT8K
CnZyaW5nX2ZyZWVfcGFja2VkKCkgZnJlZXMgdGhlIHRlbXBvcmFyeSBzdHJ1Y3R1cmUgdnJpbmcu
IEl0IGRvZXMgbm90IGFmZmVjdApkZXNjX3N0YXRlIGFuZCBkZXNjX2V4dHJhIG9mIHZxLiBTbyBp
dCBpcyBzYWZlLgoKPgo+IEFjdHVhbGx5LCBJIHRoaW5rIGZvciByZXNpemUgd2UgbmVlZAo+Cj4g
MSkgZGV0YWNoIG9sZAo+IDIpIGFsbG9jYXRlIG5ldwo+IDMpIGlmIDIpIHN1Y2NlZWQsIGF0dGFj
aCBuZXcgb3RoZXJ3aXNlIGF0dGFjaCBvbGQKCgpUaGUgaW1wbGVtZW50YXRpb24gaXMgbm93OgoK
MS4gYWxsb2NhdGUgbmV3CjIuIGZyZWUgb2xkIChkZXRhY2ggb2xkKQozLiBhdHRhY2ggbmV3Cgpl
cnJvcjoKMS4gZnJlZSB0ZW1wb3JhcnkKMi4gcmVpbml0IG9sZAoKRG8geW91IHRoaW5rIHRoaXMg
aXMgb2s/IFdlIG5lZWQgdG8gYWRkIGEgbmV3IHZhcmlhYmxlIHRvIHNhdmUgdGhlIG9sZCB2cmlu
ZyBpbgp0aGUgcHJvY2VzcyB5b3UgbWVudGlvbmVkLCB0aGVyZSBpcyBub3QgbXVjaCBkaWZmZXJl
bmNlIGluIG90aGVyLgoKVGhhbmtzLgoKCj4KPiBUaGlzIHNlZW1zIG1vcmUgY2xlYXJlciB0aGFu
IHRoZSBjdXJyZW50IGxvZ2ljPwo+Cj4gVGhhbmtzCj4KPgo+ID4gKwlyZXR1cm4gLUVOT01FTTsK
PiA+ICt9Cj4gPiArCj4gPgo+ID4gICAvKgo+ID4gICAgKiBHZW5lcmljIGZ1bmN0aW9ucyBhbmQg
ZXhwb3J0ZWQgc3ltYm9scy4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11
bQo=

