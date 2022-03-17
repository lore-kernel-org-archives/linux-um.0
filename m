Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUhmA-00Eter-En
 for linux-um@lists.infradead.org; Thu, 17 Mar 2022 04:30:16 +0000
Date: Wed, 16 Mar 2022 21:30:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm 2022-03-16-17-42 uploaded (uml sub-x86_64, sched/fair, RCU)
Message-Id: <20220316213011.8cac447e692283a4b5d97f3d@linux-foundation.org>
In-Reply-To: <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
References: <20220317004304.95F89C340E9@smtp.kernel.org>
 <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
Mime-Version: 1.0
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
Cc: broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, linux-um <linux-um@lists.infradead.org>, paulmck@kernel.org, Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>

T24gV2VkLCAxNiBNYXIgMjAyMiAyMToyMToxNiAtMDcwMCBSYW5keSBEdW5sYXAgPHJkdW5sYXBA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cgo+IAo+IAo+IE9uIDMvMTYvMjIgMTc6NDMsIEFuZHJldyBN
b3J0b24gd3JvdGU6Cj4gPiBUaGUgbW0tb2YtdGhlLW1vbWVudCBzbmFwc2hvdCAyMDIyLTAzLTE2
LTE3LTQyIGhhcyBiZWVuIHVwbG9hZGVkIHRvCj4gPiAKPiA+ICAgIGh0dHBzOi8vd3d3Lm96bGFi
cy5vcmcvfmFrcG0vbW1vdG0vCj4gPiAKPiA+IG1tb3RtLXJlYWRtZS50eHQgc2F5cwo+ID4gCj4g
PiBSRUFETUUgZm9yIG1tLW9mLXRoZS1tb21lbnQ6Cj4gPiAKPiA+IGh0dHBzOi8vd3d3Lm96bGFi
cy5vcmcvfmFrcG0vbW1vdG0vCj4gPiAKPiA+IFRoaXMgaXMgYSBzbmFwc2hvdCBvZiBteSAtbW0g
cGF0Y2ggcXVldWUuICBVcGxvYWRlZCBhdCByYW5kb20gaG9wZWZ1bGx5Cj4gPiBtb3JlIHRoYW4g
b25jZSBhIHdlZWsuCj4gPiAKPiA+IFlvdSB3aWxsIG5lZWQgcXVpbHQgdG8gYXBwbHkgdGhlc2Ug
cGF0Y2hlcyB0byB0aGUgbGF0ZXN0IExpbnVzIHJlbGVhc2UgKDUueAo+ID4gb3IgNS54LXJjWSku
ICBUaGUgc2VyaWVzIGZpbGUgaXMgaW4gYnJva2VuLW91dC50YXIuZ3ogYW5kIGlzIGR1cGxpY2F0
ZWQgaW4KPiA+IGh0dHBzOi8vb3psYWJzLm9yZy9+YWtwbS9tbW90bS9zZXJpZXMKPiAKPiAKPiBV
TUwgZm9yIHg4Nl82NCwgZGVmY29uZmlnOgo+IAo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2Fy
Y2gveDg2L2luY2x1ZGUvZ2VuZXJhdGVkL2FzbS9yd29uY2UuaDoxOjAsCj4gICAgICAgICAgICAg
ICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaDoyNDgsCj4gICAgICAgICAgICAg
ICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgva2VybmVsLmg6MjAsCj4gICAgICAgICAgICAgICAg
ICBmcm9tIC4uL2luY2x1ZGUvbGludXgvY3B1bWFzay5oOjEwLAo+ICAgICAgICAgICAgICAgICAg
ZnJvbSAuLi9pbmNsdWRlL2xpbnV4L2VuZXJneV9tb2RlbC5oOjQsCj4gICAgICAgICAgICAgICAg
ICBmcm9tIC4uL2tlcm5lbC9zY2hlZC9mYWlyLmM6MjM6Cj4gLi4vaW5jbHVkZS9saW51eC9wc2ku
aDogSW4gZnVuY3Rpb24g4oCYY2dyb3VwX21vdmVfdGFza+KAmToKPiAuLi9pbmNsdWRlL2xpbnV4
L3JjdXBkYXRlLmg6NDE0OjM2OiBlcnJvcjogZGVyZWZlcmVuY2luZyBwb2ludGVyIHRvIGluY29t
cGxldGUgdHlwZSDigJhzdHJ1Y3QgY3NzX3NldOKAmQo+ICAjZGVmaW5lIFJDVV9JTklUSUFMSVpF
Uih2KSAodHlwZW9mKCoodikpIF9fZm9yY2UgX19yY3UgKikodikKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefn5+CgpXb3JrcyBGb3IgTWUuICBJIHRyaWVkIGBtYWtlIHg4
Nl82NF9kZWZjb25maWcnIGFuZCBgbWFrZSBpMzg2X2RlZmNvbmZpZycgdG9vLgoKQ2FuIHlvdSBw
bGVhc2Ugc2hhcmUgdGhhdCAuY29uZmlnLCBvciBkZWJ1ZyBhIGJpdD8KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K

