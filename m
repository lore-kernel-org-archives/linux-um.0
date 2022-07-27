Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGYaM-008oIE-Nt
	for linux-um@lists.infradead.org; Wed, 27 Jul 2022 04:23:52 +0000
Received: by mail-pg1-f200.google.com with SMTP id s129-20020a632c87000000b00411564fe1feso7257364pgs.7
        for <linux-um@lists.infradead.org>; Tue, 26 Jul 2022 21:23:38 -0700 (PDT)
Message-ID: <1a5fa20c-c8f2-2537-2b3b-675a40e113ac@redhat.com>
Date: Wed, 27 Jul 2022 12:23:21 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v13 11/42] virtio_ring: split: extract the logic of alloc
 state and extra
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-12-xuanzhuo@linux.alibaba.com>
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
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com

CuWcqCAyMDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGNyZWF0aW5nIGRlc2Nfc3RhdGUsIGRlc2NfZXh0cmEsIGFuZCBzdWJzZXF1ZW50Cj4g
cGF0Y2hlcyB3aWxsIGNhbGwgaXQgaW5kZXBlbmRlbnRseS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+IGluZGV4IDM4MTc1MjAzNzFlZS4uNmMyNGIzM2VhMTg2IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gQEAgLTIxMiw2ICsyMTIsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1
ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAkJCQkJICAg
ICAgIGJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gICAJCQkJCSAgICAgICB2
b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gICAJCQkJCSAgICAgICBjb25z
dCBjaGFyICpuYW1lKTsKPiArc3RhdGljIHN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICp2cmluZ19h
bGxvY19kZXNjX2V4dHJhKHVuc2lnbmVkIGludCBudW0pOwo+ICAgCj4gICAvKgo+ICAgICogSGVs
cGVycy4KPiBAQCAtOTQ3LDYgKzk0OCwzMiBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2RldGFj
aF91bnVzZWRfYnVmX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIAlyZXR1cm4gTlVM
TDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0
KHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5nX3NwbGl0KQo+ICt7Cj4gKwlzdHJ1
Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAqc3RhdGU7Cj4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19l
eHRyYSAqZXh0cmE7Cj4gKwl1MzIgbnVtID0gdnJpbmdfc3BsaXQtPnZyaW5nLm51bTsKPiArCj4g
KwlzdGF0ZSA9IGttYWxsb2NfYXJyYXkobnVtLCBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3Rh
dGVfc3BsaXQpLCBHRlBfS0VSTkVMKTsKPiArCWlmICghc3RhdGUpCj4gKwkJZ290byBlcnJfc3Rh
dGU7Cj4gKwo+ICsJZXh0cmEgPSB2cmluZ19hbGxvY19kZXNjX2V4dHJhKG51bSk7Cj4gKwlpZiAo
IWV4dHJhKQo+ICsJCWdvdG8gZXJyX2V4dHJhOwo+ICsKPiArCW1lbXNldChzdGF0ZSwgMCwgbnVt
ICogc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSk7Cj4gKwo+ICsJdnJpbmdf
c3BsaXQtPmRlc2Nfc3RhdGUgPSBzdGF0ZTsKPiArCXZyaW5nX3NwbGl0LT5kZXNjX2V4dHJhID0g
ZXh0cmE7Cj4gKwlyZXR1cm4gMDsKPiArCj4gK2Vycl9leHRyYToKPiArCWtmcmVlKHN0YXRlKTsK
PiArZXJyX3N0YXRlOgo+ICsJcmV0dXJuIC1FTk9NRU07Cj4gK30KPiArCj4gICBzdGF0aWMgdm9p
ZCB2cmluZ19mcmVlX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5nX3Nw
bGl0LAo+ICAgCQkJICAgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIHsKPiBAQCAt
MjI0Miw2ICsyMjY5LDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3Zp
cnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJCQkJCSAgICAgICBjb25zdCBjaGFyICpu
YW1lKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxOwo+ICsJaW50IGVycjsK
PiAgIAo+ICAgCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklOR19QQUNL
RUQpKQo+ICAgCQlyZXR1cm4gTlVMTDsKPiBAQCAtMjI4MiwxNyArMjMxMCwxNCBAQCBzdGF0aWMg
c3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRl
eCwKPiAgIAkJCQkJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyk7Cj4gICAJfQo+ICAgCj4g
LQl2cS0+c3BsaXQuZGVzY19zdGF0ZSA9IGttYWxsb2NfYXJyYXkodnJpbmdfc3BsaXQtPnZyaW5n
Lm51bSwKPiAtCQkJc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSwgR0ZQX0tF
Uk5FTCk7Cj4gLQlpZiAoIXZxLT5zcGxpdC5kZXNjX3N0YXRlKQo+IC0JCWdvdG8gZXJyX3N0YXRl
Owo+IC0KPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gdnJpbmdfYWxsb2NfZGVzY19leHRyYSh2
cmluZ19zcGxpdC0+dnJpbmcubnVtKTsKPiAtCWlmICghdnEtPnNwbGl0LmRlc2NfZXh0cmEpCj4g
LQkJZ290byBlcnJfZXh0cmE7Cj4gKwllcnIgPSB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxp
dCh2cmluZ19zcGxpdCk7Cj4gKwlpZiAoZXJyKSB7Cj4gKwkJa2ZyZWUodnEpOwo+ICsJCXJldHVy
biBOVUxMOwo+ICsJfQo+ICAgCj4gLQltZW1zZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUsIDAsIHZy
aW5nX3NwbGl0LT52cmluZy5udW0gKgo+IC0JCQlzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nfc3Rh
dGVfc3BsaXQpKTsKPiArCXZxLT5zcGxpdC5kZXNjX3N0YXRlID0gdnJpbmdfc3BsaXQtPmRlc2Nf
c3RhdGU7Cj4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX3NwbGl0LT5kZXNjX2V4dHJh
Owo+ICAgCj4gICAJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5nX3NwbGl0LT52cmluZy5udW0pOwo+
ICAgCj4gQEAgLTIzMDAsMTIgKzIzMjUsNiBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqX192
cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAlsaXN0X2FkZF90YWls
KCZ2cS0+dnEubGlzdCwgJnZkZXYtPnZxcyk7Cj4gICAJc3Bpbl91bmxvY2soJnZkZXYtPnZxc19s
aXN0X2xvY2spOwo+ICAgCXJldHVybiAmdnEtPnZxOwo+IC0KPiAtZXJyX2V4dHJhOgo+IC0Ja2Zy
ZWUodnEtPnNwbGl0LmRlc2Nfc3RhdGUpOwo+IC1lcnJfc3RhdGU6Cj4gLQlrZnJlZSh2cSk7Cj4g
LQlyZXR1cm4gTlVMTDsKPiAgIH0KPiAgIAo+ICAgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3Jl
YXRlX3ZpcnRxdWV1ZSgKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

