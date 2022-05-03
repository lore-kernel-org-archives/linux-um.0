Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH 19/30] panic: Add the panic hypervisor notifier list
Date: Tue, 3 May 2022 17:44:03 +0000
Message-ID: <PH0PR21MB30257E4E6E16BB8FFDE8F312D7C09@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
 <PH0PR21MB30256260CCF4CAB713BBB11ED7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <0147d038-571b-0802-c210-ccd4d52cd5dd@igalia.com>
In-Reply-To: <0147d038-571b-0802-c210-ccd4d52cd5dd@igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com" <bhe@redhat.com>, "pmladek@suse.com" <pmladek@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "x86@kernel.org" <x86@kernel.org>, "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "kernel@gpiccoli.net" <kernel@gpiccoli.net>, "halves@canonical.com" <halves@canonical.com>, "fabiomirmar@gmail.com" <fabiomirmar@gmail.com>, "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "feng.tang@intel.com" <feng.tang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>, "jgross@suse.com" <jgross@suse.com>, "john.ogness@linutronix.de" <john.ogness@linutronix.de>, "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org" <luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "paulmck@kernel.org" <paulmck@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>, vkuznets <vkuznets@redhat.com>, "will@kernel.org" <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Andrea Parri <parri.andrea@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Norris <computersforpeace@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Gow <davidgow@google.com>, "David S. Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Doug Berger <opendmb@gmail.com>, Evan Green <evgreen@chromium.org>, Florian Fainelli <f.fainelli@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Julius Werner <jwerner@chromium.org>, Justin Chen <justinpopo6@gmail.com>, KY Srinivasan <kys@microsoft.com>, Lee Jones <lee.jones@linaro.org>, Markus Mayer <mmayer@broadcom.com>, Michael Ellerman <mpe@ellerman.id.au>, Mihai Carabas <mihai.carabas@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Scott Branden <scott.branden@broadcom.com>, Sebastian Reichel <sre@kernel.org>, Shile Zhang <shile.zhang@linux.alibaba.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, Wei Liu <wei.liu@kernel.org>, zhenwei pi <pizhenwei@bytedance.com>
List-ID: <linux-um.lists.infradead.org>

RnJvbTogR3VpbGhlcm1lIEcuIFBpY2NvbGkgPGdwaWNjb2xpQGlnYWxpYS5jb20+IFNlbnQ6IEZy
aWRheSwgQXByaWwgMjksIDIwMjIgMTE6MDQgQU0NCj4gDQo+IE9uIDI5LzA0LzIwMjIgMTQ6MzAs
IE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+ID4gRnJvbTogR3VpbGhlcm1lIEcuIFBp
Y2NvbGkgPGdwaWNjb2xpQGlnYWxpYS5jb20+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjcsIDIw
MjINCj4gMzo0OSBQTQ0KPiA+PiBbLi4uXQ0KPiA+Pg0KPiA+PiBAQCAtMjg0Myw3ICsyODQzLDcg
QEAgc3RhdGljIHZvaWQgX19leGl0IHZtYnVzX2V4aXQodm9pZCkNCj4gPj4gIAlpZiAobXNfaHlw
ZXJ2Lm1pc2NfZmVhdHVyZXMgJiBIVl9GRUFUVVJFX0dVRVNUX0NSQVNIX01TUl9BVkFJTEFCTEUp
IHsNCj4gPj4gIAkJa21zZ19kdW1wX3VucmVnaXN0ZXIoJmh2X2ttc2dfZHVtcGVyKTsNCj4gPj4g
IAkJdW5yZWdpc3Rlcl9kaWVfbm90aWZpZXIoJmh5cGVydl9kaWVfcmVwb3J0X2Jsb2NrKTsNCj4g
Pj4gLQkJYXRvbWljX25vdGlmaWVyX2NoYWluX3VucmVnaXN0ZXIoJnBhbmljX25vdGlmaWVyX2xp
c3QsDQo+ID4+ICsJCWF0b21pY19ub3RpZmllcl9jaGFpbl91bnJlZ2lzdGVyKCZwYW5pY19oeXBl
cnZpc29yX2xpc3QsDQo+ID4+ICAJCQkJCQkmaHlwZXJ2X3BhbmljX3JlcG9ydF9ibG9jayk7DQo+
ID4+ICAJfQ0KPiA+Pg0KPiA+DQo+ID4gVXNpbmcgdGhlIGh5cGVydmlzb3JfbGlzdCBoZXJlIHBy
b2R1Y2VzIGEgYml0IG9mIGEgbWlzbWF0Y2guICBJbiBtYW55IGNhc2VzDQo+ID4gdGhpcyBub3Rp
ZmllciB3aWxsIGRvIG5vdGhpbmcsIGFuZCB3aWxsIGRlZmVyIHRvIHRoZSBrbXNnX2R1bXAoKSBt
ZWNoYW5pc20NCj4gPiB0byBub3RpZnkgdGhlIGh5cGVydmlzb3IgYWJvdXQgdGhlIHBhbmljLiAg
IFJ1bm5pbmcgdGhlIGttc2dfZHVtcCgpDQo+ID4gbWVjaGFuaXNtIGlzIGxpbmtlZCB0byB0aGUg
aW5mb19saXN0LCBzbyBJJ20gdGhpbmtpbmcgdGhlIEh5cGVyLVYgcGFuaWMgcmVwb3J0DQo+ID4g
bm90aWZpZXIgc2hvdWxkIGJlIG9uIHRoZSBpbmZvX2xpc3QgYXMgd2VsbC4gIFRoYXQgd2F5IHRo
ZSByZXBvcnRpbmcgYmVoYXZpb3INCj4gPiBpcyB0cmlnZ2VyZWQgYXQgdGhlIHNhbWUgcG9pbnQg
aW4gdGhlIHBhbmljIHBhdGggcmVnYXJkbGVzcyBvZiB3aGljaA0KPiA+IHJlcG9ydGluZyBtZWNo
YW5pc20gaXMgdXNlZC4NCj4gPg0KPiANCj4gSGkgTWljaGFlbCwgdGhhbmtzIGZvciB5b3VyIGZl
ZWRiYWNrISBJIGFncmVlIHRoYXQgeW91ciBpZGVhIGNvdWxkIHdvcmssDQo+IGJ1dC4uLnRoZXJl
IGlzIG9uZSBkb3duc2lkZTogaW1hZ2luZSB0aGUga21zZ19kdW1wKCkgYXBwcm9hY2ggaXMgbm90
IHNldA0KPiBpbiBzb21lIEh5cGVyLVYgZ3Vlc3QsIHRoZW4gd2Ugd291bGQgcmVseSBpbiB0aGUg
cmVndWxhciBub3RpZmljYXRpb24NCj4gbWVjaGFuaXNtIFtodl9kaWVfcGFuaWNfbm90aWZ5X2Ny
YXNoKCldLCByaWdodD8NCj4gQnV0Li4ueW91IHdhbnQgdGhlbiB0byBydW4gdGhpcyBub3RpZmll
ciBpbiB0aGUgaW5mb3JtYXRpb25hbCBsaXN0LA0KPiB3aGljaC4uLndvbid0IGV4ZWN1dGUgKmJ5
IGRlZmF1bHQqIGJlZm9yZSBrZHVtcCBpZiBubyBrbXNnX2R1bXAoKSBpcw0KPiBzZXQuIFNvLCB0
aGlzIGxvZ2ljIGlzIGNvbnZvbHV0ZWQgd2hlbiB5b3UgbWl4IGl0IHdpdGggdGhlIGRlZmF1bHQg
bGV2ZWwNCj4gY29uY2VwdCArIGtkdW1wLg0KDQpZZXMsIHlvdSBhcmUgcmlnaHQuICBCdXQgdG8g
bWUgdGhhdCBzcGVha3MgYXMgbXVjaCB0byB0aGUgbGlua2FnZQ0KYmV0d2VlbiB0aGUgaW5mb3Jt
YXRpb25hbCBsaXN0IGFuZCBrbXNnX2R1bXAoKSBiZWluZyB0aGUgY29yZQ0KcHJvYmxlbS4gIEJ1
dCBhcyBJIGRlc2NyaWJlZCBpbiBteSByZXBseSB0byBQYXRjaCAyNCwgSSBjYW4gbGl2ZSB3aXRo
DQp0aGUgbGlua2FnZSBhcy1pcy4NCg0KRldJVywgZ3Vlc3RzIG9uIG5ld2VyIHZlcnNpb25zIG9m
IEh5cGVyLVYgd2lsbCBhbHdheXMgcmVnaXN0ZXIgYQ0Ka21zZyBkdW1wZXIuICBUaGUgZmxhZ3Mg
dGhhdCBhcmUgdGVzdGVkIHRvIGRlY2lkZSB3aGV0aGVyIHRvDQpyZWdpc3RlciBwcm92aWRlIGNv
bXBhdGliaWxpdHkgd2l0aCBvbGRlciB2ZXJzaW9ucyBvZiBIeXBlci1WIHRoYXQgDQpkb27igJl0
IHN1cHBvcnQgdGhlIDRLIGJ5dGVzIG9mIG5vdGlmaWNhdGlvbiBpbmZvLg0KDQo+IA0KPiBNYXkg
SSBzdWdnZXN0IHNvbWV0aGluZz8gSWYgcG9zc2libGUsIHRha2UgYSBydW4gd2l0aCB0aGlzIHBh
dGNoIHNldCArDQo+IERFQlVHX05PVElGSUVSPXksIGluICpib3RoKiBjYXNlcyAod2l0aCBhbmQg
d2l0aG91dCB0aGUga21zZ19kdW1wKCkNCj4gc2V0KS4gSSBkaWQgdGhhdCBhbmQgdGhleSBydW4g
YWxtb3N0IGF0IHRoZSBzYW1lIHRpbWUuLi5JJ3ZlIGNoZWNrZWQgdGhlDQo+IG5vdGlmaWVycyBj
YWxsZWQsIGl0J3MgbGlrZSBhbG1vc3Qgbm90aGluZyBydW5zIGluLWJldHdlZW4uDQo+IA0KPiBJ
IGZlZWwgdGhlIHBhbmljIG5vdGlmaWNhdGlvbiBtZWNoYW5pc20gZG9lcyByZWFsbHkgZml0IHdp
dGggYQ0KPiBoeXBlcnZpc29yIGxpc3QsIGl0J3MgYSBnb29kIG1hdGNoIHdpdGggdGhlIG5hdHVy
ZSBvZiB0aGUgbGlzdCwgd2hpY2gNCj4gYWltcyBhdCBpbmZvcm1pbmcgdGhlIHBhbmljIG5vdGlm
aWNhdGlvbiB0byB0aGUgaHlwZXJ2aXNvci9GVy4NCj4gT2YgY291cnNlIHdlIGNhbiBtb2RpZnkg
aXQgaWYgeW91IHByZWZlci4uLmJ1dCBwbGVhc2UgdGFrZSBpbnRvIGFjY291bnQNCj4gdGhlIGtk
dW1wIGNhc2UgYW5kIGhvdyBpdCBjb21wbGljYXRlcyB0aGUgbG9naWMuDQoNCkkgYWdyZWUgdGhh
dCB0aGUgcnVudGltZSBlZmZlY3Qgb2Ygb25lIGxpc3QgdnMuIHRoZSBvdGhlciBpcyBuaWwuICBU
aGUNCmNvZGUgd29ya3MgYW5kIGNhbiBzdGF5IGFzIHlvdSB3cml0dGVuIGl0Lg0KDQpJIHdhcyB0
cnlpbmcgdG8gYWxpZ24gZnJvbSBhIGNvbmNlcHR1YWwgc3RhbmRwb2ludC4gIEl0IHdhcyBhIGJp
dA0KdW5leHBlY3RlZCB0aGF0IG9uZSBwYXRoIHdvdWxkIGJlIG9uIHRoZSBoeXBlcnZpc29yIGxp
c3QsIGFuZCB0aGUNCm90aGVyIHBhdGggZWZmZWN0aXZlbHkgb24gdGhlIGluZm9ybWF0aW9uYWwg
bGlzdC4gIFdoZW4gSSBzZWUNCmNvbmNlcHR1YWwgbWlzbWF0Y2hlcyBsaWtlIHRoYXQsIEkgdGVu
ZCB0byB3YW50IHRvIHVuZGVyc3RhbmQgd2h5LA0KYW5kIGlmIHRoZXJlIGlzIHNvbWV0aGluZyBt
b3JlIGZ1bmRhbWVudGFsIHRoYXQgaXMgb3V0LW9mLXdoYWNrLg0KDQoNCj4gDQo+IExldCBtZSBr
bm93IHlvdXIgY29uc2lkZXJhdGlvbnMsIGluIGNhc2UgeW91IGNhbiBleHBlcmltZW50IHdpdGgg
dGhlDQo+IHBhdGNoIHNldCBhcy1pcy4NCj4gQ2hlZXJzLA0KPiANCj4gDQo+IEd1aWxoZXJtZQ0K

