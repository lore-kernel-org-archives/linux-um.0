Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Tue, 15 Feb 2022 10:17:40 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] treewide: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202151016.C0471D6E@keescook>
References: <20220215174743.GA878920@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220215174743.GA878920@embeddedor>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: GR-QLogic-Storage-Upstream@marvell.com, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-crypto@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, sparmaintainer@unisys.com, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-ext4@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, greybus-dev@lists.linaro.org, linux-i3c@lists.infradead.org, linux-rdma@vger.kernel.org, linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

T24gVHVlLCBGZWIgMTUsIDIwMjIgYXQgMTE6NDc6NDNBTSAtMDYwMCwgR3VzdGF2byBBLiBSLiBT
aWx2YSB3cm90ZToKPiBUaGVyZSBpcyBhIHJlZ3VsYXIgbmVlZCBpbiB0aGUga2VybmVsIHRvIHBy
b3ZpZGUgYSB3YXkgdG8gZGVjbGFyZQo+IGhhdmluZyBhIGR5bmFtaWNhbGx5IHNpemVkIHNldCBv
ZiB0cmFpbGluZyBlbGVtZW50cyBpbiBhIHN0cnVjdHVyZS4KPiBLZXJuZWwgY29kZSBzaG91bGQg
YWx3YXlzIHVzZSDigJxmbGV4aWJsZSBhcnJheSBtZW1iZXJz4oCdWzFdIGZvciB0aGVzZQo+IGNh
c2VzLiBUaGUgb2xkZXIgc3R5bGUgb2Ygb25lLWVsZW1lbnQgb3IgemVyby1sZW5ndGggYXJyYXlz
IHNob3VsZAo+IG5vIGxvbmdlciBiZSB1c2VkWzJdLgo+IAo+IFRoaXMgY29kZSB3YXMgdHJhbnNm
b3JtZWQgd2l0aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlOgo+IChuZXh0LTIwMjIwMjE0JCBzcGF0
Y2ggLS1qb2JzICQoZ2V0Y29uZiBfTlBST0NFU1NPUlNfT05MTikgLS1zcC1maWxlIHNjcmlwdC5j
b2NjaSAtLWluY2x1ZGUtaGVhZGVycyAtLWRpciAuID4gb3V0cHV0LnBhdGNoKQo+IAo+IEBACj4g
aWRlbnRpZmllciBTLCBtZW1iZXIsIGFycmF5Owo+IHR5cGUgVDEsIFQyOwo+IEBACj4gCj4gc3Ry
dWN0IFMgewo+ICAgLi4uCj4gICBUMSBtZW1iZXI7Cj4gICBUMiBhcnJheVsKPiAtIDAKPiAgIF07
Cj4gfTsKClRoZXNlIGFsbCBsb29rIHRyaXZpYWxseSBjb3JyZWN0IHRvIG1lLiBPbmx5IHR3byBk
aWRuJ3QgaGF2ZSB0aGUgZW5kIG9mCnRoZSBzdHJ1Y3QgdmlzaWJsZSBpbiB0aGUgcGF0Y2gsIGFu
ZCBjaGVja2luZyB0aG9zZSBzaG93ZWQgdGhlbSB0byBiZQp0cmFpbGluZyBtZW1iZXJzIGFzIHdl
bGwsIHNvOgoKUmV2aWV3ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPgoK
LS0gCktlZXMgQ29vawoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=

