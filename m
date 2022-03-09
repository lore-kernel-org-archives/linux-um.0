Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRoFm-007JEo-AS
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 04:48:51 +0000
Received: by mail-pj1-f70.google.com with SMTP id
 ds4-20020a17090b08c400b001bc1dee733eso2380399pjb.0
 for <linux-um@lists.infradead.org>; Tue, 08 Mar 2022 20:48:46 -0800 (PST)
Message-ID: <373494ae-825b-d573-012c-4e7d453934da@redhat.com>
Date: Wed, 9 Mar 2022 12:48:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 01/26] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-2-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEFkZCBxdWV1ZV9u
b3RpZnlfZGF0YSBpbiBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnLCB3aGljaCBjb21lcyBm
cm9tCj4gaGVyZSBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vl
cy84OQo+Cj4gRm9yIG5vdCBicmVha3MgdUFCSSwgYWRkIGEgbmV3IHN0cnVjdCB2aXJ0aW9fcGNp
X2NvbW1vbl9jZmdfbm90aWZ5Lgo+Cj4gU2luY2UgSSB3YW50IHRvIGFkZCBxdWV1ZV9yZXNldCBh
ZnRlciBxdWV1ZV9ub3RpZnlfZGF0YSwgSSBzdWJtaXR0ZWQKPiB0aGlzIHBhdGNoIGZpcnN0Lgo+
Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4K
CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAg
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCB8IDcgKysrKysrKwo+ICAgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcGNpLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gaW5kZXgg
M2E4NmYzNmQ3ZTNkLi4yMmJlYzliZDBkZmMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19wY2kuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgK
PiBAQCAtMTY2LDYgKzE2NiwxMyBAQCBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIHsKPiAg
IAlfX2xlMzIgcXVldWVfdXNlZF9oaTsJCS8qIHJlYWQtd3JpdGUgKi8KPiAgIH07Cj4gICAKPiAr
c3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZ19ub3RpZnkgewo+ICsJc3RydWN0IHZpcnRpb19w
Y2lfY29tbW9uX2NmZyBjZmc7Cj4gKwo+ICsJX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRhOwkvKiBy
ZWFkLXdyaXRlICovCj4gKwlfX2xlMTYgcGFkZGluZzsKPiArfTsKPiArCj4gICAvKiBGaWVsZHMg
aW4gVklSVElPX1BDSV9DQVBfUENJX0NGRzogKi8KPiAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NmZ19j
YXAgewo+ICAgCXN0cnVjdCB2aXJ0aW9fcGNpX2NhcCBjYXA7CgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC11bQo=

