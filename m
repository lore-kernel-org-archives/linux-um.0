Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Date: Sat,  7 Nov 2009 13:16:09 -0200
Message-Id: <643e6260a571b533d8985b377a82410aded4ddae.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH v4 01/12] vsprintf: factorize "(null)" string
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

Q2hhbmdlICI8TlVMTD4iIHRvICIobnVsbCkiIGFuZCBtYWtlIGl0IGEgc3RhdGljIGNvbnN0IGNo
YXJbXSBob3BpbmcgdGhhdAp0aGUgY29tcGlsZXIgd2lsbCBtYWtlIG51bGxfc3RyIGEgbGFiZWwg
dG8gYSByZWFkLW9ubHkgYXJlYSBjb250YWluaW5nIGl0LgoKU2VlOgpodHRwOi8vcGVvcGxlLnJl
ZGhhdC5jb20vZHJlcHBlci9kc29ob3d0by5wZGYgcGFydCAyLjQuMgpodHRwOi8vdWRyZXBwZXIu
bGl2ZWpvdXJuYWwuY29tLzEzODUxLmh0bWwKaHR0cDovL3VkcmVwcGVyLmxpdmVqb3VybmFsLmNv
bS8xNTExOS5odG1sCgpTaWduZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5n
b2RkYXJkQGdtYWlsLmNvbT4KQWNrZWQtYnk6IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZ3ZWlzYmVj
QGdtYWlsLmNvbT4KLS0tCiBsaWIvdnNwcmludGYuYyB8ICAgMTAgKysrKysrLS0tLQogMSBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
bGliL3ZzcHJpbnRmLmMgYi9saWIvdnNwcmludGYuYwppbmRleCAzM2JlZDVlLi4wMDJmNDYyIDEw
MDY0NAotLS0gYS9saWIvdnNwcmludGYuYworKysgYi9saWIvdnNwcmludGYuYwpAQCAtMzQsNiAr
MzQsOCBAQAogLyogV29ya3Mgb25seSBmb3IgZGlnaXRzIGFuZCBsZXR0ZXJzLCBidXQgc21hbGwg
YW5kIGZhc3QgKi8KICNkZWZpbmUgVE9MT1dFUih4KSAoKHgpIHwgMHgyMCkKIAorc3RhdGljIGNv
bnN0IGNoYXIgbnVsbF9zdHJbXSA9ICIobnVsbCkiOworCiBzdGF0aWMgdW5zaWduZWQgaW50IHNp
bXBsZV9ndWVzc19iYXNlKGNvbnN0IGNoYXIgKmNwKQogewogCWlmIChjcFswXSA9PSAnMCcpIHsK
QEAgLTU0NiwxMiArNTQ4LDEyIEBAIHN0YXRpYyBjaGFyICpudW1iZXIoY2hhciAqYnVmLCBjaGFy
ICplbmQsIHVuc2lnbmVkIGxvbmcgbG9uZyBudW0sCiAJcmV0dXJuIGJ1ZjsKIH0KIAotc3RhdGlj
IGNoYXIgKnN0cmluZyhjaGFyICpidWYsIGNoYXIgKmVuZCwgY2hhciAqcywgc3RydWN0IHByaW50
Zl9zcGVjIHNwZWMpCitzdGF0aWMgY2hhciAqc3RyaW5nKGNoYXIgKmJ1ZiwgY2hhciAqZW5kLCBj
b25zdCBjaGFyICpzLCBzdHJ1Y3QgcHJpbnRmX3NwZWMgc3BlYykKIHsKIAlpbnQgbGVuLCBpOwog
CiAJaWYgKCh1bnNpZ25lZCBsb25nKXMgPCBQQUdFX1NJWkUpCi0JCXMgPSAiPE5VTEw+IjsKKwkJ
cyA9IG51bGxfc3RyOwogCiAJbGVuID0gc3RybmxlbihzLCBzcGVjLnByZWNpc2lvbik7CiAKQEAg
LTgyMiw3ICs4MjQsNyBAQCBzdGF0aWMgY2hhciAqcG9pbnRlcihjb25zdCBjaGFyICpmbXQsIGNo
YXIgKmJ1ZiwgY2hhciAqZW5kLCB2b2lkICpwdHIsCiAJCQlzdHJ1Y3QgcHJpbnRmX3NwZWMgc3Bl
YykKIHsKIAlpZiAoIXB0cikKLQkJcmV0dXJuIHN0cmluZyhidWYsIGVuZCwgIihudWxsKSIsIHNw
ZWMpOworCQlyZXR1cm4gc3RyaW5nKGJ1ZiwgZW5kLCBudWxsX3N0ciwgc3BlYyk7CiAKIAlzd2l0
Y2ggKCpmbXQpIHsKIAljYXNlICdGJzoKQEAgLTE0NDUsNyArMTQ0Nyw3IEBAIGRvIHsJCQkJCQkJ
CQlcCiAJCQlzaXplX3QgbGVuOwogCQkJaWYgKCh1bnNpZ25lZCBsb25nKXNhdmVfc3RyID4gKHVu
c2lnbmVkIGxvbmcpLVBBR0VfU0laRQogCQkJCQl8fCAodW5zaWduZWQgbG9uZylzYXZlX3N0ciA8
IFBBR0VfU0laRSkKLQkJCQlzYXZlX3N0ciA9ICI8TlVMTD4iOworCQkJCXNhdmVfc3RyID0gbnVs
bF9zdHI7CiAJCQlsZW4gPSBzdHJsZW4oc2F2ZV9zdHIpOwogCQkJaWYgKHN0ciArIGxlbiArIDEg
PCBlbmQpCiAJCQkJbWVtY3B5KHN0ciwgc2F2ZV9zdHIsIGxlbiArIDEpOwotLSAKMS42LjUuMi4x
NTMuZzZlMzFmLmRpcnR5CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxldCBDcnlzdGFsIFJlcG9y
dHMgaGFuZGxlIHRoZSByZXBvcnRpbmcgLSBGcmVlIENyeXN0YWwgUmVwb3J0cyAyMDA4IDMwLURh
eSAKdHJpYWwuIFNpbXBsaWZ5IHlvdXIgcmVwb3J0IGRlc2lnbiwgaW50ZWdyYXRpb24gYW5kIGRl
cGxveW1lbnQgLSBhbmQgZm9jdXMgb24gCndoYXQgeW91IGRvIGJlc3QsIGNvcmUgYXBwbGljYXRp
b24gY29kaW5nLiBEaXNjb3ZlciB3aGF0J3MgbmV3IHdpdGgKQ3J5c3RhbCBSZXBvcnRzIG5vdy4g
IGh0dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1qdWx5Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QK
VXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

