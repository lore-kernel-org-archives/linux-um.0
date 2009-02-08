Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LW5ih-0005GY-5I
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Feb 2009 09:12:55 +0000
Received: from ti-out-0910.google.com ([209.85.142.191])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LW5ie-0002a6-TZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Feb 2009 09:12:55 +0000
Received: by ti-out-0910.google.com with SMTP id a6so1512840tib.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 08 Feb 2009 01:12:50 -0800 (PST)
Date: Sun, 8 Feb 2009 17:12:44 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090208091244.GB383@hack.private>
References: <dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
	<20090119152104.GC6432@c2.user-mode-linux.org>
	<dc84318c0901191746g31d51c23g65da89190dc8bfd2@mail.gmail.com>
	<49753063.8040007@hathawaymix.org>
	<alpine.LRH.2.00.0902041803360.7690@vixen.sonytel.be>
	<Pine.LNX.4.64.0902042115530.25136@anakin>
	<20090204204009.GA10680@suse.de>
	<Pine.LNX.4.64.0902042150550.25136@anakin>
	<20090207125956.110591c9@osiris.boeblingen.de.ibm.com>
	<20090208090642.GA383@hack.private>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090208090642.GA383@hack.private>
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
To: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Greg KH <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@ZenIV.linux.org.uk>, Rob Landley <rob@landley.net>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Andrew Morton <akpm@linux-foundation.org>, Shane Hathaway <shane@hathawaymix.org>, Daolong Wang <ahlongxp@gmail.com>, stable@kernel.org

T24gU3VuLCBGZWIgMDgsIDIwMDkgYXQgMDU6MDc6MTBQTSArMDgwMCwgQW3DqXJpY28gV2FuZyB3
cm90ZToKPgo+PiAJfQkJCQkJCQkJXAo+Pi0JU1lTQ0FMTF9BTElBUyhzeXNfIyNuYW1lLCBTeVNf
IyNuYW1lKTsJCQkJXAo+Pi0Jc3RhdGljIGlubGluZSBsb25nIFNZU0NfIyNuYW1lKF9fU0NfREVD
TCMjeChfX1ZBX0FSR1NfXykpCj4+KwlTWVNDQUxMX0FMSUFTKHN5cyMjbmFtZSwgU3lTIyNuYW1l
KTsJCQkJXAo+PisJc3RhdGljIGlubGluZSBsb25nIFNZU0MjI25hbWUoX19TQ19ERUNMIyN4KF9f
VkFfQVJHU19fKSkKPgo+U28geW91ciBmaW5hbCBhY3R1YWwgbmFtZSBmb3IgYSBzeXNjYWxsICdm
b28nIHdpbGwgYmUgJ3N5c2ZvbycKPmluc3RlYWQgb2YgJ3N5c19mb28nLCByaWdodD8KPgoKT29w
cywgSSBtaXNyZWFkIHRoZSBsZWFkaW5nIHVuZGVyc2NvcmUhIFNvcnJ5LgoKTG9va3MgZ29vZCB0
aGVuLAoKUmV2aWV3ZWQtYnk6IFdBTkcgQ29uZyA8d2FuZ2NvbmdAemV1dXgub3JnPgoKCi0tIAoi
QWdhaW5zdCBzdHVwaWRpdHksIHRoZSBnb2RzIHRoZW1zZWx2ZXMsIGNvbnRlbmQgaW4gdmFpbi4i
CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNyZWF0ZSBhbmQgRGVwbG95IFJpY2ggSW50ZXJuZXQg
QXBwcyBvdXRzaWRlIHRoZSBicm93c2VyIHdpdGggQWRvYmUoUilBSVIoVE0pCnNvZnR3YXJlLiBX
aXRoIEFkb2JlIEFJUiwgQWpheCBkZXZlbG9wZXJzIGNhbiB1c2UgZXhpc3Rpbmcgc2tpbGxzIGFu
ZCBjb2RlIHRvCmJ1aWxkIHJlc3BvbnNpdmUsIGhpZ2hseSBlbmdhZ2luZyBhcHBsaWNhdGlvbnMg
dGhhdCBjb21iaW5lIHRoZSBwb3dlciBvZiBsb2NhbApyZXNvdXJjZXMgYW5kIGRhdGEgd2l0aCB0
aGUgcmVhY2ggb2YgdGhlIHdlYi4gRG93bmxvYWQgdGhlIEFkb2JlIEFJUiBTREsgYW5kCkFqYXgg
ZG9jcyB0byBzdGFydCBidWlsZGluZyBhcHBsaWNhdGlvbnMgdG9kYXktaHR0cDovL3Auc2YubmV0
L3NmdS9hZG9iZS1jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=
