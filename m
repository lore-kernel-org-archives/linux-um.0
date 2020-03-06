Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA9Me-0002dA-PT
 for linux-um@lists.infradead.org; Fri, 06 Mar 2020 09:33:53 +0000
Subject: Re: [PATCH net-next 3/7] tun: reject unsupported coalescing params
References: <20200306010602.1620354-1-kuba@kernel.org>
 <20200306010602.1620354-4-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <36c409f7-a8b4-50f6-4933-1c8105755d11@redhat.com>
Date: Fri, 6 Mar 2020 17:33:16 +0800
MIME-Version: 1.0
In-Reply-To: <20200306010602.1620354-4-kuba@kernel.org>
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
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: mkubecek@suse.cz, merez@codeaurora.org, pv-drivers@vmware.com, GR-Linux-NIC-Dev@marvell.com, doshir@vmware.com, leon@kernel.org, manishc@marvell.com, linux-rdma@vger.kernel.org, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, edumazet@google.com, jgg@ziepe.ca, dledford@redhat.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org, hayeswang@realtek.com, kvalo@codeaurora.org, anton.ivanov@cambridgegreys.com

Ck9uIDIwMjAvMy82IOS4iuWNiDk6MDUsIEpha3ViIEtpY2luc2tpIHdyb3RlOgo+IFNldCBldGh0
b29sX29wcy0+c3VwcG9ydGVkX2NvYWxlc2NlX3BhcmFtcyB0byBsZXQKPiB0aGUgY29yZSByZWpl
Y3QgdW5zdXBwb3J0ZWQgY29hbGVzY2luZyBwYXJhbWV0ZXJzLgo+Cj4gVGhpcyBkcml2ZXIgZGlk
IG5vdCBwcmV2aW91c2x5IHJlamVjdCB1bnN1cHBvcnRlZCBwYXJhbWV0ZXJzLgo+Cj4gU2lnbmVk
LW9mZi1ieTogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4KPiAtLS0KPiAgIGRyaXZl
cnMvbmV0L3R1bi5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jCj4gaW5k
ZXggNzlmMjQ4Y2IyODJkLi45ZThmMjM1MTllODIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQv
dHVuLmMKPiArKysgYi9kcml2ZXJzL25ldC90dW4uYwo+IEBAIC0zNTk3LDYgKzM1OTcsNyBAQCBz
dGF0aWMgaW50IHR1bl9zZXRfY29hbGVzY2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIH0K
PiAgIAo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBldGh0b29sX29wcyB0dW5fZXRodG9vbF9vcHMg
PSB7Cj4gKwkuc3VwcG9ydGVkX2NvYWxlc2NlX3BhcmFtcyA9IEVUSFRPT0xfQ09BTEVTQ0VfUlhf
TUFYX0ZSQU1FUywKPiAgIAkuZ2V0X2RydmluZm8JPSB0dW5fZ2V0X2RydmluZm8sCj4gICAJLmdl
dF9tc2dsZXZlbAk9IHR1bl9nZXRfbXNnbGV2ZWwsCj4gICAJLnNldF9tc2dsZXZlbAk9IHR1bl9z
ZXRfbXNnbGV2ZWwsCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

