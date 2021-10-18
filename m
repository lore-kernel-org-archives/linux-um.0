Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcRJI-00FX7Z-0C
 for linux-um@lists.infradead.org; Mon, 18 Oct 2021 12:00:09 +0000
MIME-Version: 1.0
Subject: Re: [PATCH net] hamradio: baycom_epp: fix build for UML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163455840685.2577.7817040614905305666.git-patchwork-notify@kernel.org>
Date: Mon, 18 Oct 2021 12:00:06 +0000
References: <20211015021804.17005-1-rdunlap@infradead.org>
In-Reply-To: <20211015021804.17005-1-rdunlap@infradead.org>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, davem@davemloft.net, kuba@kernel.org, t.sailer@alumni.ethz.ch, linux-hams@vger.kernel.org

SGVsbG86CgpUaGlzIHBhdGNoIHdhcyBhcHBsaWVkIHRvIG5ldGRldi9uZXQuZ2l0IChtYXN0ZXIp
CmJ5IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD46CgpPbiBUaHUsIDE0IE9j
dCAyMDIxIDE5OjE4OjA0IC0wNzAwIHlvdSB3cm90ZToKPiBPbiBpMzg2LCB0aGUgYmF5Y29tX2Vw
cCBkcml2ZXIgd2FudHMgdG8gaW5zcGVjdCBYODYgQ1BVIGZlYXR1cmVzIChUU0MpCj4gYW5kIHRo
ZW4gYWN0IG9uIHRoYXQgZGF0YSwgYnV0IHRoYXQgaW5mbyBpcyBub3QgYXZhaWxhYmxlIHdoZW4g
cnVubmluZwo+IG9uIFVNTCwgc28gcHJldmVudCB0aGF0IHRlc3QgYW5kIGRvIHRoZSBkZWZhdWx0
IGFjdGlvbi4KPiAKPiBQcmV2ZW50cyB0aGlzIGJ1aWxkIGVycm9yIG9uIFVNTCArIGkzODY6Cj4g
Cj4gLi4vZHJpdmVycy9uZXQvaGFtcmFkaW8vYmF5Y29tX2VwcC5jOiBJbiBmdW5jdGlvbiDigJhl
cHBfYmjigJk6Cj4gLi4vZHJpdmVycy9uZXQvaGFtcmFkaW8vYmF5Y29tX2VwcC5jOjYzMDo2OiBl
cnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYYm9vdF9jcHVfaGFz4oCZ
OyBkaWQgeW91IG1lYW4g4oCYZ2V0X2NwdV9tYXNr4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5j
dGlvbi1kZWNsYXJhdGlvbl0KPiAgIGlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfVFNDKSkg
ICBcCj4gICAgICAgXgo+IC4uL2RyaXZlcnMvbmV0L2hhbXJhZGlvL2JheWNvbV9lcHAuYzo2NTg6
Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmEdFVFRJQ0vigJkKPiAgIEdFVFRJQ0so
dGltZTEpOwo+IAo+IFsuLi5dCgpIZXJlIGlzIHRoZSBzdW1tYXJ5IHdpdGggbGlua3M6CiAgLSBb
bmV0XSBoYW1yYWRpbzogYmF5Y29tX2VwcDogZml4IGJ1aWxkIGZvciBVTUwKICAgIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvbmV0ZGV2L25ldC9jLzBhOWJiMTFhNWUyOQoKWW91IGFyZSBhd2Vzb21l
LCB0aGFuayB5b3UhCi0tCkRlZXQtZG9vdC1kb3QsIEkgYW0gYSBib3QuCmh0dHBzOi8va29yZy5k
b2NzLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3B3Ym90Lmh0bWwKCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC11bQo=

