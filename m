Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 2 Mar 2022 13:45:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
In-Reply-To: <8e799cadb1104714f998fe74e40b3cb052c9c1ed.camel@aosc.io>
Message-ID: <alpine.DEB.2.21.2203021337430.58475@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
 <8e799cadb1104714f998fe74e40b3cb052c9c1ed.camel@aosc.io>
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
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

T24gV2VkLCAyIE1hciAyMDIyLCBJY2Vub3d5IFpoZW5nIHdyb3RlOgoKPiA+IFRoZSBvbmx5IFBD
SSBwbGF0Zm9ybXMgdGhhdCBhY3R1YWxseSBjYW4ndCBtYWtlIHVzZSBvZiBQQy1zdHlsZQo+ID4g
cGFyYWxsZWwgCj4gPiBwb3J0IGhhcmR3YXJlIGFyZSB0aG9zZSBuZXdlciBQQ0llIHN5c3RlbXMg
dGhhdCBoYXZlIG5vIHN1cHBvcnQgZm9yCj4gPiBJL08gCj4gPiBjeWNsZXMgaW4gdGhlIGhvc3Qg
YnJpZGdlLCByZXF1aXJlZCBieSBzdWNoIHBhcmFsbGVsIHBvcnRzLsKgIE5vdGFibHksCj4gPiB0
aGlzIGluY2x1ZGVzIHRoZSBzMzkwIGFyY2gsIHdoaWNoIGhhcyBwb3J0IEkvTyBhY2Nlc3NvcnMg
dGhhdCBjYXVzZSAKPiA+IGNvbXBpbGF0aW9uIHdhcm5pbmdzIChwcm9tb3RlZCB0byBlcnJvcnMg
d2l0aCBgLVdlcnJvcicpLCBhbmQgdGhlcmUKPiA+IGFyZSAKPiA+IG90aGVyIGNhc2VzIHN1Y2gg
YXMgdGhlIFBPV0VSOSBQSEI0IGRldmljZSwgdGhvdWdoIHRoaXMgb25lIGhhcwo+ID4gdmFyaWFi
bGUgCj4gPiBwb3J0IEkvTyBhY2Nlc3NvcnMgdGhhdCBkZXBlbmQgb24gdGhlIHBhcnRpY3VsYXIg
c3lzdGVtLsKgIEFsc28gaXQgaXMKPiA+IG5vdCAKPiA+IGNsZWFyIHdoZXRoZXIgdGhlIHNlcmlh
bCBwb3J0IHNpZGUgb2YgZGV2aWNlcyBlbmFibGVkIGJ5Cj4gPiBQQVJQT1JUX1NFUklBTCAKPiA+
IHVzZXMgcG9ydCBJL08gb3IgTU1JTy7CoCBGaW5hbGx5IFN1cGVyIEkvTyBzb2x1dGlvbnMgYXJl
IGFsd2F5cyBlaXRoZXIKPiA+IElTQSBvciBwbGF0Zm9ybSBkZXZpY2VzLgo+IAo+IEp1c3Qgc3Bv
dCB0aGlzIHBhdGNoIGluIGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdCwgSSB0aGluayB0aGVyZSdz
IGEKPiBwZW5kaW5nIHBhdGNoc2V0IHRoYXQgdHJpZXMgdG8gYWRkIGEgSEFTX0lPUE9SVCBLY29u
ZmlnIG9wdGlvbiwgd2hpY2gKPiBjYW4gYmUgdXNlZCBpbiB0aGlzIHNpdHVhdGlvbi4KCiBUaGFu
a3MgZm9yIHlvdXIgaW5wdXQuCgogVGhhdCBoYXMgYmVlbiBhY3R1YWxseSBkaXNjdXNzZWQgYWxy
ZWFkeSB3aXRoIGEgY29uY2x1c2lvbiB0aGF0IG1vcmUgd29yayAKaXMgcmVxdWlyZWQgdG8gaGF2
ZSBIQVNfSU9QT1JUIHN1cHBvcnRlZCwgc2VlIHRoZSB0aHJlYWQgc3RhcnRpbmcgZnJvbTogCjxo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBTXVITWRXLXV0Y0Z6Q1pUZ3FPTmp4cz1VNjYy
bkYwPWFCUXU3Wmk3RkJRb3V3aUEzZ0BtYWlsLmdtYWlsLmNvbS8+LiAKKHRoZXJlJ3MgYSByZWZl
cmVuY2UgdG8gdGhlIEhBU19JT1BPUlQgcGF0Y2hzZXQgdGhlcmUgYXMgd2VsbCkuICBPbmNlIHRo
YXQgCmhhcyBiZWVuIHNvcnRlZCBjb25maWd1cmF0aW9uIGNvbmRpdGlvbnMgZm9yIHRoZSBwYXJw
b3J0IGRyaXZlciBjYW4gYmUgCnVwZGF0ZWQgYWNjb3JkaW5nbHkuICBGb3IgdGhlIHRpbWUgYmVp
bmcgdGhlICFTMzkwIHF1YWxpZmljYXRpb24gc2hvdWxkIApkby4KCiAgTWFjaWVqCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5n
IGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

