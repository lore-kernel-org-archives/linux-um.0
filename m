Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 15 Feb 2022 21:19:29 +0200
From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH][next] treewide: Replace zero-length arrays with
 flexible-array members
Message-ID: <Ygv8wY75hNqS7zO6@unreal>
References: <20220215174743.GA878920@embeddedor>
 <202202151016.C0471D6E@keescook>
 <20220215192110.GA883653@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220215192110.GA883653@embeddedor>
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
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, GR-QLogic-Storage-Upstream@marvell.com, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-crypto@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, sparmaintainer@unisys.com, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-ext4@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, greybus-dev@lists.linaro.org, linux-i3c@lists.infradead.org, linux-rdma@vger.kernel.org, linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org

T24gVHVlLCBGZWIgMTUsIDIwMjIgYXQgMDE6MjE6MTBQTSAtMDYwMCwgR3VzdGF2byBBLiBSLiBT
aWx2YSB3cm90ZToKPiBPbiBUdWUsIEZlYiAxNSwgMjAyMiBhdCAxMDoxNzo0MEFNIC0wODAwLCBL
ZWVzIENvb2sgd3JvdGU6Cj4gPiBPbiBUdWUsIEZlYiAxNSwgMjAyMiBhdCAxMTo0Nzo0M0FNIC0w
NjAwLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOgo+ID4gPiBUaGVyZSBpcyBhIHJlZ3VsYXIg
bmVlZCBpbiB0aGUga2VybmVsIHRvIHByb3ZpZGUgYSB3YXkgdG8gZGVjbGFyZQo+ID4gPiBoYXZp
bmcgYSBkeW5hbWljYWxseSBzaXplZCBzZXQgb2YgdHJhaWxpbmcgZWxlbWVudHMgaW4gYSBzdHJ1
Y3R1cmUuCj4gPiA+IEtlcm5lbCBjb2RlIHNob3VsZCBhbHdheXMgdXNlIOKAnGZsZXhpYmxlIGFy
cmF5IG1lbWJlcnPigJ1bMV0gZm9yIHRoZXNlCj4gPiA+IGNhc2VzLiBUaGUgb2xkZXIgc3R5bGUg
b2Ygb25lLWVsZW1lbnQgb3IgemVyby1sZW5ndGggYXJyYXlzIHNob3VsZAo+ID4gPiBubyBsb25n
ZXIgYmUgdXNlZFsyXS4KPiA+ID4gCj4gPiA+IFRoaXMgY29kZSB3YXMgdHJhbnNmb3JtZWQgd2l0
aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlOgo+ID4gPiAobmV4dC0yMDIyMDIxNCQgc3BhdGNoIC0t
am9icyAkKGdldGNvbmYgX05QUk9DRVNTT1JTX09OTE4pIC0tc3AtZmlsZSBzY3JpcHQuY29jY2kg
LS1pbmNsdWRlLWhlYWRlcnMgLS1kaXIgLiA+IG91dHB1dC5wYXRjaCkKPiA+ID4gCj4gPiA+IEBA
Cj4gPiA+IGlkZW50aWZpZXIgUywgbWVtYmVyLCBhcnJheTsKPiA+ID4gdHlwZSBUMSwgVDI7Cj4g
PiA+IEBACj4gPiA+IAo+ID4gPiBzdHJ1Y3QgUyB7Cj4gPiA+ICAgLi4uCj4gPiA+ICAgVDEgbWVt
YmVyOwo+ID4gPiAgIFQyIGFycmF5Wwo+ID4gPiAtIDAKPiA+ID4gICBdOwo+ID4gPiB9Owo+ID4g
Cj4gPiBUaGVzZSBhbGwgbG9vayB0cml2aWFsbHkgY29ycmVjdCB0byBtZS4gT25seSB0d28gZGlk
bid0IGhhdmUgdGhlIGVuZCBvZgo+ID4gdGhlIHN0cnVjdCB2aXNpYmxlIGluIHRoZSBwYXRjaCwg
YW5kIGNoZWNraW5nIHRob3NlIHNob3dlZCB0aGVtIHRvIGJlCj4gPiB0cmFpbGluZyBtZW1iZXJz
IGFzIHdlbGwsIHNvOgo+ID4gCj4gPiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0Bj
aHJvbWl1bS5vcmc+Cj4gCj4gSSdsbCBhZGQgdGhpcyB0byBteSAtbmV4dCB0cmVlLgoKSSB3b3Vs
ZCBsaWtlIHRvIGFzayB5b3UgdG8gc2VuZCBtbHg1IHBhdGNoIHNlcGFyYXRlbHkgdG8gbmV0ZGV2
LiBXZSBhcmUgd29ya2luZwp0byBkZWxldGUgdGhhdCBmaWxlIGNvbXBsZXRlbHkgYW5kIHByZWZl
ciB0byBhdm9pZCBmcm9tIHVubmVjZXNzYXJ5IG1lcmdlIGNvbmZsaWN0cy4KClRoYW5rcwoKPiAK
PiBUaGFua3MhCj4gLS0KPiBHdXN0YXZvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==

