Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Date: Sat,  7 Nov 2009 13:16:12 -0200
Message-Id: <2dcd51c57b800fd45c15c8b4d3086fbe06cd826a.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH v4 04/12] vsprintf: use TOLOWER whenever possible
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

SXQgZGVjcmVhc2VzIGNvZGUgc2l6ZSBhcyB3ZWxsOgogICB0ZXh0ICAgIGRhdGEgICAgIGJzcyAg
ICAgZGVjICAgICBoZXggZmlsZW5hbWUKICAxNTc2NyAgICAgICAwICAgICAgIDggICAxNTc3NSAg
ICAzZDlmIGxpYi92c3ByaW50Zi5vLWJlZm9yZQogIDE1NzM1ICAgICAgIDAgICAgICAgOCAgIDE1
NzQzICAgIDNkN2YgbGliL3ZzcHJpbnRmLm8tVE9MT1dFUgoKU2lnbmVkLW9mZi1ieTogQW5kcsOp
IEdvZGRhcmQgUm9zYSA8YW5kcmUuZ29kZGFyZEBnbWFpbC5jb20+CkFja2VkLWJ5OiBGcmVkZXJp
YyBXZWlzYmVja2VyIDxmd2Vpc2JlY0BnbWFpbC5jb20+Ci0tLQogbGliL3ZzcHJpbnRmLmMgfCAg
IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGliL3ZzcHJpbnRmLmMgYi9saWIvdnNwcmludGYu
YwppbmRleCAwMDE1M2M1Li4xNGU0MTk3IDEwMDY0NAotLS0gYS9saWIvdnNwcmludGYuYworKysg
Yi9saWIvdnNwcmludGYuYwpAQCAtOTgzLDggKzk4Myw4IEBAIHByZWNpc2lvbjoKIHF1YWxpZmll
cjoKIAkvKiBnZXQgdGhlIGNvbnZlcnNpb24gcXVhbGlmaWVyICovCiAJc3BlYy0+cXVhbGlmaWVy
ID0gLTE7Ci0JaWYgKCpmbXQgPT0gJ2gnIHx8ICpmbXQgPT0gJ2wnIHx8ICpmbXQgPT0gJ0wnIHx8
Ci0JICAgICpmbXQgPT0gJ1onIHx8ICpmbXQgPT0gJ3onIHx8ICpmbXQgPT0gJ3QnKSB7CisJaWYg
KCpmbXQgPT0gJ2gnIHx8IFRPTE9XRVIoKmZtdCkgPT0gJ2wnIHx8CisJICAgIFRPTE9XRVIoKmZt
dCkgPT0gJ3onIHx8ICpmbXQgPT0gJ3QnKSB7CiAJCXNwZWMtPnF1YWxpZmllciA9ICpmbXQrKzsK
IAkJaWYgKHVubGlrZWx5KHNwZWMtPnF1YWxpZmllciA9PSAqZm10KSkgewogCQkJaWYgKHNwZWMt
PnF1YWxpZmllciA9PSAnbCcpIHsKQEAgLTEwNTEsNyArMTA1MSw3IEBAIHF1YWxpZmllcjoKIAkJ
CXNwZWMtPnR5cGUgPSBGT1JNQVRfVFlQRV9MT05HOwogCQllbHNlCiAJCQlzcGVjLT50eXBlID0g
Rk9STUFUX1RZUEVfVUxPTkc7Ci0JfSBlbHNlIGlmIChzcGVjLT5xdWFsaWZpZXIgPT0gJ1onIHx8
IHNwZWMtPnF1YWxpZmllciA9PSAneicpIHsKKwl9IGVsc2UgaWYgKFRPTE9XRVIoc3BlYy0+cXVh
bGlmaWVyKSA9PSAneicpIHsKIAkJc3BlYy0+dHlwZSA9IEZPUk1BVF9UWVBFX1NJWkVfVDsKIAl9
IGVsc2UgaWYgKHNwZWMtPnF1YWxpZmllciA9PSAndCcpIHsKIAkJc3BlYy0+dHlwZSA9IEZPUk1B
VF9UWVBFX1BUUkRJRkY7CkBAIC0xMTk4LDggKzExOTgsNyBAQCBpbnQgdnNucHJpbnRmKGNoYXIg
KmJ1Ziwgc2l6ZV90IHNpemUsIGNvbnN0IGNoYXIgKmZtdCwgdmFfbGlzdCBhcmdzKQogCQkJaWYg
KHF1YWxpZmllciA9PSAnbCcpIHsKIAkJCQlsb25nICppcCA9IHZhX2FyZyhhcmdzLCBsb25nICop
OwogCQkJCSppcCA9IChzdHIgLSBidWYpOwotCQkJfSBlbHNlIGlmIChxdWFsaWZpZXIgPT0gJ1on
IHx8Ci0JCQkJCXF1YWxpZmllciA9PSAneicpIHsKKwkJCX0gZWxzZSBpZiAoVE9MT1dFUihxdWFs
aWZpZXIpID09ICd6JykgewogCQkJCXNpemVfdCAqaXAgPSB2YV9hcmcoYXJncywgc2l6ZV90ICop
OwogCQkJCSppcCA9IChzdHIgLSBidWYpOwogCQkJfSBlbHNlIHsKQEAgLTE0OTAsNyArMTQ4OSw3
IEBAIGRvIHsJCQkJCQkJCQlcCiAJCQl2b2lkICpza2lwX2FyZzsKIAkJCWlmIChxdWFsaWZpZXIg
PT0gJ2wnKQogCQkJCXNraXBfYXJnID0gdmFfYXJnKGFyZ3MsIGxvbmcgKik7Ci0JCQllbHNlIGlm
IChxdWFsaWZpZXIgPT0gJ1onIHx8IHF1YWxpZmllciA9PSAneicpCisJCQllbHNlIGlmIChUT0xP
V0VSKHF1YWxpZmllcikgPT0gJ3onKQogCQkJCXNraXBfYXJnID0gdmFfYXJnKGFyZ3MsIHNpemVf
dCAqKTsKIAkJCWVsc2UKIAkJCQlza2lwX2FyZyA9IHZhX2FyZyhhcmdzLCBpbnQgKik7CkBAIC0x
ODAxLDggKzE4MDAsOCBAQCBpbnQgdnNzY2FuZihjb25zdCBjaGFyICpidWYsIGNvbnN0IGNoYXIg
KmZtdCwgdmFfbGlzdCBhcmdzKQogCiAJCS8qIGdldCBjb252ZXJzaW9uIHF1YWxpZmllciAqLwog
CQlxdWFsaWZpZXIgPSAtMTsKLQkJaWYgKCpmbXQgPT0gJ2gnIHx8ICpmbXQgPT0gJ2wnIHx8ICpm
bXQgPT0gJ0wnIHx8Ci0JCSAgICAqZm10ID09ICdaJyB8fCAqZm10ID09ICd6JykgeworCQlpZiAo
KmZtdCA9PSAnaCcgfHwgVE9MT1dFUigqZm10KSA9PSAnbCcgfHwKKwkJICAgIFRPTE9XRVIoKmZt
dCkgPT0gJ3onKSB7CiAJCQlxdWFsaWZpZXIgPSAqZm10Kys7CiAJCQlpZiAodW5saWtlbHkocXVh
bGlmaWVyID09ICpmbXQpKSB7CiAJCQkJaWYgKHF1YWxpZmllciA9PSAnaCcpIHsKLS0gCjEuNi41
LjIuMTUzLmc2ZTMxZi5kaXJ0eQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3RhbCBS
ZXBvcnRzIGhhbmRsZSB0aGUgcmVwb3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAz
MC1EYXkgCnRyaWFsLiBTaW1wbGlmeSB5b3VyIHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFu
ZCBkZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9uIAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxp
Y2F0aW9uIGNvZGluZy4gRGlzY292ZXIgd2hhdCdzIG5ldyB3aXRoCkNyeXN0YWwgUmVwb3J0cyBu
b3cuICBodHRwOi8vcC5zZi5uZXQvc2Z1L2JvYmotanVseQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBs
aXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVs
Cg==

