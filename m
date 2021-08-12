Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH -next] trap: Cleanup trap_init()
References: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
From: Vineet Gupta <vgupta@kernel.org>
Message-ID: <b49eed44-0837-906c-8779-4fffb5609653@kernel.org>
Date: Thu, 12 Aug 2021 11:57:49 -0700
MIME-Version: 1.0
In-Reply-To: <20210812123602.76356-1-wangkefeng.wang@huawei.com>
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
To: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <palmerdabbelt@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>

T24gOC8xMi8yMSA1OjM2IEFNLCBLZWZlbmcgV2FuZyB3cm90ZToKPiBUaGVyZSBhcmUgc29tZSBl
bXB0eSB0cmFwX2luaXQoKSBpbiBkaWZmZXJlbnQgQVJDSHMsIGludHJvZHVjZQo+IGEgbmV3IHdl
YWsgdHJhcF9pbml0KCkgZnVuY3Rpb24gdG8gY2xlYW51cCB0aGVtLgo+Cj4gQ2M6IFZpbmVldCBH
dXB0YTx2Z3VwdGFAa2VybmVsLm9yZz4KPiBDYzogUnVzc2VsbCBLaW5nPGxpbnV4QGFybWxpbnV4
Lm9yZy51az4KPiBDYzogWW9zaGlub3JpIFNhdG88eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+
Cj4gQ2M6IExleSBGb29uIFRhbjxsZXkuZm9vbi50YW5AaW50ZWwuY29tPgo+IENjOiBKb25hcyBC
b25uPGpvbmFzQHNvdXRocG9sZS5zZT4KPiBDYzogU3RlZmFuIEtyaXN0aWFuc3NvbjxzdGVmYW4u
a3Jpc3RpYW5zc29uQHNhdW5hbGFodGkuZmk+Cj4gQ2M6IFN0YWZmb3JkIEhvcm5lPHNob3JuZUBn
bWFpbC5jb20+Cj4gQ2M6IEphbWVzIEUuSi4gQm90dG9tbGV5PEphbWVzLkJvdHRvbWxleUBIYW5z
ZW5QYXJ0bmVyc2hpcC5jb20+Cj4gQ2M6IEhlbGdlIERlbGxlcjxkZWxsZXJAZ214LmRlPgo+IENj
OiBNaWNoYWVsIEVsbGVybWFuPG1wZUBlbGxlcm1hbi5pZC5hdT4KPiBDYzogQmVuamFtaW4gSGVy
cmVuc2NobWlkdDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+Cj4gQ2M6IFBhdWwgTWFja2VycmFz
PHBhdWx1c0BzYW1iYS5vcmc+Cj4gQ2M6IFBhdWwgV2FsbXNsZXk8cGFsbWVyZGFiYmVsdEBnb29n
bGUuY29tPgo+IENjOiBKZWZmIERpa2U8amRpa2VAYWRkdG9pdC5jb20+Cj4gQ2M6IFJpY2hhcmQg
V2VpbmJlcmdlcjxyaWNoYXJkQG5vZC5hdD4KPiBDYzogQW50b24gSXZhbm92PGFudG9uLml2YW5v
dkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQ2M6IEFuZHJldyBNb3J0b248YWtwbUBsaW51eC1mb3Vu
ZGF0aW9uLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBLZWZlbmcgV2FuZzx3YW5na2VmZW5nLndhbmdA
aHVhd2VpLmNvbT4KPiAtLS0KPiAgIGFyY2gvYXJjL2tlcm5lbC90cmFwcy5jICAgICAgfCA1IC0t
LS0tCgpBY2tlZC1ieTogVmluZWV0IEd1cHRhIDx2Z3VwdEBrZXJuZWwub3JnPsKgICNhcmNoL2Fy
YwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

