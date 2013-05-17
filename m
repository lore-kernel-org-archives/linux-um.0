Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1UdMFw-0002gI-Ke
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 May 2013 15:07:40 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UdMFt-00087u-Pa for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 May 2013 15:07:40 +0000
Date: Fri, 17 May 2013 16:50:55 +0200 (CEST)
From: "Richard RW. Weinberger" <richard@sigma-star.at>
Message-ID: <191613158.65052.1368802255386.JavaMail.root@sigma-star.at>
In-Reply-To: <51963E98.2030108@gmx.de>
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
Subject: Re: [uml-devel] WARNING: at mm/mmap.c:2757 exit_mmap+0x161/0x170()
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, trinity@vger.kernel.org

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IE9uIDA1LzE3LzIwMTMgMDI6MjIgUE0s
IHJpY2hhcmQgLXJ3LSB3ZWluYmVyZ2VyIHdyb3RlOgo+ID4gVG9yYWxmLCBjYW4geW91IHBsZWFz
ZSBhcHBlbmQgdGhlIGF0dGFjaGVkIHBhdGNoIHRvbz8KPiA+IEl0IG1ha2VzIHByb2Nlc3NlcyBr
aWxsYWJsZSB3aGljaCBjb3JydXB0ZWQgdGhlaXIgc3R1YiBwYWdlcy4KPiB5ZXMgLSBub3cgSSBj
YW4gcnVuIGFuIHRyaW5pdHkgaW5maW5pdGUgd2l0aCB0aGUgc3lzY2FsbCBtcmVtYXAoKS4KPiAK
PiBJIHN0aWxsIGdldCBmb3IgZXZlcnkgeC10aCB0aGUgc3lzbG9nIHNlZW4gYmVsb3csIGJ1dCBw
cm9jZXNzZXMgYXJlCj4gbm93IGtpbGxhYmxlIChhbmQgdHJpbml0eSBpdHNlbGYgY2FuIGtpbGwg
aXRzIGNoaWxkcyB0b28gc28gZmFyKQoKVGhhdCdzIHBlcmZlY3RseSBmaW5lLgoKVGhhbmtzLAov
L3JpY2hhcmQKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBbGllblZhdWx0IFVuaWZpZWQgU2VjdXJp
dHkgTWFuYWdlbWVudCAoVVNNKSBwbGF0Zm9ybSBkZWxpdmVycyBjb21wbGV0ZQpzZWN1cml0eSB2
aXNpYmlsaXR5IHdpdGggdGhlIGVzc2VudGlhbCBzZWN1cml0eSBjYXBhYmlsaXRpZXMuIEVhc2ls
eSBhbmQKZWZmaWNpZW50bHkgY29uZmlndXJlLCBtYW5hZ2UsIGFuZCBvcGVyYXRlIGFsbCBvZiB5
b3VyIHNlY3VyaXR5IGNvbnRyb2xzCmZyb20gYSBzaW5nbGUgY29uc29sZSBhbmQgb25lIHVuaWZp
ZWQgZnJhbWV3b3JrLiBEb3dubG9hZCBhIGZyZWUgdHJpYWwuCmh0dHA6Ly9wLnNmLm5ldC9zZnUv
YWxpZW52YXVsdF9kMmQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

