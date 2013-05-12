Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1UbYUV-0004vx-V4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 15:47:15 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UbYUT-0004SF-Px for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 15:47:15 +0000
Received: from mailout-de.gmx.net ([10.1.76.34]) by mrigmx.server.lan
	(mrigmx001) with ESMTP (Nemesis) id 0MWvJi-1V5H4a0XWm-00W0b2 for
	<user-mode-linux-devel@lists.sourceforge.net>; Sun, 12 May 2013 17:47:08
	+0200
Message-ID: <518FB97A.5070907@gmx.de>
Date: Sun, 12 May 2013 17:47:06 +0200
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
Subject: [uml-devel] WARNING: at mm/mmap.c:2757 exit_mmap+0x161/0x170()
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

V2l0aCByZWNlbnQgaG9zdCBhbmQgZ3Vlc3Qga2VybmVsIHRyaW5pdHkgb2Z0ZW4gdHJpZ2dlcnMg
dGhhdCB3YXJuaW5nCndoaWNoIHJlZmVycyB0byB0aGlzIGxpbmUKCldBUk5fT04obW0tPm5yX3B0
ZXMgPiAoRklSU1RfVVNFUl9BRERSRVNTK1BNRF9TSVpFLTEpPj5QTURfU0hJRlQpOwoKL21lIHdv
bmRlcnMgaWYgKGFuZCBob3cpIEkgY2FuIGhlbHAgdG8gaWRlbnRpZnkgdGhlIHJvb3QgY2F1c2Ug
KGlmIGl0IGlzCm5vdCBhbHJlYWR5IGtub3duKS4KCgotLSAKTWZHL1NpbmNlcmVseQpUb3JhbGYg
RsO2cnN0ZXIKcGdwIGZpbmdlciBwcmludDogN0IxQSAwN0Y0IEVDODIgMEY5MCBENEMyIDg5MzYg
ODcyQSBFNTA4IDdEQjYgOURBMwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxlYXJuIEdyYXBoIERh
dGFiYXNlcyAtIERvd25sb2FkIEZSRUUgTydSZWlsbHkgQm9vawoiR3JhcGggRGF0YWJhc2VzIiBp
cyB0aGUgZGVmaW5pdGl2ZSBuZXcgZ3VpZGUgdG8gZ3JhcGggZGF0YWJhc2VzIGFuZCAKdGhlaXIg
YXBwbGljYXRpb25zLiBUaGlzIDIwMC1wYWdlIGJvb2sgaXMgd3JpdHRlbiBieSB0aHJlZSBhY2Ns
YWltZWQgCmxlYWRlcnMgaW4gdGhlIGZpZWxkLiBUaGUgZWFybHkgYWNjZXNzIHZlcnNpb24gaXMg
YXZhaWxhYmxlIG5vdy4gCkRvd25sb2FkIHlvdXIgZnJlZSBib29rIHRvZGF5ISBodHRwOi8vcC5z
Zi5uZXQvc2Z1L25lb3RlY2hfZDJkX21heQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXIt
bW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

