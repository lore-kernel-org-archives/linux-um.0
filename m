Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dVJIv-0005KY-TU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2017 15:11:53 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dVJIs-0004do-DV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2017 15:11:53 +0000
Date: Wed, 12 Jul 2017 17:11:42 +0200
Message-ID: <c99c3170-53a6-4038-9033-5a3680b1e5db@email.android.com>
From: Thomas Meyer <thomas@m3y3r.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] um: v3: Fix FP register size for
 XSTATE/XSAVE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3769821241088848677=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============3769821241088848677==
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9J2F1dG8nPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj5BbSAxMC4wNy4yMDE3IDk6MDYgbmFjaG0uIHNjaHJpZWIgUmljaGFyZCBX
ZWluYmVyZ2VyICZsdDtyaWNoYXJkQG5vZC5hdCZndDs6PGJyIHR5cGU9ImF0dHJpYnV0aW9uIj48
YmxvY2txdW90ZSBjbGFzcz0icXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48cCBkaXI9Imx0ciI+VGhvbWFz
LAo8YnI+Cgo8YnI+CkFtIDEwLjA3LjIwMTcgdW0gMDA6MzMgc2NocmllYiBUaG9tYXMgTWV5ZXI6
Cjxicj4KJmd0OyBIYXJkIGNvZGUgbWF4IHNpemUuIFRha2VuIGZyb20KPGJyPgomZ3Q7IGh0dHBz
Oi8vc291cmNld2FyZS5vcmcvZ2l0Lz9wPWJpbnV0aWxzLWdkYi5naXQ7YT1ibG9iO2Y9Z2RiL2Nv
bW1vbi94ODYteHN0YXRlLmgKPGJyPgomZ3Q7IAo8YnI+CiZndDsgdjM6IHVzZSBzdGF0aWMgZnBf
cmVncyBmb3IgZ2V0X3NrYXNfZmF1bHRpbmZvCjxicj4KJmd0OyAKPGJyPgomZ3Q7IFNpZ25lZC1v
ZmYtYnk6IFRob21hcyBNZXllciAmbHQ7dGhvbWFzQG0zeTNyLmRlJmd0Owo8YnI+CiZndDsgLS0t
Cjxicj4KJmd0OyZuYnNwOyBhcmNoL3VtL29zLUxpbnV4L3NrYXMvcHJvY2Vzcy5jJm5ic3A7IHwm
bmJzcDsgNyArKysrLS0tCjxicj4KJmd0OyZuYnNwOyBhcmNoL3g4Ni91bS9vcy1MaW51eC9yZWdp
c3RlcnMuYyB8IDE4ICsrKysrKysrKysrKy0tLS0tLQo8YnI+CiZndDsmbmJzcDsgYXJjaC94ODYv
dW0vdXNlci1vZmZzZXRzLmMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfCZu
YnNwOyAyICstCjxicj4KJmd0OyZuYnNwOyAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQo8YnI+CiZndDsgCjxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvYXJj
aC91bS9vcy1MaW51eC9za2FzL3Byb2Nlc3MuYyBiL2FyY2gvdW0vb3MtTGludXgvc2thcy9wcm9j
ZXNzLmMKPGJyPgomZ3Q7IGluZGV4IDAzYjNjNGNjNzczNS4uYjVmZGVmNzk1OTg1IDEwMDY0NAo8
YnI+CiZndDsgLS0tIGEvYXJjaC91bS9vcy1MaW51eC9za2FzL3Byb2Nlc3MuYwo8YnI+CiZndDsg
KysrIGIvYXJjaC91bS9vcy1MaW51eC9za2FzL3Byb2Nlc3MuYwo8YnI+CiZndDsgQEAgLTg4LDEy
ICs4OCwxMyBAQCB2b2lkIHdhaXRfc3R1Yl9kb25lKGludCBwaWQpCjxicj4KJmd0OyZuYnNwOyAK
PGJyPgomZ3Q7Jm5ic3A7IGV4dGVybiB1bnNpZ25lZCBsb25nIGN1cnJlbnRfc3R1Yl9zdGFjayh2
b2lkKTsKPGJyPgomZ3Q7Jm5ic3A7IAo8YnI+CiZndDsgK3N0YXRpYyB1bnNpZ25lZCBsb25nIHNr
YXNfZmF1bHRpbmZvX2ZwcmVnc1tGUF9TSVpFXTsKPGJyPgomZ3Q7ICsKPGJyPgoKPGJyPgpVaG1t
LCBhcmUgeW91IHN1cmUgdGhhdCB0aGlzIGRvZXMgbm90IHJhY2Ugd2l0aCBvdGhlciB1c2Vyc3Bh
Y2UoKSBpbnN0YW5jZXM/Cjxicj4KCjwvcD48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+
PGRpdiBkaXI9ImF1dG8iPk9oLCBpcyBpdCByZWFsbHkgcG9zc2libGUgdGhhdCBhIHRhc2sgZ2V0
cyBzY2hlZHVsZSB3aGlsZSB3ZSBhcmUgaW4gdXNlcnNwYWNlIHNpZ25hbCBoYW5kbGluZyBmcm9t
IHB0cmFjZT88L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5B
bm90aGVyIHF1ZXN0aW9uOiB3aGVuIG1hbGxvYyBhIG1lbW9yeSBhcmVhIGluIHVzZXJzcGFjZTog
d2hlbiBkb2VzIGEgdXNlcnNwYWNlIHByb2Nlc3MgZW5kIGluIHVzZXJzcGFjZSBmdW5jdGlvbiE/
IFdoZXJlIHdvdWxkIHlvdSBmcmVlIHRoZSBtYWxsb2NlZCBtZW1vcnk/PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEi
PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0icXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij48cCBkaXI9Imx0ciI+PGJyPgpUaGFua3MsCjxicj4KLy9yaWNoYXJkCjxicj4KPC9w
Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pg==



--===============3769821241088848677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============3769821241088848677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3769821241088848677==--

