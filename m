Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out199-4.us.a.mail.aliyun.com ([47.90.199.4])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRsxj-007zIO-G5
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 09:50:33 +0000
Message-ID: <1646819291.9191294-12-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 26/26] virtio_net: support set_ringparam
Date: Wed, 9 Mar 2022 17:48:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-27-xuanzhuo@linux.alibaba.com>
 <bd27898f-59bc-215b-bb84-14582b12cb16@redhat.com>
In-Reply-To: <bd27898f-59bc-215b-bb84-14582b12cb16@redhat.com>
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
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org

T24gV2VkLCA5IE1hciAyMDIyIDE3OjI5OjI4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gU3VwcG9ydCBzZXRfcmluZ3BhcmFtIGJhc2VkIG9uIHZpcnRpbyBxdWV1ZSBy
ZXNldC4KPiA+Cj4gPiBUaGUgcngsdHhfcGVuZGluZyByZXF1aXJlZCB0byBiZSBwYXNzZWQgbXVz
dCBiZSBwb3dlciBvZiAyLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4
IGYxYmRjNmNlMjFjMy4uMWZhMmQ2MzJhOTk0IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBAIC0y
MjkwLDYgKzIyOTAsNTIgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9nZXRfcmluZ3BhcmFtKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgIAlyaW5nLT50eF9wZW5kaW5nID0gdmlydHF1ZXVlX2dl
dF92cmluZ19zaXplKHZpLT5zcVswXS52cSk7Cj4gPiAgIH0KPiA+Cj4gPiArc3RhdGljIGludCB2
aXJ0bmV0X3NldF9yaW5ncGFyYW0oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+ICsJCQkJIHN0
cnVjdCBldGh0b29sX3JpbmdwYXJhbSAqcmluZywKPiA+ICsJCQkJIHN0cnVjdCBrZXJuZWxfZXRo
dG9vbF9yaW5ncGFyYW0gKmtlcm5lbF9yaW5nLAo+ID4gKwkJCQkgc3RydWN0IG5ldGxpbmtfZXh0
X2FjayAqZXh0YWNrKQo+ID4gK3sKPiA+ICsJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRk
ZXZfcHJpdihkZXYpOwo+ID4gKwl1MzIgcnhfcGVuZGluZywgdHhfcGVuZGluZzsKPiA+ICsJc3Ry
dWN0IHJlY2VpdmVfcXVldWUgKnJxOwo+ID4gKwlzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3E7Cj4gPiAr
CWludCBpLCBlcnI7Cj4gPiArCj4gPiArCWlmIChyaW5nLT5yeF9taW5pX3BlbmRpbmcgfHwgcmlu
Zy0+cnhfanVtYm9fcGVuZGluZykKPiA+ICsJCXJldHVybiAtRUlOVkFMOwo+Cj4KPiBBbnkgY2hh
bmNlIHRoYXQgd2UgbWF5IGhpdCB0aGlzIEVJTlZBTD8KClRoaXMgaXMgZGVmaW5pdGVseSBub3Qg
dGhlIGNhc2UgYXQgcHJlc2VudC4KCkkgdGhpbmsgdGhpcyBjYW4gYmUga2VwdCwgdGhpcyBtYWtl
cyBzZW5zZS4KCkkgY2FuIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uIGlmIHlvdSB0aGlu
ayBpdCBzaG91bGQgYmUgcmVtb3ZlZC4KClRoYW5rcy4KCj4KPiBUaGFua3MKPgo+Cj4gPiArCj4g
PiArCXJ4X3BlbmRpbmcgPSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUodmktPnJxWzBdLnZxKTsK
PiA+ICsJdHhfcGVuZGluZyA9IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZSh2aS0+c3FbMF0udnEp
Owo+ID4gKwo+ID4gKwlpZiAocmluZy0+cnhfcGVuZGluZyA9PSByeF9wZW5kaW5nICYmCj4gPiAr
CSAgICByaW5nLT50eF9wZW5kaW5nID09IHR4X3BlbmRpbmcpCj4gPiArCQlyZXR1cm4gMDsKPiA+
ICsKPiA+ICsJaWYgKHJpbmctPnJ4X3BlbmRpbmcgPiB2aXJ0cXVldWVfZ2V0X3ZyaW5nX21heF9z
aXplKHZpLT5ycVswXS52cSkpCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+ICsKPiA+ICsJaWYg
KHJpbmctPnR4X3BlbmRpbmcgPiB2aXJ0cXVldWVfZ2V0X3ZyaW5nX21heF9zaXplKHZpLT5zcVsw
XS52cSkpCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+ICsKPiA+ICsJZm9yIChpID0gMDsgaSA8
IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykgewo+ID4gKwkJcnEgPSB2aS0+cnEgKyBpOwo+ID4g
KwkJc3EgPSB2aS0+c3EgKyBpOwo+ID4gKwo+ID4gKwkJaWYgKHJpbmctPnR4X3BlbmRpbmcgIT0g
dHhfcGVuZGluZykgewo+ID4gKwkJCWVyciA9IHZpcnRuZXRfdHhfdnFfcmVzZXQodmksIHNxLCBy
aW5nLT50eF9wZW5kaW5nKTsKPiA+ICsJCQlpZiAoZXJyKQo+ID4gKwkJCQlyZXR1cm4gZXJyOwo+
ID4gKwkJfQo+ID4gKwo+ID4gKwkJaWYgKHJpbmctPnJ4X3BlbmRpbmcgIT0gcnhfcGVuZGluZykg
ewo+ID4gKwkJCWVyciA9IHZpcnRuZXRfcnhfdnFfcmVzZXQodmksIHJxLCByaW5nLT5yeF9wZW5k
aW5nKTsKPiA+ICsJCQlpZiAoZXJyKQo+ID4gKwkJCQlyZXR1cm4gZXJyOwo+ID4gKwkJfQo+ID4g
Kwl9Cj4gPiArCj4gPiArCXJldHVybiAwOwo+ID4gK30KPiA+Cj4gPiAgIHN0YXRpYyB2b2lkIHZp
cnRuZXRfZ2V0X2RydmluZm8oc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+ICAgCQkJCXN0cnVj
dCBldGh0b29sX2RydmluZm8gKmluZm8pCj4gPiBAQCAtMjUyMyw2ICsyNTY5LDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBldGh0b29sX29wcyB2aXJ0bmV0X2V0aHRvb2xfb3BzID0gewo+ID4gICAJ
LmdldF9kcnZpbmZvID0gdmlydG5ldF9nZXRfZHJ2aW5mbywKPiA+ICAgCS5nZXRfbGluayA9IGV0
aHRvb2xfb3BfZ2V0X2xpbmssCj4gPiAgIAkuZ2V0X3JpbmdwYXJhbSA9IHZpcnRuZXRfZ2V0X3Jp
bmdwYXJhbSwKPiA+ICsJLnNldF9yaW5ncGFyYW0gPSB2aXJ0bmV0X3NldF9yaW5ncGFyYW0sCj4g
PiAgIAkuZ2V0X3N0cmluZ3MgPSB2aXJ0bmV0X2dldF9zdHJpbmdzLAo+ID4gICAJLmdldF9zc2V0
X2NvdW50ID0gdmlydG5ldF9nZXRfc3NldF9jb3VudCwKPiA+ICAgCS5nZXRfZXRodG9vbF9zdGF0
cyA9IHZpcnRuZXRfZ2V0X2V0aHRvb2xfc3RhdHMsCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtdW0K

