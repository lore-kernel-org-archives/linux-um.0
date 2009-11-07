Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Date: Sat,  7 Nov 2009 13:16:16 -0200
Message-Id: <57d62b178a5bbd0393e83a2293ba933e60ddc658.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH v4 08/12] vsprintf: reuse almost identical
	simple_strtoulX() functions
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

VGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBzaW1wbGVfc3RydG91bCgpIGFuZCBzaW1wbGVfc3RydG91
bGwoKSBpcyBqdXN0CnRoZSBzaXplIG9mIHRoZSB2YXJpYWJsZSB1c2VkIHRvIGtlZXAgdHJhY2sg
b2YgdGhlIHN1bSBvZiBjaGFyYWN0ZXJzCmNvbnZlcnRlZCB0byBudW1iZXJzOgoKdW5zaWduZWQg
bG9uZyBzaW1wbGVfc3RydG91bCgpIHsuLi59CnVuc2lnbmVkIGxvbmcgbG9uZyBzaW1wbGVfc3Ry
dG91bGwoKXsuLi59CgpCb3RoIGFyZSBzYW1lIHNpemUgKDggYnl0ZXMpIG9uIG15IENvcmUgMi9n
Y2MgNC40LjEuCk92ZXJmbG93IGNvbmRpdGlvbiBpcyBub3QgY2hlY2tlZCBvbiBib3RoIGZ1bmN0
aW9ucywgc28gYW4gZXh0cmVtZWx5IGxhcmdlCnN0cmluZyBjYW4gYnJlYWsgdGhlc2UgZnVuY3Rp
b25zIHNvIHRoYXQgdGhleSBkb24ndCBldmVuIG5vdGljZSBpdC4KCkFzIHdlIGRvIG5vdCBjYXJl
IGZvciBvdmVyZmxvd2luZyBvbiB0aGVzZSBmdW5jdGlvbnMsIGFsd2F5cyBrZWVwIHRoZSBzdW0K
dXNpbmcgdGhlIGxhcmdlciB2YXJpYWJsZSBhcm91bmQgKHVuc2lnbmVkIGxvbmcgbG9uZykgb24g
c2ltcGxlX3N0cnRvdWxsKCkKYW5kIGNhc3QgaXQgdG8gKHVuc2lnbmVkIGxvbmcpIG9uIHNpbXBs
ZV9zdHJ0b3VsKCksIHdoaWNoIHRoZW4gYmVjb21lcwpqdXN0IGEgd3JhcHBlciBhcm91bmQgc2lt
cGxlX3N0cnRvdWxsKCkuCgpDb2RlIHNpemUgZGVjcmVhc2VzIGJ5IDMwNCBieXRlczoKICAgdGV4
dCAgICBkYXRhICAgICBic3MgICAgIGRlYyAgICAgaGV4IGZpbGVuYW1lCiAgMTU1NDMgICAgICAg
MCAgICAgICA4ICAgMTU1NTEgICAgM2NiZiBsaWIvdnNwcmludGYuby1iZWZvcmUKICAxNTIzOSAg
ICAgICAwICAgICAgIDggICAxNTI0NyAgICAzYjhmIGxpYi92c3ByaW50Zi5vLWFmdGVyCgpTaWdu
ZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJkQGdtYWlsLmNvbT4K
QWNrZWQtYnk6IEluZ28gTW9sbmFyIDxtaW5nb0BlbHRlLmh1PgotLS0KIGxpYi92c3ByaW50Zi5j
IHwgICA0OCArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
IDEgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvbGliL3ZzcHJpbnRmLmMgYi9saWIvdnNwcmludGYuYwppbmRleCA1NjZjOTQ3Li43
ZWM5NmEzIDEwMDY0NAotLS0gYS9saWIvdnNwcmludGYuYworKysgYi9saWIvdnNwcmludGYuYwpA
QCAtNDksMTQgKzQ5LDE0IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgc2ltcGxlX2d1ZXNzX2Jhc2Uo
Y29uc3QgY2hhciAqY3ApCiB9CiAKIC8qKgotICogc2ltcGxlX3N0cnRvdWwgLSBjb252ZXJ0IGEg
c3RyaW5nIHRvIGFuIHVuc2lnbmVkIGxvbmcKKyAqIHNpbXBsZV9zdHJ0b3VsbCAtIGNvbnZlcnQg
YSBzdHJpbmcgdG8gYW4gdW5zaWduZWQgbG9uZyBsb25nCiAgKiBAY3A6IFRoZSBzdGFydCBvZiB0
aGUgc3RyaW5nCiAgKiBAZW5kcDogQSBwb2ludGVyIHRvIHRoZSBlbmQgb2YgdGhlIHBhcnNlZCBz
dHJpbmcgd2lsbCBiZSBwbGFjZWQgaGVyZQogICogQGJhc2U6IFRoZSBudW1iZXIgYmFzZSB0byB1
c2UKICAqLwotdW5zaWduZWQgbG9uZyBzaW1wbGVfc3RydG91bChjb25zdCBjaGFyICpjcCwgY2hh
ciAqKmVuZHAsIHVuc2lnbmVkIGludCBiYXNlKQordW5zaWduZWQgbG9uZyBsb25nIHNpbXBsZV9z
dHJ0b3VsbChjb25zdCBjaGFyICpjcCwgY2hhciAqKmVuZHAsIHVuc2lnbmVkIGludCBiYXNlKQog
ewotCXVuc2lnbmVkIGxvbmcgcmVzdWx0ID0gMDsKKwl1bnNpZ25lZCBsb25nIGxvbmcgcmVzdWx0
ID0gMDsKIAogCWlmICghYmFzZSkKIAkJYmFzZSA9IHNpbXBsZV9ndWVzc19iYXNlKGNwKTsKQEAg
LTc4LDU0ICs3OCwzNCBAQCB1bnNpZ25lZCBsb25nIHNpbXBsZV9zdHJ0b3VsKGNvbnN0IGNoYXIg
KmNwLCBjaGFyICoqZW5kcCwgdW5zaWduZWQgaW50IGJhc2UpCiAKIAlyZXR1cm4gcmVzdWx0Owog
fQotRVhQT1JUX1NZTUJPTChzaW1wbGVfc3RydG91bCk7CitFWFBPUlRfU1lNQk9MKHNpbXBsZV9z
dHJ0b3VsbCk7CiAKIC8qKgotICogc2ltcGxlX3N0cnRvbCAtIGNvbnZlcnQgYSBzdHJpbmcgdG8g
YSBzaWduZWQgbG9uZworICogc2ltcGxlX3N0cnRvdWwgLSBjb252ZXJ0IGEgc3RyaW5nIHRvIGFu
IHVuc2lnbmVkIGxvbmcKICAqIEBjcDogVGhlIHN0YXJ0IG9mIHRoZSBzdHJpbmcKICAqIEBlbmRw
OiBBIHBvaW50ZXIgdG8gdGhlIGVuZCBvZiB0aGUgcGFyc2VkIHN0cmluZyB3aWxsIGJlIHBsYWNl
ZCBoZXJlCiAgKiBAYmFzZTogVGhlIG51bWJlciBiYXNlIHRvIHVzZQogICovCi1sb25nIHNpbXBs
ZV9zdHJ0b2woY29uc3QgY2hhciAqY3AsIGNoYXIgKiplbmRwLCB1bnNpZ25lZCBpbnQgYmFzZSkK
K3Vuc2lnbmVkIGxvbmcgc2ltcGxlX3N0cnRvdWwoY29uc3QgY2hhciAqY3AsIGNoYXIgKiplbmRw
LCB1bnNpZ25lZCBpbnQgYmFzZSkKIHsKLQlpZiAoKmNwID09ICctJykKLQkJcmV0dXJuIC1zaW1w
bGVfc3RydG91bChjcCArIDEsIGVuZHAsIGJhc2UpOwotCi0JcmV0dXJuIHNpbXBsZV9zdHJ0b3Vs
KGNwLCBlbmRwLCBiYXNlKTsKKwlyZXR1cm4gKHVuc2lnbmVkIGxvbmcpc2ltcGxlX3N0cnRvdWxs
KGNwLCBlbmRwLCBiYXNlKTsKIH0KLUVYUE9SVF9TWU1CT0woc2ltcGxlX3N0cnRvbCk7CitFWFBP
UlRfU1lNQk9MKHNpbXBsZV9zdHJ0b3VsKTsKIAogLyoqCi0gKiBzaW1wbGVfc3RydG91bGwgLSBj
b252ZXJ0IGEgc3RyaW5nIHRvIGFuIHVuc2lnbmVkIGxvbmcgbG9uZworICogc2ltcGxlX3N0cnRv
bCAtIGNvbnZlcnQgYSBzdHJpbmcgdG8gYSBzaWduZWQgbG9uZwogICogQGNwOiBUaGUgc3RhcnQg
b2YgdGhlIHN0cmluZwogICogQGVuZHA6IEEgcG9pbnRlciB0byB0aGUgZW5kIG9mIHRoZSBwYXJz
ZWQgc3RyaW5nIHdpbGwgYmUgcGxhY2VkIGhlcmUKICAqIEBiYXNlOiBUaGUgbnVtYmVyIGJhc2Ug
dG8gdXNlCiAgKi8KLXVuc2lnbmVkIGxvbmcgbG9uZyBzaW1wbGVfc3RydG91bGwoY29uc3QgY2hh
ciAqY3AsIGNoYXIgKiplbmRwLCB1bnNpZ25lZCBpbnQgYmFzZSkKK2xvbmcgc2ltcGxlX3N0cnRv
bChjb25zdCBjaGFyICpjcCwgY2hhciAqKmVuZHAsIHVuc2lnbmVkIGludCBiYXNlKQogewotCXVu
c2lnbmVkIGxvbmcgbG9uZyByZXN1bHQgPSAwOwotCi0JaWYgKCFiYXNlKQotCQliYXNlID0gc2lt
cGxlX2d1ZXNzX2Jhc2UoY3ApOwotCi0JaWYgKGJhc2UgPT0gMTYgJiYgY3BbMF0gPT0gJzAnICYm
IFRPTE9XRVIoY3BbMV0pID09ICd4JykKLQkJY3AgKz0gMjsKLQotCXdoaWxlIChpc3hkaWdpdCgq
Y3ApKSB7Ci0JCXVuc2lnbmVkIGludCB2YWx1ZTsKLQotCQl2YWx1ZSA9IGlzZGlnaXQoKmNwKSA/
ICpjcCAtICcwJyA6IFRPTE9XRVIoKmNwKSAtICdhJyArIDEwOwotCQlpZiAodmFsdWUgPj0gYmFz
ZSkKLQkJCWJyZWFrOwotCQlyZXN1bHQgPSByZXN1bHQgKiBiYXNlICsgdmFsdWU7Ci0JCWNwKys7
Ci0JfQotCWlmIChlbmRwKQotCQkqZW5kcCA9IChjaGFyICopY3A7CisJaWYgKCpjcCA9PSAnLScp
CisJCXJldHVybiAtc2ltcGxlX3N0cnRvdWwoY3AgKyAxLCBlbmRwLCBiYXNlKTsKIAotCXJldHVy
biByZXN1bHQ7CisJcmV0dXJuIHNpbXBsZV9zdHJ0b3VsKGNwLCBlbmRwLCBiYXNlKTsKIH0KLUVY
UE9SVF9TWU1CT0woc2ltcGxlX3N0cnRvdWxsKTsKK0VYUE9SVF9TWU1CT0woc2ltcGxlX3N0cnRv
bCk7CiAKIC8qKgogICogc2ltcGxlX3N0cnRvbGwgLSBjb252ZXJ0IGEgc3RyaW5nIHRvIGEgc2ln
bmVkIGxvbmcgbG9uZwotLSAKMS42LjUuMi4xNTMuZzZlMzFmLmRpcnR5CgoKLS0tLS0tLS0tLS0t
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

