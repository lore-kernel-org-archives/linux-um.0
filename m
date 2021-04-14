Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 14 Apr 2021 17:38:32 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH] init: consolidate trap_init()
Message-ID: <20210414173832.52bc3ddb@xhacker.debian>
In-Reply-To: <20210414172757.3ebfaa4c@xhacker.debian>
References: <20210414165808.458a3d11@xhacker.debian>
 <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
 <20210414172757.3ebfaa4c@xhacker.debian>
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-parisc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, openrisc@lists.librecores.org, Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

T24gV2VkLCAxNCBBcHIgMjAyMSAxNzoyNzo1NyArMDgwMApKaXNoZW5nIFpoYW5nIDxKaXNoZW5n
LlpoYW5nQHN5bmFwdGljcy5jb20+IHdyb3RlOgoKPiBDQVVUSU9OOiBFbWFpbCBvcmlnaW5hdGVk
IGV4dGVybmFsbHksIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4K
PiAKPiAKPiBPbiBXZWQsIDE0IEFwciAyMDIxIDExOjEwOjQyICswMjAwCj4gQ2hyaXN0b3BoZSBM
ZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToKPiAKPiA+Cj4gPiBMZSAx
NC8wNC8yMDIxIMOgIDEwOjU4LCBKaXNoZW5nIFpoYW5nIGEgw6ljcml0IDogIAo+ID4gPiBNYW55
IGFyY2hpdGVjdHVyZXMgaW1wbGVtZW50IHRoZSB0cmFwX2luaXQoKSBhcyBOT1AsIHNpbmNlIHRo
ZXJlIGlzCj4gPiA+IG5vIHN1Y2ggZGVmYXVsdCBmb3IgdHJhcF9pbml0KCksIHRoaXMgZW1wdHkg
c3R1YiBpcyBkdXBsaWNhdGVkIGFtb25nCj4gPiA+IHRoZXNlIGFyY2hpdGVjdHVyZXMuIFByb3Zp
ZGUgYSBnZW5lcmljIGJ1dCB3ZWFrIE5PUCBpbXBsZW1lbnRhdGlvbgo+ID4gPiB0byBkcm9wIHRo
ZSBlbXB0eSBzdHVicyBvZiB0cmFwX2luaXQoKSBpbiB0aGVzZSBhcmNoaXRlY3R1cmVzLiAgCj4g
Pgo+ID4gWW91IGRlZmluZSB0aGUgd2VhayBmdW5jdGlvbiBpbiB0aGUgX19pbml0IHNlY3Rpb24u
Cj4gPgo+ID4gTW9zdCBidXQgbm90IGFsbCBhcmNoaXRlY3R1cmVzIGhhZCBpdCBpbiBfX2luaXQg
c2VjdGlvbi4KPiA+Cj4gPiBBbmQgdGhlIHJlbWFpbmluZyBvbmVzIG1heSBub3QgYmUgZGVmaW5l
ZCBpbiBfX2luaXQgc2VjdGlvbi4gRm9yIGluc3RhbmNlIGxvb2sgYXQgdGhlIG9uZSBpbiBhbHBo
YQo+ID4gYXJjaGl0ZWN0dXJlLgo+ID4KPiA+IEhhdmUgeW91IGNoZWNrZWQgdGhhdCBpdCBpcyBu
b3QgYSBwcm9ibGVtID8gSXQgd291bGQgYmUgZ29vZCB0byBzYXkgc29tZXRoaW5nIGFib3V0IGl0
IGluIHRoZSBjb21taXQKPiA+IGRlc2NyaXB0aW9uLiAgCj4gCj4gRm9yIHRob3NlIG5vbi1ub3Ag
cGxhdGZvcm1zLCBJIGNhbiBvbmx5IHRlc3QgeDg2L2FybTY0LywgYnV0IGJvdGggaGFzCj4gX19p
bml0IG1hcmsuIEknbSBub3Qgc3VyZSB3aGV0aGVyIHRoaXMgaXMgYSBwcm9ibGVtIGZvciBhbHBo
YSBldGMuIE1heWJlCj4gSSBjYW4gY2hlY2sgd2hpY2ggc2VjdGlvbiB0aGUgdHJhcF9pbml0KCkg
c2l0cy4gT3IgdG8gYXZvaWQgYW55IHBvc3NpYmxlCj4gcmVncmVzc2lvbiwgSSBjYW4gYWRkIF9f
aW5pdCBtYXJrIHRvIHRob3NlIHJlbWFpbmluZyBvbmVzIHdpdGhvdXQgaXQgaW4KPiBwcmVwYXJh
dGlvbiBwYXRjaGVzLgo+IAoKSGksCgpJIGZvdW5kIG9ubHkgdGhyZWUgcGxhdGZvcm1zIGRvbid0
IGhhdmUgdGhlIF9faW5pdCBtYXJrZXIgZm9yIHRyYXBfaW5pdCgpLCBJCndpbGwgYWRkIHRoZSBf
X2luaXQgbWFya2VyIGluIHRocmVlIHByZXBhcmF0aW9uIHBhdGNoZXMgaW4gbmV3IHZlcnNpb24u
Cgp0aGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

