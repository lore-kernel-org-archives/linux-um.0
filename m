Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQVdJ-00059j-Hd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 11:17:37 -0700
Received: from smtp5.wanadoo.fr ([193.252.22.26] helo=mwinf0501.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BQVdI-0007Em-Qq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 11:17:36 -0700
Subject: Re: [uml-devel] [PATCH] host context switch reduction
From: Laurent Vivier <LaurentVivier@wanadoo.fr>
In-Reply-To: <012201c43dcb$402ca6a0$2000000a@schlepptopp>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
	<012201c43dcb$402ca6a0$2000000a@schlepptopp>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-GcmNCCK7luaKI6sKOoxL"
Message-Id: <1084990661.2255.28.camel@chartreuse>
Mime-Version: 1.0
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 19 May 2004 20:17:43 +0200
To: roland <for_spam@gmx.de>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net



--=-GcmNCCK7luaKI6sKOoxL
Content-Type: multipart/mixed; boundary="=-yIjM7ZbDS5Cim7OPA2mo"



--=-yIjM7ZbDS5Cim7OPA2mo
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Le mer 19/05/2004 =E0 20:01, roland a =E9crit :
> Hi Laurent !
> Great!
> Thanks a lot for your work :)
>=20
> but i have a question:
>=20
> old mail from jeff:
> >The patches below are from Laurent Vivier who didn't make them public.  =
They
> >add a new feature to ptrace on the host which cuts down on the number of
> >context switches needed for a UML system call, plus makes UML use it
>=20
> so - if your patch adds a new feature for ptrace on the HOST - shouldn`t =
we need TWO patches for 2.6 ?
> One patch for uml and one patch for the host ?
>=20
> this one seems for uml only.
> some of us already run uml 2.6(.x) on a 2.6.(.x) host and put their focus=
 on the "new kernel" (me too).

OK, as I didn't find skas patch for 2.6 I thought it didn't exist...
anyway I tried to port the 2.4 host sysemu patch to 2.6, find it
attached. I never tested it, or compiled it ! I have no system with 2.6
kernel, and the only I386 system I have is very, very, very noisy...
it's a good system only when it is switched off ;-) !

> regards
> roland
>=20
> ps:
> since this would be the 2nd patch for the HOST (besides skas), would it m=
ake sense, to merge "skas" and "sysemu" into one common
> HOST-patch (if it has been tested and approved stable) ?
>=20

YES, I think... but Jeff is the boss ;-)

>=20
>=20
> ----- Original Message -----=20
> From: "Laurent Vivier" <LaurentVivier@wanadoo.fr>
> To: "Jeff Dike" <jdike@addtoit.com>
> Cc: "roland" <for_spam@gmx.de>; <user-mode-linux-devel@lists.sourceforge.=
net>
> Sent: Wednesday, May 19, 2004 7:27 PM
> Subject: Re: [uml-devel] [PATCH] host context switch reduction
>=20
>=20
> Hi,
>=20
> as it is a plebiscite ;-), find attached the patch for UML 2.6.6 and
> measurements I made on my poor netserver.
>=20
> Laurent
>=20
> Le mar 18/05/2004 =E0 19:59, Jeff Dike a =E9crit :
> > On Tue, May 18, 2004 at 12:22:45AM +0200, roland wrote:
> > > the question is:
> > > is the "real world" performance benefit, uml get`s from this patch wo=
rth taking your time and is it implemented in a way, so
> that
> > > uml maintainers are happy with that ?
> >
> > The patch seems reasonable to me.  I'd be happiest with Laurent pushing=
 this
> > into mainline himself.
> >
> > > i cannot really estimate, what performance benefits your patch brings=
 to uml in detail, but what i have seen so far, this seems
> > > quite worth doing the work.  reducing context switches by 1/3 is a LO=
T, imho - and reducing the execution time of the
> getpid-loop to
> > > nearly the half is quite impressive.
> >
> > Yeah, but no real workloads do while(1) getpid();
> >
> > The kernel build improvement is obviously smaller, but still worth havi=
ng.
> >
> > > are there any "con`s" that argue for that work _NOT_ being done ?
> >
> > No.  But testing, and happy reports to the appropriate mailing lists wo=
uld
> > help.
> >
> > Jeff
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-------
>=20
>=20
> > HP Netserver LH Pro bi-pro 200 MHz / 256 MB RAM
> >
> > NATIF:
> >
> > netserver:/usr/src# uname -a
> > Linux netserver 2.4.24-sysemu #4 SMP Tue Feb 17 16:43:11 CET 2004 i686 =
GNU/Linux
> >
> > netserver:/usr/src# time ./getpid 1000000
> >
> > real    0m1.763s
> > user    0m0.910s
> > sys     0m0.860s
> >
> > real    0m1.759s
> > user    0m0.900s
> > sys     0m0.870s
> >
> > real    0m1.759s
> > user    0m0.950s
> > sys     0m0.800s
> >
> > UML with sysemu:
> >
> > (none):~# uname -a
> > Linux (none) 2.6.6-1um #10 Wed May 19 12:54:37 CEST 2004 i686 unknown
> >
> > (none):/mnt/usr/src# time ./getpid 1000000
> >
> > real    1m1.508s
> > user    0m7.960s
> > sys     0m53.450s
> >
> > real    1m1.881s
> > user    0m6.630s
> > sys     0m55.240s
> >
> > real    1m1.920s
> > user    0m6.580s
> > sys     0m55.340s
> >
> > UML w/o sysemu
> >
> > real    1m32.833s
> > user    0m7.610s
> > sys     1m25.130s
> >
> > real    1m32.921s
> > user    0m7.890s
> > sys     1m24.980s
> >
> > real    1m33.493s
> > user    0m8.010s
> > sys     1m24.960s
> >
>=20

--=-yIjM7ZbDS5Cim7OPA2mo
Content-Disposition: attachment; filename=host-sysemu-2.6.6.patch
Content-Type: text/x-patch; name=host-sysemu-2.6.6.patch; charset=iso-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtck5jIGxpbnV4LTIuNi42L2FyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUyBsaW51eC0yLjYu
Ni1zeXNlbXUvYXJjaC9pMzg2L2tlcm5lbC9lbnRyeS5TDQoqKiogbGludXgtMi42LjYvYXJjaC9p
Mzg2L2tlcm5lbC9lbnRyeS5TCU1vbiBNYXkgMTAgMDQ6MzI6MjYgMjAwNA0KLS0tIGxpbnV4LTIu
Ni42LXN5c2VtdS9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMJVHVlIE1heSAxOCAxMTozNjo1MiAy
MDA0DQoqKioqKioqKioqKioqKioNCioqKiAyODYsMjkxICoqKioNCi0tLSAyODYsMjk0IC0tLS0N
CiAgCUdFVF9USFJFQURfSU5GTyglZWJwKQ0KICAJY21wbCAkKG5yX3N5c2NhbGxzKSwgJWVheA0K
ICAJamFlIHN5c2NhbGxfYmFkc3lzDQorIAkJCQkJIyBzeXN0ZW0gY2FsbCBlbXVsYXRpb24NCisg
CXRlc3RiICQoX1RJRl9TWVNDQUxMX0VNVSksVElfRkxBR1MoJWVicCkNCisgCWpueiBzeXNjYWxs
X2VtdV9lbnRyeQ0KICAJCQkJCSMgc3lzdGVtIGNhbGwgdHJhY2luZyBpbiBvcGVyYXRpb24NCiAg
CXRlc3RiICQoX1RJRl9TWVNDQUxMX1RSQUNFfF9USUZfU1lTQ0FMTF9BVURJVCksVElfRkxBR1Mo
JWVicCkNCiAgCWpueiBzeXNjYWxsX3RyYWNlX2VudHJ5DQoqKioqKioqKioqKioqKioNCioqKiAz
MzksMzQ0ICoqKioNCi0tLSAzNDIsMzUxIC0tLS0NCiAgCWNhbGwgZG9fbm90aWZ5X3Jlc3VtZQ0K
ICAJam1wIHJlc3RvcmVfYWxsDQogIA0KKyAJIyBwZXJmb3JtIHN5c2NhbCBlbXVsYXRpb24NCisg
c3lzY2FsbF9lbXVfZW50cnk6DQorIAljYWxsIGRvX3N5c2NhbGxfZW11DQorIAlqbXAgc3lzY2Fs
bF9leGl0DQogIAkjIHBlcmZvcm0gc3lzY2FsbCBleGl0IHRyYWNpbmcNCiAgCUFMSUdODQogIHN5
c2NhbGxfdHJhY2VfZW50cnk6DQpkaWZmIC1yTmMgbGludXgtMi42LjYvYXJjaC9pMzg2L2tlcm5l
bC9wdHJhY2UuYyBsaW51eC0yLjYuNi1zeXNlbXUvYXJjaC9pMzg2L2tlcm5lbC9wdHJhY2UuYw0K
KioqIGxpbnV4LTIuNi42L2FyY2gvaTM4Ni9rZXJuZWwvcHRyYWNlLmMJTW9uIE1heSAxMCAwNDoz
MjoyNiAyMDA0DQotLS0gbGludXgtMi42LjYtc3lzZW11L2FyY2gvaTM4Ni9rZXJuZWwvcHRyYWNl
LmMJVHVlIE1heSAxOCAxMTo0Mzo1NCAyMDA0DQoqKioqKioqKioqKioqKioNCioqKiAzNTYsMzYx
ICoqKioNCi0tLSAzNTYsMzYyIC0tLS0NCiAgCQkgIH0NCiAgCQkgIGJyZWFrOw0KICANCisgCWNh
c2UgUFRSQUNFX1NDRU1VOiAvKiBjb250aW51ZSBhbmQgcmVwbGFjZSBuZXh0IHN5c2NhbGwgKi8N
CiAgCWNhc2UgUFRSQUNFX1NZU0NBTEw6IC8qIGNvbnRpbnVlIGFuZCBzdG9wIGF0IG5leHQgKHJl
dHVybiBmcm9tKSBzeXNjYWxsICovDQogIAljYXNlIFBUUkFDRV9DT05UOiB7IC8qIHJlc3RhcnQg
YWZ0ZXIgc2lnbmFsLiAqLw0KICAJCWxvbmcgdG1wOw0KKioqKioqKioqKioqKioqDQoqKiogMzYz
LDM2OCAqKioqDQotLS0gMzY0LDM3NSAtLS0tDQogIAkJcmV0ID0gLUVJTzsNCiAgCQlpZiAoKHVu
c2lnbmVkIGxvbmcpIGRhdGEgPiBfTlNJRykNCiAgCQkJYnJlYWs7DQorIAkJaWYgKHJlcXVlc3Qg
PT0gUFRSQUNFX1NDRU1VKSB7DQorIAkJCXNldF90c2tfdGhyZWFkX2ZsYWcoY2hpbGQsIFRJRl9T
WVNDQUxMX0VNVSk7DQorIAkJfQ0KKyAJCWVsc2Ugew0KKyAJCQljbGVhcl90c2tfdGhyZWFkX2Zs
YWcoY2hpbGQsIFRJRl9TWVNDQUxMX0VNVSk7DQorIAkJfQ0KICAJCWlmIChyZXF1ZXN0ID09IFBU
UkFDRV9TWVNDQUxMKSB7DQogIAkJCXNldF90c2tfdGhyZWFkX2ZsYWcoY2hpbGQsIFRJRl9TWVND
QUxMX1RSQUNFKTsNCiAgCQl9DQoqKioqKioqKioqKioqKioNCioqKiA0MDMsNDA5ICoqKioNCiAg
CQlyZXQgPSAtRUlPOw0KICAJCWlmICgodW5zaWduZWQgbG9uZykgZGF0YSA+IF9OU0lHKQ0KICAJ
CQlicmVhazsNCiEgCQljbGVhcl90c2tfdGhyZWFkX2ZsYWcoY2hpbGQsIFRJRl9TWVNDQUxMX1RS
QUNFKTsNCiAgCQlpZiAoKGNoaWxkLT5wdHJhY2UgJiBQVF9EVFJBQ0UpID09IDApIHsNCiAgCQkJ
LyogU3B1cmlvdXMgZGVsYXllZCBURiB0cmFwcyBtYXkgb2NjdXIgKi8NCiAgCQkJY2hpbGQtPnB0
cmFjZSB8PSBQVF9EVFJBQ0U7DQotLS0gNDEwLDQxNiAtLS0tDQogIAkJcmV0ID0gLUVJTzsNCiAg
CQlpZiAoKHVuc2lnbmVkIGxvbmcpIGRhdGEgPiBfTlNJRykNCiAgCQkJYnJlYWs7DQohIAkJY2xl
YXJfdHNrX3RocmVhZF9mbGFnKGNoaWxkLCBUSUZfU1lTQ0FMTF9UUkFDRXxUSUZfU1lTQ0FMTF9F
TVUpOw0KICAJCWlmICgoY2hpbGQtPnB0cmFjZSAmIFBUX0RUUkFDRSkgPT0gMCkgew0KICAJCQkv
KiBTcHVyaW91cyBkZWxheWVkIFRGIHRyYXBzIG1heSBvY2N1ciAqLw0KICAJCQljaGlsZC0+cHRy
YWNlIHw9IFBUX0RUUkFDRTsNCioqKioqKioqKioqKioqKg0KKioqIDUzOCw1NDMgKioqKg0KLS0t
IDU0NSw1NzIgLS0tLQ0KICAJCXJldHVybjsNCiAgCWlmICghKGN1cnJlbnQtPnB0cmFjZSAmIFBU
X1BUUkFDRUQpKQ0KICAJCXJldHVybjsNCisgCS8qIHRoZSAweDgwIHByb3ZpZGVzIGEgd2F5IGZv
ciB0aGUgdHJhY2luZyBwYXJlbnQgdG8gZGlzdGluZ3Vpc2gNCisgCSAgIGJldHdlZW4gYSBzeXNj
YWxsIHN0b3AgYW5kIFNJR1RSQVAgZGVsaXZlcnkgKi8NCisgCXB0cmFjZV9ub3RpZnkoU0lHVFJB
UCB8ICgoY3VycmVudC0+cHRyYWNlICYgUFRfVFJBQ0VTWVNHT09EKQ0KKyAJCQkJID8gMHg4MCA6
IDApKTsNCisgDQorIAkvKg0KKyAJICogdGhpcyBpc24ndCB0aGUgc2FtZSBhcyBjb250aW51aW5n
IHdpdGggYSBzaWduYWwsIGJ1dCBpdCB3aWxsIGRvDQorIAkgKiBmb3Igbm9ybWFsIHVzZS4gIHN0
cmFjZSBvbmx5IGNvbnRpbnVlcyB3aXRoIGEgc2lnbmFsIGlmIHRoZQ0KKyAJICogc3RvcHBpbmcg
c2lnbmFsIGlzIG5vdCBTSUdUUkFQLiAgLWJybA0KKyAJICovDQorIAlpZiAoY3VycmVudC0+ZXhp
dF9jb2RlKSB7DQorIAkJc2VuZF9zaWcoY3VycmVudC0+ZXhpdF9jb2RlLCBjdXJyZW50LCAxKTsN
CisgCQljdXJyZW50LT5leGl0X2NvZGUgPSAwOw0KKyAJfQ0KKyB9DQorIA0KKyB2b2lkIGRvX3N5
c2NhbGxfZW11KHZvaWQpDQorIHsNCisgCWlmICghdGVzdF90aHJlYWRfZmxhZyhUSUZfU1lTQ0FM
TF9FTVUpKQ0KKyAJCXJldHVybjsNCisgCWlmICghKGN1cnJlbnQtPnB0cmFjZSAmIFBUX1BUUkFD
RUQpKQ0KKyAJCXJldHVybjsNCiAgCS8qIHRoZSAweDgwIHByb3ZpZGVzIGEgd2F5IGZvciB0aGUg
dHJhY2luZyBwYXJlbnQgdG8gZGlzdGluZ3Vpc2gNCiAgCSAgIGJldHdlZW4gYSBzeXNjYWxsIHN0
b3AgYW5kIFNJR1RSQVAgZGVsaXZlcnkgKi8NCiAgCXB0cmFjZV9ub3RpZnkoU0lHVFJBUCB8ICgo
Y3VycmVudC0+cHRyYWNlICYgUFRfVFJBQ0VTWVNHT09EKQ0KZGlmZiAtck5jIGxpbnV4LTIuNi42
L2luY2x1ZGUvYXNtLWkzODYvdGhyZWFkX2luZm8uaCBsaW51eC0yLjYuNi1zeXNlbXUvaW5jbHVk
ZS9hc20taTM4Ni90aHJlYWRfaW5mby5oDQoqKiogbGludXgtMi42LjYvaW5jbHVkZS9hc20taTM4
Ni90aHJlYWRfaW5mby5oCU1vbiBNYXkgMTAgMDQ6MzI6MDEgMjAwNA0KLS0tIGxpbnV4LTIuNi42
LXN5c2VtdS9pbmNsdWRlL2FzbS1pMzg2L3RocmVhZF9pbmZvLmgJVHVlIE1heSAxOCAxMTozMzow
MCAyMDA0DQoqKioqKioqKioqKioqKioNCioqKiAxNTEsMTU2ICoqKioNCi0tLSAxNTEsMTU3IC0t
LS0NCiAgI2RlZmluZSBUSUZfTkVFRF9SRVNDSEVECTMJLyogcmVzY2hlZHVsaW5nIG5lY2Vzc2Fy
eSAqLw0KICAjZGVmaW5lIFRJRl9TSU5HTEVTVEVQCQk0CS8qIHJlc3RvcmUgc2luZ2xlc3RlcCBv
biByZXR1cm4gdG8gdXNlciBtb2RlICovDQogICNkZWZpbmUgVElGX0lSRVQJCTUJLyogcmV0dXJu
IHdpdGggaXJldCAqLw0KKyAjZGVmaW5lIFRJRl9TWVNDQUxMX0VNVQkJNgkvKiBzeXNjYWxsIGVt
dWxhdGlvbiBhY3RpdmUgKi8NCiAgI2RlZmluZSBUSUZfU1lTQ0FMTF9BVURJVAk3CS8qIHN5c2Nh
bGwgYXVkaXRpbmcgYWN0aXZlICovDQogICNkZWZpbmUgVElGX1BPTExJTkdfTlJGTEFHCTE2CS8q
IHRydWUgaWYgcG9sbF9pZGxlKCkgaXMgcG9sbGluZyBUSUZfTkVFRF9SRVNDSEVEICovDQogIA0K
KioqKioqKioqKioqKioqDQoqKiogMTYwLDE2NSAqKioqDQotLS0gMTYxLDE2NyAtLS0tDQogICNk
ZWZpbmUgX1RJRl9ORUVEX1JFU0NIRUQJKDE8PFRJRl9ORUVEX1JFU0NIRUQpDQogICNkZWZpbmUg
X1RJRl9TSU5HTEVTVEVQCQkoMTw8VElGX1NJTkdMRVNURVApDQogICNkZWZpbmUgX1RJRl9JUkVU
CQkoMTw8VElGX0lSRVQpDQorICNkZWZpbmUgX1RJRl9TWVNDQUxMX0VNVQkoMTw8VElGX1NZU0NB
TExfRU1VKQ0KICAjZGVmaW5lIF9USUZfU1lTQ0FMTF9BVURJVAkoMTw8VElGX1NZU0NBTExfQVVE
SVQpDQogICNkZWZpbmUgX1RJRl9QT0xMSU5HX05SRkxBRwkoMTw8VElGX1BPTExJTkdfTlJGTEFH
KQ0KICANCmRpZmYgLXJOYyBsaW51eC0yLjYuNi9pbmNsdWRlL2xpbnV4L3B0cmFjZS5oIGxpbnV4
LTIuNi42LXN5c2VtdS9pbmNsdWRlL2xpbnV4L3B0cmFjZS5oDQoqKiogbGludXgtMi42LjYvaW5j
bHVkZS9saW51eC9wdHJhY2UuaAlNb24gTWF5IDEwIDA0OjMyOjAwIDIwMDQNCi0tLSBsaW51eC0y
LjYuNi1zeXNlbXUvaW5jbHVkZS9saW51eC9wdHJhY2UuaAlUdWUgTWF5IDE4IDExOjQ0OjM5IDIw
MDQNCioqKioqKioqKioqKioqKg0KKioqIDIwLDI1ICoqKioNCi0tLSAyMCwyNiAtLS0tDQogICNk
ZWZpbmUgUFRSQUNFX0RFVEFDSAkJMHgxMQ0KICANCiAgI2RlZmluZSBQVFJBQ0VfU1lTQ0FMTAkJ
ICAyNA0KKyAjZGVmaW5lIFBUUkFDRV9TQ0VNVQkJICAyNQ0KICANCiAgLyogMHg0MjAwLTB4NDMw
MCBhcmUgcmVzZXJ2ZWQgZm9yIGFyY2hpdGVjdHVyZS1pbmRlcGVuZGVudCBhZGRpdGlvbnMuICAq
Lw0KICAjZGVmaW5lIFBUUkFDRV9TRVRPUFRJT05TCTB4NDIwMA0K

--=-yIjM7ZbDS5Cim7OPA2mo--

--=-GcmNCCK7luaKI6sKOoxL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAq6TFbmJwdIv5dzMRAqCyAJoChE2B9XdKRtVMn0Bddu3W+gaYLQCdHQvl
FynVurdbldZ6NLRNd5K9iDY=
=ioM6
-----END PGP SIGNATURE-----

--=-GcmNCCK7luaKI6sKOoxL--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
