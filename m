Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRt6p-0082Gi-L8
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 09:59:57 +0000
Message-ID: <1646819926.6046128-13-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 21/26] virtio: add helper virtio_find_vqs_ctx_size()
Date: Wed, 9 Mar 2022 17:58:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-22-xuanzhuo@linux.alibaba.com>
 <f1fb522d-74ce-a642-7768-deaad76aeddc@redhat.com>
In-Reply-To: <f1fb522d-74ce-a642-7768-deaad76aeddc@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE3OjA0OjEyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gSW50cm9kdWNlIGhlbHBlciB2aXJ0aW9fZmluZF92cXNfY3R4X3NpemUoKSB0
byBjYWxsIGZpbmRfdnFzIGFuZCBzcGVjaWZ5Cj4gPiB0aGUgbWF4aW11bSBzaXplIG9mIGVhY2gg
dnEgcmluZy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5o
IHwgMTIgKysrKysrKysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5j
bHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+IGluZGV4IDUxNTc1MjRkODAzNi4uOTIxZDg2
MTBkYjBjIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+
ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiBAQCAtMjMzLDYgKzIzMywx
OCBAQCBpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwg
dW5zaWduZWQgbnZxcywKPiA+ICAgCQkJCSAgICAgIGRlc2MsIE5VTEwpOwo+ID4gICB9Cj4gPgo+
ID4gK3N0YXRpYyBpbmxpbmUKPiA+ICtpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eF9zaXplKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1MzIgbnZxcywKPiA+ICsJCQkJIHN0cnVjdCB2aXJ0cXVl
dWUgKnZxc1tdLAo+ID4gKwkJCQkgdnFfY2FsbGJhY2tfdCAqY2FsbGJhY2tzW10sCj4gPiArCQkJ
CSBjb25zdCBjaGFyICogY29uc3QgbmFtZXNbXSwKPiA+ICsJCQkJIGNvbnN0IGJvb2wgKmN0eCwg
c3RydWN0IGlycV9hZmZpbml0eSAqZGVzYywKPiA+ICsJCQkJIHUzMiBzaXplc1tdKQo+ID4gK3sK
PiA+ICsJcmV0dXJuIHZkZXYtPmNvbmZpZy0+ZmluZF92cXModmRldiwgbnZxcywgdnFzLCBjYWxs
YmFja3MsIG5hbWVzLCBjdHgsCj4gPiArCQkJCSAgICAgIGRlc2MsIHNpemVzKTsKPiA+ICt9Cj4K
Pgo+IERvIHdlIG5lZWQgdG8gY29udmVydCBhbGwgdGhlIG9wZW4gY29kZWQgZGlyZWN0IGNhbGwg
dG8gZmluZF92cXMoKSBvdGhlcgo+IHRoYW4gbmV0PwoKCkRvIHlvdSBtZWFuIGNhbGxpbmcgZmlu
ZF92cXMgd2l0aG91dCBhIGhlbHBlcj8gVGhlIGtlcm5lbCBkb2Vzbid0IGRvIHRoYXQKYW55bW9y
ZS4KClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KPgo+ID4gKwo+ID4gICAvKioKPiA+ICAgICogdmly
dGlvX3Jlc2V0X3ZxIC0gcmVzZXQgYSBxdWV1ZSBpbmRpdmlkdWFsbHkKPiA+ICAgICogQHZxOiB0
aGUgdmlydHF1ZXVlCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

