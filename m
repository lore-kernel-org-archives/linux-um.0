Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns8Mi-00EMEt-67
 for linux-um@lists.infradead.org; Fri, 20 May 2022 19:32:49 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <YodEWlfo4kFd8+mt@linutronix.de>
Date: Fri, 20 May 2022 14:32:24 -0500
In-Reply-To: <YodEWlfo4kFd8+mt@linutronix.de> (Sebastian Andrzej Siewior's
 message of "Fri, 20 May 2022 09:33:46 +0200")
Message-ID: <87wnegyp87.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org, Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Douglas Miller <dougmill@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiB3cml0ZXM6
Cgo+IE9uIDIwMjItMDUtMTggMTc6NDk6NTAgWy0wNTAwXSwgRXJpYyBXLiBCaWVkZXJtYW4gd3Jv
dGU6Cj4+IAo+PiBGb3IgcHRyYWNlX3N0b3AgdG8gd29yayBvbiBQUkVFTVRfUlQgbm8gc3Bpbmxv
Y2tzIGNhbiBiZSB0YWtlbiBvbmNlCj4+IHB0cmFjZV9mcmVlemVfdHJhY2VkIGhhcyBjb21wbGV0
ZWQgc3VjY2Vzc2Z1bGx5LiAgV2hpY2ggZnVuZGFtZW50YWxseQo+PiBtZWFucyB0aGUgbG9jayBk
YW5jZSBvZiBkcm9wcGluZyBzaWdsb2NrIGFuZCBncmFiYmluZyB0YXNrbGlzdF9sb2NrIGRvZXMK
Pj4gbm90IHdvcmsgb24gUFJFRU1QVF9SVC4gIFNvIEkgaGF2ZSB3b3JrZWQgdGhyb3VnaCB3aGF0
IGlzIG5lY2Vzc2FyeSBzbwo+PiB0aGF0IHRhc2tsaXN0X2xvY2sgZG9lcyBub3QgbmVlZCB0byBi
ZSBncmFiYmVkIGluIHB0cmFjZV9zdG9wIGFmdGVyCj4+IHNpZ2xvY2sgaXMgZHJvcHBlZC4KPiDi
gKYKPiBJdCB0b29rIG1lIGEgd2hpbGUgdG8gcmVhbGlzZSB0aGF0IHRoaXMgaXMgYSBmb2xsb3ct
dXAgSSBzb21laG93IGFzc3VtZWQKPiB0aGF0IHlvdSBhZGRlZCBhIGZldyBwYXRjaGVzIG9uIHRv
cC4gTWlnaHQgaGF2ZSBiZWVuIHRoZSB5ZXN0ZXJkYXkncwo+IGhlYXQuIGI0IGFsc28gcmVmdXNl
ZCB0byBkb3dubG9hZCB0aGlzIHNlcmllcyBiZWNhdXNlIHRoZSB2NCBpbiB0aGlzCj4gdGhyZWFk
IGxvb2tlZCBuZXdlcuKApiBBbnl3YXkuIEJvdGggc2VyaWVzIGFwcGxpZWQ6Cj4KPiB8ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Cj4gfCBXQVJOSU5HOiBzdXNwaWNpb3VzIFJDVSB1c2Fn
ZQo+IHwgNS4xOC4wLXJjNysgIzE2IE5vdCB0YWludGVkCj4gfCAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+IHwgaW5jbHVkZS9saW51eC9wdHJhY2UuaDoxMjAgc3VzcGljaW91cyByY3Vf
ZGVyZWZlcmVuY2VfY2hlY2soKSB1c2FnZSEKPiB8Cj4gfCBvdGhlciBpbmZvIHRoYXQgbWlnaHQg
aGVscCB1cyBkZWJ1ZyB0aGlzOgo+IHwKPiB8IHJjdV9zY2hlZHVsZXJfYWN0aXZlID0gMiwgZGVi
dWdfbG9ja3MgPSAxCj4gfCAyIGxvY2tzIGhlbGQgYnkgc3NkZC8xNzM0Ogo+IHwgICMwOiBmZmZm
ODg4MDBlYWE2OTE4ICgmc2lnaGFuZC0+c2lnbG9jayl7Li4uLn0tezI6Mn0sIGF0OiBsb2NrX3Bh
cmVudHNfc2lnbG9ja3MrMHhmMC8weDNiMAo+IHwgICMxOiBmZmZmODg4MDBlYWE3MWQ4ICgmc2ln
aGFuZC0+c2lnbG9jay8yKXsuLi4ufS17MjoyfSwgYXQ6IGxvY2tfcGFyZW50c19zaWdsb2Nrcysw
eDExNS8weDNiMAo+IHwKPiB8IHN0YWNrIGJhY2t0cmFjZToKPiB8IENQVTogMiBQSUQ6IDE3MzQg
Q29tbTogc3NkZCBOb3QgdGFpbnRlZCA1LjE4LjAtcmM3KyAjMTYKPiB8IEhhcmR3YXJlIG5hbWU6
IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMC1kZWJpYW4t
MS4xNi4wLTQgMDQvMDEvMjAxNAo+IHwgQ2FsbCBUcmFjZToKPiB8ICA8VEFTSz4KPiB8ICBkdW1w
X3N0YWNrX2x2bCsweDQ1LzB4NWEKPiB8ICB1bmxvY2tfcGFyZW50c19zaWdsb2NrcysweGI2LzB4
YzAKPiB8ICBwdHJhY2Vfc3RvcCsweGI5LzB4MzkwCj4gfCAgZ2V0X3NpZ25hbCsweDUxYy8weDhk
MAo+IHwgIGFyY2hfZG9fc2lnbmFsX29yX3Jlc3RhcnQrMHgzMS8weDc1MAo+IHwgIGV4aXRfdG9f
dXNlcl9tb2RlX3ByZXBhcmUrMHgxNTcvMHgyMjAKPiB8ICBpcnFlbnRyeV9leGl0X3RvX3VzZXJf
bW9kZSsweDUvMHg1MAo+IHwgIGFzbV9zeXN2ZWNfYXBpY190aW1lcl9pbnRlcnJ1cHQrMHgxMi8w
eDIwCj4KPiBUaGF0IGlzIHB0cmFjZV9wYXJlbnQoKSBpbiB1bmxvY2tfcGFyZW50c19zaWdsb2Nr
cygpLgoKSG93IG9kZC4gIEkgdGhvdWdodCBJIGhhZCB0aGUgYXBwcm9wcmlhdGUgbG9ja2RlcCBj
b25maWcgb3B0aW9ucyBlbmFibGVkCmluIG15IHRlc3QgYnVpbGQgdG8gY2F0Y2ggdGhpbmdzIGxp
a2UgdGhpcy4gIEkgZ3Vlc3Mgbm90LgoKTm93IEkgYW0gdHJ5aW5nIHRvIHRoaW5rIGhvdyB0byB0
ZWxsIGl0IHRoYXQgaG9sZGluZyB0aGUgYXBwcm9wcmlhdGUKaWdsb2NrIG1ha2VzIHRoaXMgb2su
CgpFcmljCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

