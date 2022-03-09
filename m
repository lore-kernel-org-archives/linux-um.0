Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRryp-007mth-6k
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 08:47:36 +0000
Received: by mail-pj1-f70.google.com with SMTP id
 w3-20020a17090ac98300b001b8b914e91aso1211445pjt.0
 for <linux-um@lists.infradead.org>; Wed, 09 Mar 2022 00:47:30 -0800 (PST)
Message-ID: <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
Date: Wed, 9 Mar 2022 16:47:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 13/26] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
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
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Johannes Berg <johannes.berg@intel.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFBlcmZvcm1pbmcg
cmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8gZm91ciBzdGVwczoKPgo+ICAgMS4gcmVz
ZXRfdnEoKSAgICAgICAgICAgICAgICAgICAgIC0gbm90aWZ5IHRoZSBkZXZpY2UgdG8gcmVzZXQg
dGhlIHF1ZXVlCj4gICAyLiB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xl
IHRoZSBidWZmZXIgc3VibWl0dGVkCj4gICAzLiB2aXJ0cXVldWVfcmVzZXRfdnJpbmcoKSAgICAg
ICAgLSByZXNldCB0aGUgdnJpbmcgKG1heSByZS1hbGxvYykKPiAgIDQuIGVuYWJsZV9yZXNldF92
cSgpICAgICAgICAgICAgICAtIG1tYXAgdnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxlIHRoZSBx
dWV1ZQo+Cj4gU28gYWRkIHR3byBjYWxsYmFja3MgcmVzZXRfdnEsIGVuYWJsZV9yZXNldF92cSB0
byBzdHJ1Y3QKPiB2aXJ0aW9fY29uZmlnX29wcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L3Zp
cnRpb19jb25maWcuaCB8IDExICsrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5o
IGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCA0ZDEwN2FkMzExNDkuLmQ1
MTkwNmIxMzg5ZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+
ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTc0LDYgKzc0LDE1IEBA
IHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7Cj4gICAgKiBAc2V0X3ZxX2FmZmluaXR5OiBzZXQg
dGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwpLgo+ICAgICogQGdldF92cV9h
ZmZpbml0eTogZ2V0IHRoZSBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUgKG9wdGlvbmFsKS4KPiAg
ICAqIEBnZXRfc2htX3JlZ2lvbjogZ2V0IGEgc2hhcmVkIG1lbW9yeSByZWdpb24gYmFzZWQgb24g
dGhlIGluZGV4Lgo+ICsgKiBAcmVzZXRfdnE6IHJlc2V0IGEgcXVldWUgaW5kaXZpZHVhbGx5IChv
cHRpb25hbCkuCj4gKyAqCXZxOiB0aGUgdmlydHF1ZXVlCj4gKyAqCVJldHVybnMgMCBvbiBzdWNj
ZXNzIG9yIGVycm9yIHN0YXR1cwo+ICsgKglDYWxsZXIgc2hvdWxkIGd1YXJhbnRlZSB0aGF0IHRo
ZSB2cmluZyBpcyBub3QgYWNjZXNzZWQgYnkgYW55IGZ1bmN0aW9ucwo+ICsgKglvZiB2aXJ0cXVl
dWUuCgoKV2UgcHJvYmFibHkgbmVlZCB0byBiZSBtb3JlIGFjY3VyYXRlIGhlcmU6CgoxKSByZXNl
dF92cSB3aWxsIGd1YXJhbnRlZSB0aGF0IHRoZSBjYWxsYmFja3MgYXJlIGRpc2FibGVkIG9yIHN5
bmNocm9uaXplZAoyKSBleGNlcHQgZm9yIHRoZSBjYWxsYmFjaywgdGhlIGNhbGxlciBzaG91bGQg
Z3VhcmFudGVlIC4uLgoKVGhhbmtzCgoKPiArICogQGVuYWJsZV9yZXNldF92cTogZW5hYmxlIGEg
cmVzZXQgcXVldWUKPiArICoJdnE6IHRoZSB2aXJ0cXVldWUKPiArICoJUmV0dXJucyAwIG9uIHN1
Y2Nlc3Mgb3IgZXJyb3Igc3RhdHVzCj4gKyAqCUlmIHJlc2V0X3ZxIGlzIHNldCwgdGhlbiBlbmFi
bGVfcmVzZXRfdnEgbXVzdCBhbHNvIGJlIHNldC4KPiAgICAqLwo+ICAgdHlwZWRlZiB2b2lkIHZx
X2NhbGxiYWNrX3Qoc3RydWN0IHZpcnRxdWV1ZSAqKTsKPiAgIHN0cnVjdCB2aXJ0aW9fY29uZmln
X29wcyB7Cj4gQEAgLTEwMCw2ICsxMDksOCBAQCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+
ICAgCQkJaW50IGluZGV4KTsKPiAgIAlib29sICgqZ2V0X3NobV9yZWdpb24pKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2LAo+ICAgCQkJICAgICAgIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiAq
cmVnaW9uLCB1OCBpZCk7Cj4gKwlpbnQgKCpyZXNldF92cSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEp
Owo+ICsJaW50ICgqZW5hYmxlX3Jlc2V0X3ZxKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gICB9
Owo+ICAgCj4gICAvKiBJZiBkcml2ZXIgZGlkbid0IGFkdmVydGlzZSB0aGUgZmVhdHVyZSwgaXQg
d2lsbCBuZXZlciBhcHBlYXIuICovCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=

