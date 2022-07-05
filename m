Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out199-13.us.a.mail.aliyun.com ([47.90.199.13])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Xri-00Dvzl-SW
	for linux-um@lists.infradead.org; Tue, 05 Jul 2022 02:00:41 +0000
Message-ID: <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
Date: Tue, 5 Jul 2022 09:59:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
 <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
In-Reply-To: <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
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
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-um@lists.infradead.org, netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, kangjie.xu@linux.alibaba.com, virtualization@lists.linux-foundation.org

T24gTW9uLCA0IEp1bCAyMDIyIDExOjQ0OjEyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5jdGlvbiBvZiB0aGUg
cnggcXVldWVzLgo+ID4gQmFzZWQgb24gdGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8g
bW9kaWZ5IHRoZSByaW5nIG51bSBvZiB0aGUKPiA+IHF1ZXVlLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAg
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGlu
ZGV4IDlmZTIyMmEzNjYzYS4uNmFiMTZmZDE5M2U1IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBA
IC0yNzgsNiArMjc4LDggQEAgc3RydWN0IHBhZGRlZF92bmV0X2hkciB7Cj4gPiAgIAljaGFyIHBh
ZGRpbmdbMTJdOwo+ID4gICB9Owo+ID4KPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2ZyZWVf
dW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiA+ICsKPiA+ICAg
c3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ICAgewo+ID4gICAJcmV0dXJu
ICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJUlRJT19YRFBfRkxBRzsKPiA+IEBAIC0xODQ2LDYgKzE4
NDgsMjYgQEAgc3RhdGljIG5ldGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNr
Yiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ICAgCXJldHVybiBORVRERVZfVFhfT0s7Cj4g
PiAgIH0KPiA+Cj4gPiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSwKPiA+ICsJCQkgICAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgdTMyIHJp
bmdfbnVtKQo+ID4gK3sKPiA+ICsJaW50IGVyciwgcWluZGV4Owo+ID4gKwo+ID4gKwlxaW5kZXgg
PSBycSAtIHZpLT5ycTsKPiA+ICsKPiA+ICsJbmFwaV9kaXNhYmxlKCZycS0+bmFwaSk7Cj4KPgo+
IERvIHdlIG5lZWQgdG8gY2FuY2VsIHRoZSByZWZpbGwgd29yayBoZXJlPwoKCkkgdGhpbmsgbm8s
IG5hcGlfZGlzYWJsZSBpcyBtdXR1YWxseSBleGNsdXNpdmUsIHdoaWNoIGVuc3VyZXMgdGhhdCB0
aGVyZSB3aWxsIGJlCm5vIGNvbmZsaWN0cyBiZXR3ZWVuIHRoZW0uCgpUaGFua3MuCgo+Cj4gVGhh
bmtzCj4KPgo+ID4gKwo+ID4gKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHJxLT52cSwgcmluZ19u
dW0sIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCW5l
dGRldl9lcnIodmktPmRldiwgInJlc2l6ZSByeCBmYWlsOiByeCBxdWV1ZSBpbmRleDogJWQgZXJy
OiAlZFxuIiwgcWluZGV4LCBlcnIpOwo+ID4gKwo+ID4gKwlpZiAoIXRyeV9maWxsX3JlY3Yodmks
IHJxLCBHRlBfS0VSTkVMKSkKPiA+ICsJCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdmktPnJlZmls
bCwgMCk7Cj4gPiArCj4gPiArCXZpcnRuZXRfbmFwaV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkp
Owo+ID4gKwlyZXR1cm4gZXJyOwo+ID4gK30KPiA+ICsKPiA+ICAgLyoKPiA+ICAgICogU2VuZCBj
b21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1h
bmRzCj4gPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5
IGZlYXR1cmUgYml0cywgc2hvdWxkCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K

