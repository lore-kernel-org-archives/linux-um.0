Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7D51-003tNm-SR
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:36:53 +0000
Received: by mail-pl1-f200.google.com with SMTP id a10-20020a170902ecca00b0016a50049af0so1217105plh.10
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:36:49 -0700 (PDT)
Message-ID: <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
Date: Fri, 1 Jul 2022 17:36:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
 <20220701022950-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220701022950-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com

CuWcqCAyMDIyLzcvMSAxNDozMSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBPbiBXZWQs
IEp1biAyOSwgMjAyMiBhdCAwMjo1Njo0MVBNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4+IFRo
aXMgcGF0Y2ggYWxsb3dzIHRoZSBuZXcgaW50cm9kdWNlZAo+PiBfX3ZpcnRxdWV1ZV9icmVhaygp
L19fdmlydHF1ZXVlX3VuYnJlYWsoKSB0byBicmVhay91bmJyZWFrIHRoZQo+PiB2aXJ0cXVldWUu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+Cj4gSSB3b25kZXIgaG93IHRoaXMgaW50ZXJhY3RzIHdpdGggdGhlIGhhcmRlbmluZyBwYXRj
aGVzLgo+IEphc29uPwoKCkNvbnNpZGVyIHdlJ3ZlIG1hcmtlZCBpdCBhcyBicm9rZW4sIEkgdGhp
bmsgd2UgZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IAp0aGUgaGFyZGVuaW5nIGluIHRoaXMgc2Vy
aWVzLiBKdXN0IG1ha2UgaXQgd29yayB3aXRob3V0IGhhcmRlbmluZy4KCkFuZCBJIHdpbGwgaGFu
ZGxlIHZxIHJlc2V0IHdoZW4gcmV3b3JrIHRoZSBJUlEgaGFyZGVuaW5nLgoKVGhhbmtzCgoKPgo+
PiAtLS0KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjQgKysrKysrKysrKysr
KysrKysrKysrKysrCj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAzICsrKwo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPj4gaW5kZXggNWVjNDM2MDdjYzE1Li43YjAyYmU3ZmNlNjcgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+PiBAQCAtMjc0NCw2ICsyNzQ0LDMwIEBAIHVuc2lnbmVkIGludCB2aXJ0cXVldWVf
Z2V0X3ZyaW5nX3NpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+PiAgIH0KPj4gICBFWFBPUlRf
U1lNQk9MX0dQTCh2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUpOwo+PiAgIAo+PiArLyoKPj4gKyAq
IFRoaXMgZnVuY3Rpb24gc2hvdWxkIG9ubHkgYmUgY2FsbGVkIGJ5IHRoZSBjb3JlLCBub3QgZGly
ZWN0bHkgYnkgdGhlIGRyaXZlci4KPj4gKyAqLwo+PiArdm9pZCBfX3ZpcnRxdWV1ZV9icmVhayhz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4+ICt7Cj4+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEgPSB0b192dnEoX3ZxKTsKPj4gKwo+PiArCS8qIFBhaXJzIHdpdGggUkVBRF9PTkNFKCkgaW4g
dmlydHF1ZXVlX2lzX2Jyb2tlbigpLiAqLwo+PiArCVdSSVRFX09OQ0UodnEtPmJyb2tlbiwgdHJ1
ZSk7Cj4+ICt9Cj4+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRxdWV1ZV9icmVhayk7Cj4+ICsK
Pj4gKy8qCj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBvbmx5IGJlIGNhbGxlZCBieSB0aGUg
Y29yZSwgbm90IGRpcmVjdGx5IGJ5IHRoZSBkcml2ZXIuCj4+ICsgKi8KPj4gK3ZvaWQgX192aXJ0
cXVldWVfdW5icmVhayhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4+ICt7Cj4+ICsJc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPj4gKwo+PiArCS8qIFBhaXJzIHdpdGgg
UkVBRF9PTkNFKCkgaW4gdmlydHF1ZXVlX2lzX2Jyb2tlbigpLiAqLwo+PiArCVdSSVRFX09OQ0Uo
dnEtPmJyb2tlbiwgZmFsc2UpOwo+PiArfQo+IEkgZG9uJ3QgdGhpbmsgdGhlc2UgIlBhaXJzIiBj
b21tZW50cyBoYXZlIGFueSB2YWx1ZS4KPgo+Cj4+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRx
dWV1ZV91bmJyZWFrKTsKPj4gKwo+PiAgIGJvb2wgdmlydHF1ZXVlX2lzX2Jyb2tlbihzdHJ1Y3Qg
dmlydHF1ZXVlICpfdnEpCj4+ICAgewo+PiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9
IHRvX3Z2cShfdnEpOwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaCBiL2lu
Y2x1ZGUvbGludXgvdmlydGlvLmgKPj4gaW5kZXggMTI3MjU2NmFkZWM2Li5kYzQ3NGEwZDQ4ZDEg
MTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPj4gKysrIGIvaW5jbHVkZS9s
aW51eC92aXJ0aW8uaAo+PiBAQCAtMTM4LDYgKzEzOCw5IEBAIGJvb2wgaXNfdmlydGlvX2Rldmlj
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpOwo+PiAgIHZvaWQgdmlydGlvX2JyZWFrX2RldmljZShzdHJ1
Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4gICB2b2lkIF9fdmlydGlvX3VuYnJlYWtfZGV2aWNl
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwo+PiAgIAo+PiArdm9pZCBfX3ZpcnRxdWV1ZV9i
cmVhayhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+PiArdm9pZCBfX3ZpcnRxdWV1ZV91bmJyZWFr
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4+ICsKPj4gICB2b2lkIHZpcnRpb19jb25maWdfY2hh
bmdlZChzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4gICAjaWZkZWYgQ09ORklHX1BNX1NM
RUVQCj4+ICAgaW50IHZpcnRpb19kZXZpY2VfZnJlZXplKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpk
ZXYpOwo+PiAtLSAKPj4gMi4zMS4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=

