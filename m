Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IN9aT-00053R-Ci for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2007 08:54:42 -0700
Received: from apollo.fprintf.net ([208.75.87.34])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IN9aQ-0006MJ-Vp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2007 08:54:41 -0700
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <20070820141102.GA5833@c2.user-mode-linux.org>
References: <200708191142.57281.toralf.foerster@gmx.de>
	<20070819155746.GA5896@c2.user-mode-linux.org>
	<200708191812.35947.toralf.foerster@gmx.de>
	<20070820141102.GA5833@c2.user-mode-linux.org>
Date: Mon, 20 Aug 2007 11:55:22 -0400
Message-Id: <1187625322.28647.171.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] build error of an UML kernel with 2.6.2x sources
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, user-mode-linux-devel@lists.sourceforge.net

Ck9uIE1vbiwgMjAwNy0wOC0yMCBhdCAxMDoxMSAtMDQwMCwgSmVmZiBEaWtlIHdyb3RlOgo+IE9u
IFN1biwgQXVnIDE5LCAyMDA3IGF0IDA2OjEyOjMzUE0gKzAyMDAsIFRvcmFsZiBGw7Zyc3RlciB3
cm90ZToKPiA+IEkgZm91bmQgYSBkZWZpbml0aW9uIG9mIGVsZl9mcHJlZ3NldF90IHdpdGhpbiBp
bmNsdWNlIGZpbGVzIGZyb20gdGhlIGdsaWJjCj4gPiBwYWNrYWdlOgo+ID4gCj4gPiB0Zm9lcnN0
ZUBuMjIgL3Vzci9pbmNsdWRlICQgZ3JlcCAtSGlyIHVzZXJfaTM4N19zdHJ1Y3QgKgo+ID4gCj4g
PiB0Zm9lcnN0ZUBuMjIgL3Vzci9pbmNsdWRlICQgZ3JlcCAtSGlyIGVsZl9mcHJlZ3NldF90ICoK
PiA+IHN5cy9wcm9jZnMuaDp0eXBlZGVmIHN0cnVjdCB1c2VyX2ZwcmVnc19zdHJ1Y3QgZWxmX2Zw
cmVnc2V0X3Q7Cj4gPiBzeXMvcHJvY2ZzLmg6dHlwZWRlZiBlbGZfZnByZWdzZXRfdCBwcmZwcmVn
c2V0X3Q7Cj4gCj4gVGhpcyBkb2Vzbid0IGhlbHAgc28gZmFyIC0geW91IG5vdyBuZWVkIHRvIGZp
bmQgYSBkZWZpbml0aW9uIG9mIHN0cnVjdAo+IHVzZXJfZnByZWdzX3N0cnVjdC4KPiAKPiAJCQkJ
SmVmZgo+IAoKSXRzIGluIDxzeXMvdXNlci5oPiBoZXJlLiAgSSBoYXZlIGxpbnV4LWhlYWRlcnMt
Mi42LjIyLXIyLgoKRGFuaWVsCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBp
cyBzcG9uc29yZWQgYnk6IFNwbHVuayBJbmMuClN0aWxsIGdyZXBwaW5nIHRocm91Z2ggbG9nIGZp
bGVzIHRvIGZpbmQgcHJvYmxlbXM/ICBTdG9wLgpOb3cgU2VhcmNoIGxvZyBldmVudHMgYW5kIGNv
bmZpZ3VyYXRpb24gZmlsZXMgdXNpbmcgQUpBWCBhbmQgYSBicm93c2VyLgpEb3dubG9hZCB5b3Vy
IEZSRUUgY29weSBvZiBTcGx1bmsgbm93ID4+ICBodHRwOi8vZ2V0LnNwbHVuay5jb20vCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51
eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2Vy
LW1vZGUtbGludXgtZGV2ZWwK
