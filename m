Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8DIT-004Mn2-9n
	for linux-um@lists.infradead.org; Mon, 04 Jul 2022 04:02:54 +0000
Received: by mail-pj1-f72.google.com with SMTP id l15-20020a17090a660f00b001ef7b1d2289so2494084pjj.9
        for <linux-um@lists.infradead.org>; Sun, 03 Jul 2022 21:02:50 -0700 (PDT)
Message-ID: <fd85439f-8c94-e4f9-8500-811b3cf4c9ed@redhat.com>
Date: Mon, 4 Jul 2022 12:02:35 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 21/40] virtio_ring: packed: introduce
 virtqueue_resize_packed()
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-22-xuanzhuo@linux.alibaba.com>
 <de7cf56d-acbd-1a2b-2226-a9fdd89afb78@redhat.com>
 <1656900812.860175-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1656900812.860175-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com, virtualization@lists.linux-foundation.org

CuWcqCAyMDIyLzcvNCAxMDoxMywgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBGcmksIDEgSnVsIDIw
MjIgMTc6Mjc6NDggKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3Rl
Ogo+PiDlnKggMjAyMi82LzI5IDE0OjU2LCBYdWFuIFpodW8g5YaZ6YGTOgo+Pj4gdmlydGlvIHJp
bmcgcGFja2VkIHN1cHBvcnRzIHJlc2l6ZS4KPj4+Cj4+PiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJp
bmcgaXMgc3VjY2Vzc2Z1bGx5IGFsbG9jYXRlZCBiYXNlZCBvbiB0aGUgbmV3IG51bSwKPj4+IHdl
IHdpbGwgcmVsZWFzZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0
dXJuZWQsCj4+PiBpbmRpY2F0aW5nIHRoYXQgdGhlIHZyaW5nIHN0aWxsIHBvaW50cyB0byB0aGUg
b2xkIHZyaW5nLgo+Pj4KPj4+IEluIHRoZSBjYXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFsaXpl
KGJ5IHZpcnRxdWV1ZV9yZWluaXRfcGFja2VkKCkpIHRoZQo+Pj4gdmlydHF1ZXVlIHRvIGVuc3Vy
ZSB0aGF0IHRoZSB2cmluZyBjYW4gYmUgdXNlZC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4+PiBpbmRleCA2NTBmNzAxYTU0ODAuLjQ4NjA3ODcyODZkYiAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPj4+IEBAIC0yMDQyLDYgKzIwNDIsMzUgQEAgc3RhdGljIHN0cnVjdCB2
aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+Pj4gICAgCXJldHVybiBO
VUxMOwo+Pj4gICAgfQo+Pj4KPj4+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVfcGFja2Vk
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMyIG51bSkKPj4+ICt7Cj4+PiArCXN0cnVjdCB2cmlu
Z192aXJ0cXVldWVfcGFja2VkIHZyaW5nID0ge307Cj4+PiArCXN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+PiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0g
X3ZxLT52ZGV2Owo+Pj4gKwlpbnQgZXJyOwo+Pj4gKwo+Pj4gKwlpZiAodnJpbmdfYWxsb2NfcXVl
dWVfcGFja2VkKCZ2cmluZywgdmRldiwgbnVtKSkKPj4+ICsJCWdvdG8gZXJyX3Jpbmc7Cj4+PiAr
Cj4+PiArCWVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3BhY2tlZCgmdnJpbmcpOwo+Pj4g
KwlpZiAoZXJyKQo+Pj4gKwkJZ290byBlcnJfc3RhdGVfZXh0cmE7Cj4+PiArCj4+PiArCXZyaW5n
X2ZyZWUoJnZxLT52cSk7Cj4+PiArCj4+PiArCXZpcnRxdWV1ZV9pbml0KHZxLCB2cmluZy52cmlu
Zy5udW0pOwo+Pj4gKwl2aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3BhY2tlZCh2cSwgJnZyaW5nKTsK
Pj4+ICsJdmlydHF1ZXVlX3ZyaW5nX2luaXRfcGFja2VkKHZxKTsKPj4+ICsKPj4+ICsJcmV0dXJu
IDA7Cj4+PiArCj4+PiArZXJyX3N0YXRlX2V4dHJhOgo+Pj4gKwl2cmluZ19mcmVlX3BhY2tlZCgm
dnJpbmcsIHZkZXYpOwo+Pj4gK2Vycl9yaW5nOgo+Pj4gKwl2aXJ0cXVldWVfcmVpbml0X3BhY2tl
ZCh2cSk7Cj4+Cj4+IFNvIGRlc2Nfc3RhdGUgYW5kIGRlc2NfZXh0cmEgaGFzIGJlZW4gZnJlZWQg
dnJpbmdfZnJlZV9wYWNrZWQoKSB3aGVuCj4+IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3BhY2tl
ZCgpIGZhaWxzLiBXZSBtaWdodCBnZXQgdXNlLWFmdGVyLWZyZWUgaGVyZT8KPiB2cmluZ19mcmVl
X3BhY2tlZCgpIGZyZWVzIHRoZSB0ZW1wb3Jhcnkgc3RydWN0dXJlIHZyaW5nLiBJdCBkb2VzIG5v
dCBhZmZlY3QKPiBkZXNjX3N0YXRlIGFuZCBkZXNjX2V4dHJhIG9mIHZxLiBTbyBpdCBpcyBzYWZl
LgoKCllvdSBhcmUgcmlnaHQuCgoKPgo+PiBBY3R1YWxseSwgSSB0aGluayBmb3IgcmVzaXplIHdl
IG5lZWQKPj4KPj4gMSkgZGV0YWNoIG9sZAo+PiAyKSBhbGxvY2F0ZSBuZXcKPj4gMykgaWYgMikg
c3VjY2VlZCwgYXR0YWNoIG5ldyBvdGhlcndpc2UgYXR0YWNoIG9sZAo+Cj4gVGhlIGltcGxlbWVu
dGF0aW9uIGlzIG5vdzoKPgo+IDEuIGFsbG9jYXRlIG5ldwo+IDIuIGZyZWUgb2xkIChkZXRhY2gg
b2xkKQo+IDMuIGF0dGFjaCBuZXcKPgo+IGVycm9yOgo+IDEuIGZyZWUgdGVtcG9yYXJ5Cj4gMi4g
cmVpbml0IG9sZAo+Cj4gRG8geW91IHRoaW5rIHRoaXMgaXMgb2s/IFdlIG5lZWQgdG8gYWRkIGEg
bmV3IHZhcmlhYmxlIHRvIHNhdmUgdGhlIG9sZCB2cmluZyBpbgo+IHRoZSBwcm9jZXNzIHlvdSBt
ZW50aW9uZWQsIHRoZXJlIGlzIG5vdCBtdWNoIGRpZmZlcmVuY2UgaW4gb3RoZXIuCgoKWWVzLCBJ
IHRoaW5rIHRoZSBjb2RlIGlzIGZpbmUuIEJ1dCBJJ2Qgc3VnZ2VzdCB0byByZW5hbWUgInZyaW5n
IiB0byAKInZyaW5nX3BhY2tlZCIsIHRoaXMgc2ltcGxpZnkgdGhlIHJldmlld2Vycy4KCk90aGVy
IHRoYW4gdGhpcywgeW91IGNhbiBhZGQ6CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KCgo+Cj4gVGhhbmtzLgo+Cj4KPj4gVGhpcyBzZWVtcyBtb3JlIGNsZWFyZXIg
dGhhbiB0aGUgY3VycmVudCBsb2dpYz8KPj4KPj4gVGhhbmtzCj4+Cj4+Cj4+PiArCXJldHVybiAt
RU5PTUVNOwo+Pj4gK30KPj4+ICsKPj4+Cj4+PiAgICAvKgo+Pj4gICAgICogR2VuZXJpYyBmdW5j
dGlvbnMgYW5kIGV4cG9ydGVkIHN5bWJvbHMuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC11bQo=

