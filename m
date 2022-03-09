Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpb3-007Tlo-Sv
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 06:14:55 +0000
Received: by mail-pf1-f200.google.com with SMTP id
 67-20020a621446000000b004f739ef52f1so1008681pfu.0
 for <linux-um@lists.infradead.org>; Tue, 08 Mar 2022 22:14:47 -0800 (PST)
Message-ID: <4bc140fa-9e72-4bb5-47d9-84d9db384898@redhat.com>
Date: Wed, 9 Mar 2022 14:14:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7 02/26] virtio: queue_reset: add VIRTIO_F_RING_RESET
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-3-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEFkZGVkIFZJUlRJ
T19GX1JJTkdfUkVTRVQsIGl0IGNhbWUgZnJvbSBoZXJlCj4gaHR0cHM6Ly9naXRodWIuY29tL29h
c2lzLXRjcy92aXJ0aW8tc3BlYy9pc3N1ZXMvMTI0CgoKTml0OiBpdCdzIGJldHRlciB0byBleHBs
YWluIFZJUlRJT19GX1JJTkdfUkVTRVQgYSBsaXR0bGUgYml0IGhlcmUuCgpPdGhlciB0aGFuIHRo
aXMuCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+Cj4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0K
PiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmggfCA3ICsrKysrKy0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19jb25maWcuaAo+IGluZGV4IGI1ZWRhMDZmMGQ1Ny4uMDg2MmJlODAyZmY4IDEw
MDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiArKysgYi9p
bmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTUyLDcgKzUyLDcgQEAKPiAg
ICAqIHJlc3QgYXJlIHBlci1kZXZpY2UgZmVhdHVyZSBiaXRzLgo+ICAgICovCj4gICAjZGVmaW5l
IFZJUlRJT19UUkFOU1BPUlRfRl9TVEFSVAkyOAo+IC0jZGVmaW5lIFZJUlRJT19UUkFOU1BPUlRf
Rl9FTkQJCTM4Cj4gKyNkZWZpbmUgVklSVElPX1RSQU5TUE9SVF9GX0VORAkJNDEKPiAgIAo+ICAg
I2lmbmRlZiBWSVJUSU9fQ09ORklHX05PX0xFR0FDWQo+ICAgLyogRG8gd2UgZ2V0IGNhbGxiYWNr
cyB3aGVuIHRoZSByaW5nIGlzIGNvbXBsZXRlbHkgdXNlZCwgZXZlbiBpZiB3ZSd2ZQo+IEBAIC05
Miw0ICs5Miw5IEBACj4gICAgKiBEb2VzIHRoZSBkZXZpY2Ugc3VwcG9ydCBTaW5nbGUgUm9vdCBJ
L08gVmlydHVhbGl6YXRpb24/Cj4gICAgKi8KPiAgICNkZWZpbmUgVklSVElPX0ZfU1JfSU9WCQkJ
MzcKPiArCj4gKy8qCj4gKyAqIFRoaXMgZmVhdHVyZSBpbmRpY2F0ZXMgdGhhdCB0aGUgZHJpdmVy
IGNhbiByZXNldCBhIHF1ZXVlIGluZGl2aWR1YWxseS4KPiArICovCj4gKyNkZWZpbmUgVklSVElP
X0ZfUklOR19SRVNFVAkJNDAKPiAgICNlbmRpZiAvKiBfVUFQSV9MSU5VWF9WSVJUSU9fQ09ORklH
X0ggKi8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

