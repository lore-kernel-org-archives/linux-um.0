Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne77F-00BPpS-7q
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 03:22:55 +0000
Received: by mail-pj1-f70.google.com with SMTP id
 38-20020a17090a09a900b001cb95d9ea46so2548352pjo.7
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 20:22:49 -0700 (PDT)
Message-ID: <b435b86d-26af-2e39-8859-6746830769d5@redhat.com>
Date: Tue, 12 Apr 2022 11:22:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 06/32] virtio_ring: split: extract the logic of alloc
 queue
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-7-xuanzhuo@linux.alibaba.com>
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
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBTZXBhcmF0ZSB0
aGUgbG9naWMgb2Ygc3BsaXQgdG8gY3JlYXRlIHZyaW5nIHF1ZXVlLgo+Cj4gVGhpcyBmZWF0dXJl
IGlzIHJlcXVpcmVkIGZvciBzdWJzZXF1ZW50IHZpcnR1cXVldWUgcmVzZXQgdnJpbmcuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0t
LQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDUzICsrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyks
IDE3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggMzNmZGRmYjkwN2E2
Li43MmQ1YWUwNjNmYTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtOTE1LDIzICs5MTUs
MTUgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zl9zcGxpdChzdHJ1
Y3QgdmlydHF1ZXVlICpfdnEpCj4gICAJcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICAKPiAtc3RhdGlj
IHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gLQl1bnNp
Z25lZCBpbnQgaW5kZXgsCj4gLQl1bnNpZ25lZCBpbnQgbnVtLAo+IC0JdW5zaWduZWQgaW50IHZy
aW5nX2FsaWduLAo+IC0Jc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gLQlib29sIHdlYWtf
YmFycmllcnMsCj4gLQlib29sIG1heV9yZWR1Y2VfbnVtLAo+IC0JYm9vbCBjb250ZXh0LAo+IC0J
Ym9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiAtCXZvaWQgKCpjYWxsYmFjayko
c3RydWN0IHZpcnRxdWV1ZSAqKSwKPiAtCWNvbnN0IGNoYXIgKm5hbWUpCj4gK3N0YXRpYyB2b2lk
ICp2cmluZ19hbGxvY19xdWV1ZV9zcGxpdChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiAr
CQkJCSAgICAgZG1hX2FkZHJfdCAqZG1hX2FkZHIsCj4gKwkJCQkgICAgIHUzMiAqbiwKPiArCQkJ
CSAgICAgdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ICsJCQkJICAgICBib29sIHdlYWtfYmFy
cmllcnMsCgoKVGhpcyBpcyBub3QgdXNlZCBpbiB0aGlzIGZ1bmN0aW9uLgoKVGhhbmtzCgoKPiAr
CQkJCSAgICAgYm9vbCBtYXlfcmVkdWNlX251bSkKPiAgIHsKPiAtCXN0cnVjdCB2aXJ0cXVldWUg
KnZxOwo+ICAgCXZvaWQgKnF1ZXVlID0gTlVMTDsKPiAtCWRtYV9hZGRyX3QgZG1hX2FkZHI7Cj4g
LQlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiAtCXN0cnVjdCB2cmluZyB2cmluZzsKPiAr
CXUzMiBudW0gPSAqbjsKPiAgIAo+ICAgCS8qIFdlIGFzc3VtZSBudW0gaXMgYSBwb3dlciBvZiAy
LiAqLwo+ICAgCWlmIChudW0gJiAobnVtIC0gMSkpIHsKPiBAQCAtOTQyLDcgKzkzNCw3IEBAIHN0
YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAg
CS8qIFRPRE86IGFsbG9jYXRlIGVhY2ggcXVldWUgY2h1bmsgaW5kaXZpZHVhbGx5ICovCj4gICAJ
Zm9yICg7IG51bSAmJiB2cmluZ19zaXplKG51bSwgdnJpbmdfYWxpZ24pID4gUEFHRV9TSVpFOyBu
dW0gLz0gMikgewo+ICAgCQlxdWV1ZSA9IHZyaW5nX2FsbG9jX3F1ZXVlKHZkZXYsIHZyaW5nX3Np
emUobnVtLCB2cmluZ19hbGlnbiksCj4gLQkJCQkJICAmZG1hX2FkZHIsCj4gKwkJCQkJICBkbWFf
YWRkciwKPiAgIAkJCQkJICBHRlBfS0VSTkVMfF9fR0ZQX05PV0FSTnxfX0dGUF9aRVJPKTsKPiAg
IAkJaWYgKHF1ZXVlKQo+ICAgCQkJYnJlYWs7Cj4gQEAgLTk1NiwxMSArOTQ4LDM4IEBAIHN0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAgCWlm
ICghcXVldWUpIHsKPiAgIAkJLyogVHJ5IHRvIGdldCBhIHNpbmdsZSBwYWdlLiBZb3UgYXJlIG15
IG9ubHkgaG9wZSEgKi8KPiAgIAkJcXVldWUgPSB2cmluZ19hbGxvY19xdWV1ZSh2ZGV2LCB2cmlu
Z19zaXplKG51bSwgdnJpbmdfYWxpZ24pLAo+IC0JCQkJCSAgJmRtYV9hZGRyLCBHRlBfS0VSTkVM
fF9fR0ZQX1pFUk8pOwo+ICsJCQkJCSAgZG1hX2FkZHIsIEdGUF9LRVJORUx8X19HRlBfWkVSTyk7
Cj4gICAJfQo+ICAgCWlmICghcXVldWUpCj4gICAJCXJldHVybiBOVUxMOwo+ICAgCj4gKwkqbiA9
IG51bTsKPiArCXJldHVybiBxdWV1ZTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB2aXJ0cXVl
dWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gKwl1bnNpZ25lZCBpbnQgaW5kZXgs
Cj4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+ICsJdW5zaWduZWQgaW50IHZyaW5nX2FsaWduLAo+ICsJ
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gKwlib29sIHdlYWtfYmFycmllcnMsCj4gKwli
b29sIG1heV9yZWR1Y2VfbnVtLAo+ICsJYm9vbCBjb250ZXh0LAo+ICsJYm9vbCAoKm5vdGlmeSko
c3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1
ZSAqKSwKPiArCWNvbnN0IGNoYXIgKm5hbWUpCj4gK3sKPiArCXNpemVfdCBxdWV1ZV9zaXplX2lu
X2J5dGVzOwo+ICsJc3RydWN0IHZpcnRxdWV1ZSAqdnE7Cj4gKwlkbWFfYWRkcl90IGRtYV9hZGRy
Owo+ICsJc3RydWN0IHZyaW5nIHZyaW5nOwo+ICsJdm9pZCAqcXVldWU7Cj4gKwo+ICsJcXVldWUg
PSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCh2ZGV2LCAmZG1hX2FkZHIsICZudW0sIHZyaW5nX2Fs
aWduLAo+ICsJCQkJCXdlYWtfYmFycmllcnMsIG1heV9yZWR1Y2VfbnVtKTsKPiArCWlmICghcXVl
dWUpCj4gKwkJcmV0dXJuIE5VTEw7Cj4gKwo+ICAgCXF1ZXVlX3NpemVfaW5fYnl0ZXMgPSB2cmlu
Z19zaXplKG51bSwgdnJpbmdfYWxpZ24pOwo+ICAgCXZyaW5nX2luaXQoJnZyaW5nLCBudW0sIHF1
ZXVlLCB2cmluZ19hbGlnbik7Cj4gICAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==

