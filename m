Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 15 Feb 2022 13:21:10 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH][next] treewide: Replace zero-length arrays with
 flexible-array members
Message-ID: <20220215192110.GA883653@embeddedor>
References: <20220215174743.GA878920@embeddedor>
 <202202151016.C0471D6E@keescook>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202202151016.C0471D6E@keescook>
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
To: Kees Cook <keescook@chromium.org>
Cc: GR-QLogic-Storage-Upstream@marvell.com, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-crypto@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, sparmaintainer@unisys.com, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-ext4@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, greybus-dev@lists.linaro.org, linux-i3c@lists.infradead.org, linux-rdma@vger.kernel.org, linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org

T24gVHVlLCBGZWIgMTUsIDIwMjIgYXQgMTA6MTc6NDBBTSAtMDgwMCwgS2VlcyBDb29rIHdyb3Rl
Ogo+IE9uIFR1ZSwgRmViIDE1LCAyMDIyIGF0IDExOjQ3OjQzQU0gLTA2MDAsIEd1c3Rhdm8gQS4g
Ui4gU2lsdmEgd3JvdGU6Cj4gPiBUaGVyZSBpcyBhIHJlZ3VsYXIgbmVlZCBpbiB0aGUga2VybmVs
IHRvIHByb3ZpZGUgYSB3YXkgdG8gZGVjbGFyZQo+ID4gaGF2aW5nIGEgZHluYW1pY2FsbHkgc2l6
ZWQgc2V0IG9mIHRyYWlsaW5nIGVsZW1lbnRzIGluIGEgc3RydWN0dXJlLgo+ID4gS2VybmVsIGNv
ZGUgc2hvdWxkIGFsd2F5cyB1c2Ug4oCcZmxleGlibGUgYXJyYXkgbWVtYmVyc+KAnVsxXSBmb3Ig
dGhlc2UKPiA+IGNhc2VzLiBUaGUgb2xkZXIgc3R5bGUgb2Ygb25lLWVsZW1lbnQgb3IgemVyby1s
ZW5ndGggYXJyYXlzIHNob3VsZAo+ID4gbm8gbG9uZ2VyIGJlIHVzZWRbMl0uCj4gPiAKPiA+IFRo
aXMgY29kZSB3YXMgdHJhbnNmb3JtZWQgd2l0aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlOgo+ID4g
KG5leHQtMjAyMjAyMTQkIHNwYXRjaCAtLWpvYnMgJChnZXRjb25mIF9OUFJPQ0VTU09SU19PTkxO
KSAtLXNwLWZpbGUgc2NyaXB0LmNvY2NpIC0taW5jbHVkZS1oZWFkZXJzIC0tZGlyIC4gPiBvdXRw
dXQucGF0Y2gpCj4gPiAKPiA+IEBACj4gPiBpZGVudGlmaWVyIFMsIG1lbWJlciwgYXJyYXk7Cj4g
PiB0eXBlIFQxLCBUMjsKPiA+IEBACj4gPiAKPiA+IHN0cnVjdCBTIHsKPiA+ICAgLi4uCj4gPiAg
IFQxIG1lbWJlcjsKPiA+ICAgVDIgYXJyYXlbCj4gPiAtIDAKPiA+ICAgXTsKPiA+IH07Cj4gCj4g
VGhlc2UgYWxsIGxvb2sgdHJpdmlhbGx5IGNvcnJlY3QgdG8gbWUuIE9ubHkgdHdvIGRpZG4ndCBo
YXZlIHRoZSBlbmQgb2YKPiB0aGUgc3RydWN0IHZpc2libGUgaW4gdGhlIHBhdGNoLCBhbmQgY2hl
Y2tpbmcgdGhvc2Ugc2hvd2VkIHRoZW0gdG8gYmUKPiB0cmFpbGluZyBtZW1iZXJzIGFzIHdlbGws
IHNvOgo+IAo+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4K
CkknbGwgYWRkIHRoaXMgdG8gbXkgLW5leHQgdHJlZS4KClRoYW5rcyEKLS0KR3VzdGF2bwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFp
bGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

