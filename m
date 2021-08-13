Return-Path: <openrisc-bounces@lists.librecores.org>
From: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
References: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
Date: Fri, 13 Aug 2021 12:27:58 +1000
Message-ID: <87czqim635.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Subject: Re: [OpenRISC] [PATCH -next] trap: Cleanup trap_init()
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Cc: Jonas Bonn <jonas@southpole.se>, Kefeng Wang <wangkefeng.wang@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Helge Deller <deller@gmx.de>, Paul Walmsley <palmerdabbelt@google.com>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Richard Weinberger <richard@nod.at>, Paul Mackerras <paulus@samba.org>, Vineet Gupta <vgupta@kernel.org>, Jeff Dike <jdike@addtoit.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
List-ID: <linux-um.lists.infradead.org>

S2VmZW5nIFdhbmcgPHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPiB3cml0ZXM6Cj4gVGhlcmUg
YXJlIHNvbWUgZW1wdHkgdHJhcF9pbml0KCkgaW4gZGlmZmVyZW50IEFSQ0hzLCBpbnRyb2R1Y2UK
PiBhIG5ldyB3ZWFrIHRyYXBfaW5pdCgpIGZ1bmN0aW9uIHRvIGNsZWFudXAgdGhlbS4KPgo+IENj
OiBWaW5lZXQgR3VwdGEgPHZndXB0YUBrZXJuZWwub3JnPgo+IENjOiBSdXNzZWxsIEtpbmcgPGxp
bnV4QGFybWxpbnV4Lm9yZy51az4KPiBDYzogWW9zaGlub3JpIFNhdG8gPHlzYXRvQHVzZXJzLnNv
dXJjZWZvcmdlLmpwPgo+IENjOiBMZXkgRm9vbiBUYW4gPGxleS5mb29uLnRhbkBpbnRlbC5jb20+
Cj4gQ2M6IEpvbmFzIEJvbm4gPGpvbmFzQHNvdXRocG9sZS5zZT4KPiBDYzogU3RlZmFuIEtyaXN0
aWFuc3NvbiA8c3RlZmFuLmtyaXN0aWFuc3NvbkBzYXVuYWxhaHRpLmZpPgo+IENjOiBTdGFmZm9y
ZCBIb3JuZSA8c2hvcm5lQGdtYWlsLmNvbT4KPiBDYzogSmFtZXMgRS5KLiBCb3R0b21sZXkgPEph
bWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+Cj4gQ2M6IEhlbGdlIERlbGxlciA8
ZGVsbGVyQGdteC5kZT4KPiBDYzogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1
Pgo+IENjOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+
Cj4gQ2M6IFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2FtYmEub3JnPgo+IENjOiBQYXVsIFdhbG1z
bGV5IDxwYWxtZXJkYWJiZWx0QGdvb2dsZS5jb20+Cj4gQ2M6IEplZmYgRGlrZSA8amRpa2VAYWRk
dG9pdC5jb20+Cj4gQ2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+Cj4gQ2M6
IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBDYzogQW5k
cmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBL
ZWZlbmcgV2FuZyA8d2FuZ2tlZmVuZy53YW5nQGh1YXdlaS5jb20+Cj4gLS0tCj4gIGFyY2gvYXJj
L2tlcm5lbC90cmFwcy5jICAgICAgfCA1IC0tLS0tCj4gIGFyY2gvYXJtL2tlcm5lbC90cmFwcy5j
ICAgICAgfCA1IC0tLS0tCj4gIGFyY2gvaDgzMDAva2VybmVsL3RyYXBzLmMgICAgfCA0IC0tLS0K
PiAgYXJjaC9oZXhhZ29uL2tlcm5lbC90cmFwcy5jICB8IDQgLS0tLQo+ICBhcmNoL25kczMyL2tl
cm5lbC90cmFwcy5jICAgIHwgNSAtLS0tLQo+ICBhcmNoL25pb3MyL2tlcm5lbC90cmFwcy5jICAg
IHwgNSAtLS0tLQo+ICBhcmNoL29wZW5yaXNjL2tlcm5lbC90cmFwcy5jIHwgNSAtLS0tLQo+ICBh
cmNoL3BhcmlzYy9rZXJuZWwvdHJhcHMuYyAgIHwgNCAtLS0tCj4gIGFyY2gvcG93ZXJwYy9rZXJu
ZWwvdHJhcHMuYyAgfCA1IC0tLS0tCgpBY2tlZC1ieTogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVs
bGVybWFuLmlkLmF1PiAocG93ZXJwYykKCmNoZWVycwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpPcGVuUklTQyBtYWlsaW5nIGxpc3QKT3BlblJJU0NAbGlz
dHMubGlicmVjb3Jlcy5vcmcKaHR0cHM6Ly9saXN0cy5saWJyZWNvcmVzLm9yZy9saXN0aW5mby9v
cGVucmlzYwo=

