Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Date: Sat,  7 Nov 2009 13:16:18 -0200
Message-Id: <c7d3b02b5e28eaa54a5360d57dfd177c44320187.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH v4 10/12] string: factorize skip_spaces and
	export it to be generally available
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

T24gdGhlIGZvbGxvd2luZyBzZW50ZW5jZToKICAgIHdoaWxlICgqcyAmJiBpc3NwYWNlKCpzKSkK
ICAgICAgICBzKys7CgpJZiAqcyA9PSAwLCBpc3NwYWNlKCkgZXZhbHVhdGVzIHRvICgoX2N0eXBl
WypzXSAmIDB4MjApICE9IDApLCB3aGljaApldmFsdWF0ZXMgdG8gKCgweDA4ICYgMHgyMCkgIT0g
MCkgd2hpY2ggZXF1YWxzIHRvIDAgYXMgd2VsbC4KSWYgKnMgPT0gMSwgd2UgZGVwZW5kIG9uIGlz
c3BhY2UoKSByZXN1bHQgYW55d2F5LgoKSW4gb3RoZXIgd29yZHMsICJhIGNoYXIgZXF1YWxzIHpl
cm8gaXMgbmV2ZXIgYSBzcGFjZSIuIFNvIHJlbW92ZSB0aGlzIGNoZWNrLgpBbHNvLCAqcyAhPSAw
IGlzIGJ5IGZhciB0aGUgbW9zdCBjb21tb24gY2FzZSAobm9uLWVtcHR5IHN0cmluZykuCgpTaWdu
ZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJkQGdtYWlsLmNvbT4K
LS0tCiBpbmNsdWRlL2xpbnV4L3N0cmluZy5oIHwgICAgMSArCiBsaWIvc3RyaW5nLmMgICAgICAg
ICAgIHwgICAxOSArKysrKysrKysrKysrKystLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdHJp
bmcuaCBiL2luY2x1ZGUvbGludXgvc3RyaW5nLmgKaW5kZXggYjg1MDg4Ni4uM2JiYTllZSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9zdHJpbmcuaAorKysgYi9pbmNsdWRlL2xpbnV4L3N0cmlu
Zy5oCkBAIC02Miw2ICs2Miw3IEBAIGV4dGVybiBjaGFyICogc3RybmNocihjb25zdCBjaGFyICos
IHNpemVfdCwgaW50KTsKICNpZm5kZWYgX19IQVZFX0FSQ0hfU1RSUkNIUgogZXh0ZXJuIGNoYXIg
KiBzdHJyY2hyKGNvbnN0IGNoYXIgKixpbnQpOwogI2VuZGlmCitleHRlcm4gY29uc3QgY2hhciAq
IF9fbXVzdF9jaGVjayBza2lwX3NwYWNlcyhjb25zdCBjaGFyICopOwogZXh0ZXJuIGNoYXIgKiBf
X211c3RfY2hlY2sgc3Ryc3RyaXAoY2hhciAqKTsKICNpZm5kZWYgX19IQVZFX0FSQ0hfU1RSU1RS
CiBleHRlcm4gY2hhciAqIHN0cnN0cihjb25zdCBjaGFyICosY29uc3QgY2hhciAqKTsKZGlmZiAt
LWdpdCBhL2xpYi9zdHJpbmcuYyBiL2xpYi9zdHJpbmcuYwppbmRleCBiMTliODdhLi5kOWE1MWQ1
IDEwMDY0NAotLS0gYS9saWIvc3RyaW5nLmMKKysrIGIvbGliL3N0cmluZy5jCkBAIC0zMzAsNiAr
MzMwLDIwIEBAIEVYUE9SVF9TWU1CT0woc3RybmNocik7CiAjZW5kaWYKIAogLyoqCisgKiBza2lw
X3NwYWNlcyAtIFJlbW92ZXMgbGVhZGluZyB3aGl0ZXNwYWNlIGZyb20gQHMuCisgKiBAczogVGhl
IHN0cmluZyB0byBiZSBzdHJpcHBlZC4KKyAqCisgKiBSZXR1cm5zIGEgcG9pbnRlciB0byB0aGUg
Zmlyc3Qgbm9uLXdoaXRlc3BhY2UgY2hhcmFjdGVyIGluIEBzLgorICovCitjb25zdCBjaGFyICpz
a2lwX3NwYWNlcyhjb25zdCBjaGFyICpzdHIpCit7CisJd2hpbGUgKGlzc3BhY2UoKnN0cikpCisJ
CSsrc3RyOworCXJldHVybiBzdHI7Cit9CitFWFBPUlRfU1lNQk9MKHNraXBfc3BhY2VzKTsKKwor
LyoqCiAgKiBzdHJzdHJpcCAtIFJlbW92ZXMgbGVhZGluZyBhbmQgdHJhaWxpbmcgd2hpdGVzcGFj
ZSBmcm9tIEBzLgogICogQHM6IFRoZSBzdHJpbmcgdG8gYmUgc3RyaXBwZWQuCiAgKgpAQCAtMzUy
LDEwICszNjYsNyBAQCBjaGFyICpzdHJzdHJpcChjaGFyICpzKQogCQllbmQtLTsKIAkqKGVuZCAr
IDEpID0gJ1wwJzsKIAotCXdoaWxlICgqcyAmJiBpc3NwYWNlKCpzKSkKLQkJcysrOwotCi0JcmV0
dXJuIHM7CisJcmV0dXJuIChjaGFyICopc2tpcF9zcGFjZXMocyk7CiB9CiBFWFBPUlRfU1lNQk9M
KHN0cnN0cmlwKTsKIAotLSAKMS42LjUuMi4xNTMuZzZlMzFmLmRpcnR5CgoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9ydHMgaGFuZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVl
IENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURheSAKdHJpYWwuIFNpbXBsaWZ5IHlvdXIgcmVwb3J0
IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRlcGxveW1lbnQgLSBhbmQgZm9jdXMgb24gCndoYXQg
eW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRpb24gY29kaW5nLiBEaXNjb3ZlciB3aGF0J3MgbmV3
IHdpdGgKQ3J5c3RhbCBSZXBvcnRzIG5vdy4gIGh0dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1qdWx5
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9k
ZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by91c2VyLW1vZGUtbGludXgtZGV2ZWwK

