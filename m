Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 17 Sep 2020 22:46:52 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <482280458.101023.1600375612958.JavaMail.zimbra@nod.at>
In-Reply-To: <20200917151050.5363-12-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-12-willy@infradead.org>
Subject: Re: [PATCH 11/13] ubifs: Tell the VFS that readpage was synchronous
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
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, v9fs-developer@lists.sourceforge.net, ceph-devel <ceph-devel@vger.kernel.org>, linux-afs@lists.infradead.org

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIk1hdHRoZXcgV2lsY294IiA8
d2lsbHlAaW5mcmFkZWFkLm9yZz4KPiBBbjogImxpbnV4LWZzZGV2ZWwiIDxsaW51eC1mc2RldmVs
QHZnZXIua2VybmVsLm9yZz4KPiBDQzogIk1hdHRoZXcgV2lsY294IiA8d2lsbHlAaW5mcmFkZWFk
Lm9yZz4sICJsaW51eC1tbSIgPGxpbnV4LW1tQGt2YWNrLm9yZz4sIHY5ZnMtZGV2ZWxvcGVyQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldCwKPiAibGludXgta2VybmVsIiA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz4sIGxpbnV4LWFmc0BsaXN0cy5pbmZyYWRlYWQub3JnLCAiY2VwaC1kZXZlbCIK
PiA8Y2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc+LCBsaW51eC1jaWZzQHZnZXIua2VybmVsLm9y
ZywgZWNyeXB0ZnNAdmdlci5rZXJuZWwub3JnLCAibGludXgtdW0iCj4gPGxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmc+LCAibGludXgtbXRkIiA8bGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5v
cmc+LCAicmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0Pgo+IEdlc2VuZGV0OiBEb25uZXJzdGFnLCAx
Ny4gU2VwdGVtYmVyIDIwMjAgMTc6MTA6NDgKPiBCZXRyZWZmOiBbUEFUQ0ggMTEvMTNdIHViaWZz
OiBUZWxsIHRoZSBWRlMgdGhhdCByZWFkcGFnZSB3YXMgc3luY2hyb25vdXMKCj4gVGhlIHViaWZz
IHJlYWRwYWdlIGltcGxlbWVudGF0aW9uIHdhcyBhbHJlYWR5IHN5bmNocm9ub3VzLCBzbyB1c2UK
PiBBT1BfVVBEQVRFRF9QQUdFIHRvIGF2b2lkIGN5Y2xpbmcgdGhlIHBhZ2UgbG9jay4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9y
Zz4KPiAtLS0KPiBmcy91Ymlmcy9maWxlLmMgfCAxNiArKysrKysrKysrLS0tLS0tCj4gMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpGb3IgdWJpZnMsIGpm
ZnMyIGFuZCBob3N0ZnM6CgpBY2tlZC1ieTogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5v
ZC5hdD4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==

