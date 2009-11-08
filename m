Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <cover.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
Date: Sun, 08 Nov 2009 10:05:03 -0600
Message-Id: <1257696303.4184.8.camel@mulgrave.site>
Mime-Version: 1.0
Subject: Re: [uml-devel] [dm-devel] [PATCH v4 00/12] introduce skip_spaces(),
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
To: device-mapper development <dm-devel@redhat.com>
Cc: Pavel Roskin <proski@gnu.org>, Stefan Haberland <stefan.haberland@de.ibm.com>, Jan Kara <jack@suse.cz>, linux-cachefs@redhat.com, Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steve Dickson <steved@redhat.com>, "James E . J . Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, ibm-acpi-devel@lists.sourceforge.net, Chr@nerdnet.nl, Julia Lawall <julia@diku.dk>, "H . Peter Anvin" <hpa@zytor.com>, Daire Byrne <Daire.Byrne@framestore.com>, Alasdair G Kergon <agk@redhat.com>, Greg Banks <gnb@melbourne.sgi.com>, Stefan Weinhuber <wein@de.ibm.com>, Eric Sandeen <sandeen@redhat.com>, Adam Belay <abelay@mit.edu>, netfilter-devel@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, James Morris <jmorris@namei.org>, Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, WANG Cong <wangcong@zeuux.org>, Roman Hoog Antink <rha@open.ch>, linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrea Righi <righi.andrea@gmail.com>, alsa-devel@alsa-project.org, Len Brown <len.brown@intel.com>, Samuel Ortiz <samuel@sortiz.org>, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, Trond Myklebust <Trond.Myklebust@netapp.com>, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Kyle@nerdnet.nl, Steven Rostedt <rostedt@goodmis.org>, Sitsofe Wheeler <sitsofe@yahoo.com>, linux-raid@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andreas Dilger <adilger@sun.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Mikulas Patocka <mpatocka@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-user@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>, Thomas Gleixner <tglx@linutronix.de>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Arjan van de Ven <arjan@linux.intel.com>, Jan Engelhardt <jengelh@medozas.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Andre Noll <maan@systemlinux.org>, Theodore Ts'o <tytso@mit.edu>, linux-parisc@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>, netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org, Stoyan Gaydarov <stoyboyker@gmail.com>, Patrick McHardy <kaber@trash.net>, n <kyle@mcmartin.ca>, istof Schmitt <christof.schmitt@de.ibm.com>, netfilter@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Joe Perches <joe@perches.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, "David S . Miller" <davem@davemloft.net>

T24gU2F0LCAyMDA5LTExLTA3IGF0IDEzOjE2IC0wMjAwLCBBbmRyw6kgR29kZGFyZCBSb3NhIHdy
b3RlOgo+IFRoaXMgcGF0Y2ggcmVkdWNlcyBsaWIuYSBjb2RlIHNpemUgYnkgMTczIGJ5dGVzIG9u
IG15IENvcmUgMiB3aXRoIGdjYyA0LjQuMQo+IGV2ZW4gY29uc2lkZXJpbmcgdGhhdCBpdCBleHBv
cnRzIGEgbmV3bHkgZGVmaW5lZCBmdW5jdGlvbiBza2lwX3NwYWNlcygpCj4gdG8gZHJpdmVyczoK
PiAgICB0ZXh0ICAgIGRhdGEgICAgIGJzcyAgICAgZGVjICAgICBoZXggZmlsZW5hbWUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAKPiAgIDY0ODY3ICAgICA4NDAgICAgIDU5MiAgIDY2Mjk5ICAg
MTAyZmIgKFRPVEFMUy1saWIuYS1iZWZvcmUpCj4gICA2NDk1NCAgICAgNTg0ICAgICA1ODggICA2
NjEyNiAgIDEwMjRlIChUT1RBTFMtbGliLmEtYWZ0ZXIpCj4gYW5kIGltcGxlbWVudHMgc29tZSBj
b2RlIHRpZHkgdXAuCj4gCj4gQmVzaWRlcyByZWR1Y2luZyBsaWIuYSBzaXplLCBpdCBjb252ZXJ0
cyBtYW55IGluLXRyZWUgZHJpdmVycyB0byB1c2UgdGhlCj4gbmV3bHkgZGVmaW5lZCBmdW5jdGlv
biwgd2hpY2ggbWFrZXMgYW5vdGhlciBzbWFsbCByZWR1Y3Rpb24gb24ga2VybmVsIHNpemUKPiBv
dmVyYWxsIHdoZW4gdGhvc2UgZHJpdmVycyBhcmUgdXNlZC4KCkJlZm9yZSB3ZSBlbWJhcmsgb24g
c29tZXRoaW5nIGFzIG1hc3NpdmUgYXMgdGhpcywgY291bGQgd2UgdGFrZSBhIHN0ZXAKYmFjay4g
IEkgYWdyZWUgdGhhdCBpZiBJIHdlcmUgY29taW5nIHVwIHdpdGggdGhlIHN0cnN0aXAoKSBpbnRl
cmZhY2UKdG9kYXkgSSBwcm9iYWJseSB3b3VsZG4ndCBoYXZlIGdpdmVuIGl0IHR3byBvdmVybG9h
ZGVkIHVzZXMuCgpIb3dldmVyLCBJIHRoaW5rIHRoZSBmdW5jdGlvbiwgaW4gc3BpdGUgb2YgdGhp
cyBtaW5vciBpc3N1ZSwgaXMgdmVyeQp1c2FibGUuICBJIHN0aWxsIGRvbid0IHVuZGVyc3RhbmQg
d2h5IHBlb3BsZSB0aG91Z2h0IGFkZGluZyBhCl9fbXVzdF9jaGVjaywgd2hpY2ggaXMgd2hhdCBk
YW1hZ2VkIG9uZSBvZiB0aGUgb3ZlcmxvYWRlZCB1c2VzLCBpcyBhCmdvb2QgaWRlYS4KCkFzc3Vt
aW5nIHRoZXJlJ3MgYSBnb29kIGFuc3dlciB0byB0aGUgYWJvdmU6Cgo+ICsgKiBza2lwX3NwYWNl
cyAtIFJlbW92ZXMgbGVhZGluZyB3aGl0ZXNwYWNlIGZyb20gQHMuCj4gKyAqIEBzOiBUaGUgc3Ry
aW5nIHRvIGJlIHN0cmlwcGVkLgo+ICsgKgo+ICsgKiBSZXR1cm5zIGEgcG9pbnRlciB0byB0aGUg
Zmlyc3Qgbm9uLXdoaXRlc3BhY2UgY2hhcmFjdGVyIGluIEBzLgo+ICsgKi8KPiArY29uc3QgY2hh
ciAqc2tpcF9zcGFjZXMoY29uc3QgY2hhciAqc3RyKQoKSSBkb24ndCB0aGluayBjb25zdCByZXR1
cm4gaXMgYSBnb29kIGlkZWEgYmVjYXVzZSBtb3N0IGZ1bmN0aW9ucyB3aWxsIGJlCm1hbmlwdWxh
dGluZyB0aGUgc3RyaW5nIGFuZCB1c2luZyBwb2ludGVycyB0aGF0IHdvbid0IGJlIGNvbnN0LCBz
byB0aGlzCndpbGwgZ2VuZXJhdGUgYSB0b24gb2YgJ2luaXRpYWxpemF0aW9uIGRpc2NhcmRzIHF1
YWxpZmllcnMgZnJvbSBwb2ludGVyCnRhcmdldCB0eXBlJyAuLi4gc28gdGhhdCBsZWFkcyB0byB0
aGUgcXVlc3Rpb24gb2Ygd2hldGhlciB0aGlzIHBhdGNoCnNlcmllcyB3YXMgYWN0dWFsbHkgY29t
cGlsZWQgLi4uCgpKYW1lcwoKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTGV0IENyeXN0YWwgUmVw
b3J0cyBoYW5kbGUgdGhlIHJlcG9ydGluZyAtIEZyZWUgQ3J5c3RhbCBSZXBvcnRzIDIwMDggMzAt
RGF5IAp0cmlhbC4gU2ltcGxpZnkgeW91ciByZXBvcnQgZGVzaWduLCBpbnRlZ3JhdGlvbiBhbmQg
ZGVwbG95bWVudCAtIGFuZCBmb2N1cyBvbiAKd2hhdCB5b3UgZG8gYmVzdCwgY29yZSBhcHBsaWNh
dGlvbiBjb2RpbmcuIERpc2NvdmVyIHdoYXQncyBuZXcgd2l0aApDcnlzdGFsIFJlcG9ydHMgbm93
LiAgaHR0cDovL3Auc2YubmV0L3NmdS9ib2JqLWp1bHkKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlz
dApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

