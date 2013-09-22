Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1VNf1G-0003AM-L8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 08:27:54 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1VNf1F-00024G-80
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Sep 2013 08:27:54 +0000
Received: from [80.171.221.199] ([80.171.221.199]) by mail.gmx.com (mrgmx102)
	with ESMTPSA (Nemesis) id 0LnlmV-1Vol6j2kb1-00hz6t for
	<user-mode-linux-devel@lists.sourceforge.net>; Sun, 22 Sep 2013 10:27:46
	+0200
Message-ID: <523EA9FF.60804@gmx.de>
Date: Sun, 22 Sep 2013 10:27:43 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <52376466.2040601@gmx.de>
	<CAFLxGvyw7j_xGpk0F-DLLhxJFEXUjW_Jc0ggKySmRe0NszDAuw@mail.gmail.com>
In-Reply-To: <CAFLxGvyw7j_xGpk0F-DLLhxJFEXUjW_Jc0ggKySmRe0NszDAuw@mail.gmail.com>
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
Subject: Re: [uml-devel] difference of a shell script versus command line
 WRT "winch_thread : TIOCSCTTY failed on fd 1 err = 1"
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

T24gMDkvMjIvMjAxMyAwODo1MiBBTSwgcmljaGFyZCAtcnctIHdlaW5iZXJnZXIgd3JvdGU6Cj4g
T24gTW9uLCBTZXAgMTYsIDIwMTMgYXQgMTA6MDQgUE0sIFRvcmFsZiBGw7Zyc3RlciA8dG9yYWxm
LmZvZXJzdGVyQGdteC5kZT4gd3JvdGU6Cj4+IElmIEkgcnVuIHRoZSBmb2xsb3dpbmcgc2NyaXB0
Cj4+Cj4+ICQ+IGNhdCBsLnNoCj4+ICMhL2Jpbi9zaAo+PiAjCj4+Cj4+IC91c3IvbG9jYWwvYmlu
L2xpbnV4LXYzLjExLTg3MTgtZzBmYjVjYTEgZWFybHlwcmludGsgdWJkYT0vaG9tZS90Zm9lcnN0
ZS92aXJ0dWFsL3VtbC9uMjJ1bnN0NCB1YmRiPS9tbnQvcmFtZGlzay9uMjJ1bnN0NF9zd2FwIGV0
aDA9dHVudGFwLHRhcDIsNzI6ZWY6M2Q6NWQ6ZDM6ZGIgbWVtPTEwMjVNIGNvbjA9ZmQ6MCxmZDox
IGNvbj1wdHMgdW1pZD11bWxfbjIydW5zdDQgcm9vdGZzdHlwZT1leHQ0Cj4+Cj4+Cj4+IHRoZW4g
ZHVyaW5nIHN0YXJ0IG9mIHRoZSBVTUwgSSBnZXQKPj4KPj4gLi4uCj4+IE5ldGRldmljZSAwICg3
MjplZjozZDo1ZDpkMzpkYikgOgo+PiBUVU4vVEFQIGJhY2tlbmQgLQo+PiB3aW5jaF90aHJlYWQg
OiBUSU9DU0NUVFkgZmFpbGVkIG9uIGZkIDEgZXJyID0gMQo+IAo+IEhtbSwgdGhhdCdzIGEgcmVn
cmVzc2lvbiBpbnRyb2R1Y2VkIGJ5Ogo+IGNvbW1pdCAyNTAxMjcyMTZkZDY2MzVmNTczMDc1MmQ3
NDQ0YmRlYzk5MmFlY2IwCj4gQXV0aG9yOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9k
LmF0Pgo+IERhdGU6ICAgU3VuIEF1ZyAxOCAxMzozMDowOSAyMDEzICswMjAwCj4gCj4gICAgIHVt
OiBSdW4gVU1MIGluIGl0J3Mgb3duIHNlc3Npb24uCj4gCj4gICAgIElmIFVNTCBpcyBub3QgcnVu
IGJ5IGEgc2hlbGwgaXQgY2FuIGhhcHBlbiB0aGF0IFVNTAo+ICAgICB3aWxsIGtpbGwgdW5yZWxh
dGVkIHByb2Nlc2VzIHVwb24gYSBmYXRhbCBleGl0IGJlY2F1c2UKPiAgICAgaXQgaXNzdWVzIGEg
a2lsbCgwLCAuLi4pLgo+ICAgICBUbyBwcmV2ZW50IHN1Y2ggb2RkaXRpZXMgd2UgY3JlYXRlIGEg
bmV3IHNlc3Npb24gaW4gbWFpbigpLgo+IAo+ICAgICBSZXBvcnRlZC1hbmQtdGVzdGVkLWJ5OiBS
aWNoYXJkIFcuTS4gSm9uZXMgPHJqb25lc0ByZWRoYXQuY29tPgo+ICAgICBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pgo+IAo+IAo+IFRoZSB3aW5jaC10
aHJlYWQgYWxzbyBoYXMgaXQncyBvd24gc2Vzc2lvbiwgdGhpcyBzZWVtcyB0byBiZSB0byBhbiBp
c3N1ZS4KPiAKCnN1cmUgLSBJIGNhbiByZXByb2R1Y2UgaXQgd2l0aCBsaW51eC12My4xMS04NzE4
LWcwZmI1Y2ExICwgd2hpY2ggZG9lc24ndCBjb250YWluIHRoYXQgY29tbWl0LCBvciA/CgotLSAK
TWZHL1NpbmNlcmVseQpUb3JhbGYgRsO2cnN0ZXIKcGdwIGZpbmdlciBwcmludDogN0IxQSAwN0Y0
IEVDODIgMEY5MCBENEMyIDg5MzYgODcyQSBFNTA4IDdEQjYgOURBMwoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkxJTUlURUQgVElNRSBTQUxFIC0gRnVsbCBZZWFyIG9mIE1pY3Jvc29mdCBUcmFpbmlu
ZyBGb3IgSnVzdCAkNDkuOTkhCjEsNTAwKyBob3VycyBvZiB0dXRvcmlhbHMgaW5jbHVkaW5nIFZp
c3VhbFN0dWRpbyAyMDEyLCBXaW5kb3dzIDgsIFNoYXJlUG9pbnQKMjAxMywgU1FMIDIwMTIsIE1W
QyA0LCBtb3JlLiBCRVNUIFZBTFVFOiBOZXcgTXVsdGktTGlicmFyeSBQb3dlciBQYWNrIGluY2x1
ZGVzCk1vYmlsZSwgQ2xvdWQsIEphdmEsIGFuZCBVWCBEZXNpZ24uIExvd2VzdCBwcmljZSBldmVy
ISBFbmRzIDkvMjIvMTMuIApodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9j
bGs/aWQ9NjQ1NDU4NzEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcg
bGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZl
bAo=

