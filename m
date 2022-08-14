Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
 list
Date: Sun, 14 Aug 2022 05:25:30 +0000
Message-ID: <91f708ed-f456-dc83-281e-fc18a0b4b981@nvidia.com>
References: <20220813220034.806698-1-ira.weiny@intel.com>
In-Reply-To: <20220813220034.806698-1-ira.weiny@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5261E63C04B5044FBDC2CBFA7DC85685@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: "ira.weiny@intel.com" <ira.weiny@intel.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "Fabio M . De Francesco" <fmdefrancesco@gmail.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-um.lists.infradead.org>

T24gOC8xMy8yMiAxNTowMCwgaXJhLndlaW55QGludGVsLmNvbSB3cm90ZToNCj4gRnJvbTogSXJh
IFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiANCj4ga21hcCgpIGFuZCBrbWFwX2F0b21p
YygpIGFyZSBiZWluZyBkZXByZWNhdGVkIGluIGZhdm9yIG9mDQo+IGttYXBfbG9jYWxfcGFnZSgp
Lg0KPiANCj4gVGhlcmUgYXJlIHR3byBtYWluIHByb2JsZW1zIHdpdGgga21hcCgpOiAoMSkgSXQg
Y29tZXMgd2l0aCBhbiBvdmVyaGVhZA0KPiBhcyBtYXBwaW5nIHNwYWNlIGlzIHJlc3RyaWN0ZWQg
YW5kIHByb3RlY3RlZCBieSBhIGdsb2JhbCBsb2NrIGZvcg0KPiBzeW5jaHJvbml6YXRpb24gYW5k
ICgyKSBpdCBhbHNvIHJlcXVpcmVzIGdsb2JhbCBUTEIgaW52YWxpZGF0aW9uIHdoZW4NCj4gdGhl
IGttYXDigJlzIHBvb2wgd3JhcHMgYW5kIGl0IG1pZ2h0IGJsb2NrIHdoZW4gdGhlIG1hcHBpbmcg
c3BhY2UgaXMgZnVsbHkNCj4gdXRpbGl6ZWQgdW50aWwgYSBzbG90IGJlY29tZXMgYXZhaWxhYmxl
Lg0KPiANCj4ga21hcF9sb2NhbF9wYWdlKCkgaXMgc2FmZSBmcm9tIGFueSBjb250ZXh0IGFuZCBp
cyB0aGVyZWZvcmUgcmVkdW5kYW50DQo+IHdpdGgga21hcF9hdG9taWMoKSB3aXRoIHRoZSBleGNl
cHRpb24gb2YgYW55IHBhZ2VmYXVsdCBvciBwcmVlbXB0aW9uDQo+IGRpc2FibGUgcmVxdWlyZW1l
bnRzLiAgSG93ZXZlciwgdXNpbmcga21hcF9hdG9taWMoKSBmb3IgdGhlc2Ugc2lkZQ0KPiBlZmZl
Y3RzIG1ha2VzIHRoZSBjb2RlIGxlc3MgY2xlYXIuICBTbyBhbnkgcmVxdWlyZW1lbnQgZm9yIHBh
Z2VmYXVsdCBvcg0KPiBwcmVlbXB0aW9uIGRpc2FibGUgc2hvdWxkIGJlIG1hZGUgZXhwbGljaXRs
eS4NCj4gDQo+IFdpdGgga21hcF9sb2NhbF9wYWdlKCkgdGhlIG1hcHBpbmdzIGFyZSBwZXIgdGhy
ZWFkLCBDUFUgbG9jYWwsIGNhbiB0YWtlDQo+IHBhZ2UgZmF1bHRzLCBhbmQgY2FuIGJlIGNhbGxl
ZCBmcm9tIGFueSBjb250ZXh0IChpbmNsdWRpbmcgaW50ZXJydXB0cykuDQo+IEl0IGlzIGZhc3Rl
ciB0aGFuIGttYXAoKSBpbiBrZXJuZWxzIHdpdGggSElHSE1FTSBlbmFibGVkLiBGdXJ0aGVybW9y
ZSwNCj4gdGhlIHRhc2tzIGNhbiBiZSBwcmVlbXB0ZWQgYW5kLCB3aGVuIHRoZXkgYXJlIHNjaGVk
dWxlZCB0byBydW4gYWdhaW4sDQo+IHRoZSBrZXJuZWwgdmlydHVhbCBhZGRyZXNzZXMgYXJlIHJl
c3RvcmVkLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRy
b25peC5kZT4NCj4gU3VnZ2VzdGVkLWJ5OiBGYWJpbyBNLiBEZSBGcmFuY2VzY28gPGZtZGVmcmFu
Y2VzY29AZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlueUBp
bnRlbC5jb20+DQo+IA0KPiAtLS0NCj4gU3VnZ2VzdGVkIGJ5IGNyZWRpdHMuDQo+IAlUaG9tYXM6
IElkZWEgdG8ga2VlcCBmcm9tIGdyb3dpbmcgbW9yZSBrbWFwL2ttYXBfYXRvbWljIGNhbGxzLg0K
PiAJRmFiaW86IFN0b2xlIHNvbWUgb2YgaGlzIGJvaWxlciBwbGF0ZSBjb21taXQgbWVzc2FnZS4N
Cj4gDQo+IE5vdGVzIG9uIHRyZWUtd2lkZSBjb252ZXJzaW9uczoNCj4gDQo+IEkndmUgY2MnZWQg
bWFpbGluZyBsaXN0cyBmb3Igc3Vic3lzdGVtcyB3aGljaCBjdXJyZW50bHkgY29udGFpbnMgZWl0
aGVyIGttYXAoKQ0KPiBvciBrbWFwX2F0b21pYygpIGNhbGxzLiAgQXMgc29tZSBvZiB5b3UgYWxy
ZWFkeSBrbm93IEZhYmlvIGFuZCBJIGhhdmUgYmVlbg0KPiB3b3JraW5nIHRocm91Z2ggY29udmVy
dGluZyBrbWFwKCkgY2FsbHMgdG8ga21hcF9sb2NhbF9wYWdlKCkuICBCdXQgdGhlcmUgaXMgYQ0K
PiBsb3QgbW9yZSB3b3JrIHRvIGJlIGRvbmUuICBIZWxwIGZyb20gdGhlIGNvbW11bml0eSBpcyBh
bHdheXMgd2VsY29tZSwNCj4gZXNwZWNpYWxseSB3aXRoIGttYXBfYXRvbWljKCkgY29udmVyc2lv
bnMuICBUbyBrZWVwIGZyb20gc3RlcHBpbmcgb24gZWFjaA0KPiBvdGhlcnMgdG9lcyBJJ3ZlIGNy
ZWF0ZWQgYSBzcHJlYWRzaGVldCBvZiB0aGUgY3VycmVudCBjYWxsc1sxXS4gIFBsZWFzZSBsZXQg
bWUNCj4gb3IgRmFiaW8ga25vdyBpZiB5b3UgcGxhbiBvbiB0YWNraW5nIG9uZSBvZiB0aGUgY29u
dmVyc2lvbnMgc28gd2UgY2FuIG1hcmsgaXQNCj4gb2ZmIHRoZSBsaXN0Lg0KPiANCj4gWzFdIGh0
dHBzOi8vZG9jcy5nb29nbGUuY29tL3NwcmVhZHNoZWV0cy9kLzFpX2NrWjEwcDkwYkhfQ2t4RDJi
WU5pMDVTMlF6ODRFMk9GUHY4enFfXzB3L2VkaXQjZ2lkPTE2Nzk3MTQzNTcNCj4gDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg==

