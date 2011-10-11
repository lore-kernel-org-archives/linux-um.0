Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1RDcQ1-0007OU-35
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Oct 2011 13:30:53 +0000
Received: from mailout-de.gmx.net ([213.165.64.22])
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1RDcPv-00062O-7Y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Oct 2011 13:30:53 +0000
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Date: Tue, 11 Oct 2011 15:30:38 +0200
MIME-Version: 1.0
Message-Id: <201110111530.39765.toralf.foerster@gmx.de>
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
Subject: [uml-devel] huh, entered softirq 1 TIMER
To: user-mode-linux-devel@lists.sourceforge.net

V2l0aCB2My4xLXJjOS02NC1nNjUxMTJkYyBhcyBob3N0IGFuZCBndWVzdCBvcGVyYXRpbmcgc3lz
dGVtIEkgcnVuIG9mdGVuIGludG8gdGhpcyA6CgouLi4KbmZzNGZpbGVsYXlvdXRfaW5pdDogTkZT
djQgRmlsZSBMYXlvdXQgRHJpdmVyIFJlZ2lzdGVyaW5nLi4uCkluc3RhbGxpbmcga25mc2QgKGNv
cHlyaWdodCAoQykgMTk5NiBva2lyQG1vbmFkLnN3Yi5kZSkuClN3aXRjaGVkIHRvIE5PSHogbW9k
ZSBvbiBDUFUgIzAKaHVoLCBlbnRlcmVkIHNvZnRpcnEgMSBUSU1FUiAwODA5MGRkMCBwcmVlbXB0
X2NvdW50IDAwMDAwMTAxLCBleGl0ZWQgd2l0aCAwODM1MWFjNT8KCm9yCgouLi4KTkVUOiBSZWdp
c3RlcmVkIHByb3RvY29sIGZhbWlseSAxNwpSZWdpc3RlcmluZyB0aGUgZG5zX3Jlc29sdmVyIGtl
eSB0eXBlClN3aXRjaGVkIHRvIE5PSHogbW9kZSBvbiBDUFUgIzAKaHVoLCBlbnRlcmVkIHNvZnRp
cnEgMSBUSU1FUiAwODA5MDExMCBwcmVlbXB0X2NvdW50IDAwMDAwMTAwLCBleGl0ZWQgd2l0aCAw
ODM0ZmFkMj8KCm9yCgouLi4KQ2hlY2tpbmcgaG9zdCBNQURWX1JFTU9WRSBzdXBwb3J0Li4uT0sK
VU1MIEF1ZGlvIFJlbGF5IChob3N0IGRzcCA9IC9kZXYvc291bmQvZHNwLCBob3N0IG1peGVyID0g
L2Rldi9zb3VuZC9taXhlcikKU3dpdGNoZWQgdG8gTk9IeiBtb2RlIG9uIENQVSAjMApodWgsIGVu
dGVyZWQgc29mdGlycSAxIFRJTUVSIDA4MDkwZGQwIHByZWVtcHRfY291bnQgMDAwMDAxMDAsIGV4
aXRlZCB3aXRoIDA4MzUxYWM1PwoKQWZ0ZXIgdGhhdCBvbmUgb2YgbXkgQ1BVIGNvcmVzIGlzIGF0
IDEwMCUgYW5kIG5vdGhpbmcgbW9yZSBoYXBwZW5zIC4uLgoKQSBDdHJsLUMgZ2l2ZXMgOgoKaHVo
LCBlbnRlcmVkIHNvZnRpcnEgMSBUSU1FUiAwODA5MGRkMCBwcmVlbXB0X2NvdW50IDAwMDAwMTAw
LCBleGl0ZWQgd2l0aCAwODM1MWFjNT8KXkMqKiogZ2xpYmMgZGV0ZWN0ZWQgKioqIC91c3IvbG9j
YWwvYmluL2xpbnV4LXYzLjEtcmM5LTY0LWc2NTExMmRjOiBkb3VibGUgZnJlZSBvciBjb3JydXB0
aW9uICh0b3ApOiAweDA5NzE1NmYwICoqKgoKCi0tIApNZkcvU2luY2VyZWx5ClRvcmFsZiBGw7Zy
c3RlcgpwZ3AgZmluZ2VyIHByaW50OiA3QjFBIDA3RjQgRUM4MiAwRjkwIEQ0QzIgODkzNiA4NzJB
IEU1MDggN0RCNiA5REEzCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQWxsIHRoZSBkYXRhIGNvbnRp
bnVvdXNseSBnZW5lcmF0ZWQgaW4geW91ciBJVCBpbmZyYXN0cnVjdHVyZSBjb250YWlucyBhCmRl
ZmluaXRpdmUgcmVjb3JkIG9mIGN1c3RvbWVycywgYXBwbGljYXRpb24gcGVyZm9ybWFuY2UsIHNl
Y3VyaXR5CnRocmVhdHMsIGZyYXVkdWxlbnQgYWN0aXZpdHkgYW5kIG1vcmUuIFNwbHVuayB0YWtl
cyB0aGlzIGRhdGEgYW5kIG1ha2VzCnNlbnNlIG9mIGl0LiBCdXNpbmVzcyBzZW5zZS4gSVQgc2Vu
c2UuIENvbW1vbiBzZW5zZS4KaHR0cDovL3Auc2YubmV0L3NmdS9zcGx1bmstZDJkLW9jdApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGlu
dXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNl
ci1tb2RlLWxpbnV4LWRldmVsCg==

