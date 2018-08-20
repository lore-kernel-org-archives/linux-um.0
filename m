Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1frro6-0004f3-O8
 for linux-um@lists.infradead.org; Mon, 20 Aug 2018 21:33:52 +0000
Date: Mon, 20 Aug 2018 23:33:31 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: due to kconfig changes kernel config file is no longer
 sufficient for configuring the kernel
Message-ID: <20180820233331.08dd2bfb@naga.suse.cz>
In-Reply-To: <CAK7LNATCktToMui4NYxoUXV8ZbuDK8F0JCp_CysEWaSBPUP7NQ@mail.gmail.com>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
 <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
 <20180628111623.3807fe9b@naga.suse.cz>
 <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
 <20180806200725.4efa5d35@kitsune.suse.cz>
 <CAK7LNATCktToMui4NYxoUXV8ZbuDK8F0JCp_CysEWaSBPUP7NQ@mail.gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Rich Felker <dalias@libc.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Jeff Mahoney <jeffm@suse.com>, Dominik Brodowski <linux@dominikbrodowski.net>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Linux-sh list <linux-sh@vger.kernel.org>, Andreas Schwab <schwab@suse.de>, X86 ML <x86@kernel.org>, "Peter Zijlstra, " <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Kees Cook <keescook@chromium.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, Richard Weinberger <richard@nod.at>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Michal Marek <michal.lkml@markovi.net>, Ulf Magnusson <ulfalizer@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, "David S. Miller" <davem@davemloft.net>

SGVsbG8sCgpPbiBUdWUsIDIxIEF1ZyAyMDE4IDAzOjE1OjEyICswOTAwCk1hc2FoaXJvIFlhbWFk
YSA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+IHdyb3RlOgoKPiAyMDE4LTA4LTA3IDM6
MDcgR01UKzA5OjAwIE1pY2hhbCBTdWNow6FuZWsgPG1zdWNoYW5la0BzdXNlLmRlPjoKPiA+IE9u
IE1vbiwgMzAgSnVsIDIwMTggMTc6MDI6NDIgKzA5MDAKPiA+IE1hc2FoaXJvIFlhbWFkYSA8eWFt
YWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+IHdyb3RlOgo+ID4gIAo+ID4+IDIwMTgtMDYtMjgg
MTg6MTYgR01UKzA5OjAwIE1pY2hhbCBTdWNow6FuZWsgPG1zdWNoYW5la0BzdXNlLmRlPjogIAo+
ID4+ID4gT24gV2VkLCAyNyBKdW4gMjAxOCAyMzowNzoyMSArMDkwMAo+ID4+ID4gTWFzYWhpcm8g
WWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4gd3JvdGU6Cj4gPj4gPiAgCgo+
ID4+Cj4gPj4KPiA+PiAgCj4gPj4gPj4KPiA+PiA+PiBvdXQtb2YtdHJlZSBtb2R1bGVzIGFyZSBi
dWlsdCB3aXRoIGV4YWN0bHkgdGhlIHNhbWUKPiA+PiA+PiBjb25maWd1cmF0aW9uIGFzIHVzZWQg
Zm9yIHRoZSBrZXJuZWwuICAKPiA+PiA+Cj4gPj4gPiBJdCBpcyBub3QgdHJ1ZS4gQW5kIHRoYXQg
aXMgdGhlIHByb2JsZW0uIFlvdSBuZWVkIHRoZSBjb25maWcgZmlsZQo+ID4+ID4gYW5kIGR1bXAg
b2YgdGhlIGVudmlyb25tZW50IHBhc3NlZCB0byB0aGUgbWFrZSBjb21tYW5kIGF0Cj4gPj4gPiBj
b25maWd1cmF0aW9uIHRpbWUgdG8gZ2V0IHRoZSBleGFjdCBzYW1lIGNvbmZpZ3VyYXRpb24uIFRo
ZQo+ID4+ID4gZW52aXJvbm1lbnQgaXMgbm90IHNhdmVkIGFueXdoZXJlLCB0aG91Z2guICAKPiA+
Pgo+ID4+Cj4gPj4gV2h5IGR1bXAgb2YgdGhlIGVudmlyb25tZW50Pwo+ID4+Cj4gPj4KPiA+PiBJ
ZiB5b3UgYXJlIGJ1aWxkaW5nIGV4dGVybmFsIG1vZHVsZXMgbmF0aXZlbHkKPiA+PiB5b3VyIGRp
c3RyaWJ1dGlvbiBwcm92aWRlcyAvbGliL21vZHVsZXMvJCh1bmFtZSAtcikvYnVpbGQsCj4gPj4g
d2hpY2ggY29udGFpbnMgZmlsZXMgZW5vdWdoIGZvciBidWlsZGluZyBleHRlcm5hbCBtb2R1bGVz
Lgo+ID4+Cj4gPj4gWW91IGNhbiBwYXNzIHRoZSBkaXJlY3RvcnkgcGF0aCB0byBNPS4uLiBwYXJh
bWV0ZXIuICBUaGF0J3MgaXQuICAKPiA+Cj4gPiBObywgdGhhdCdzIG5vdCBpdC4gU2luY2UgcGFz
c2luZyBBUkNIPWkzODYgaXMgdGhlIGRlLWZhY3RvIHN0YW5kYXJkCj4gPiB0byBjb25maWd1cmUg
YSAzMmJpdCBrZXJuZWwgYW5kIHRoZSByZXN1bHQgb2YgcGFzc2luZyB0aGF0IHdhcyBub3QKPiA+
IHNhdmVkIHlvdSBuZWVkIHRvIHBhc3MgaXQgdG8gbWFrZSBhcyB3ZWxsLiAgCj4gCj4gCj4gSWYg
eW91IHBhc3MgQVJDSD0gZm9yIHRoZSBjb25maWd1cmF0aW9uIHBoYXNlLAo+IHlvdSBuZWVkIHRv
IHBhc3MgdGhlIHNhbWUgQVJDSD0gaW4gdGhlIGJ1aWxkIHBoYXNlLgo+IAo+IAo+IAo+IAo+IFdo
YXQgSSBjYW4gc3VnZ2VzdCBmb3IgeW91IGlzOgo+IAo+IAo+ICQgbWFrZSBBUkNIPWkzODYgZGVm
Y29uZmlnCj4gJCBtYWtlIEFSQ0g9aTM4Ngo+IAo+ICAgIE9SCj4gCj4gJCBtYWtlIGkzODZfZGVm
Y29uZmlnCj4gJCBtYWtlCgpNYXliZSB5b3UgbWlzc2VkIHRoYXQgYnV0IEkgZG8gbm90IHdhbnQg
dG8gYnVpbGQgdGhlIGRlZmNvbmZpZy4gSSB3YW50CnRvIGJ1aWxkIGEgKnBhcnRpY3VsYXIqIGNv
bmZpZyB3aGljaCBoYXMgYmVlbiBzYXZlZCBpbiBhIGZpbGUKYmVmb3JlaGFuZC4KPiAKPiA+IEFu
ZCB5b3UgbmVlZCB0byBwYXRjaCBhIG51bWJlciBvZgo+ID4gM3JkIHBhcnR5IGJ1aWxkIHNjcmlw
dHMgdGhhdCBidWlsZCBhIGtlcm5lbCBtb2R1bGUgYXMgcGFydCBvZiBhCj4gPiBiaWdnZXIgcHJv
amVjdC4gIAo+IAo+IAo+IFlvdSBkbyBub3QgbmVlZCB0byBwYXRjaCBhIG51bWJlciBvZiBzY3Jp
cHRzLgo+IAo+IEp1c3Qgb25lIGxpbmVyIGZpeC4KPiBBZGQgJ2V4cG9ydCBBUkNIPWkzODYnIGlu
IHRoZSB0b3AgbGV2ZWwgc2NyaXB0LgoKQW5kIHRoYXQgZG9lcyBub3Qgd29yayBiZWNhdXNlIHRo
ZXJlIGlzIG5vIHRvcGxldmVsIHNjcmlwdC4gcnBtIGhhcwp0aHJlZSB0b3BsZXZlbCBzY3JpcHRz
IC0gcHJlcCwgYnVpbGQgYW5kIGluc3RhbGwuCgpCdWlsZGluZyBvdXQtb2YtdHJlZSBtb2R1bGUg
aXMgYW5vdGhlciB0b3BsZXZlbCBzY3JpcHQuCgpBbmQgaXQgZG9lcyBub3Qgc3VmZmljZSB0byAn
ZXhwb3J0IEFSQ0g9aTM4NicuIFdoYXQgaWYgaXQgd2FzIGEgNjRiaXQKY29uZmlnPyBIb3cgZG8g
SSB0ZWxsPwoKV2l0aCBtb3JlIGFuZCBtb3JlIG9wdGlvbnMgbGVmdCBvdXQgb2YgdGhlIGNvbmZp
ZyB0aGF0IGRlcGVuZCBvbgpjb21waWxlciBmZWF0dXJlcywgZW52aXJvbm1lbnQgdmFyaWFibGVz
LCBwaGFzZSBvZiB0aGUgbW9vbiBvciB3aGF0bm90CnlvdSBjYW4ndCBldmVuIHRlbGwgd2hhdCBr
aW5kIG9mIGtlcm5lbCB0aGUgdXNlciBpcyBydW5uaW5nIGJ5IGxvb2tpbmcKYXQgdGhlIGNvbmZp
Zy4KClRoYW5rcwoKTWljaGFsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==

