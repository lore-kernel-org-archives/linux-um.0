Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AooyP-0001oG-N2
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 11:15:37 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AooyM-000628-8b
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 11:15:34 -0800
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <20040205183624.GA5236@elte.hu>
Message-ID: <Pine.LNX.4.58.0402051911250.17214@vega.dur.ac.uk>
References: <20040119082805.GA4412@elte.hu> <Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk>
 <20040120002301.GA5708@elte.hu> <Pine.LNX.4.58.0401232125410.8188@vega.dur.ac.uk>
 <Pine.GSO.4.58.0401232342360.24271@altair.dur.ac.uk>
 <Pine.LNX.4.58.0401241215200.21419@vega.dur.ac.uk>
 <200401241820.i0OIKHY3002399@ccure.user-mode-linux.org>
 <Pine.LNX.4.58.0401241923510.27438@vega.dur.ac.uk> <20040205123057.GA23555@elte.hu>
 <Pine.GSO.4.58.0402051236350.5177@algedi.dur.ac.uk> <20040205183624.GA5236@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-360593916-1221359340-1076008522=:17214"
Subject: [uml-devel] Re: tt mode tls/glibc crash with 2.6 (Was: Re: uml-patch-2.6.0)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 5 Feb 2004 19:15:22 +0000 (GMT)
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---360593916-1221359340-1076008522=:17214
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 5 Feb 2004, Ingo Molnar wrote:

> mind sending the archparam-i386.h diff you have? I commented out the
> creation of the two vsyscall auxiliary entries in ARCH_DLINFO - is that
> enough?

This is the patch I think we agreed was the way to fix it.

	Michael Young
---360593916-1221359340-1076008522=:17214
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ttglibc.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="ttglibc.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjYuMS9pbmNsdWRlL2FzbS11bS9hcmNocGFy
YW0taTM4Ni5oLm9yaWcgbGludXgtMi42LjEvaW5jbHVkZS9hc20tdW0vYXJj
aHBhcmFtLWkzODYuaA0KLS0tIGxpbnV4LTIuNi4xL2luY2x1ZGUvYXNtLXVt
L2FyY2hwYXJhbS1pMzg2Lmgub3JpZwkyMDA0LTAyLTA1IDE5OjAzOjQ1LjAw
MDAwMDAwMCArMDAwMA0KKysrIGxpbnV4LTIuNi4xL2luY2x1ZGUvYXNtLXVt
L2FyY2hwYXJhbS1pMzg2LmgJMjAwNC0wMS0zMSAxOTowMTo1MS4wMDAwMDAw
MDAgKzAwMDANCkBAIC01Niw3ICs1Niw4IEBADQogCXByX3JlZ1sxNl0gPSBQ
VF9SRUdTX1NTKHJlZ3MpOwkJXA0KIH0gd2hpbGUoMCk7DQogDQotI2RlZmlu
ZSBWU1lTQ0FMTF9CQVNFCShfX2ZpeF90b192aXJ0KEZJWF9WU1lTQ0FMTCkp
DQorLyojZGVmaW5lIFZTWVNDQUxMX0JBU0UJKF9fZml4X3RvX3ZpcnQoRklY
X1ZTWVNDQUxMKSkqLw0KKyNkZWZpbmUgVlNZU0NBTExfQkFTRQlOVUxMDQog
I2RlZmluZSBWU1lTQ0FMTF9FSERSCSgoY29uc3Qgc3RydWN0IGVsZmhkciAq
KSBWU1lTQ0FMTF9CQVNFKQ0KICNkZWZpbmUgVlNZU0NBTExfRU5UUlkJKCh1
bnNpZ25lZCBsb25nKSAmX19rZXJuZWxfdnN5c2NhbGwpDQogZXh0ZXJuIHZv
aWQgKl9fa2VybmVsX3ZzeXNjYWxsOw0K

---360593916-1221359340-1076008522=:17214--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
