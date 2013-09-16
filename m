Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1VLf2j-0007ru-Or
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Sep 2013 20:05:09 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1VLf2i-0000Qr-Jr
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Sep 2013 20:05:09 +0000
Received: from [92.224.120.219] ([92.224.120.219]) by mail.gmx.com (mrgmx001)
	with ESMTPSA (Nemesis) id 0LzblK-1VylKR3346-014kWZ for
	<user-mode-linux-devel@lists.sourceforge.net>; Mon, 16 Sep 2013 22:05:01
	+0200
Message-ID: <52376466.2040601@gmx.de>
Date: Mon, 16 Sep 2013 22:04:54 +0200
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
Subject: [uml-devel] difference of a shell script versus command line WRT
 "winch_thread : TIOCSCTTY failed on fd 1 err = 1"
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

SWYgSSBydW4gdGhlIGZvbGxvd2luZyBzY3JpcHQKCiQ+IGNhdCBsLnNoCiMhL2Jpbi9zaAojCgov
dXNyL2xvY2FsL2Jpbi9saW51eC12My4xMS04NzE4LWcwZmI1Y2ExIGVhcmx5cHJpbnRrIHViZGE9
L2hvbWUvdGZvZXJzdGUvdmlydHVhbC91bWwvbjIydW5zdDQgdWJkYj0vbW50L3JhbWRpc2svbjIy
dW5zdDRfc3dhcCBldGgwPXR1bnRhcCx0YXAyLDcyOmVmOjNkOjVkOmQzOmRiIG1lbT0xMDI1TSBj
b24wPWZkOjAsZmQ6MSBjb249cHRzIHVtaWQ9dW1sX24yMnVuc3Q0IHJvb3Rmc3R5cGU9ZXh0NAoK
CnRoZW4gZHVyaW5nIHN0YXJ0IG9mIHRoZSBVTUwgSSBnZXQKCi4uLgpOZXRkZXZpY2UgMCAoNzI6
ZWY6M2Q6NWQ6ZDM6ZGIpIDoKVFVOL1RBUCBiYWNrZW5kIC0Kd2luY2hfdGhyZWFkIDogVElPQ1ND
VFRZIGZhaWxlZCBvbiBmZCAxIGVyciA9IDEKRVhUNC1mcyAodWJkYSk6IG1vdW50ZWQgZmlsZXN5
c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLiBPcHRzOiAobnVsbCkKLi4uCgoKd2hlcmVhcyB0
aGUgY29tbWFuZCAtIGlmIGRpcmVjdGx5IHJ1biBpbiB0aGUgdGVybWluYWwgLSBkb24ndCBzaG93
IHRoYXQgbGluZS4KTm93IEknbSB3b25kZXJpbmcgd2hhdCBtYWtlcyB0aGUgZGlmZmVyZW5jZSBh
bmQgd2hhdCdzIHRoZSBjb3JyZWN0IHdheSB0byBzdGFydCBhbiBVTUwuCgoKLS0gCk1mRy9TaW5j
ZXJlbHkKVG9yYWxmIEbDtnJzdGVyCnBncCBmaW5nZXIgcHJpbnQ6IDdCMUEgMDdGNCBFQzgyIDBG
OTAgRDRDMiA4OTM2IDg3MkEgRTUwOCA3REI2IDlEQTMKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpM
SU1JVEVEIFRJTUUgU0FMRSAtIEZ1bGwgWWVhciBvZiBNaWNyb3NvZnQgVHJhaW5pbmcgRm9yIEp1
c3QgJDQ5Ljk5IQoxLDUwMCsgaG91cnMgb2YgdHV0b3JpYWxzIGluY2x1ZGluZyBWaXN1YWxTdHVk
aW8gMjAxMiwgV2luZG93cyA4LCBTaGFyZVBvaW50CjIwMTMsIFNRTCAyMDEyLCBNVkMgNCwgbW9y
ZS4gQkVTVCBWQUxVRTogTmV3IE11bHRpLUxpYnJhcnkgUG93ZXIgUGFjayBpbmNsdWRlcwpNb2Jp
bGUsIENsb3VkLCBKYXZhLCBhbmQgVVggRGVzaWduLiBMb3dlc3QgcHJpY2UgZXZlciEgRW5kcyA5
LzIwLzEzLiAKaHR0cDovL3B1YmFkcy5nLmRvdWJsZWNsaWNrLm5ldC9nYW1wYWQvY2xrP2lkPTU4
MDQxMTUxJml1PS80MTQwL29zdGcuY2xrdHJrCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNl
ci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

