Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Date: Sat,  7 Nov 2009 13:16:08 -0200
Message-Id: <cover.1257602781.git.andre.goddard@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH v4 00/12] introduce skip_spaces(),
	reducing code size plus some clean-ups
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

VGhpcyBwYXRjaCByZWR1Y2VzIGxpYi5hIGNvZGUgc2l6ZSBieSAxNzMgYnl0ZXMgb24gbXkgQ29y
ZSAyIHdpdGggZ2NjIDQuNC4xCmV2ZW4gY29uc2lkZXJpbmcgdGhhdCBpdCBleHBvcnRzIGEgbmV3
bHkgZGVmaW5lZCBmdW5jdGlvbiBza2lwX3NwYWNlcygpCnRvIGRyaXZlcnM6CiAgIHRleHQgICAg
ZGF0YSAgICAgYnNzICAgICBkZWMgICAgIGhleCBmaWxlbmFtZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgIAogIDY0ODY3ICAgICA4NDAgICAgIDU5MiAgIDY2Mjk5ICAgMTAyZmIgKFRPVEFMUy1s
aWIuYS1iZWZvcmUpCiAgNjQ5NTQgICAgIDU4NCAgICAgNTg4ICAgNjYxMjYgICAxMDI0ZSAoVE9U
QUxTLWxpYi5hLWFmdGVyKQphbmQgaW1wbGVtZW50cyBzb21lIGNvZGUgdGlkeSB1cC4KCkJlc2lk
ZXMgcmVkdWNpbmcgbGliLmEgc2l6ZSwgaXQgY29udmVydHMgbWFueSBpbi10cmVlIGRyaXZlcnMg
dG8gdXNlIHRoZQpuZXdseSBkZWZpbmVkIGZ1bmN0aW9uLCB3aGljaCBtYWtlcyBhbm90aGVyIHNt
YWxsIHJlZHVjdGlvbiBvbiBrZXJuZWwgc2l6ZQpvdmVyYWxsIHdoZW4gdGhvc2UgZHJpdmVycyBh
cmUgdXNlZC4KCnAucy46IEluZ28sIEkgaG9wZSB0byBoYXZlIGZpbmFsbHkgZml4ZWQgbXkgZW52
aXJvbm1lbnQgYnkgdXNpbmcgc2VuZC1lbWFpbCBub3cuClBsZWFzZSBsZXQgbWUga25vdyBpZiB5
b3UgaGF2ZSBhbnkgcHJvYmxlbSB3aXRoIHRoZXNlIGFuZCB0aGFuayB5b3UgZm9yIHRoZQpnb29k
IGFkdmljZS4gZ2V0X21haW50YWluZXIucGwgZ2F2ZSBsb3RzIG9mIHBlb3BsZSBhcyBvdXRwdXQs
IEkgaG9wZSB0aGF0J3Mgb2suCgpDaGFuZ2Vsb2c6CiAgIHY0OiBjb252ZXJ0IGRyaXZlcnMgb3Zl
ciBuZXdseSBkZWZpbmVkIHNraXBfc3BhY2VzKCkgZnVuY3Rpb24gCiAgIHYzOiBpbXByb3ZlZCBj
b21tZW50cyBvbiBwYXRjaCA1LzcgYW5kIGZhY3Rvcml6ZSBhIHN3aXRjaCBzdGF0ZW1lbnQgb24g
Ni83CmFzIHBlciBzdWdnZXN0aW9ucyBmcm9tIEluZ28gYW5kIEZyZWRlcmljICh0aGFua3MhKQog
ICB2MjogYWRkcmVzc2VkIGZlZWRiYWNrIGZyb20gRnJlZGVyaWMgV2Vpc2JlY2tlciByZXZpZXcg
KHRoYW5rcyEhKQphbmQgc3BsaXQgaW50byBzZXBhcmF0ZSBwYXRjaGVzCiAgIHYxOiBvcmlnaW5h
bCBzdWJtaXNzaW9uCgpBbmRyw6kgR29kZGFyZCBSb3NhICgxMik6CiAgdnNwcmludGY6IGZhY3Rv
cml6ZSAiKG51bGwpIiBzdHJpbmcKICB2c3ByaW50ZjogcHJlLWNhbGN1bGF0ZSBmaW5hbCBzdHJp
bmcgbGVuZ3RoIGZvciBsYXRlciB1c2UKICB2c3ByaW50ZjogZ2l2ZSBpdCBzb21lIGNhcmUgdG8g
cGxlYXNlIGNoZWNrcGF0Y2gucGwKICB2c3ByaW50ZjogdXNlIFRPTE9XRVIgd2hlbmV2ZXIgcG9z
c2libGUKICB2c3ByaW50ZjogcmVkdWNlIGNvZGUgc2l6ZSBieSBhdm9pZGluZyBleHRyYSBjaGVj
awogIHZzcHJpbnRmOiBtb3ZlIGxvY2FsIHZhcnMgdG8gYmxvY2sgbG9jYWwgdmFycyBhbmQgcmVt
b3ZlIHVubmVlZGVkCiAgICBvbmVzCiAgdnNwcmludGY6IGZhY3RvciBvdXQgc2tpcF9zcGFjZSBj
b2RlIGluIGEgc2VwYXJhdGUgZnVuY3Rpb24KICB2c3ByaW50ZjogcmV1c2UgYWxtb3N0IGlkZW50
aWNhbCBzaW1wbGVfc3RydG91bFgoKSBmdW5jdGlvbnMKICBjdHlwZTogY29uc3RpZnkgcmVhZC1v
bmx5IF9jdHlwZSBzdHJpbmcKICBzdHJpbmc6IGZhY3Rvcml6ZSBza2lwX3NwYWNlcyBhbmQgZXhw
b3J0IGl0IHRvIGJlIGdlbmVyYWxseSBhdmFpbGFibGUKICBzdHJpbmc6IG9uIHN0cnN0cmlwKCks
IGZpcnN0IHJlbW92ZSBsZWFkaW5nIHNwYWNlcyBiZWZvcmUgcnVubmluZwogICAgb3ZlciBzdHIK
ICB0cmVlLXdpZGU6IGNvbnZlcnQgb3BlbiBjYWxscyB0byByZW1vdmUgc3BhY2VzIHRvIHNraXBf
c3BhY2VzKCkgbGliCiAgICBmdW5jdGlvbgoKIGFyY2gvczM5MC9rZXJuZWwvZGVidWcuYyAgICAg
ICAgICAgICAgfCAgICAzICstCiBhcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5jICAgICAg
IHwgICAxNiArLQogYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2lmLmMgICAgICAgICB8ICAgMTEg
Ky0KIGRyaXZlcnMvbWQvZG0tdGFibGUuYyAgICAgICAgICAgICAgICAgfCAgICA2ICstCiBkcml2
ZXJzL21kL21kLmMgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNCArLQogZHJpdmVycy9wYXJp
c2MvcGRjX3N0YWJsZS5jICAgICAgICAgICB8ICAgIDkgKy0KIGRyaXZlcnMvcGxhdGZvcm0veDg2
L3RoaW5rcGFkX2FjcGkuYyAgfCAgICA3ICstCiBkcml2ZXJzL3BucC9pbnRlcmZhY2UuYyAgICAg
ICAgICAgICAgIHwgICAzNiArLS0tCiBkcml2ZXJzL3MzOTAvYmxvY2svZGFzZF9wcm9jLmMgICAg
ICAgIHwgICAgNSArLQogZHJpdmVycy92aWRlby9iYWNrbGlnaHQvbGNkLmMgICAgICAgICB8ICAg
IDQgKy0KIGRyaXZlcnMvdmlkZW8vZGlzcGxheS9kaXNwbGF5LXN5c2ZzLmMgfCAgICAyICstCiBm
cy9jYWNoZWZpbGVzL2RhZW1vbi5jICAgICAgICAgICAgICAgIHwgICAgOCArLQogZnMvZXh0NC9z
dXBlci5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDcgKy0KIGluY2x1ZGUvbGludXgvY3R5
cGUuaCAgICAgICAgICAgICAgICAgfCAgICAyICstCiBpbmNsdWRlL2xpbnV4L3N0cmluZy5oICAg
ICAgICAgICAgICAgIHwgICAgMSArCiBrZXJuZWwvcGFyYW1zLmMgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgOCArLQogbGliL2FyZ3Zfc3BsaXQuYyAgICAgICAgICAgICAgICAgICAgICB8ICAg
MTMgKy0KIGxpYi9jdHlwZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUwICsrKy0t
LQogbGliL2R5bmFtaWNfZGVidWcuYyAgICAgICAgICAgICAgICAgICB8ICAgIDQgKy0KIGxpYi9z
dHJpbmcuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDE5ICsrLQogbGliL3ZzcHJpbnRm
LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAzNDIgKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tCiBuZXQvaXJkYS9pcm5ldC9pcm5ldC5oICAgICAgICAgICAgICAgIHwgICAgMSAr
CiBuZXQvaXJkYS9pcm5ldC9pcm5ldF9wcHAuYyAgICAgICAgICAgIHwgICAgOCArLQogbmV0L25l
dGZpbHRlci94dF9yZWNlbnQuYyAgICAgICAgICAgICB8ICAgIDMgKy0KIHNvdW5kL3BjaS9oZGEv
aGRhX2h3ZGVwLmMgICAgICAgICAgICAgfCAgICA3ICstCiAyNSBmaWxlcyBjaGFuZ2VkLCAyNjQg
aW5zZXJ0aW9ucygrKSwgMzEyIGRlbGV0aW9ucygtKQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpM
ZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0aGUgcmVwb3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJl
cG9ydHMgMjAwOCAzMC1EYXkgCnRyaWFsLiBTaW1wbGlmeSB5b3VyIHJlcG9ydCBkZXNpZ24sIGlu
dGVncmF0aW9uIGFuZCBkZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9uIAp3aGF0IHlvdSBkbyBiZXN0
LCBjb3JlIGFwcGxpY2F0aW9uIGNvZGluZy4gRGlzY292ZXIgd2hhdCdzIG5ldyB3aXRoCkNyeXN0
YWwgUmVwb3J0cyBub3cuICBodHRwOi8vcC5zZi5uZXQvc2Z1L2JvYmotanVseQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2
ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2Rl
LWxpbnV4LWRldmVsCg==

