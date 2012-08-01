Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1SwiIS-0008Mz-1q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Aug 2012 23:25:44 +0000
Received: from meriadoc.sigma-star.at ([178.63.61.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SwiIQ-00017C-NY
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Aug 2012 23:25:44 +0000
Message-ID: <5019B30B.8010306@sigma-star.at>
Date: Thu, 02 Aug 2012 00:51:55 +0200
From: Richard Weinberger <richard@sigma-star.at>
MIME-Version: 1.0
References: <50179725.9cO+m/nAt3rcNdV1%vleclement@gmail.com>
In-Reply-To: <50179725.9cO+m/nAt3rcNdV1%vleclement@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] um: fix missing include with glibc 2.16
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?= <vleclement@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

T24gMzEuMDcuMjAxMiAxMDoyOCwgVmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcSB3
cm90ZToKPiBGcm9tOiBWaWFubmV5IGxlIENsw6ltZW50IGRlIFNhaW50LU1hcmNxIDx2bGVjbGVt
ZW50QGdtYWlsLmNvbT4KPgo+IEFzIG9mIGdsaWJjIDIuMTYsIHN5cy93YWl0LmggZG9lcyBubyBs
b25nZXIgaW5jbHVkZSBzeXMvcmVzb3VyY2UuaCwKPiB3aGljaCBpcyBuZWVkZWQgZm9yIGdldHJs
aW1pdCgpLiBUaGlzIHBhdGNoIGZpeGVzIGNvbXBpbGluZyBVTUwgd2l0aAo+IGdsaWJjIDIuMTYu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBWaWFubmV5IGxlIENsw6ltZW50IGRlIFNhaW50LU1hcmNxIDx2
bGVjbGVtZW50QGdtYWlsLmNvbT4KClNvcnJ5LCBJIGNhbm5vdCBhcHBseSB0aGlzIHBhdGNoLgpJ
dCdzIGJhc2U2NCBlbmNvZGVkLgoKQ2FuIHlvdSBwbGVhc2Ugc2VuZCBpdCB1c2luZyBnaXQ/CgpU
aGFua3MsCi8vcmljaGFyZAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMaXZlIFNlY3VyaXR5IFZp
cnR1YWwgQ29uZmVyZW5jZQpFeGNsdXNpdmUgbGl2ZSBldmVudCB3aWxsIGNvdmVyIGFsbCB0aGUg
d2F5cyB0b2RheSdzIHNlY3VyaXR5IGFuZCAKdGhyZWF0IGxhbmRzY2FwZSBoYXMgY2hhbmdlZCBh
bmQgaG93IElUIG1hbmFnZXJzIGNhbiByZXNwb25kLiBEaXNjdXNzaW9ucyAKd2lsbCBpbmNsdWRl
IGVuZHBvaW50IHNlY3VyaXR5LCBtb2JpbGUgc2VjdXJpdHkgYW5kIHRoZSBsYXRlc3QgaW4gbWFs
d2FyZSAKdGhyZWF0cy4gaHR0cDovL3d3dy5hY2NlbGFjb21tLmNvbS9qYXcvc2ZybmwwNDI0MjAx
Mi8xMTQvNTAxMjIyNjMvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

