Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRsZi-007uM8-SG
 for linux-um@lists.infradead.org; Wed, 09 Mar 2022 09:25:44 +0000
Message-ID: <1646817926.9029093-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 13/26] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
Date: Wed, 9 Mar 2022 17:25:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
 <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
In-Reply-To: <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE2OjQ3OjExICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gUGVyZm9ybWluZyByZXNldCBvbiBhIHF1ZXVlIGlzIGRpdmlkZWQgaW50byBm
b3VyIHN0ZXBzOgo+ID4KPiA+ICAgMS4gcmVzZXRfdnEoKSAgICAgICAgICAgICAgICAgICAgIC0g
bm90aWZ5IHRoZSBkZXZpY2UgdG8gcmVzZXQgdGhlIHF1ZXVlCj4gPiAgIDIuIHZpcnRxdWV1ZV9k
ZXRhY2hfdW51c2VkX2J1ZigpICAtIHJlY3ljbGUgdGhlIGJ1ZmZlciBzdWJtaXR0ZWQKPiA+ICAg
My4gdmlydHF1ZXVlX3Jlc2V0X3ZyaW5nKCkgICAgICAgIC0gcmVzZXQgdGhlIHZyaW5nIChtYXkg
cmUtYWxsb2MpCj4gPiAgIDQuIGVuYWJsZV9yZXNldF92cSgpICAgICAgICAgICAgICAtIG1tYXAg
dnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxlIHRoZSBxdWV1ZQo+ID4KPiA+IFNvIGFkZCB0d28g
Y2FsbGJhY2tzIHJlc2V0X3ZxLCBlbmFibGVfcmVzZXRfdnEgdG8gc3RydWN0Cj4gPiB2aXJ0aW9f
Y29uZmlnX29wcy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oIHwgMTEgKysrKysrKysrKysKPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggYi9p
bmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+ID4gaW5kZXggNGQxMDdhZDMxMTQ5Li5kNTE5
MDZiMTM4OWYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+
ID4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+IEBAIC03NCw2ICs3NCwx
NSBAQCBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gewo+ID4gICAgKiBAc2V0X3ZxX2FmZmluaXR5
OiBzZXQgdGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwpLgo+ID4gICAgKiBA
Z2V0X3ZxX2FmZmluaXR5OiBnZXQgdGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9u
YWwpLgo+ID4gICAgKiBAZ2V0X3NobV9yZWdpb246IGdldCBhIHNoYXJlZCBtZW1vcnkgcmVnaW9u
IGJhc2VkIG9uIHRoZSBpbmRleC4KPiA+ICsgKiBAcmVzZXRfdnE6IHJlc2V0IGEgcXVldWUgaW5k
aXZpZHVhbGx5IChvcHRpb25hbCkuCj4gPiArICoJdnE6IHRoZSB2aXJ0cXVldWUKPiA+ICsgKglS
ZXR1cm5zIDAgb24gc3VjY2VzcyBvciBlcnJvciBzdGF0dXMKPiA+ICsgKglDYWxsZXIgc2hvdWxk
IGd1YXJhbnRlZSB0aGF0IHRoZSB2cmluZyBpcyBub3QgYWNjZXNzZWQgYnkgYW55IGZ1bmN0aW9u
cwo+ID4gKyAqCW9mIHZpcnRxdWV1ZS4KPgo+Cj4gV2UgcHJvYmFibHkgbmVlZCB0byBiZSBtb3Jl
IGFjY3VyYXRlIGhlcmU6Cj4KPiAxKSByZXNldF92cSB3aWxsIGd1YXJhbnRlZSB0aGF0IHRoZSBj
YWxsYmFja3MgYXJlIGRpc2FibGVkIG9yIHN5bmNocm9uaXplZAo+IDIpIGV4Y2VwdCBmb3IgdGhl
IGNhbGxiYWNrLCB0aGUgY2FsbGVyIHNob3VsZCBndWFyYW50ZWUgLi4uCgpPSy4KClRoYW5rcy4K
Cj4KPiBUaGFua3MKPgo+Cj4gPiArICogQGVuYWJsZV9yZXNldF92cTogZW5hYmxlIGEgcmVzZXQg
cXVldWUKPiA+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ID4gKyAqCVJldHVybnMgMCBvbiBzdWNj
ZXNzIG9yIGVycm9yIHN0YXR1cwo+ID4gKyAqCUlmIHJlc2V0X3ZxIGlzIHNldCwgdGhlbiBlbmFi
bGVfcmVzZXRfdnEgbXVzdCBhbHNvIGJlIHNldC4KPiA+ICAgICovCj4gPiAgIHR5cGVkZWYgdm9p
ZCB2cV9jYWxsYmFja190KHN0cnVjdCB2aXJ0cXVldWUgKik7Cj4gPiAgIHN0cnVjdCB2aXJ0aW9f
Y29uZmlnX29wcyB7Cj4gPiBAQCAtMTAwLDYgKzEwOSw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmln
X29wcyB7Cj4gPiAgIAkJCWludCBpbmRleCk7Cj4gPiAgIAlib29sICgqZ2V0X3NobV9yZWdpb24p
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gICAJCQkgICAgICAgc3RydWN0IHZpcnRp
b19zaG1fcmVnaW9uICpyZWdpb24sIHU4IGlkKTsKPiA+ICsJaW50ICgqcmVzZXRfdnEpKHN0cnVj
dCB2aXJ0cXVldWUgKnZxKTsKPiA+ICsJaW50ICgqZW5hYmxlX3Jlc2V0X3ZxKShzdHJ1Y3Qgdmly
dHF1ZXVlICp2cSk7Cj4gPiAgIH07Cj4gPgo+ID4gICAvKiBJZiBkcml2ZXIgZGlkbid0IGFkdmVy
dGlzZSB0aGUgZmVhdHVyZSwgaXQgd2lsbCBuZXZlciBhcHBlYXIuICovCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlz
dApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

