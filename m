Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AK2im-00063p-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 12 Nov 2003 13:40:16 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AK2im-0007Bl-3E
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 12 Nov 2003 13:40:16 -0800
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <Pine.GSO.4.58.0311120922330.5371@algedi.dur.ac.uk>
Message-ID: <Pine.GSO.4.58.0311122133370.3936@altair.dur.ac.uk>
References: <Pine.GSO.4.53.0309102139120.9641@altair.dur.ac.uk>
 <Pine.GSO.4.53.0309122031300.4368@altair.dur.ac.uk> 
 <Pine.GSO.4.53.0309161720480.4325@algedi.dur.ac.uk> 
 <200309172018.h8HKIjNu020871@ccure.karaya.com> <Pine.GSO.4.58.0311120922330.5371@algedi.dur.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1068673202=:3936"
Subject: [uml-devel] Re: uml segfaults on fedora core 1 (was redhat beta "severn")
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 12 Nov 2003 21:40:02 +0000 (GMT)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1068673202=:3936
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 12 Nov 2003, M A Young wrote:

> On Wed, 17 Sep 2003, Jeff Dike wrote:
>
> > m.a.young@durham.ac.uk said:
> > > The exec-shield code appears to have been modified in the latest
> > > redhat beta kernel with the result that uml kernels no longer crash -
> > > presumably the memory allocations aren't stirred up quite so much.
> > > Hence patching this problem may now be unnecessary.
> >
> > Excellent.  I looked at mingo's original description briefly, and didn't see
> > anything which would obviously break UML.
>
> I think these are back, my current theory is that you see this if you
> build your kernel on fedora core (ie. with exec-shield aware gcc). I will
> investigate further, and recheck my test patch, but I think the workaround
> echo 0 >/proc/sys/kernel/exec-shield-randomize
> on the host kernel should avoid the problem for the moment.

The attached patch seems to fix the problem (briefly the problem is that
the randomize function splits the executable and data areas, and before
you were acting on the gap, which with randomize turned on is
unallocated). The patch should work against 2.4 or 2.6.

	Michael Young
---559023410-1804928587-1068673202=:3936
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fedoraseg.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="fedoraseg.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjQuMjIvYXJjaC91bS9rZXJuZWwvdHQvbWVt
LmMub3JpZyBsaW51eC0yLjQuMjIvYXJjaC91bS9rZXJuZWwvdHQvbWVtLmMN
Ci0tLSBsaW51eC0yLjQuMjIvYXJjaC91bS9rZXJuZWwvdHQvbWVtLmMub3Jp
ZwkyMDAzLTExLTExIDIxOjUyOjMwLjAwMDAwMDAwMCArMDAwMA0KKysrIGxp
bnV4LTIuNC4yMi9hcmNoL3VtL2tlcm5lbC90dC9tZW0uYwkyMDAzLTExLTEy
IDIwOjA2OjM3LjAwMDAwMDAwMCArMDAwMA0KQEAgLTE4LDcgKzE4LDcgQEAN
CiAJaWYoIWphaWwgfHwgZGVidWcpDQogCQlyZW1hcF9kYXRhKFVNTF9ST1VO
RF9ET1dOKCZfc3RleHQpLCBVTUxfUk9VTkRfVVAoJl9ldGV4dCksIDEpOw0K
IAlyZW1hcF9kYXRhKFVNTF9ST1VORF9ET1dOKCZfc2RhdGEpLCBVTUxfUk9V
TkRfVVAoJl9lZGF0YSksIDEpOw0KLQlyZW1hcF9kYXRhKFVNTF9ST1VORF9E
T1dOKCZfX2Jzc19zdGFydCksIFVNTF9ST1VORF9VUChicmtfc3RhcnQpLCAx
KTsNCisJcmVtYXBfZGF0YShVTUxfUk9VTkRfRE9XTigmX19ic3Nfc3RhcnQp
LCBVTUxfUk9VTkRfVVAoJl9lbmQpLCAxKTsNCiB9DQogDQogI2lmZGVmIENP
TkZJR19IT1NUXzJHXzJHDQpkaWZmIC1OYXVyIGxpbnV4LTIuNC4yMi9hcmNo
L3VtL2tlcm5lbC90dC9wcm9jZXNzX2tlcm4uYy5vcmlnIGxpbnV4LTIuNC4y
Mi9hcmNoL3VtL2tlcm5lbC90dC9wcm9jZXNzX2tlcm4uYw0KLS0tIGxpbnV4
LTIuNC4yMi9hcmNoL3VtL2tlcm5lbC90dC9wcm9jZXNzX2tlcm4uYy5vcmln
CTIwMDMtMTEtMTEgMjE6NTI6MzAuMDAwMDAwMDAwICswMDAwDQorKysgbGlu
dXgtMi40LjIyL2FyY2gvdW0va2VybmVsL3R0L3Byb2Nlc3Nfa2Vybi5jCTIw
MDMtMTEtMTIgMjA6MDc6NDYuMDAwMDAwMDAwICswMDAwDQpAQCAtNDA1LDcg
KzQwNSw3IEBADQogCXByb3RlY3RfbWVtb3J5KHN0YXJ0LCBlbmQgLSBzdGFy
dCwgMSwgdywgMSwgMSk7DQogDQogCXN0YXJ0ID0gKHVuc2lnbmVkIGxvbmcp
IFVNTF9ST1VORF9ET1dOKCZfX2Jzc19zdGFydCk7DQotCWVuZCA9ICh1bnNp
Z25lZCBsb25nKSBVTUxfUk9VTkRfVVAoYnJrX3N0YXJ0KTsNCisJZW5kID0g
KHVuc2lnbmVkIGxvbmcpIFVNTF9ST1VORF9VUCgmX2VuZCk7DQogCXByb3Rl
Y3RfbWVtb3J5KHN0YXJ0LCBlbmQgLSBzdGFydCwgMSwgdywgMSwgMSk7DQog
DQogCW1wcm90ZWN0X2tlcm5lbF92bSh3KTsNCg==

---559023410-1804928587-1068673202=:3936--


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
