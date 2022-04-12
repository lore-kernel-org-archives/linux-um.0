Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne6ey-00BLYu-As
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 02:53:43 +0000
Received: by mail-pf1-f200.google.com with SMTP id
 f126-20020a62db84000000b00505b489c10fso3620531pfg.18
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 19:53:37 -0700 (PDT)
Message-ID: <e9f76bff-c842-3dae-644e-0b7005d3f1fd@redhat.com>
Date: Tue, 12 Apr 2022 10:53:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 04/32] virtio_ring: remove the arg vq of
 vring_alloc_desc_extra()
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-5-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBUaGUgcGFyYW1l
dGVyIHZxIG9mIHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEoKSBpcyB1c2VsZXNzLiBUaGlzIHBhdGNo
Cj4gcmVtb3ZlcyB0aGlzIHBhcmFtZXRlci4KPgo+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGNh
bGwgdGhpcyBmdW5jdGlvbiB0byBhdm9pZCBwYXNzaW5nIHVzZWxlc3MKPiBhcmd1bWVudHMuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoK
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNyArKystLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4g
aW5kZXggZjE4MDdmNmIwNmE1Li5jYjYwMTA3NTBhOTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiBAQCAtMTYzNiw4ICsxNjM2LDcgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51
c2VkX2J1Zl9wYWNrZWQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICAgCXJldHVybiBOVUxMOwo+
ICAgfQo+ICAgCj4gLXN0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2Nf
ZGVzY19leHRyYShzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAtCQkJCQkJICAgICAgIHVu
c2lnbmVkIGludCBudW0pCj4gK3N0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqdnJpbmdf
YWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKQo+ICAgewo+ICAgCXN0cnVjdCB2cmlu
Z19kZXNjX2V4dHJhICpkZXNjX2V4dHJhOwo+ICAgCXVuc2lnbmVkIGludCBpOwo+IEBAIC0xNzU1
LDcgKzE3NTQsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRx
dWV1ZV9wYWNrZWQoCj4gICAJLyogUHV0IGV2ZXJ5dGhpbmcgaW4gZnJlZSBsaXN0cy4gKi8KPiAg
IAl2cS0+ZnJlZV9oZWFkID0gMDsKPiAgIAo+IC0JdnEtPnBhY2tlZC5kZXNjX2V4dHJhID0gdnJp
bmdfYWxsb2NfZGVzY19leHRyYSh2cSwgbnVtKTsKPiArCXZxLT5wYWNrZWQuZGVzY19leHRyYSA9
IHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEobnVtKTsKPiAgIAlpZiAoIXZxLT5wYWNrZWQuZGVzY19l
eHRyYSkKPiAgIAkJZ290byBlcnJfZGVzY19leHRyYTsKPiAgIAo+IEBAIC0yMjMzLDcgKzIyMzIs
NyBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50
IGluZGV4LAo+ICAgCWlmICghdnEtPnNwbGl0LmRlc2Nfc3RhdGUpCj4gICAJCWdvdG8gZXJyX3N0
YXRlOwo+ICAgCj4gLQl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9jX2Rlc2NfZXh0
cmEodnEsIHZyaW5nLm51bSk7Cj4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9j
X2Rlc2NfZXh0cmEodnJpbmcubnVtKTsKPiAgIAlpZiAoIXZxLT5zcGxpdC5kZXNjX2V4dHJhKQo+
ICAgCQlnb3RvIGVycl9leHRyYTsKPiAgIAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K

