Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7CWO-003kUD-Il
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:01:06 +0000
Received: by mail-pj1-f71.google.com with SMTP id u19-20020a17090a891300b001ed01af4131so2587758pjn.1
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:01:00 -0700 (PDT)
Message-ID: <cbdd2030-a4b3-afdd-b22d-cb8223524b20@redhat.com>
Date: Fri, 1 Jul 2022 17:00:45 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v11 11/40] virtio_ring: split: extract the logic of vring
 init
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-12-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGluaXRpYWxpemluZyB2cmluZywgYW5kIHN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsCj4g
Y2FsbCBpdCBzZXBhcmF0ZWx5Lgo+Cj4gVGhpcyBmdW5jdGlvbiBjb21wbGV0ZXMgdGhlIHZhcmlh
YmxlIGluaXRpYWxpemF0aW9uIG9mIHNwbGl0IHZyaW5nLiBJdAo+IHRvZ2V0aGVyIHdpdGggdGhl
IGxvZ2ljIG9mIGF0YXRjaCBjb25zdGl0dXRlcyB0aGUgaW5pdGlhbGl6YXRpb24gb2YKPiB2cmlu
Zy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0K
PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzMCArKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMSBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDkwMjViZDM3M2QzYi4uMzU1NDBk
YWFhMWU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTk0MCw2ICs5NDAsMjQgQEAgc3Rh
dGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zl9zcGxpdChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpCj4gICAJcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmly
dHF1ZXVlX3ZyaW5nX2luaXRfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gK3sK
PiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2Owo+ICsKPiArCXZkZXYgPSB2cS0+dnEudmRl
djsKPiArCj4gKwl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsKPiArCXZxLT5zcGxp
dC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiArCj4gKwkvKiBObyBjYWxsYmFjaz8gIFRlbGwgb3Ro
ZXIgc2lkZSBub3QgdG8gYm90aGVyIHVzLiAqLwo+ICsJaWYgKCF2cS0+dnEuY2FsbGJhY2spIHsK
PiArCQl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93IHw9IFZSSU5HX0FWQUlMX0ZfTk9fSU5U
RVJSVVBUOwo+ICsJCWlmICghdnEtPmV2ZW50KQo+ICsJCQl2cS0+c3BsaXQudnJpbmcuYXZhaWwt
PmZsYWdzID0gY3B1X3RvX3ZpcnRpbzE2KHZkZXYsCj4gKwkJCQkJdnEtPnNwbGl0LmF2YWlsX2Zs
YWdzX3NoYWRvdyk7Cj4gKwl9Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCB2aXJ0cXVldWVfdnJp
bmdfYXR0YWNoX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgCQkJCQkgc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCAqdnJpbmcpCj4gICB7Cj4gQEAgLTIyOTksMTcgKzIz
MTcsNiBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQg
aW50IGluZGV4LAo+ICAgCXZxLT5pbmRpcmVjdCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBW
SVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpICYmCj4gICAJCSFjb250ZXh0Owo+ICAgCj4gLQl2
cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsKPiAtCXZxLT5zcGxpdC5hdmFpbF9pZHhf
c2hhZG93ID0gMDsKPiAtCj4gLQkvKiBObyBjYWxsYmFjaz8gIFRlbGwgb3RoZXIgc2lkZSBub3Qg
dG8gYm90aGVyIHVzLiAqLwo+IC0JaWYgKCFjYWxsYmFjaykgewo+IC0JCXZxLT5zcGxpdC5hdmFp
bF9mbGFnc19zaGFkb3cgfD0gVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQ7Cj4gLQkJaWYgKCF2
cS0+ZXZlbnQpCj4gLQkJCXZxLT5zcGxpdC52cmluZy5hdmFpbC0+ZmxhZ3MgPSBjcHVfdG9fdmly
dGlvMTYodmRldiwKPiAtCQkJCQl2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93KTsKPiAtCX0K
PiAtCj4gICAJdnJpbmcudnJpbmcgPSBfdnJpbmc7Cj4gICAKPiAgIAllcnIgPSB2cmluZ19hbGxv
Y19zdGF0ZV9leHRyYV9zcGxpdCgmdnJpbmcpOwo+IEBAIC0yMzIwLDYgKzIzMjcsNyBAQCBzdHJ1
Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+
ICAgCj4gICAJdmlydHF1ZXVlX2luaXQodnEsIHZyaW5nLnZyaW5nLm51bSk7Cj4gICAJdmlydHF1
ZXVlX3ZyaW5nX2F0dGFjaF9zcGxpdCh2cSwgJnZyaW5nKTsKPiArCXZpcnRxdWV1ZV92cmluZ19p
bml0X3NwbGl0KHZxKTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7
Cj4gICAJbGlzdF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

