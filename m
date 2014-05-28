Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Wpgc6-0004BV-BU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 May 2014 16:22:02 +0000
Received: from mail-ve0-f175.google.com ([209.85.128.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Wpgc5-0001TN-DQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 May 2014 16:22:02 +0000
Received: by mail-ve0-f175.google.com with SMTP id jw12so12800028veb.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 May 2014 09:21:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOV6k-BK_oQQ9MwQ1ggp==QPh-vQ=_Kz7j0rVquqAeuoyjr=4w@mail.gmail.com>
References: <CAOV6k-BK_oQQ9MwQ1ggp==QPh-vQ=_Kz7j0rVquqAeuoyjr=4w@mail.gmail.com>
Date: Wed, 28 May 2014 18:21:55 +0200
Message-ID: <CAFLxGvw+0L2SSXGzddOgG56g1avyuU4EvUG_peMowe65fh02pQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Skas Mode : How does it work ?
To: =?UTF-8?B?U8OpYmFzdGllbiBGcsOpbWFs?= <sebastien.fremal@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

T24gVHVlLCBNYXkgMjcsIDIwMTQgYXQgMzo1OCBQTSwgU8OpYmFzdGllbiBGcsOpbWFsCjxzZWJh
c3RpZW4uZnJlbWFsQGdtYWlsLmNvbT4gd3JvdGU6Cj4gSGVsbG8sCj4KPiBJJ20gYSBQaEQgU3R1
ZGVudCBzdHVkeWluZyB2aXJ0dWFsaXphdGlvbiBtZXRob2RzLiBJIGZvdW5kIGFuIGFydGljbGUg
b24gVU1MCj4gZXhwbGFpbmluZyBob3cgaXQgd29ya3MgaW4gVFQgbW9kZQo+IChodHRwczovL3d3
dy5rZXJuZWwub3JnL2RvYy9vbHMvMjAwMS91bWwucGRmKS4KPgo+IEkgcmVhZCB0aGF0IHRoZXJl
IGlzIG5vdyBhIHNrYXMgbW9kZSBmaXhpbmcgc2VjdXJpdHkgYW5kIHBlcmZvcm1hbmNlIGlzc3Vz
ZXMKPiBvZiB0aGUgVFQgbW9kZSAoaHR0cDovL3VzZXItbW9kZS1saW51eC5zb3VyY2Vmb3JnZS5u
ZXQvb2xkL3NrYXMuaHRtbCksIGJ1dCBJCj4gZG9uJ3QgZmluZCBpbmZvcm1hdGlvbnMgb24gaG93
IGl0IHdvcmtzLiBJdCBzZWVtcyB0aGF0IHRoZSB0cmFjaW5nIHRocmVhZAo+IGRvZXNuJ3QgZXhp
c3QgaW4gc2thcyBtb2RlLiBJJ20gc2VhcmNoaW5nIGluZm9ybWF0aW9ucyBvbiBob3cgdGhpcyBz
eXN0ZW0KPiB3b3JrcywgZXNwZWNpYWxseSBob3cgc3lzdGVtIGNhbGxzIGFyZSB2aXJ0dWFsaXpl
ZC4gSXMgdGhpcyBpbmZvcm1hdGlvbgo+IGF2YWlsYWJsZSBzb21ld2hlcmUgPwoKRmVlbCBmcmVl
IHRvIGFzayBtZSB3aGF0ZXZlciB5b3Ugd2FudCB0byBrbm93LgoKU0tBUyBtZWFucyAiU2VwYXJh
dGVkIEtlcm5lbCBBZGRyZXNzIFNwYWNlIi4KSXQgZW5zdXJlcyB0aGF0IHVzZXJzcGFjZSBjYW5u
b3QgYWNjZXNzIGtlcm5lbCBtZW1vcnkuClRoZSBmaXJzdCB2ZXJzaW9uIG9mIFNLQVMgd2FzIFNL
QVMzIGl0IG5lZWRlZCBhIGtlcm5lbCBwYXRjaCBvbiB0aGUKaG9zdCBzaWRlIHdoaWNoCm5ldmVy
IHdlbnQgbWFpbmxpbmUuClRoZXJlIHdhcyBhbHNvIGFuIGF0dGVtcHQgdG8gbWFrZSBTS0FTIG1h
aW5saW5lIHJlYWR5LCBTS0FTNC4KVGhlbiB0aGUgVU1MIGRldmVsb3BlcnMgZm91bmQgYSB3YXkg
dG8gaW1wbGVtZW50IFNLQVMgd2l0aG91dCBwYXRjaGluZwp0aGUgaG9zdCBrZXJuZWwsIFNLQVMw
LgpDdXJyZW50bHkgVU1MIHN1cHBvcnRzIFNBU0swIGFuZCBTS0FTMy4KQnV0IEkgYmV0IFNLQVMz
IHN1cHBvcnQgaXMgYnJva2VuIGFzIG5vYm9keSB1c2VzIGl0IGFueW1vcmUuIEknbGwKcmVtb3Zl
IGl0IHNvb24uCgpJbiBTS0FTMCBldmVyeSBndWVzdCBwcm9jZXNzIGhhcyBhIHR3aW4gb24gdGhl
IGhvc3Qgc2lkZS4KSWYgdGhlIFVNTCBrZXJuZWwgd2FudHMgdG8gY2hhbmdlIGEgbWVtb3J5IG1h
cHBpbmcgb2YgYSBwcm9jZXNzIGl0IGhhcyB0bwpkbyBpdCB3aXRoaW4gdGhlIGd1ZXN0IHByb2Nl
c3Mgb24gdGhlIGhvc3QuIFRoaXMgbWVjaGFuaXNtIGlzIGRvbmUgdXNpbmcKdGhlIHN0dWIgcGFn
ZXMuClRoZSBrZXJuZWwgb3ducyB0d28gcGFnZXMgd2l0aGluIGV2ZXJ5IGd1ZXN0IHByb2Nlc3Mg
YW5kIGNhbiBleGVjdXRlCmNvZGUgYXMgdGhlIGd1ZXN0LgpPZiBjb3Vyc2UgVU1MIGhhcyB0byBt
YWtlIHN1cmUgdGhhdCBubyBndWVzdCBwcm9jZXNzIGV2ZXJ5IGNhbiBjb250cm9sCml0cyBzdHVi
IHBhZ2VzLApvdGhlcndpc2UgaXQgY291bGQgYnJlYWsgb3V0LgoKU3lzdGVtIGNhbGwgdmlzdWFs
aXphdGlvbiBvbiBVTUwgaXMgZG9uZSB1c2luZyBwdHJhY2UoKS4KVU1MIGlzIGJhc2ljYWxseSBz
eXN0ZW0gY2FsbCBlbXVsYXRvci4gSXQgdXNlcyBwdHJhY2UoKSB0byBtYWtlIGV2ZXJ5CnN5c3Rl
bSBjYWxsIHZvaWQKYW5kIGVtdWxhdGVzIGl0LgoKLS0gClRoYW5rcywKLy9yaWNoYXJkCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KVGltZSBpcyBtb25leS4gU3RvcCB3YXN0aW5nIGl0ISBHZXQgeW91
ciB3ZWIgQVBJIGluIDUgbWludXRlcy4Kd3d3LnJlc3RsZXQuY29tL2Rvd25sb2FkCmh0dHA6Ly9w
LnNmLm5ldC9zZnUvcmVzdGxldApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1s
aW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

