Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Date: Sat,  7 Nov 2009 13:16:15 -0200
Message-Id: <7206ef594e67a240a842339f520284de6569b1fc.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH v4 07/12] vsprintf: factor out skip_space code
	in a separate function
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

SXQgZGVjcmVhc2VzIGNvZGUgc2l6ZToKICAgdGV4dCAgICBkYXRhICAgICBic3MgICAgIGRlYyAg
ICAgaGV4IGZpbGVuYW1lCiAgMTU3MTkgICAgICAgMCAgICAgICA4ICAgMTU3MjcgICAgM2Q2ZiBs
aWIvdnNwcmludGYuby1iZWZvcmUKICAxNTU0MyAgICAgICAwICAgICAgIDggICAxNTU1MSAgICAz
Y2JmIGxpYi92c3ByaW50Zi5vLWFmdGVyCgpTaWduZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBS
b3NhIDxhbmRyZS5nb2RkYXJkQGdtYWlsLmNvbT4KQWNrZWQtYnk6IEZyZWRlcmljIFdlaXNiZWNr
ZXIgPGZ3ZWlzYmVjQGdtYWlsLmNvbT4KLS0tCiBsaWIvdnNwcmludGYuYyB8ICAgMTkgKysrKysr
KysrKystLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi92c3ByaW50Zi5jIGIvbGliL3ZzcHJpbnRmLmMKaW5k
ZXggZjcwM2ZkZi4uNTY2Yzk0NyAxMDA2NDQKLS0tIGEvbGliL3ZzcHJpbnRmLmMKKysrIGIvbGli
L3ZzcHJpbnRmLmMKQEAgLTE3MzYsNiArMTczNiwxMyBAQCBFWFBPUlRfU1lNQk9MX0dQTChicHJp
bnRmKTsKIAogI2VuZGlmIC8qIENPTkZJR19CSU5BUllfUFJJTlRGICovCiAKK3N0YXRpYyBub2lu
bGluZSBjb25zdCBjaGFyICpza2lwX3NwYWNlKGNvbnN0IGNoYXIgKnN0cikKK3sKKwl3aGlsZSAo
aXNzcGFjZSgqc3RyKSkKKwkJKytzdHI7CisJcmV0dXJuIHN0cjsKK30KKwogLyoqCiAgKiB2c3Nj
YW5mIC0gVW5mb3JtYXQgYSBidWZmZXIgaW50byBhIGxpc3Qgb2YgYXJndW1lbnRzCiAgKiBAYnVm
OglpbnB1dCBidWZmZXIKQEAgLTE3NTcsMTAgKzE3NjQsOCBAQCBpbnQgdnNzY2FuZihjb25zdCBj
aGFyICpidWYsIGNvbnN0IGNoYXIgKmZtdCwgdmFfbGlzdCBhcmdzKQogCQkgKiB3aGl0ZSBzcGFj
ZSwgaW5jbHVkaW5nIG5vbmUsIGluIHRoZSBpbnB1dC4KIAkJICovCiAJCWlmIChpc3NwYWNlKCpm
bXQpKSB7Ci0JCQl3aGlsZSAoaXNzcGFjZSgqZm10KSkKLQkJCQkrK2ZtdDsKLQkJCXdoaWxlIChp
c3NwYWNlKCpzdHIpKQotCQkJCSsrc3RyOworCQkJZm10ID0gc2tpcF9zcGFjZShmbXQpOworCQkJ
c3RyID0gc2tpcF9zcGFjZShzdHIpOwogCQl9CiAKIAkJLyogYW55dGhpbmcgdGhhdCBpcyBub3Qg
YSBjb252ZXJzaW9uIG11c3QgbWF0Y2ggZXhhY3RseSAqLwpAQCAtMTgzMCw4ICsxODM1LDcgQEAg
aW50IHZzc2NhbmYoY29uc3QgY2hhciAqYnVmLCBjb25zdCBjaGFyICpmbXQsIHZhX2xpc3QgYXJn
cykKIAkJCWlmIChmaWVsZF93aWR0aCA9PSAtMSkKIAkJCQlmaWVsZF93aWR0aCA9IElOVF9NQVg7
CiAJCQkvKiBmaXJzdCwgc2tpcCBsZWFkaW5nIHdoaXRlIHNwYWNlIGluIGJ1ZmZlciAqLwotCQkJ
d2hpbGUgKGlzc3BhY2UoKnN0cikpCi0JCQkJc3RyKys7CisJCQlzdHIgPSBza2lwX3NwYWNlKHN0
cik7CiAKIAkJCS8qIG5vdyBjb3B5IHVudGlsIG5leHQgd2hpdGUgc3BhY2UgKi8KIAkJCXdoaWxl
ICgqc3RyICYmICFpc3NwYWNlKCpzdHIpICYmIGZpZWxkX3dpZHRoLS0pCkBAIC0xODczLDggKzE4
NzcsNyBAQCBpbnQgdnNzY2FuZihjb25zdCBjaGFyICpidWYsIGNvbnN0IGNoYXIgKmZtdCwgdmFf
bGlzdCBhcmdzKQogCQkvKiBoYXZlIHNvbWUgc29ydCBvZiBpbnRlZ2VyIGNvbnZlcnNpb24uCiAJ
CSAqIGZpcnN0LCBza2lwIHdoaXRlIHNwYWNlIGluIGJ1ZmZlci4KIAkJICovCi0JCXdoaWxlIChp
c3NwYWNlKCpzdHIpKQotCQkJc3RyKys7CisJCXN0ciA9IHNraXBfc3BhY2Uoc3RyKTsKIAogCQlk
aWdpdCA9ICpzdHI7CiAJCWlmIChpc19zaWduICYmIGRpZ2l0ID09ICctJykKLS0gCjEuNi41LjIu
MTUzLmc2ZTMxZi5kaXJ0eQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3RhbCBSZXBv
cnRzIGhhbmRsZSB0aGUgcmVwb3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1E
YXkgCnRyaWFsLiBTaW1wbGlmeSB5b3VyIHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFuZCBk
ZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9uIAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0
aW9uIGNvZGluZy4gRGlzY292ZXIgd2hhdCdzIG5ldyB3aXRoCkNyeXN0YWwgUmVwb3J0cyBub3cu
ICBodHRwOi8vcC5zZi5uZXQvc2Z1L2JvYmotanVseQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0
ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

