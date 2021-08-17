Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG1NH-002sfy-SK
 for linux-um@lists.infradead.org; Tue, 17 Aug 2021 15:51:39 +0000
Message-ID: <46d3c77cb6fcc686d3f3110eb2412f3fd2e682dc.camel@sipsolutions.net>
Subject: Re: [PATCH v2 7/8] um: add PCI over virtio emulation driver
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Aug 2021 17:51:27 +0200
In-Reply-To: <20210817155006.GA3020013@bjorn-Precision-5520>
References: <20210817155006.GA3020013@bjorn-Precision-5520>
MIME-Version: 1.0
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-um@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org

SGksCgo+IFRoZSB2aXJ0aW9fcGNpZGV2X29wcyBrZXJuZWwtZG9jIGJlbG93IGRvZXNuJ3QgbWF0
Y2ggdGhlIGFjdHVhbCBlbnVtLAo+IHNvIGl0IGdlbmVyYXRlcyBzZXZlcmFsIHdhcm5pbmdzOgo+
IAo+IMKgwqBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaWRldi5oOjQxOiB3YXJuaW5nOiBF
bnVtIHZhbHVlICdWSVJUSU9fUENJREVWX09QX1JFU0VSVkVEJyBub3QgZGVzY3JpYmVkIGluIGVu
dW0gJ3ZpcnRpb19wY2lkZXZfb3BzJwo+IMKgwqBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3Bj
aWRldi5oOjQxOiB3YXJuaW5nOiBFbnVtIHZhbHVlICdWSVJUSU9fUENJREVWX09QX01NSU9fUkVB
RCcgbm90IGRlc2NyaWJlZCBpbiBlbnVtICd2aXJ0aW9fcGNpZGV2X29wcycKPiDCoMKgaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19wY2lkZXYuaDo0MTogd2FybmluZzogRW51bSB2YWx1ZSAnVklS
VElPX1BDSURFVl9PUF9NTUlPX1dSSVRFJyBub3QgZGVzY3JpYmVkIGluIGVudW0gJ3ZpcnRpb19w
Y2lkZXZfb3BzJwo+IMKgwqBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaWRldi5oOjQxOiB3
YXJuaW5nOiBFeGNlc3MgZW51bSB2YWx1ZSAnVklSVElPX1BDSURFVl9PUF9CQVJfUkVBRCcgZGVz
Y3JpcHRpb24gaW4gJ3ZpcnRpb19wY2lkZXZfb3BzJwo+IMKgwqBpbmNsdWRlL3VhcGkvbGludXgv
dmlydGlvX3BjaWRldi5oOjQxOiB3YXJuaW5nOiBFeGNlc3MgZW51bSB2YWx1ZSAnVklSVElPX1BD
SURFVl9PUF9CQVJfV1JJVEUnIGRlc2NyaXB0aW9uIGluICd2aXJ0aW9fcGNpZGV2X29wcycKPiAK
PiBGV0lXLCBoZXJlJ3MgdGhlIGNvbW1hbmQgSSB1c2VkIHRvIGZpbmQgdGhlc2U6Cj4gCj4gwqDC
oCQgZmluZCBpbmNsdWRlIGRyaXZlcnMvcGNpIC10eXBlIGYgLXBhdGggIipwY2kqLltjaF0iIHwg
eGFyZ3Mgc2NyaXB0cy9rZXJuZWwtZG9jIC1ub25lCgpPb3BzLiBJdCBkaWRuJ3QgZ2V0IHRpZWQg
dG8gYW55IHJlYWwgZG9jIGNyZWF0aW9uIHNvIEkgZ3Vlc3MgdGhlIGJvdHMKZGlkbid0IGZpbmQg
aXQsIGJ1dCBJJ2xsIHNlbmQgYSBwYXRjaCB0byBmaXggaXQsIHRoYW5rcyEKCmpvaGFubmVzCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0g
bWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

