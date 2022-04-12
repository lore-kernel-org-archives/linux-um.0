Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne6ZT-00BKzf-SZ
 for linux-um@lists.infradead.org; Tue, 12 Apr 2022 02:48:01 +0000
Received: by mail-pj1-f70.google.com with SMTP id
 rm11-20020a17090b3ecb00b001c713925e58so709108pjb.6
 for <linux-um@lists.infradead.org>; Mon, 11 Apr 2022 19:47:53 -0700 (PDT)
Message-ID: <9868de23-c171-2492-a43f-78f51df84640@redhat.com>
Date: Tue, 12 Apr 2022 10:47:41 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v9 02/32] virtio: struct virtio_config_ops add callbacks
 for queue_reset
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-3-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBQZXJmb3JtaW5n
IHJlc2V0IG9uIGEgcXVldWUgaXMgZGl2aWRlZCBpbnRvIGZvdXIgc3RlcHM6Cj4KPiAgIDEuIHRy
YW5zcG9ydDogbm90aWZ5IHRoZSBkZXZpY2UgdG8gcmVzZXQgdGhlIHF1ZXVlCj4gICAyLiB2cmlu
ZzogICAgIHJlY3ljbGUgdGhlIGJ1ZmZlciBzdWJtaXR0ZWQKPiAgIDMuIHZyaW5nOiAgICAgcmVz
ZXQvcmVzaXplIHRoZSB2cmluZyAobWF5IHJlLWFsbG9jKQo+ICAgNC4gdHJhbnNwb3J0OiBtbWFw
IHZyaW5nIHRvIGRldmljZSwgYW5kIGVuYWJsZSB0aGUgcXVldWUKCgpOaXQ6IGl0IGxvb2tzIHRv
IG1lIHdlJ2QgYmV0dGVyIHNheSBpdCdzIGFuIGV4YW1wbGUgKHNpbmNlIHN0ZXAgMyBvciAKZXZl
biAyIGlzIG5vdCBhIG11c3QpLgoKCj4KPiBJbiBvcmRlciB0byBzdXBwb3J0IHF1ZXVlIHJlc2V0
LCBhZGQgdHdvIGNhbGxiYWNrcyhyZXNldF92cSwKPiBlbmFibGVfcmVzZXRfdnEpIGluIHN0cnVj
dCB2aXJ0aW9fY29uZmlnX29wcyB0byBpbXBsZW1lbnQgc3RlcHMgMSBhbmQgNC4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4g
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDEyICsrKysrKysrKysrKwo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3ZpcnRpb19jb25maWcuaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gaW5k
ZXggNGQxMDdhZDMxMTQ5Li5kNGFkY2QwZTFjNTcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51
eC92aXJ0aW9fY29uZmlnLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+
IEBAIC03NCw2ICs3NCwxNiBAQCBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gewo+ICAgICogQHNl
dF92cV9hZmZpbml0eTogc2V0IHRoZSBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUgKG9wdGlvbmFs
KS4KPiAgICAqIEBnZXRfdnFfYWZmaW5pdHk6IGdldCB0aGUgYWZmaW5pdHkgZm9yIGEgdmlydHF1
ZXVlIChvcHRpb25hbCkuCj4gICAgKiBAZ2V0X3NobV9yZWdpb246IGdldCBhIHNoYXJlZCBtZW1v
cnkgcmVnaW9uIGJhc2VkIG9uIHRoZSBpbmRleC4KPiArICogQHJlc2V0X3ZxOiByZXNldCBhIHF1
ZXVlIGluZGl2aWR1YWxseSAob3B0aW9uYWwpLgo+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ICsg
KglSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBlcnJvciBzdGF0dXMKPiArICoJcmVzZXRfdnEgd2ls
bCBndWFyYW50ZWUgdGhhdCB0aGUgY2FsbGJhY2tzIGFyZSBkaXNhYmxlZCBhbmQgc3luY2hyb25p
emVkLgo+ICsgKglFeGNlcHQgZm9yIHRoZSBjYWxsYmFjaywgdGhlIGNhbGxlciBzaG91bGQgZ3Vh
cmFudGVlIHRoYXQgdGhlIHZyaW5nIGlzCgoKSSB3b25kZXIgd2hhdCdzIHRoZSBpbXBsaWNhdGlv
bnMgZm9yIHZpcnRpbyBoYXJkZW5pbmdbMV0uIEluIHRoYXQgCnNlcmllcywgd2UgYWdyZWUgdG8g
aGF2ZSBhIHN5bmNocm9uaXplX3ZxcygpIGNvbmZpZyBvcHMgdG8gbWFrZSBzdXJlIApjYWxsYmFj
a3MgYXJlIHN5bmNocm9uaXplZC4KCkl0IHVzZXMgYSBnbG9iYWwgZmxhZyBhbmQgYSBkZXZpY2Ug
d2lzZSBzeW5jaHJvbml6YXRpb24gbWVjaGFuaXNtLiBJdCAKbG9va3MgdG8gbWUgd2UgbmVlZCB0
byBzd2l0Y2ggdG8KCjEpIHBlciB2aXJ0cXVldWUgZmxhZwoyKSBwZXIgdmlydHF1ZXVlIHN5bmNo
cm9uaXphdGlvbgoKVGhhbmtzCgoKPiArICoJbm90IGFjY2Vzc2VkIGJ5IGFueSBmdW5jdGlvbnMg
b2YgdmlydHF1ZXVlLgo+ICsgKiBAZW5hYmxlX3Jlc2V0X3ZxOiBlbmFibGUgYSByZXNldCBxdWV1
ZQo+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ICsgKglSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBl
cnJvciBzdGF0dXMKPiArICoJSWYgcmVzZXRfdnEgaXMgc2V0LCB0aGVuIGVuYWJsZV9yZXNldF92
cSBtdXN0IGFsc28gYmUgc2V0Lgo+ICAgICovCj4gICB0eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tf
dChzdHJ1Y3QgdmlydHF1ZXVlICopOwo+ICAgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHsKPiBA
QCAtMTAwLDYgKzExMCw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB7Cj4gICAJCQlpbnQg
aW5kZXgpOwo+ICAgCWJvb2wgKCpnZXRfc2htX3JlZ2lvbikoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYsCj4gICAJCQkgICAgICAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uICpyZWdpb24sIHU4
IGlkKTsKPiArCWludCAoKnJlc2V0X3ZxKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gKwlpbnQg
KCplbmFibGVfcmVzZXRfdnEpKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiAgIH07Cj4gICAKPiAg
IC8qIElmIGRyaXZlciBkaWRuJ3QgYWR2ZXJ0aXNlIHRoZSBmZWF0dXJlLCBpdCB3aWxsIG5ldmVy
IGFwcGVhci4gKi8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

