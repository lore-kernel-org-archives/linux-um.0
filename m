Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neAku-00C8he-Qu
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 07:16:06 +0000
Received: by mail-pf1-f200.google.com with SMTP id
 t4-20020a628104000000b005056f132662so8051236pfd.21
 for <linux-um@lists.infradead.org>; Tue, 12 Apr 2022 00:16:00 -0700 (PDT)
Message-ID: <ccd0fd5d-389a-70e9-ae48-406514e383d6@redhat.com>
Date: Tue, 12 Apr 2022 15:15:44 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 27/32] virtio: add helper virtio_find_vqs_ctx_size()
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-28-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-28-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBJbnRyb2R1Y2Ug
aGVscGVyIHZpcnRpb19maW5kX3Zxc19jdHhfc2l6ZSgpIHRvIGNhbGwgZmluZF92cXMgYW5kIHNw
ZWNpZnkKPiB0aGUgbWF4aW11bSBzaXplIG9mIGVhY2ggdnEgcmluZy4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGluY2x1ZGUvbGludXgv
dmlydGlvX2NvbmZpZy5oIHwgMTIgKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCAwZjdkZWY3ZGRmZDIu
LjIyZTI5YzkyNjk0NiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcu
aAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTIzNSw2ICsyMzUs
MTggQEAgaW50IHZpcnRpb19maW5kX3Zxc19jdHgoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYs
IHVuc2lnbmVkIG52cXMsCj4gICAJCQkJICAgICAgY3R4LCBkZXNjKTsKPiAgIH0KPiAgIAo+ICtz
dGF0aWMgaW5saW5lCj4gK2ludCB2aXJ0aW9fZmluZF92cXNfY3R4X3NpemUoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYsIHUzMiBudnFzLAo+ICsJCQkJIHN0cnVjdCB2aXJ0cXVldWUgKnZxc1td
LAo+ICsJCQkJIHZxX2NhbGxiYWNrX3QgKmNhbGxiYWNrc1tdLAo+ICsJCQkJIGNvbnN0IGNoYXIg
KiBjb25zdCBuYW1lc1tdLAo+ICsJCQkJIHUzMiBzaXplc1tdLAo+ICsJCQkJIGNvbnN0IGJvb2wg
KmN0eCwgc3RydWN0IGlycV9hZmZpbml0eSAqZGVzYykKPiArewo+ICsJcmV0dXJuIHZkZXYtPmNv
bmZpZy0+ZmluZF92cXModmRldiwgbnZxcywgdnFzLCBjYWxsYmFja3MsIG5hbWVzLCBzaXplcywK
PiArCQkJCSAgICAgIGN0eCwgZGVzYyk7Cj4gK30KPiArCj4gICAvKioKPiAgICAqIHZpcnRpb19k
ZXZpY2VfcmVhZHkgLSBlbmFibGUgdnEgdXNlIGluIHByb2JlIGZ1bmN0aW9uCj4gICAgKiBAdmRl
djogdGhlIGRldmljZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

