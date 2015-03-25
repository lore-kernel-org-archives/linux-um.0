Return-Path: <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
Message-ID: <1427317867.6468.87.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Mar 2015 08:11:07 +1100
In-Reply-To: <20150325183647.GA9331@gmail.com>
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
 <20150325183316.GA9090@gmail.com> <20150325183647.GA9331@gmail.com>
Mime-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>, user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, cov@codeaurora.org, user-mode-linux-user@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

T24gV2VkLCAyMDE1LTAzLTI1IGF0IDE5OjM2ICswMTAwLCBJbmdvIE1vbG5hciB3cm90ZToKPiAq
IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPiB3cm90ZToKPiAKPiA+ID4gKyNkZWZpbmUg
X19IQVZFX0FSQ0hfUkVNQVAKPiA+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhcmNoX3JlbWFwKHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tLAo+ID4gPiArCQkJICAgICAgdW5zaWduZWQgbG9uZyBvbGRfc3Rh
cnQsIHVuc2lnbmVkIGxvbmcgb2xkX2VuZCwKPiA+ID4gKwkJCSAgICAgIHVuc2lnbmVkIGxvbmcg
bmV3X3N0YXJ0LCB1bnNpZ25lZCBsb25nIG5ld19lbmQpCj4gPiA+ICt7Cj4gPiA+ICsJLyoKPiA+
ID4gKwkgKiBtcmVtYXAoKSBkb2Vzbid0IGFsbG93IG1vdmluZyBtdWx0aXBsZSB2bWFzIHNvIHdl
IGNhbiBsaW1pdCB0aGUKPiA+ID4gKwkgKiBjaGVjayB0byBvbGRfc3RhcnQgPT0gdmRzb19iYXNl
Lgo+ID4gPiArCSAqLwo+ID4gPiArCWlmIChvbGRfc3RhcnQgPT0gbW0tPmNvbnRleHQudmRzb19i
YXNlKQo+ID4gPiArCQltbS0+Y29udGV4dC52ZHNvX2Jhc2UgPSBuZXdfc3RhcnQ7Cj4gPiA+ICt9
Cj4gPiAKPiA+IG1yZW1hcCgpIGRvZXNuJ3QgYWxsb3cgbW92aW5nIG11bHRpcGxlIHZtYXMsIGJ1
dCBpdCBhbGxvd3MgdGhlIAo+ID4gbW92ZW1lbnQgb2YgbXVsdGktcGFnZSB2bWFzIGFuZCBpdCBh
bHNvIGFsbG93cyBwYXJ0aWFsIG1yZW1hcCgpcywgCj4gPiB3aGVyZSBpdCB3aWxsIHNwbGl0IHVw
IGEgdm1hLgo+IAo+IEkuZS4gbXJlbWFwKCkgc3VwcG9ydHMgdGhlIHNocmlua2luZyAoYW5kIGdy
b3dpbmcpIG9mIHZtYXMuIEluIHRoYXQgCj4gY2FzZSBtcmVtYXAoKSB3aWxsIHVubWFwIHRoZSBl
bmQgb2YgdGhlIHZtYSBhbmQgd2lsbCBzaHJpbmsgdGhlIAo+IHJlbWFpbmluZyB2RFNPIHZtYS4K
PiAKPiBEb2Vzbid0IHRoYXQgcmVzdWx0IGluIGEgbm9uLXdvcmtpbmcgdkRTTyB0aGF0IHNob3Vs
ZCB6ZXJvIG91dCAKPiB2ZHNvX2Jhc2U/CgpSaWdodC4gTm93IHdlIGNhbid0IGNvbXBsZXRlbHkg
cHJldmVudCB0aGUgdXNlciBmcm9tIHNob290aW5nIGl0c2VsZiBpbgp0aGUgZm9vdCBJIHN1cHBv
c2UsIHRob3VnaCB0aGVyZSBpcyBhIGxlZ2l0IHVzYWdlIHNjZW5hcmlvIHdoaWNoIGlzIHRvCm1v
dmUgdGhlIHZEU08gYXJvdW5kIHdoaWNoIGl0IHdvdWxkIGJlIG5pY2UgdG8gc3VwcG9ydC4gSSB0
aGluayBpdCdzCnJlYXNvbmFibGUgdG8gcHV0IHRoZSBvbnVzIG9uIHRoZSB1c2VyIGhlcmUgdG8g
ZG8gdGhlIHJpZ2h0IHRoaW5nLgoKQ2hlZXJzLApCZW4uCgo+IFRoYW5rcywKPiAKPiAJSW5nbwo+
IC0tCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vi
c2NyaWJlIGxpbnV4LWtlcm5lbCIgaW4KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jk
b21vQHZnZXIua2VybmVsLm9yZwo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2Vy
Lmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbAo+IFBsZWFzZSByZWFkIHRoZSBGQVEgYXQg
IGh0dHA6Ly93d3cudHV4Lm9yZy9sa21sLwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2
QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4
cHBjLWRldg==

