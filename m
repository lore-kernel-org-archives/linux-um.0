Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQUqo-0001GA-25 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 10:27:30 -0700
Received: from smtp6.wanadoo.fr ([193.252.22.25] helo=mwinf0602.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BQUqn-00048W-Bl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 10:27:29 -0700
Subject: Re: [uml-devel] [PATCH] host context switch reduction
From: Laurent Vivier <LaurentVivier@wanadoo.fr>
In-Reply-To: <20040518175904.GB29114@ccure.user-mode-linux.org>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-evY54/WSFaPYy3kclJ2Z"
Message-Id: <1084987654.2250.4.camel@chartreuse>
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
Date: Wed, 19 May 2004 19:27:36 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net



--=-evY54/WSFaPYy3kclJ2Z
Content-Type: multipart/mixed; boundary="=-YL7WPgXBWp5FS9qHvCzu"



--=-YL7WPgXBWp5FS9qHvCzu
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

as it is a plebiscite ;-), find attached the patch for UML 2.6.6 and
measurements I made on my poor netserver.

Laurent

Le mar 18/05/2004 =E0 19:59, Jeff Dike a =E9crit :
> On Tue, May 18, 2004 at 12:22:45AM +0200, roland wrote:
> > the question is:
> > is the "real world" performance benefit, uml get`s from this patch wort=
h taking your time and is it implemented in a way, so that
> > uml maintainers are happy with that ?
>=20
> The patch seems reasonable to me.  I'd be happiest with Laurent pushing t=
his
> into mainline himself.
>=20
> > i cannot really estimate, what performance benefits your patch brings t=
o uml in detail, but what i have seen so far, this seems
> > quite worth doing the work.  reducing context switches by 1/3 is a LOT,=
 imho - and reducing the execution time of the getpid-loop to
> > nearly the half is quite impressive.
>=20
> Yeah, but no real workloads do while(1) getpid();
>=20
> The kernel build improvement is obviously smaller, but still worth having=
.
>=20
> > are there any "con`s" that argue for that work _NOT_ being done ?
>=20
> No.  But testing, and happy reports to the appropriate mailing lists woul=
d
> help.
>=20
> 				Jeff

--=-YL7WPgXBWp5FS9qHvCzu
Content-Disposition: inline; filename=measure-getpid-2.6.6.txt
Content-Type: text/plain; name=measure-getpid-2.6.6.txt; charset=iso-8859-1
Content-Transfer-Encoding: base64

SFAgTmV0c2VydmVyIExIIFBybyBiaS1wcm8gMjAwIE1IeiAvIDI1NiBNQiBSQU0NCg0KTkFUSUY6
DQoNCm5ldHNlcnZlcjovdXNyL3NyYyMgdW5hbWUgLWENCkxpbnV4IG5ldHNlcnZlciAyLjQuMjQt
c3lzZW11ICM0IFNNUCBUdWUgRmViIDE3IDE2OjQzOjExIENFVCAyMDA0IGk2ODYgR05VL0xpbnV4
DQoNCm5ldHNlcnZlcjovdXNyL3NyYyMgdGltZSAuL2dldHBpZCAxMDAwMDAwDQoNCnJlYWwgICAg
MG0xLjc2M3MNCnVzZXIgICAgMG0wLjkxMHMNCnN5cyAgICAgMG0wLjg2MHMNCg0KcmVhbCAgICAw
bTEuNzU5cw0KdXNlciAgICAwbTAuOTAwcw0Kc3lzICAgICAwbTAuODcwcw0KDQpyZWFsICAgIDBt
MS43NTlzDQp1c2VyICAgIDBtMC45NTBzDQpzeXMgICAgIDBtMC44MDBzDQoNClVNTCB3aXRoIHN5
c2VtdToNCg0KKG5vbmUpOn4jIHVuYW1lIC1hDQpMaW51eCAobm9uZSkgMi42LjYtMXVtICMxMCBX
ZWQgTWF5IDE5IDEyOjU0OjM3IENFU1QgMjAwNCBpNjg2IHVua25vd24NCg0KKG5vbmUpOi9tbnQv
dXNyL3NyYyMgdGltZSAuL2dldHBpZCAxMDAwMDAwIA0KDQpyZWFsICAgIDFtMS41MDhzDQp1c2Vy
ICAgIDBtNy45NjBzDQpzeXMgICAgIDBtNTMuNDUwcw0KDQpyZWFsICAgIDFtMS44ODFzDQp1c2Vy
ICAgIDBtNi42MzBzDQpzeXMgICAgIDBtNTUuMjQwcw0KDQpyZWFsICAgIDFtMS45MjBzDQp1c2Vy
ICAgIDBtNi41ODBzDQpzeXMgICAgIDBtNTUuMzQwcw0KDQpVTUwgdy9vIHN5c2VtdQ0KDQpyZWFs
ICAgIDFtMzIuODMzcw0KdXNlciAgICAwbTcuNjEwcw0Kc3lzICAgICAxbTI1LjEzMHMNCg0KcmVh
bCAgICAxbTMyLjkyMXMNCnVzZXIgICAgMG03Ljg5MHMNCnN5cyAgICAgMW0yNC45ODBzDQoNCnJl
YWwgICAgMW0zMy40OTNzDQp1c2VyICAgIDBtOC4wMTBzDQpzeXMgICAgIDFtMjQuOTYwcw0K

--=-YL7WPgXBWp5FS9qHvCzu
Content-Disposition: attachment; filename=um-sysemu-2.6.6.patch
Content-Type: text/x-patch; name=um-sysemu-2.6.6.patch; charset=iso-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtck5jIGxpbnV4LTIuNi42L2FyY2gvdW0va2VybmVsL3Byb2Nlc3MuYyB1bWwtbGludXgt
Mi42LjYvYXJjaC91bS9rZXJuZWwvcHJvY2Vzcy5jDQoqKiogbGludXgtMi42LjYvYXJjaC91bS9r
ZXJuZWwvcHJvY2Vzcy5jCVdlZCBNYXkgMTkgMTQ6Mjc6MTMgMjAwNA0KLS0tIHVtbC1saW51eC0y
LjYuNi9hcmNoL3VtL2tlcm5lbC9wcm9jZXNzLmMJV2VkIE1heSAxOSAxNDoyNTo0MCAyMDA0DQoq
KioqKioqKioqKioqKioNCioqKiAxOSwyNCAqKioqDQotLS0gMTksMjUgLS0tLQ0KICAjaW5jbHVk
ZSA8YXNtL3NpZ2NvbnRleHQuaD4NCiAgI2luY2x1ZGUgPGFzbS91bmlzdGQuaD4NCiAgI2luY2x1
ZGUgPGFzbS9wYWdlLmg+DQorICNpbmNsdWRlIDxhc20vdXNlci5oPg0KICAjaW5jbHVkZSAidXNl
cl91dGlsLmgiDQogICNpbmNsdWRlICJrZXJuX3V0aWwuaCINCiAgI2luY2x1ZGUgInVzZXIuaCIN
CioqKioqKioqKioqKioqKg0KKioqIDIyNywyMzIgKioqKg0KLS0tIDIyOCwyNjcgLS0tLQ0KICAJ
fQ0KICAJc3RvcF9wdHJhY2VkX2NoaWxkKHBpZCwgc3RhY2ssIDApOw0KICAJcHJpbnRrKCJPS1xu
Iik7DQorIA0KKyAjaWZkZWYgUFRSQUNFX1NZU0VNVQ0KKyAJcHJpbnRrKCJDaGVja2luZyBzeXNj
YWxsIGVtdWxhdGlvbiBwYXRjaCBmb3IgcHRyYWNlLi4uIik7DQorIAl1c2Vfc3lzZW11ID0gMDsN
CisgCXBpZCA9IHN0YXJ0X3B0cmFjZWRfY2hpbGQoJnN0YWNrKTsNCisgCWlmKHB0cmFjZShQVFJB
Q0VfU1lTRU1VLCBwaWQsIDAsIDApID49IDApIHsNCisgCQlzdHJ1Y3QgdXNlcl9yZWdzX3N0cnVj
dCByZWdzOw0KKyANCisgCQlpZiAod2FpdHBpZChwaWQsICZzdGF0dXMsIFdVTlRSQUNFRCkgPCAw
KQ0KKyAJCQlwYW5pYygiY2hlY2tfcHRyYWNlIDogd2FpdCBmYWlsZWQsIGVycm5vID0gJWQiLCBl
cnJubyk7DQorIAkJaWYoIVdJRlNUT1BQRUQoc3RhdHVzKSB8fCAoV1NUT1BTSUcoc3RhdHVzKSAh
PSBTSUdUUkFQKSkNCisgCQkJcGFuaWMoImNoZWNrX3B0cmFjZSA6IGV4cGVjdGVkIFNJR1RSQVAs
ICINCisgCQkJICAgICAgImdvdCBzdGF0dXMgPSAlZCIsIHN0YXR1cyk7DQorIA0KKyAJCWlmIChw
dHJhY2UoUFRSQUNFX0dFVFJFR1MsIHBpZCwgMCwgJnJlZ3MpIDwgMCkNCisgCQkJcGFuaWMoImNo
ZWNrX3B0cmFjZSA6IGZhaWxlZCB0byByZWFkIGNoaWxkICINCisgCQkJICAgICAgInJlZ2lzdGVy
cywgZXJybm8gPSAlZCIsIGVycm5vKTsNCisgCQlyZWdzLm9yaWdfZWF4ID0gcGlkOw0KKyAJCWlm
IChwdHJhY2UoUFRSQUNFX1NFVFJFR1MsIHBpZCwgMCwgJnJlZ3MpIDwgMCkNCisgCQkJcGFuaWMo
ImNoZWNrX3B0cmFjZSA6IGZhaWxlZCB0byBtb2RpZnkgY2hpbGQgIg0KKyAJCQkgICAgICAicmVn
aXN0ZXJzLCBlcnJubyA9ICVkIiwgZXJybm8pOw0KKyANCisgCQlzdG9wX3B0cmFjZWRfY2hpbGQo
cGlkLCBzdGFjaywgMCk7DQorIA0KKyAJCXByaW50aygiT0tcbiIpOw0KKyAJCXVzZV9zeXNlbXUg
PSAxOw0KKyAJfQ0KKyAJZWxzZQ0KKyAJew0KKyAJCXByaW50aygibWlzc2luZ1xuIik7DQorIAkJ
c3RvcF9wdHJhY2VkX2NoaWxkKHBpZCwgc3RhY2ssIDEpOw0KKyAJfQ0KKyANCisgIyBlbmRpZiAv
KiBQVFJBQ0VfU1lTRU1VICovDQogIH0NCiAgDQogIGludCBydW5fa2VybmVsX3RocmVhZChpbnQg
KCpmbikodm9pZCAqKSwgdm9pZCAqYXJnLCB2b2lkICoqam1wX3B0cikNCmRpZmYgLXJOYyBsaW51
eC0yLjYuNi9hcmNoL3VtL2tlcm5lbC9za2FzL2luY2x1ZGUvcHRyYWNlLXNrYXMuaCB1bWwtbGlu
dXgtMi42LjYvYXJjaC91bS9rZXJuZWwvc2thcy9pbmNsdWRlL3B0cmFjZS1za2FzLmgNCioqKiBs
aW51eC0yLjYuNi9hcmNoL3VtL2tlcm5lbC9za2FzL2luY2x1ZGUvcHRyYWNlLXNrYXMuaAlXZWQg
TWF5IDE5IDE0OjI3OjEzIDIwMDQNCi0tLSB1bWwtbGludXgtMi42LjYvYXJjaC91bS9rZXJuZWwv
c2thcy9pbmNsdWRlL3B0cmFjZS1za2FzLmgJV2VkIE1heSAxOSAxMToyMjowNCAyMDA0DQoqKioq
KioqKioqKioqKioNCioqKiAxMCwxNSAqKioqDQotLS0gMTAsMjIgLS0tLQ0KICANCiAgI2lmZGVm
IFVNTF9DT05GSUdfTU9ERV9TS0FTDQogIA0KKyAvKiBzeXNjYWxsIGVtdWxhdGlvbiBwYXRoIGlu
IHB0cmFjZSAqLw0KKyANCisgI2lmbmRlZiBQVFJBQ0VfU1lTRU1VDQorICNkZWZpbmUgUFRSQUNF
X1NZU0VNVSAyNQ0KKyAjZW5kaWYNCisgZXh0ZXJuIGludCB1c2Vfc3lzZW11Ow0KKyANCiAgI2lu
Y2x1ZGUgInNrYXNfcHRyZWdzLmgiDQogIA0KICAjZGVmaW5lIEhPU1RfRlJBTUVfU0laRSAxNw0K
ZGlmZiAtck5jIGxpbnV4LTIuNi42L2FyY2gvdW0va2VybmVsL3NrYXMvcHJvY2Vzcy5jIHVtbC1s
aW51eC0yLjYuNi9hcmNoL3VtL2tlcm5lbC9za2FzL3Byb2Nlc3MuYw0KKioqIGxpbnV4LTIuNi42
L2FyY2gvdW0va2VybmVsL3NrYXMvcHJvY2Vzcy5jCVdlZCBNYXkgMTkgMTQ6Mjc6MTMgMjAwNA0K
LS0tIHVtbC1saW51eC0yLjYuNi9hcmNoL3VtL2tlcm5lbC9za2FzL3Byb2Nlc3MuYwlXZWQgTWF5
IDE5IDExOjIyOjA0IDIwMDQNCioqKioqKioqKioqKioqKg0KKioqIDI4LDMzICoqKioNCi0tLSAy
OCwzNyAtLS0tDQogICNpbmNsdWRlICJjaGFuX3VzZXIuaCINCiAgI2luY2x1ZGUgInNpZ25hbF91
c2VyLmgiDQogIA0KKyAjaWZkZWYgUFRSQUNFX1NZU0VNVQ0KKyBpbnQgdXNlX3N5c2VtdSA9IDA7
DQorICNlbmRpZg0KKyANCiAgaW50IGlzX3NrYXNfd2luY2goaW50IHBpZCwgaW50IGZkLCB2b2lk
ICpkYXRhKQ0KICB7DQogIAlpZihwaWQgIT0gZ2V0cGlkKCkpDQoqKioqKioqKioqKioqKioNCioq
KiA2OCw3MyAqKioqDQotLS0gNzIsODEgLS0tLQ0KICAJCXJldHVybjsNCiAgCX0NCiAgDQorICNp
ZmRlZiBQVFJBQ0VfU1lTRU1VDQorIAlpZiAoIXVzZV9zeXNlbXUpDQorIAl7DQorICNlbmRpZg0K
ICAJZXJyID0gcHRyYWNlKFBUUkFDRV9QT0tFVVNFUiwgcGlkLCBQVF9TWVNDQUxMX05SX09GRlNF
VCwgX19OUl9nZXRwaWQpOw0KICAJaWYoZXJyIDwgMCkNCiAgCSAgICAgICAgcGFuaWMoImhhbmRs
ZV90cmFwIC0gbnVsbGlmeWluZyBzeXNjYWxsIGZhaWxlZCBlcnJubyA9ICVkXG4iLCANCioqKioq
KioqKioqKioqKg0KKioqIDgyLDg3ICoqKioNCi0tLSA5MCw5OCAtLS0tDQogIAlpZigoZXJyIDwg
MCkgfHwgIVdJRlNUT1BQRUQoc3RhdHVzKSB8fCAoV1NUT1BTSUcoc3RhdHVzKSAhPSBTSUdUUkFQ
KSkNCiAgCQlwYW5pYygiaGFuZGxlX3RyYXAgLSBmYWlsZWQgdG8gd2FpdCBhdCBlbmQgb2Ygc3lz
Y2FsbCwgIg0KICAJCSAgICAgICJlcnJubyA9ICVkLCBzdGF0dXMgPSAlZFxuIiwgZXJybm8sIHN0
YXR1cyk7DQorICNpZmRlZiBQVFJBQ0VfU1lTRU1VDQorIAl9DQorICNlbmRpZg0KICANCiAgCWhh
bmRsZV9zeXNjYWxsKHJlZ3MpOw0KICB9DQoqKioqKioqKioqKioqKioNCioqKiAxMzksMTQ0ICoq
KioNCi0tLSAxNTAsMTYwIC0tLS0NCiAgDQogIAlyZXN0b3JlX3JlZ2lzdGVycyhyZWdzKTsNCiAg
CQkNCisgI2lmZGVmIFBUUkFDRV9TWVNFTVUNCisgCWlmICh1c2Vfc3lzZW11KQ0KKyAJCWVyciA9
IHB0cmFjZShQVFJBQ0VfU1lTRU1VLCBwaWQsIDAsIDApOw0KKyAJZWxzZQ0KKyAjZW5kaWYNCiAg
CWVyciA9IHB0cmFjZShQVFJBQ0VfU1lTQ0FMTCwgcGlkLCAwLCAwKTsNCiAgCWlmKGVycikNCiAg
CQlwYW5pYygidXNlcnNwYWNlIC0gUFRSQUNFX1NZU0NBTEwgZmFpbGVkLCBlcnJubyA9ICVkXG4i
LCANCioqKioqKioqKioqKioqKg0KKioqIDE3NywxODIgKioqKg0KLS0tIDE5MywyMDQgLS0tLQ0K
ICANCiAgCQlyZXN0b3JlX3JlZ2lzdGVycyhyZWdzKTsNCiAgDQorICNpZmRlZiBQVFJBQ0VfU1lT
RU1VDQorIAkJaWYgKHVzZV9zeXNlbXUpDQorIAkJCW9wID0gc2luZ2xlc3RlcHBpbmdfc2thcygp
ID8gUFRSQUNFX1NJTkdMRVNURVAgOiANCisgCQkJCVBUUkFDRV9TWVNFTVU7DQorIAkJZWxzZQ0K
KyAjZW5kaWYNCiAgCQlvcCA9IHNpbmdsZXN0ZXBwaW5nX3NrYXMoKSA/IFBUUkFDRV9TSU5HTEVT
VEVQIDogDQogIAkJCVBUUkFDRV9TWVNDQUxMOw0KICAJCWVyciA9IHB0cmFjZShvcCwgcGlkLCAw
LCAwKTsNCg==

--=-YL7WPgXBWp5FS9qHvCzu--

--=-evY54/WSFaPYy3kclJ2Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAq5kGbmJwdIv5dzMRAvBDAJ0cnAEKj6Qnc264NtAzmYYI9zgimQCfWDax
gb5sKVCwYYxt9V4VEetzyqg=
=xKJA
-----END PGP SIGNATURE-----

--=-evY54/WSFaPYy3kclJ2Z--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
