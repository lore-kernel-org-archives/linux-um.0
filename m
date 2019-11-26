Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZXmu-0003tq-U6
 for linux-um@lists.infradead.org; Tue, 26 Nov 2019 10:09:42 +0000
Date: Tue, 26 Nov 2019 11:09:34 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <243342257.98153.1574762974057.JavaMail.zimbra@nod.at>
In-Reply-To: <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net>
References: <cover.1573179553.git.thehajime@gmail.com>
 <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
 <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
 <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
 <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at>
 <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>, tavi purdila <tavi.purdila@gmail.com>, linux-um <linux-um@lists.infradead.org>, retrage01 <retrage01@gmail.com>, liuyuan <liuyuan@google.com>, pscollins <pscollins@google.com>, linux-kernel-library <linux-kernel-library@freelists.org>, sigmaepsilon92 <sigmaepsilon92@gmail.com>, Hajime Tazaki <thehajime@gmail.com>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+PiBNeSBwb2ludCBpcyB0aGF0IFVNTCBh
bmQgTEtMIHNob3VsZCB0cnkgdG8gZG8gdXNlIHRoZSBzYW1lIGNvbmNlcHQvY29kZQo+PiByZWdh
cmRpbmcgdmlydGlvLiBBdCB0aGUgZW5kIG9mIGRheSBib3RoIHVzZSB2aXJ0dWFsIGRldmljZXMg
d2hpY2ggdXNlCj4+IGZhY2lsaXRpZXMgZnJvbSB0aGUgaG9zdC4KPj4gSWYgdGhpcyBpcyByZWFs
bHkgbm90IHBvc3NpYmxlIGl0IG5lZWRzIGEgZ29vZCBleHBsYW5hdGlvbi4KPiAKPiBJIHRoaW5r
IGl0IGlzbid0IHBvc3NpYmxlLCB1bmxlc3MgeW91IHVzZSB2aG9zdC11c2VyIG92ZXIgYSB1bml4
IGRvbWFpbgo+IHNvY2tldCBpbnRlcm5hbGx5IHRvIHRhbGsgYmV0d2VlbiB0aGUga2VybmVsICh2
aXJ0aW9fdW1sKSBhbmQgaHlwZXJ2aXNvcgo+IChkZXZpY2UpIGNvbXBvbmVudHMuCj4gCj4gSW4g
dmlydGlvX3VtbCwgdGhlIGRldmljZSBpbXBsZW1lbnRhdGlvbiBpcyBhc3N1bWVkIHRvIGJlIGEg
c2VwYXJhdGUKPiBwcm9jZXNzIHdpdGggYSB2aG9zdC11c2VyIGNvbm5lY3Rpb24uIEhlcmUgaW4g
TEtMLCB0aGUgdmlydGlvIGRldmljZSBpcwo+IHBhcnQgb2YgdGhlICJoeXBlcnZpc29yIiwgaS5l
LiBpbiB0aGUgc2FtZSBwcm9jZXNzLgoKRXhhY3RseSwgY3VycmVudGx5IFVNTCBhbmQgTEtMIHNv
bHZlIHNhbWUgdGhpbmdzIGRpZmZlcmVudGx5LCBidXQgZG8gd2UgbmVlZCB0bz8KCklmIHdlIGZh
aWwgdG8gYWdyZWUgb24gc3VjaCBhIGhpZ2ggbGV2ZWwgSSBtaWdodCBtYWtlIHNlbnNlIHRvIHJl
ZXZhbHVhdGUgdG8gb3B0aW9uCm9mIG5vdCBtZXJnaW5nIFVNTCBhbmQgTEtMIGF0IGFsbC4KQnV0
IHRoaXMgaXMgYmV5b25kIG15IGRlY2lzaW9uYWwgcG93ZXIgYW5kIHNvbWV0aGluZyBJJ2QgbGlr
ZSB0byBhdm9pZC4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==

