Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Vmllu-0005BO-VN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 14:43:51 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Vmllt-0005hR-QI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 14:43:50 +0000
Received: from [192.168.178.21] ([80.171.148.255]) by mail.gmx.com (mrgmx002)
	with ESMTPSA (Nemesis) id 0LlESk-1VF5dx0Ok2-00b7FE for
	<user-mode-linux-devel@lists.sourceforge.net>; Sat, 30 Nov 2013 15:43:43
	+0100
Message-ID: <5299F99D.9040503@gmx.de>
Date: Sat, 30 Nov 2013 15:43:41 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <5299F818.4070408@gmx.de>
In-Reply-To: <5299F818.4070408@gmx.de>
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
Subject: Re: [uml-devel] does 3.12.2 breaks UML with "con=xterm" ?
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

T24gMTEvMzAvMjAxMyAwMzozNyBQTSwgVG9yYWxmIEbDtnJzdGVyIHdyb3RlOgo+IAo+IFRvZGF5
IEkgcmVhbGl6ZWQgdGhhdCBhIFVNTCBjb3JlcyBpZiBJIHVzZSB0aGUgeHRlcm0gZm9yIHRoZSBp
bi9vdXQuCj4gCj4gSSBkbyB1c3VhbGx5IHVzZSAiY29uMD1mZDowLGZkOjEgY29uPXB0cyIgdG8g
c3RhcnQgYSAzMmJpdCBVTUwgYnV0IGJlY2F1c2UgdGhlIHh0ZXJtIHdheSB3YXMgZmluZSBkdXJp
bmcgdGhlIHBhc3QgZmV3IHdlZWtzICh5ZXMsIEkga25vdywgaXQgd2FzIGJyb2tlbiBmb3IgYSBs
b25nZXIgdGltZSBiZWZvcmUpIGFuZCB0aGUgb25seSBjaGFuZ2UgeWVzdGVyZGF5IHdhcyB0byB1
cGdyYWRlIGZyb20gdmFuaWxsYSBrZXJuZWwgMy4xMi4xIHRvIDMuMTIuMiBJJ20gd29uZGVyaW5n
IGlmIHRoZXJlJ3MgYSAic3VzcGljb3VzIiBjb21taXQgaW4gdGhhdCBzdGFibGUga2VybmVsIHdo
aWNoIGNvdWxkIGJlIHRoZSByZWFzb24gPwo+IAo+IAo+IEZXSVcgOgo+IHRmb2Vyc3RlQG4yMiB+
ICQgZ2RiIC0tY29yZT0vbW50L3JhbWRpc2svY29yZSAvaG9tZS90Zm9lcnN0ZS9kZXZlbC9saW51
eC9saW51eCAtbiAtYmF0Y2ggLWV4IGJ0Cj4gW05ldyBMV1AgMjk1NTldCj4gQ29yZSB3YXMgZ2Vu
ZXJhdGVkIGJ5IGAvaG9tZS90Zm9lcnN0ZS9kZXZlbC9saW51eC9saW51eCBlYXJseXByaW50ayB1
YmRhPS9ob21lL3Rmb2Vyc3RlL3ZpcnR1YWwvdW1sL3RyJy4KPiBQcm9ncmFtIHRlcm1pbmF0ZWQg
d2l0aCBzaWduYWwgMTEsIFNlZ21lbnRhdGlvbiBmYXVsdC4KPiAjMCAgZmluaXNoX3Rhc2tfc3dp
dGNoIChwcmV2PTB4ZmZmZjlkMmYsIHJxPTxvcHRpbWl6ZWQgb3V0PikgYXQga2VybmVsL3NjaGVk
L2NvcmUuYzoxOTkzCj4gMTk5MyAgICAgICAgICAgIHByZXZfc3RhdGUgPSBwcmV2LT5zdGF0ZTsK
PiAjMCAgZmluaXNoX3Rhc2tfc3dpdGNoIChwcmV2PTB4ZmZmZjlkMmYsIHJxPTxvcHRpbWl6ZWQg
b3V0PikgYXQga2VybmVsL3NjaGVkL2NvcmUuYzoxOTkzCj4gIzEgIDB4MDg0Mjc0MTggaW4gY29u
dGV4dF9zd2l0Y2ggKG5leHQ9PG9wdGltaXplZCBvdXQ+LCBwcmV2PTB4NDZkOWVlY2MsIHJxPTxv
cHRpbWl6ZWQgb3V0PikgYXQga2VybmVsL3NjaGVkL2NvcmUuYzoyMTMwCj4gIzIgIF9fc2NoZWR1
bGUgKCkgYXQga2VybmVsL3NjaGVkL2NvcmUuYzoyNTY4Cj4gIzMgIDB4MDg0Mjc1MDUgaW4gc2No
ZWR1bGUgKCkgYXQga2VybmVsL3NjaGVkL2NvcmUuYzoyNjA0Cj4gIzQgIDB4MDgwOGI5MTIgaW4g
c2lnc3VzcGVuZCAoc2V0PTB4NDZkOWVlY2MpIGF0IGtlcm5lbC9zaWduYWwuYzozNTU5Cj4gIzUg
IDB4MDgwNjQ2ZDggaW4gd2luY2hfdGhyZWFkIChhcmc9MHg0NmQ5ZWVjYykgYXQgYXJjaC91bS9k
cml2ZXJzL2NoYW5fdXNlci5jOjIxMAo+ICM2ICAweDA4M2RhMzhlIGluIGNsb25lICgpCj4gCj4g
CgpQZmYgLSBnbGliYyB3YXMgdXBncmFkZSBmcm9tIDIuMTUtcjMgdG8gMi4xNiB0b28gLSAvbWUg
aG9wZSwgdGhhdCBpdCBpcwpub3QgZ2xpYmMuCgotLSAKTWZHL1NpbmNlcmVseQpUb3JhbGYgRsO2
cnN0ZXIKcGdwIGZpbmdlciBwcmludDogN0IxQSAwN0Y0IEVDODIgMEY5MCBENEMyIDg5MzYgODcy
QSBFNTA4IDdEQjYgOURBMwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJhcGlkbHkgdHJvdWJsZXNo
b290IHByb2JsZW1zIGJlZm9yZSB0aGV5IGFmZmVjdCB5b3VyIGJ1c2luZXNzLiBNb3N0IElUIApv
cmdhbml6YXRpb25zIGRvbid0IGhhdmUgYSBjbGVhciBwaWN0dXJlIG9mIGhvdyBhcHBsaWNhdGlv
biBwZXJmb3JtYW5jZSAKYWZmZWN0cyB0aGVpciByZXZlbnVlLiBXaXRoIEFwcER5bmFtaWNzLCB5
b3UgZ2V0IDEwMCUgdmlzaWJpbGl0eSBpbnRvIHlvdXIgCkphdmEsLk5FVCwgJiBQSFAgYXBwbGlj
YXRpb24uIFN0YXJ0IHlvdXIgMTUtZGF5IEZSRUUgVFJJQUwgb2YgQXBwRHluYW1pY3MgUHJvIQpo
dHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBhZC9jbGs/aWQ9ODQzNDkzNTEmaXU9
LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGlu
dXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

