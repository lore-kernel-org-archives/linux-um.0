Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 20 May 2022 21:58:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
Message-ID: <20220520195848.GY2578@worktop.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <YodEWlfo4kFd8+mt@linutronix.de>
 <87wnegyp87.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87wnegyp87.fsf@email.froward.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org, Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Douglas Miller <dougmill@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

T24gRnJpLCBNYXkgMjAsIDIwMjIgYXQgMDI6MzI6MjRQTSAtMDUwMCwgRXJpYyBXLiBCaWVkZXJt
YW4gd3JvdGU6Cj4gU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4
LmRlPiB3cml0ZXM6Cj4gCj4gPiBPbiAyMDIyLTA1LTE4IDE3OjQ5OjUwIFstMDUwMF0sIEVyaWMg
Vy4gQmllZGVybWFuIHdyb3RlOgo+ID4+IAo+ID4+IEZvciBwdHJhY2Vfc3RvcCB0byB3b3JrIG9u
IFBSRUVNVF9SVCBubyBzcGlubG9ja3MgY2FuIGJlIHRha2VuIG9uY2UKPiA+PiBwdHJhY2VfZnJl
ZXplX3RyYWNlZCBoYXMgY29tcGxldGVkIHN1Y2Nlc3NmdWxseS4gIFdoaWNoIGZ1bmRhbWVudGFs
bHkKPiA+PiBtZWFucyB0aGUgbG9jayBkYW5jZSBvZiBkcm9wcGluZyBzaWdsb2NrIGFuZCBncmFi
YmluZyB0YXNrbGlzdF9sb2NrIGRvZXMKPiA+PiBub3Qgd29yayBvbiBQUkVFTVBUX1JULiAgU28g
SSBoYXZlIHdvcmtlZCB0aHJvdWdoIHdoYXQgaXMgbmVjZXNzYXJ5IHNvCj4gPj4gdGhhdCB0YXNr
bGlzdF9sb2NrIGRvZXMgbm90IG5lZWQgdG8gYmUgZ3JhYmJlZCBpbiBwdHJhY2Vfc3RvcCBhZnRl
cgo+ID4+IHNpZ2xvY2sgaXMgZHJvcHBlZC4KPiA+IOKApgo+ID4gSXQgdG9vayBtZSBhIHdoaWxl
IHRvIHJlYWxpc2UgdGhhdCB0aGlzIGlzIGEgZm9sbG93LXVwIEkgc29tZWhvdyBhc3N1bWVkCj4g
PiB0aGF0IHlvdSBhZGRlZCBhIGZldyBwYXRjaGVzIG9uIHRvcC4gTWlnaHQgaGF2ZSBiZWVuIHRo
ZSB5ZXN0ZXJkYXkncwo+ID4gaGVhdC4gYjQgYWxzbyByZWZ1c2VkIHRvIGRvd25sb2FkIHRoaXMg
c2VyaWVzIGJlY2F1c2UgdGhlIHY0IGluIHRoaXMKPiA+IHRocmVhZCBsb29rZWQgbmV3ZXLigKYg
QW55d2F5LiBCb3RoIHNlcmllcyBhcHBsaWVkOgo+ID4KPiA+IHwgPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KPiA+IHwgV0FSTklORzogc3VzcGljaW91cyBSQ1UgdXNhZ2UKPiA+IHwgNS4x
OC4wLXJjNysgIzE2IE5vdCB0YWludGVkCj4gPiB8IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPiB8IGluY2x1ZGUvbGludXgvcHRyYWNlLmg6MTIwIHN1c3BpY2lvdXMgcmN1X2RlcmVm
ZXJlbmNlX2NoZWNrKCkgdXNhZ2UhCj4gPiB8Cj4gPiB8IG90aGVyIGluZm8gdGhhdCBtaWdodCBo
ZWxwIHVzIGRlYnVnIHRoaXM6Cj4gPiB8Cj4gPiB8IHJjdV9zY2hlZHVsZXJfYWN0aXZlID0gMiwg
ZGVidWdfbG9ja3MgPSAxCj4gPiB8IDIgbG9ja3MgaGVsZCBieSBzc2RkLzE3MzQ6Cj4gPiB8ICAj
MDogZmZmZjg4ODAwZWFhNjkxOCAoJnNpZ2hhbmQtPnNpZ2xvY2spey4uLi59LXsyOjJ9LCBhdDog
bG9ja19wYXJlbnRzX3NpZ2xvY2tzKzB4ZjAvMHgzYjAKPiA+IHwgICMxOiBmZmZmODg4MDBlYWE3
MWQ4ICgmc2lnaGFuZC0+c2lnbG9jay8yKXsuLi4ufS17MjoyfSwgYXQ6IGxvY2tfcGFyZW50c19z
aWdsb2NrcysweDExNS8weDNiMAo+ID4gfAo+ID4gfCBzdGFjayBiYWNrdHJhY2U6Cj4gPiB8IENQ
VTogMiBQSUQ6IDE3MzQgQ29tbTogc3NkZCBOb3QgdGFpbnRlZCA1LjE4LjAtcmM3KyAjMTYKPiA+
IHwgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJ
T1MgMS4xNi4wLWRlYmlhbi0xLjE2LjAtNCAwNC8wMS8yMDE0Cj4gPiB8IENhbGwgVHJhY2U6Cj4g
PiB8ICA8VEFTSz4KPiA+IHwgIGR1bXBfc3RhY2tfbHZsKzB4NDUvMHg1YQo+ID4gfCAgdW5sb2Nr
X3BhcmVudHNfc2lnbG9ja3MrMHhiNi8weGMwCj4gPiB8ICBwdHJhY2Vfc3RvcCsweGI5LzB4Mzkw
Cj4gPiB8ICBnZXRfc2lnbmFsKzB4NTFjLzB4OGQwCj4gPiB8ICBhcmNoX2RvX3NpZ25hbF9vcl9y
ZXN0YXJ0KzB4MzEvMHg3NTAKPiA+IHwgIGV4aXRfdG9fdXNlcl9tb2RlX3ByZXBhcmUrMHgxNTcv
MHgyMjAKPiA+IHwgIGlycWVudHJ5X2V4aXRfdG9fdXNlcl9tb2RlKzB4NS8weDUwCj4gPiB8ICBh
c21fc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0KzB4MTIvMHgyMAo+ID4KPiA+IFRoYXQgaXMg
cHRyYWNlX3BhcmVudCgpIGluIHVubG9ja19wYXJlbnRzX3NpZ2xvY2tzKCkuCj4gCj4gSG93IG9k
ZC4gIEkgdGhvdWdodCBJIGhhZCB0aGUgYXBwcm9wcmlhdGUgbG9ja2RlcCBjb25maWcgb3B0aW9u
cyBlbmFibGVkCj4gaW4gbXkgdGVzdCBidWlsZCB0byBjYXRjaCB0aGluZ3MgbGlrZSB0aGlzLiAg
SSBndWVzcyBub3QuCj4gCj4gTm93IEkgYW0gdHJ5aW5nIHRvIHRoaW5rIGhvdyB0byB0ZWxsIGl0
IHRoYXQgaG9sZGluZyB0aGUgYXBwcm9wcmlhdGUKPiBpZ2xvY2sgbWFrZXMgdGhpcyBvay4KClRo
ZSB0eXBpY2FsIGFubm90YXRpb24gaXMgc29tZXRoaW5nIGxpa2U6CgoJcmN1X2RlcmVmZXJlbmNl
X3Byb3RlY3RlZChmb28sIGxvY2tkZXBfaXNfaGVsZCgmYmFyKSkKCkV4Y2VwdCBpbiB0aGlzIGNh
c2UgSSB0aGluayB0aGUgcHJvYmxlbSBpcyB0aGF0IGJhciBkZXBlbmRzIG9uIGZvbyBpbgpub24t
dHJpdmlhbCB3YXlzLiBUaGF0IGlzLCBmb28gaXMgJ3Rhc2stPnBhcmVudCcgYW5kIGJhciBpcwon
dGFzay0+cGFyZW50LT5zaWdoYW5kLT5zaWdsb2NrJyBvciBzb21ldGhpbmcuCgpUaGUgb3RoZXIg
b3B0aW9uIGlzIHRvIHVzZSByY3VfZGVyZWZlcmVuY2VfcmF3KCkgaW4gdGhpcyBvbmUgaW5zdGFu
Y2UKYW5kIGhhdmUgYSBjb21tZW50IHRoYXQgZXhwbGFpbnMgdGhlIHNpdHVhdGlvbi4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxp
bmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

