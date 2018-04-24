Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
 <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
 <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk>
 <87zi1sd28d.fsf@xmission.com>
 <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
 <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
Date: Tue, 24 Apr 2018 17:24:24 -0500
In-Reply-To: <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
 ("Martin \=\?utf-8\?Q\?P\=C3\=A4rtel\=22's\?\= message of "Wed,
 25 Apr 2018 01:03:39 +0300")
Message-ID: <87lgdc1bvr.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use
 force_sig_fault in relay_signal.
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Martin =?utf-8?Q?P=C3=A4rtel?= <martin.partel@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

TWFydGluIFDDpHJ0ZWwgPG1hcnRpbi5wYXJ0ZWxAZ21haWwuY29tPiB3cml0ZXM6Cgo+IEFuZCBv
bmNlIG1vcmUgaW4gcGxhaW4gdGV4dC4uCj4KPiBPbiAyNSBBcHJpbCAyMDE4IGF0IDAxOjAwLCBN
YXJ0aW4gUMOkcnRlbCA8bWFydGluLnBhcnRlbEBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBIaSBh
bGwsCj4+Cj4+IFRoaXMgd2FzIGFnZXMgYWdvLCBidXQgZnJvbSB3aGF0IEkgcmVtZW1iZXIuLi4K
Pj4KPj4+Cj4+PiBIYXZpbmcgYSBzZWNvbmQgbG9vayBJIHJlYWxseSBkb24ndCB1bmRlcnN0YW5k
IHdoYXQgcmVsYXlfc2lnbmFsIGlzCj4+PiB0cnlpbmcgdG8gZG8uCj4+Pgo+Pj4gVGhlIGZ1bmN0
aW9uIHJlbGF5X3NpZ25hbCBkb2VzIG5vdCBwYXNzIHNpZ2luZm8gdGhyb3VnaCB1bmNoYW5nZWQu
Cj4+Cj4+Cj4+IEp1c3QgY29weWluZyB0aGUgZW50aXJlIHN0cnVjdCB3b3VsZCBkbyB0aGUgd3Jv
bmcgdGhpbmcuIEl0IHdhcyBkaXNjdXNzZWQgaGVyZToKPj4gaHR0cHM6Ly9tYXJjLmluZm8vP2w9
dXNlci1tb2RlLWxpbnV4LWRldmVsJm09MTMzOTEwNzA3OTExOTk5Jnc9MgoKU28geW91IGFyZSBy
ZWduZXJhdGluZyBzaWdpbmZvIHRvIGVuc3VyZSB5b3UgZG9uJ3QgY29weSB1bmludGVuZGVkCnRo
aW5ncyBzdWNoIGFzIHRoZSBob3N0IHBpZCBhbmQgaG9zdCB1aWQuCgpUaGVuIG15IGFuYWx5c2lz
IGlzIGNvcnJlY3QgdGhhdCB5b3Ugc2ltcGx5IG1pc3NlZCBmaWx0ZXJpbmcgb3V0IHRoZQpzaSBj
b2RlcyB0aGF0IGFyZSBub3Qgc2lnbmFsIHNwZWNpZmljIGFuZCBkbyBub3QgdXNlIHRoZSBmYXVs
dCBsYXlvdXQKaW4gc3RydWN0IHNpZ2luZm8uCgpJcyBzaV9hZGRyIHNhZmUgdG8gY29weSBhY3Jv
c3M/ICBJIHByZXN1bWUgc28gc2luY2UgdGhlIGtlcm5lbCBqdXN0CnB0cmFjZXMgYW4gb3JkaW5h
cnkgcHJvY2VzcywgYnV0IEkgZmlndXJlIEkgc2hvdWxkIGFzayBhbmQgZG91YmxlCmNoZWNrLgoK
SSBhbSBnb2luZyB0byByZXNwaW4gbXkgcGF0Y2guICBJIHdvdWxkIHNheSB0aGF0IHlvdSByZWFs
bHkgbmVlZCBhCndoaXRlLWxpc3Qgb2Ygc2lfY29kZXMgdGhhdCB3aG9zZSB1c2Ugb2Ygc3RydWN0
IHNpZ2luZm8gdGhhdCB5b3Uga25vdy4KT3RoZXJ3aXNlIHlvdSBjb3VsZCBnZXQgaW50byB0aGUg
c2FtZSBwcm9ibGVtIG9mIHVuZGVyIG9yIG92ZXIgY29weWluZwpkYXRhLgoKRXJpYwoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0eSBvbiBv
bmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRvdC5vcmch
IGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXIt
bW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

