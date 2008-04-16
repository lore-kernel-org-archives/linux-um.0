Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jm0ST-0003S3-Tx for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 22:45:25 -0700
Received: from qb-out-0506.google.com ([72.14.204.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jm0ST-0000ZU-Lw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 22:45:25 -0700
Received: by qb-out-0506.google.com with SMTP id c8so2661300qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Apr 2008 22:45:25 -0700 (PDT)
Date: Wed, 16 Apr 2008 13:41:27 +0800 (CST)
Message-Id: <20080416.134127.128610481.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
In-Reply-To: <20080414154342.GA9434@c2.user-mode-linux.org>
References: <20080412.233914.54446044.xiyou.wangcong@gmail.com>
	<20080414154342.GA9434@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] UML: Fix another build error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

RnJvbTogSmVmZiBEaWtlIDxqZGlrZUBhZGR0b2l0LmNvbT4NCkRhdGU6IE1vbiwgMTQgQXByIDIw
MDggMTE6NDM6NDIgLTA0MDANCj4gT24gU2F0LCBBcHIgMTIsIDIwMDggYXQgMTE6Mzk6MTRQTSAr
MDgwMCwgV0FORyBDb25nIHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGZv
bGxvd2luZyBidWlsZCBlcnJvci4NCj4gPiANCj4gPiAgIENDICAgICAgYXJjaC91bS9kcml2ZXJz
L21jb25zb2xlX2tlcm4ubw0KPiA+IC9ob21lL3dhbmdjb25nL3Byb2plY3RzL2xpbnV4LTIuNi9h
cmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5jOjMzNzogZXJyb3I6IHJlZGVmaW5pdGlvbiBv
ZiDigJhtY29uc29sZV9yZWdpc3Rlcl9kZXbigJkNCj4gPiAvaG9tZS93YW5nY29uZy9wcm9qZWN0
cy9saW51eC0yLjYvYXJjaC91bS9pbmNsdWRlL21jb25zb2xlX2tlcm4uaDo0NzogZXJyb3I6IHBy
ZXZpb3VzIGRlZmluaXRpb24gb2Yg4oCYbWNvbnNvbGVfcmVnaXN0ZXJfZGV24oCZIHdhcyBoZXJl
DQo+ID4gbWFrZVsyXTogKioqIFthcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5vXSBFcnJv
ciAxDQo+ID4gbWFrZVsxXTogKioqIFthcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5rb10g
RXJyb3IgMg0KPiA+IG1ha2U6ICoqKiBbc3ViLW1ha2VdIEVycm9yIDINCj4gDQo+IFRoaXMgb25l
IGlzIGZpc2h5LiAgRm9yIG9uZSB0aGluZywgaXQgbG9va3MgbGlrZSB5b3UgcmVwcm9kdWNlIHRo
aXMNCj4gd2l0aCAhQ09ORklHX01DT05TT0xFLCBidXQgSSBqdXN0IHN1Y2Nlc3NmdWxseSBidWls
dCBhDQo+ICFDT05GSUdfTUNPTlNPTEUgVU1MLg0KPiANCj4gU2Vjb25kLCB0aGUgYXJjaC91bS9k
cml2ZXJzL01ha2VmaWxlIGxvb2tzIHRvIG1lIChhbmQgdGhlIGJ1aWxkIGxvZw0KPiBjb25maXJt
cykgdGhhdCBtY29uc29sZV9rZXJuLmMgaXNuJ3QgY29tcGlsZWQgd2l0aCAhQ09ORklHX01DT05T
T0xFLg0KPiANCj4gVGhpcmQsIHlvdSBzaG91bGQgYXNrIHlvdXJzZWxmIGlmIHRoZXJlIG1pZ2h0
IGJlIGEgZGVlcGVyIHByb2JsZW0gdGhhdA0KPiBuZWVkcyBmaXhpbmcgaWYgeW91IGZpbmQgeW91
cnNlbGYgcHV0dGluZyAjaWZkZWYgQ09ORklHX0ZPTyBpbiBmaWxlcw0KPiB3aGljaCBpbXBsZW1l
bnQgRk9PLg0KDQpUaGFua3MgZm9yIHRlYWNoaW5nIHRoaXMhDQoNCkkgd2lsbCB0cnkgaWYgaXQn
cyBwb3NzaWJsZSB0byByZXByb2R1Y2UgdGhpcy4NCg0KDQogQ29uZw0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgdGhlIDIwMDggSmF2YU9uZShTTSkg
Q29uZmVyZW5jZSAKRG9uJ3QgbWlzcyB0aGlzIHllYXIncyBleGNpdGluZyBldmVudC4gVGhlcmUn
cyBzdGlsbCB0aW1lIHRvIHNhdmUgJDEwMC4gClVzZSBwcmlvcml0eSBjb2RlIEo4VEwyRDIuIApo
dHRwOi8vYWQuZG91YmxlY2xpY2submV0L2NsazsxOTg3NTc2NzM7MTM1MDMwMzg7cD9odHRwOi8v
amF2YS5zdW4uY29tL2phdmFvbmUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUt
bGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=
