Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Vmlfe-00046Z-2r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 14:37:22 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Vmlfc-0005d2-RY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Nov 2013 14:37:22 +0000
Received: from [192.168.178.21] ([80.171.148.255]) by mail.gmx.com (mrgmx002)
	with ESMTPSA (Nemesis) id 0MId0S-1VkYk61YhU-002Jxb for
	<user-mode-linux-devel@lists.sourceforge.net>; Sat, 30 Nov 2013 15:37:14
	+0100
Message-ID: <5299F818.4070408@gmx.de>
Date: Sat, 30 Nov 2013 15:37:12 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
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
Subject: [uml-devel] does 3.12.2 breaks UML with "con=xterm" ?
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

ClRvZGF5IEkgcmVhbGl6ZWQgdGhhdCBhIFVNTCBjb3JlcyBpZiBJIHVzZSB0aGUgeHRlcm0gZm9y
IHRoZSBpbi9vdXQuCgpJIGRvIHVzdWFsbHkgdXNlICJjb24wPWZkOjAsZmQ6MSBjb249cHRzIiB0
byBzdGFydCBhIDMyYml0IFVNTCBidXQgYmVjYXVzZSB0aGUgeHRlcm0gd2F5IHdhcyBmaW5lIGR1
cmluZyB0aGUgcGFzdCBmZXcgd2Vla3MgKHllcywgSSBrbm93LCBpdCB3YXMgYnJva2VuIGZvciBh
IGxvbmdlciB0aW1lIGJlZm9yZSkgYW5kIHRoZSBvbmx5IGNoYW5nZSB5ZXN0ZXJkYXkgd2FzIHRv
IHVwZ3JhZGUgZnJvbSB2YW5pbGxhIGtlcm5lbCAzLjEyLjEgdG8gMy4xMi4yIEknbSB3b25kZXJp
bmcgaWYgdGhlcmUncyBhICJzdXNwaWNvdXMiIGNvbW1pdCBpbiB0aGF0IHN0YWJsZSBrZXJuZWwg
d2hpY2ggY291bGQgYmUgdGhlIHJlYXNvbiA/CgoKRldJVyA6CnRmb2Vyc3RlQG4yMiB+ICQgZ2Ri
IC0tY29yZT0vbW50L3JhbWRpc2svY29yZSAvaG9tZS90Zm9lcnN0ZS9kZXZlbC9saW51eC9saW51
eCAtbiAtYmF0Y2ggLWV4IGJ0CltOZXcgTFdQIDI5NTU5XQpDb3JlIHdhcyBnZW5lcmF0ZWQgYnkg
YC9ob21lL3Rmb2Vyc3RlL2RldmVsL2xpbnV4L2xpbnV4IGVhcmx5cHJpbnRrIHViZGE9L2hvbWUv
dGZvZXJzdGUvdmlydHVhbC91bWwvdHInLgpQcm9ncmFtIHRlcm1pbmF0ZWQgd2l0aCBzaWduYWwg
MTEsIFNlZ21lbnRhdGlvbiBmYXVsdC4KIzAgIGZpbmlzaF90YXNrX3N3aXRjaCAocHJldj0weGZm
ZmY5ZDJmLCBycT08b3B0aW1pemVkIG91dD4pIGF0IGtlcm5lbC9zY2hlZC9jb3JlLmM6MTk5Mwox
OTkzICAgICAgICAgICAgcHJldl9zdGF0ZSA9IHByZXYtPnN0YXRlOwojMCAgZmluaXNoX3Rhc2tf
c3dpdGNoIChwcmV2PTB4ZmZmZjlkMmYsIHJxPTxvcHRpbWl6ZWQgb3V0PikgYXQga2VybmVsL3Nj
aGVkL2NvcmUuYzoxOTkzCiMxICAweDA4NDI3NDE4IGluIGNvbnRleHRfc3dpdGNoIChuZXh0PTxv
cHRpbWl6ZWQgb3V0PiwgcHJldj0weDQ2ZDllZWNjLCBycT08b3B0aW1pemVkIG91dD4pIGF0IGtl
cm5lbC9zY2hlZC9jb3JlLmM6MjEzMAojMiAgX19zY2hlZHVsZSAoKSBhdCBrZXJuZWwvc2NoZWQv
Y29yZS5jOjI1NjgKIzMgIDB4MDg0Mjc1MDUgaW4gc2NoZWR1bGUgKCkgYXQga2VybmVsL3NjaGVk
L2NvcmUuYzoyNjA0CiM0ICAweDA4MDhiOTEyIGluIHNpZ3N1c3BlbmQgKHNldD0weDQ2ZDllZWNj
KSBhdCBrZXJuZWwvc2lnbmFsLmM6MzU1OQojNSAgMHgwODA2NDZkOCBpbiB3aW5jaF90aHJlYWQg
KGFyZz0weDQ2ZDllZWNjKSBhdCBhcmNoL3VtL2RyaXZlcnMvY2hhbl91c2VyLmM6MjEwCiM2ICAw
eDA4M2RhMzhlIGluIGNsb25lICgpCgoKLS0gCk1mRy9TaW5jZXJlbHkKVG9yYWxmIEbDtnJzdGVy
CnBncCBmaW5nZXIgcHJpbnQ6IDdCMUEgMDdGNCBFQzgyIDBGOTAgRDRDMiA4OTM2IDg3MkEgRTUw
OCA3REI2IDlEQTMKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpSYXBpZGx5IHRyb3VibGVzaG9vdCBw
cm9ibGVtcyBiZWZvcmUgdGhleSBhZmZlY3QgeW91ciBidXNpbmVzcy4gTW9zdCBJVCAKb3JnYW5p
emF0aW9ucyBkb24ndCBoYXZlIGEgY2xlYXIgcGljdHVyZSBvZiBob3cgYXBwbGljYXRpb24gcGVy
Zm9ybWFuY2UgCmFmZmVjdHMgdGhlaXIgcmV2ZW51ZS4gV2l0aCBBcHBEeW5hbWljcywgeW91IGdl
dCAxMDAlIHZpc2liaWxpdHkgaW50byB5b3VyIApKYXZhLC5ORVQsICYgUEhQIGFwcGxpY2F0aW9u
LiBTdGFydCB5b3VyIDE1LWRheSBGUkVFIFRSSUFMIG9mIEFwcER5bmFtaWNzIFBybyEKaHR0cDov
L3B1YmFkcy5nLmRvdWJsZWNsaWNrLm5ldC9nYW1wYWQvY2xrP2lkPTg0MzQ5MzUxJml1PS80MTQw
L29zdGcuY2xrdHJrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

