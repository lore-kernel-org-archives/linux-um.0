Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRsXA-007tzL-0l
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 09:23:05 +0000
Message-ID: <1646817741.6086373-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 08/26] virtio_ring: extract the logic of freeing vring
Date: Wed, 9 Mar 2022 17:22:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
 <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
In-Reply-To: <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE1OjUxOjEzICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gSW50cm9kdWNlIHZyaW5nX2ZyZWUoKSB0byBmcmVlIHRoZSB2cmluZyBvZiB2
cS4KPiA+Cj4gPiBQcmV2ZW50IGRvdWJsZSBmcmVlIGJ5IHNldHRpbmcgdnEtPnJlc2V0Lgo+ID4K
PiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+
Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI1ICsrKysrKysr
KysrKysrKysrKysrLS0tLS0KPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICA4
ICsrKysrKysrCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IGI1YTliZjRmNDViMy4u
ZTA0MjJjMDRjOTAzIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTI0NDIsMTQg
KzI0NDIsMTAgQEAgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25l
ZCBpbnQgaW5kZXgsCj4gPiAgIH0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfbmV3X3Zp
cnRxdWV1ZSk7Cj4gPgo+ID4gLXZvaWQgdnJpbmdfZGVsX3ZpcnRxdWV1ZShzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpCj4gPiArc3RhdGljIHZvaWQgX192cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSkKPiA+ICAgewo+ID4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEo
X3ZxKTsKPiA+Cj4gPiAtCXNwaW5fbG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+
ID4gLQlsaXN0X2RlbCgmX3ZxLT5saXN0KTsKPiA+IC0Jc3Bpbl91bmxvY2soJnZxLT52cS52ZGV2
LT52cXNfbGlzdF9sb2NrKTsKPiA+IC0KPiA+ICAgCWlmICh2cS0+d2Vfb3duX3JpbmcpIHsKPiA+
ICAgCQlpZiAodnEtPnBhY2tlZF9yaW5nKSB7Cj4gPiAgIAkJCXZyaW5nX2ZyZWVfcXVldWUodnEt
PnZxLnZkZXYsCj4gPiBAQCAtMjQ4MCw2ICsyNDc2LDI1IEBAIHZvaWQgdnJpbmdfZGVsX3ZpcnRx
dWV1ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gPiAgIAkJa2ZyZWUodnEtPnNwbGl0LmRlc2Nf
c3RhdGUpOwo+ID4gICAJCWtmcmVlKHZxLT5zcGxpdC5kZXNjX2V4dHJhKTsKPiA+ICAgCX0KPiA+
ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICp2
cSkKPiA+ICt7Cj4gPiArCV9fdnJpbmdfZnJlZSh2cSk7Cj4gPiArCXZxLT5yZXNldCA9IFZJUlRJ
T19WUV9SRVNFVF9TVEVQX1ZSSU5HX1JFTEVBU0U7Cj4gPiArfQo+ID4gKwo+ID4gK3ZvaWQgdnJp
bmdfZGVsX3ZpcnRxdWV1ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gPiArewo+ID4gKwlzdHJ1
Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gKwo+ID4gKwlzcGluX2xv
Y2soJnZxLT52cS52ZGV2LT52cXNfbGlzdF9sb2NrKTsKPiA+ICsJbGlzdF9kZWwoJl92cS0+bGlz
dCk7Cj4gPiArCXNwaW5fdW5sb2NrKCZ2cS0+dnEudmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gPiAr
Cj4gPiArCWlmIChfdnEtPnJlc2V0ICE9IFZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5HX1JFTEVB
U0UpCj4gPiArCQlfX3ZyaW5nX2ZyZWUoX3ZxKTsKPiA+ICsKPiA+ICAgCWtmcmVlKHZxKTsKPiA+
ICAgfQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19kZWxfdmlydHF1ZXVlKTsKPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8u
aAo+ID4gaW5kZXggZDU5YWRjNGJlMDY4Li5lMzcxNGU2ZGIzMzAgMTAwNjQ0Cj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4g
PiBAQCAtMTAsNiArMTAsMTMgQEAKPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJs
ZS5oPgo+ID4gICAjaW5jbHVkZSA8bGludXgvZ2ZwLmg+Cj4gPgo+ID4gK2VudW0gdmlydGlvX3Zx
X3Jlc2V0X3N0ZXAgewo+ID4gKwlWSVJUSU9fVlFfUkVTRVRfU1RFUF9OT05FLAo+ID4gKwlWSVJU
SU9fVlFfUkVTRVRfU1RFUF9ERVZJQ0UsCj4gPiArCVZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5H
X1JFTEVBU0UsCj4gPiArCVZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5HX0FUVEFDSCwKPiA+ICt9
Owo+Cj4KPiBUaGlzIHBhcnQgbG9va3Mgbm90IHJlbGF0ZWQgdG8gdGhlIHN1YmplY3QuCj4KPiBB
bmQgaXQgbmVlZHMgZGV0YWlsIGRvY3VtZW50YXRpb24gb24gdGhpcy4KPgo+IEJ1dCBJIHdvbmRl
ciBob3cgdXNlZnVsIGl0IGlzLCBhbnl3YXkgd2UgY2FuIGNoZWNrIHRoZSByZXNldCBzdGF0dXMg
dmlhCj4gdHJhbnNwb3J0IHNwZWNpZmljIHdheSBhbmQgaW4gdGhlIGZ1dHVyZSB3ZSBtYXkgd2Fu
dCB0byBkbyBtb3JlIHRoYW4KPiBqdXN0IHJlc2l6aW5nIChlLmcgUEFTSUQpLgoKCkkgd2lsbCB0
cnkgYW5kIHJlbW92ZSBpdCBmcm9tIGhlcmUuCgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+ID4g
Kwo+ID4gICAvKioKPiA+ICAgICogdmlydHF1ZXVlIC0gYSBxdWV1ZSB0byByZWdpc3RlciBidWZm
ZXJzIGZvciBzZW5kaW5nIG9yIHJlY2VpdmluZy4KPiA+ICAgICogQGxpc3Q6IHRoZSBjaGFpbiBv
ZiB2aXJ0cXVldWVzIGZvciB0aGlzIGRldmljZQo+ID4gQEAgLTMzLDYgKzQwLDcgQEAgc3RydWN0
IHZpcnRxdWV1ZSB7Cj4gPiAgIAl1bnNpZ25lZCBpbnQgbnVtX2ZyZWU7Cj4gPiAgIAl1bnNpZ25l
ZCBpbnQgbnVtX21heDsKPiA+ICAgCXZvaWQgKnByaXY7Cj4gPiArCWVudW0gdmlydGlvX3ZxX3Jl
c2V0X3N0ZXAgcmVzZXQ7Cj4gPiAgIH07Cj4gPgo+ID4gICBpbnQgdmlydHF1ZXVlX2FkZF9vdXRi
dWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K

