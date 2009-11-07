Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Date: Sat,  7 Nov 2009 13:16:17 -0200
Message-Id: <360ba96ac59d5bb9f14aef9ce0ec5f57014c2f8e.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH v4 09/12] ctype: constify read-only _ctype string
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
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Stoyan Gaydarov <stoyboyker@gmail.com>, Julia Lawall <julia@diku.dk>, Jeff Dike <jdike@addtoit.com>, James Morris <jmorris@namei.org>, WANG Cong <wangcong@zeuux.org>, Pekka Enberg <penberg@cs.helsinki.fi>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Joe Perches <joe@perches.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@linux.intel.com>, Neil Brown <neilb@suse.de>, Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Andre Noll <maan@systemlinux.org>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Roel Kluin <roel.kluin@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Len Brown <len.brown@intel.com>, Adam Belay <abelay@mit.edu>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Richard Purdie <rpurdie@rpsys.net>, Andrea Righi <righi.andrea@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Pavel Roskin <proski@gnu.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Steve Dickson <steved@redhat.com>, Trond Myklebust <Trond.Myklebust@netapp.com>, Daire Byrne <Daire.Byrne@framestore.com>, Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@sun.com>, Eric Sandeen <sandeen@redhat.com>, Jan Kara <jack@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>, Takashi Iwai <tiwai@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, Sitsofe Wheeler <sitsofe@yahoo.com>, Christof Schmitt <christof.schmitt@de.ibm.com>, Greg Banks <gnb@melbourne.sgi.com>, Jason Baron <jbaron@redhat.com>, "David S . Miller" <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, Samuel Ortiz <samuel@sortiz.org>, Patrick McHardy <kaber@trash.net>, Jan Engelhardt <jengelh@medozas.de>, Roman Hoog Antink <rha@open.ch>, Jaroslav Kysela <perex@perex.cz>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, dm-devel@redhat.com, linux-raid@vger.kernel.org, linux-parisc@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-cachefs@redhat.com, linux-ext4@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org, coreteam@netfilter.org, alsa-devel@alsa-project.org
Cc: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>

V2hpbGUgYXQgaXQsIHVzZSB0YWJzIHRvIGluZGVudCB0aGUgY29tbWVudHMuCgpTaWduZWQtb2Zm
LWJ5OiBBbmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJkQGdtYWlsLmNvbT4KLS0tCiBp
bmNsdWRlL2xpbnV4L2N0eXBlLmggfCAgICAyICstCiBsaWIvY3R5cGUuYyAgICAgICAgICAgfCAg
IDUwICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMiBm
aWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2N0eXBlLmggYi9pbmNsdWRlL2xpbnV4L2N0eXBlLmgKaW5kZXgg
YWZhMzYzOS4uNmRlYzk0NCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9jdHlwZS5oCisrKyBi
L2luY2x1ZGUvbGludXgvY3R5cGUuaApAQCAtMTUsNyArMTUsNyBAQAogI2RlZmluZSBfWAkweDQw
CS8qIGhleCBkaWdpdCAqLwogI2RlZmluZSBfU1AJMHg4MAkvKiBoYXJkIHNwYWNlICgweDIwKSAq
LwogCi1leHRlcm4gdW5zaWduZWQgY2hhciBfY3R5cGVbXTsKK2V4dGVybiBjb25zdCB1bnNpZ25l
ZCBjaGFyIF9jdHlwZVtdOwogCiAjZGVmaW5lIF9faXNtYXNrKHgpIChfY3R5cGVbKGludCkodW5z
aWduZWQgY2hhcikoeCldKQogCmRpZmYgLS1naXQgYS9saWIvY3R5cGUuYyBiL2xpYi9jdHlwZS5j
CmluZGV4IGQwMmFjZTEuLjI2YmFhNjIgMTAwNjQ0Ci0tLSBhL2xpYi9jdHlwZS5jCisrKyBiL2xp
Yi9jdHlwZS5jCkBAIC03LDMwICs3LDMwIEBACiAjaW5jbHVkZSA8bGludXgvY3R5cGUuaD4KICNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KIAotdW5zaWduZWQgY2hhciBfY3R5cGVbXSA9IHsKLV9D
LF9DLF9DLF9DLF9DLF9DLF9DLF9DLAkJCS8qIDAtNyAqLwotX0MsX0N8X1MsX0N8X1MsX0N8X1Ms
X0N8X1MsX0N8X1MsX0MsX0MsCQkvKiA4LTE1ICovCi1fQyxfQyxfQyxfQyxfQyxfQyxfQyxfQywJ
CQkvKiAxNi0yMyAqLwotX0MsX0MsX0MsX0MsX0MsX0MsX0MsX0MsCQkJLyogMjQtMzEgKi8KLV9T
fF9TUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCwJCQkvKiAzMi0zOSAqLwotX1AsX1AsX1AsX1AsX1As
X1AsX1AsX1AsCQkJLyogNDAtNDcgKi8KLV9ELF9ELF9ELF9ELF9ELF9ELF9ELF9ELAkJCS8qIDQ4
LTU1ICovCi1fRCxfRCxfUCxfUCxfUCxfUCxfUCxfUCwJCQkvKiA1Ni02MyAqLwotX1AsX1V8X1gs
X1V8X1gsX1V8X1gsX1V8X1gsX1V8X1gsX1V8X1gsX1UsCS8qIDY0LTcxICovCi1fVSxfVSxfVSxf
VSxfVSxfVSxfVSxfVSwJCQkvKiA3Mi03OSAqLwotX1UsX1UsX1UsX1UsX1UsX1UsX1UsX1UsCQkJ
LyogODAtODcgKi8KLV9VLF9VLF9VLF9QLF9QLF9QLF9QLF9QLAkJCS8qIDg4LTk1ICovCi1fUCxf
THxfWCxfTHxfWCxfTHxfWCxfTHxfWCxfTHxfWCxfTHxfWCxfTCwJLyogOTYtMTAzICovCi1fTCxf
TCxfTCxfTCxfTCxfTCxfTCxfTCwJCQkvKiAxMDQtMTExICovCi1fTCxfTCxfTCxfTCxfTCxfTCxf
TCxfTCwJCQkvKiAxMTItMTE5ICovCi1fTCxfTCxfTCxfUCxfUCxfUCxfUCxfQywJCQkvKiAxMjAt
MTI3ICovCi0wLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLAkJLyogMTI4LTE0MyAqLwot
MCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwJCS8qIDE0NC0xNTkgKi8KLV9TfF9TUCxf
UCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCwgICAvKiAxNjAtMTc1
ICovCi1fUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCxfUCwgICAg
ICAgLyogMTc2LTE5MSAqLwotX1UsX1UsX1UsX1UsX1UsX1UsX1UsX1UsX1UsX1UsX1UsX1UsX1Us
X1UsX1UsX1UsICAgICAgIC8qIDE5Mi0yMDcgKi8KLV9VLF9VLF9VLF9VLF9VLF9VLF9VLF9QLF9V
LF9VLF9VLF9VLF9VLF9VLF9VLF9MLCAgICAgICAvKiAyMDgtMjIzICovCi1fTCxfTCxfTCxfTCxf
TCxfTCxfTCxfTCxfTCxfTCxfTCxfTCxfTCxfTCxfTCxfTCwgICAgICAgLyogMjI0LTIzOSAqLwot
X0wsX0wsX0wsX0wsX0wsX0wsX0wsX1AsX0wsX0wsX0wsX0wsX0wsX0wsX0wsX0x9OyAgICAgIC8q
IDI0MC0yNTUgKi8KK2NvbnN0IHVuc2lnbmVkIGNoYXIgX2N0eXBlW10gPSB7CitfQyxfQyxfQyxf
QyxfQyxfQyxfQyxfQywJCQkJLyogMC03ICovCitfQyxfQ3xfUyxfQ3xfUyxfQ3xfUyxfQ3xfUyxf
Q3xfUyxfQyxfQywJCQkvKiA4LTE1ICovCitfQyxfQyxfQyxfQyxfQyxfQyxfQyxfQywJCQkJLyog
MTYtMjMgKi8KK19DLF9DLF9DLF9DLF9DLF9DLF9DLF9DLAkJCQkvKiAyNC0zMSAqLworX1N8X1NQ
LF9QLF9QLF9QLF9QLF9QLF9QLF9QLAkJCQkvKiAzMi0zOSAqLworX1AsX1AsX1AsX1AsX1AsX1As
X1AsX1AsCQkJCS8qIDQwLTQ3ICovCitfRCxfRCxfRCxfRCxfRCxfRCxfRCxfRCwJCQkJLyogNDgt
NTUgKi8KK19ELF9ELF9QLF9QLF9QLF9QLF9QLF9QLAkJCQkvKiA1Ni02MyAqLworX1AsX1V8X1gs
X1V8X1gsX1V8X1gsX1V8X1gsX1V8X1gsX1V8X1gsX1UsCQkvKiA2NC03MSAqLworX1UsX1UsX1Us
X1UsX1UsX1UsX1UsX1UsCQkJCS8qIDcyLTc5ICovCitfVSxfVSxfVSxfVSxfVSxfVSxfVSxfVSwJ
CQkJLyogODAtODcgKi8KK19VLF9VLF9VLF9QLF9QLF9QLF9QLF9QLAkJCQkvKiA4OC05NSAqLwor
X1AsX0x8X1gsX0x8X1gsX0x8X1gsX0x8X1gsX0x8X1gsX0x8X1gsX0wsCQkvKiA5Ni0xMDMgKi8K
K19MLF9MLF9MLF9MLF9MLF9MLF9MLF9MLAkJCQkvKiAxMDQtMTExICovCitfTCxfTCxfTCxfTCxf
TCxfTCxfTCxfTCwJCQkJLyogMTEyLTExOSAqLworX0wsX0wsX0wsX1AsX1AsX1AsX1AsX0MsCQkJ
CS8qIDEyMC0xMjcgKi8KKzAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsCQkJLyogMTI4
LTE0MyAqLworMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwJCQkvKiAxNDQtMTU5ICov
CitfU3xfU1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsX1AsCS8q
IDE2MC0xNzUgKi8KK19QLF9QLF9QLF9QLF9QLF9QLF9QLF9QLF9QLF9QLF9QLF9QLF9QLF9QLF9Q
LF9QLAkvKiAxNzYtMTkxICovCitfVSxfVSxfVSxfVSxfVSxfVSxfVSxfVSxfVSxfVSxfVSxfVSxf
VSxfVSxfVSxfVSwJLyogMTkyLTIwNyAqLworX1UsX1UsX1UsX1UsX1UsX1UsX1UsX1AsX1UsX1Us
X1UsX1UsX1UsX1UsX1UsX0wsCS8qIDIwOC0yMjMgKi8KK19MLF9MLF9MLF9MLF9MLF9MLF9MLF9M
LF9MLF9MLF9MLF9MLF9MLF9MLF9MLF9MLAkvKiAyMjQtMjM5ICovCitfTCxfTCxfTCxfTCxfTCxf
TCxfTCxfUCxfTCxfTCxfTCxfTCxfTCxfTCxfTCxfTH07CS8qIDI0MC0yNTUgKi8KIAogRVhQT1JU
X1NZTUJPTChfY3R5cGUpOwotLSAKMS42LjUuMi4xNTMuZzZlMzFmLmRpcnR5CgoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9ydHMgaGFuZGxlIHRoZSByZXBvcnRpbmcgLSBG
cmVlIENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURheSAKdHJpYWwuIFNpbXBsaWZ5IHlvdXIgcmVw
b3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxveW1lbnQgLSBhbmQgZm9jdXMgb24gCndo
YXQgeW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRpb24gY29kaW5nLiBEaXNjb3ZlciB3aGF0J3Mg
bmV3IHdpdGgKQ3J5c3RhbCBSZXBvcnRzIG5vdy4gIGh0dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1q
dWx5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXIt
bW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

