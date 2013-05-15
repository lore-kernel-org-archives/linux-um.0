Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Uch1q-0008HF-Oh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 May 2013 19:06:22 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uch1p-0003Wq-R0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 May 2013 19:06:22 +0000
Received: from mailout-de.gmx.net ([10.1.76.4]) by mrigmx.server.lan
	(mrigmx002) with ESMTP (Nemesis) id 0MY1JW-1Uydku1Bsu-00Uq3C for
	<user-mode-linux-devel@lists.sourceforge.net>; Wed, 15 May 2013 21:06:16
	+0200
Message-ID: <5193DCA7.1070708@gmx.de>
Date: Wed, 15 May 2013 21:06:15 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <518FB97A.5070907@gmx.de>
	<CAFLxGvzn+Q=D4vjTNuggSTnQKVp0QYLPoHmUwAVBcRbSmD3HWQ@mail.gmail.com>
	<518FBE6A.50605@gmx.de>
	<CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
	<CAFLxGvwEiE0dfw9Vju_Xg6mXkF_NH_OU_t7puPceYN42dphTLA@mail.gmail.com>
	<518FE33B.60701@gmx.de>
	<CAFLxGvyiKbbkPAG0h42y1fb=Z6YuboJPdyb+2Xk9Z2YYt7oryg@mail.gmail.com>
	<518FF354.7020408@gmx.de>
	<CAFLxGvxYjpt6X9MQF3Huh-Sqzm3CBMJAfGb_Qjpqu00iUzj=qg@mail.gmail.com>
	<518FFBA3.6000800@gmx.de>
	<CAFLxGvx+8wpBeF_TqOk3JKBEoADAS-NeatpJMuSVvaDhZNqE0g@mail.gmail.com>
	<CAFLxGvzSEY8iciEONkxNGeO6Lt5v4VcB2sF1XPcqLA=n8PUaAQ@mail.gmail.com>
	<51901400.4060302@gmx.de>
	<CAFLxGvx-saWcJ+JCubUBAVT70OSMZDYNETqiNijJgXeqCPwwUA@mail.gmail.com>
In-Reply-To: <CAFLxGvx-saWcJ+JCubUBAVT70OSMZDYNETqiNijJgXeqCPwwUA@mail.gmail.com>
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
Subject: Re: [uml-devel] WARNING: at mm/mmap.c:2757 exit_mmap+0x161/0x170()
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

T24gMDUvMTMvMjAxMyAwOToxMiBBTSwgcmljaGFyZCAtcnctIHdlaW5iZXJnZXIgd3JvdGU6Cj4g
VGhpcyBsb29rcyBsaWtlIGFub3RoZXIgaXNzdWUuCj4gQXJlIHlvdSB0ZXN0aW5nIHByb2Nlc3Nf
dm1fd3JpdGV2KCkgd2l0aCB0cmluaXR5Pwo+IExvb2tzIGxpa2UgaXQgbWFuYWdlZCB0byBvdmVy
d3JpdGUgdGhlIHN0dWIgcGFnZSBvZiBhIHByb2Nlc3MsIHdoaWNoCj4gaXMgbm90IGdvb2QuCm5v
cGUsIGl0IGlzIHRoZSBtcmVtYXAgc3lzY2FsbC4KCkEgY29tbWFuZCBsaWtlIAoKJD50cmluaXR5
IC1jIG1yZW1hcCAtTiAxMAoKaW1tZWRpYXRlbHkgYWZ0ZXIgc3RhcnRpbmcgYSAzMiBiaXQgR2Vu
dG9vIGxpbnV4IGd1ZXN0IHdpdGggY3VycmVudCBrZXJuZWwgMy4xMC1yYzEtLi4uICsKc3Rybmxl
biArIHN0dWI0IHBhdGNoIHdvcmtzLCBidXQgbGF0ZXIgYQoKJD50cmluaXR5IC1jIG1yZW1hcCAt
TiAxMDAwCgp5aWVsZHMgaW50byAKCjIwMTMtMDUtMTVUMjE6MDI6MDQuMDYxKzAyOjAwIHRyaW5p
dHkga2VybmVsOiBTdHViIHJlZ2lzdGVycyAtCjIwMTMtMDUtMTVUMjE6MDI6MDQuMDYxKzAyOjAw
IHRyaW5pdHkga2VybmVsOiAgIDAgLSAxMDAwMDAKMjAxMy0wNS0xNVQyMTowMjowNC4wNjErMDI6
MDAgdHJpbml0eSBrZXJuZWw6ICAgMSAtIDMwMDAwMAoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2MSsw
MjowMCB0cmluaXR5IGtlcm5lbDogICAyIC0gMAoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2MSswMjow
MCB0cmluaXR5IGtlcm5lbDogICAzIC0gMAoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2MSswMjowMCB0
cmluaXR5IGtlcm5lbDogICA0IC0gMAoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2MSswMjowMCB0cmlu
aXR5IGtlcm5lbDogICA1IC0gMAoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2MSswMjowMCB0cmluaXR5
IGtlcm5lbDogICA2IC0gMAoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2MSswMjowMCB0cmluaXR5IGtl
cm5lbDogICA3IC0gN2IKMjAxMy0wNS0xNVQyMTowMjowNC4wNjErMDI6MDAgdHJpbml0eSBrZXJu
ZWw6ICAgOCAtIDdiCjIwMTMtMDUtMTVUMjE6MDI6MDQuMDY1KzAyOjAwIHRyaW5pdHkga2VybmVs
OiAgIDkgLSAwCjIwMTMtMDUtMTVUMjE6MDI6MDQuMDY1KzAyOjAwIHRyaW5pdHkga2VybmVsOiAg
IDEwIC0gMzMKMjAxMy0wNS0xNVQyMTowMjowNC4wNjUrMDI6MDAgdHJpbml0eSBrZXJuZWw6ICAg
MTEgLSBmZmZmZmZmZgoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2NSswMjowMCB0cmluaXR5IGtlcm5l
bDogICAxMiAtIDEwMDBjMwoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2NSswMjowMCB0cmluaXR5IGtl
cm5lbDogICAxMyAtIDczCjIwMTMtMDUtMTVUMjE6MDI6MDQuMDY1KzAyOjAwIHRyaW5pdHkga2Vy
bmVsOiAgIDE0IC0gMTAyMDYKMjAxMy0wNS0xNVQyMTowMjowNC4wNjUrMDI6MDAgdHJpbml0eSBr
ZXJuZWw6ICAgMTUgLSAxMDEwMjgKMjAxMy0wNS0xNVQyMTowMjowNC4wNjUrMDI6MDAgdHJpbml0
eSBrZXJuZWw6ICAgMTYgLSA3YgoyMDEzLTA1LTE1VDIxOjAyOjA0LjA2NSswMjowMCB0cmluaXR5
IGtlcm5lbDogd2FpdF9zdHViX2RvbmUgOiBmYWlsZWQgdG8gd2FpdCBmb3IgU0lHVFJBUCwgcGlk
ID0gMTU2OTIsIG4gPSAxNTY5MiwgZXJybm8gPSAwLCBzdGF0dXMgPSAweGI3ZgoKYW5kIG5vdyB0
aGF0IHByb2Nlc3MgY2FuJ3QgYmUga2lsbGVkIC0gSSBoYWQgdG8gc3RvcCB0aGUgVU1MIGd1ZXN0
LgoKLS0gCk1mRy9TaW5jZXJlbHkKVG9yYWxmIEbDtnJzdGVyCnBncCBmaW5nZXIgcHJpbnQ6IDdC
MUEgMDdGNCBFQzgyIDBGOTAgRDRDMiA4OTM2IDg3MkEgRTUwOCA3REI2IDlEQTMKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpBbGllblZhdWx0IFVuaWZpZWQgU2VjdXJpdHkgTWFuYWdlbWVudCAoVVNN
KSBwbGF0Zm9ybSBkZWxpdmVycyBjb21wbGV0ZQpzZWN1cml0eSB2aXNpYmlsaXR5IHdpdGggdGhl
IGVzc2VudGlhbCBzZWN1cml0eSBjYXBhYmlsaXRpZXMuIEVhc2lseSBhbmQKZWZmaWNpZW50bHkg
Y29uZmlndXJlLCBtYW5hZ2UsIGFuZCBvcGVyYXRlIGFsbCBvZiB5b3VyIHNlY3VyaXR5IGNvbnRy
b2xzCmZyb20gYSBzaW5nbGUgY29uc29sZSBhbmQgb25lIHVuaWZpZWQgZnJhbWV3b3JrLiBEb3du
bG9hZCBhIGZyZWUgdHJpYWwuCmh0dHA6Ly9wLnNmLm5ldC9zZnUvYWxpZW52YXVsdF9kMmQKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxp
bnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3Vz
ZXItbW9kZS1saW51eC1kZXZlbAo=

