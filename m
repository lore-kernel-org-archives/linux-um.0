Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrx96-00B5qc-7Q
 for linux-um@lists.infradead.org; Fri, 20 May 2022 07:34:02 +0000
Date: Fri, 20 May 2022 09:33:46 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
Message-ID: <YodEWlfo4kFd8+mt@linutronix.de>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org, Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Douglas Miller <dougmill@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

T24gMjAyMi0wNS0xOCAxNzo0OTo1MCBbLTA1MDBdLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90ZToK
PiAKPiBGb3IgcHRyYWNlX3N0b3AgdG8gd29yayBvbiBQUkVFTVRfUlQgbm8gc3BpbmxvY2tzIGNh
biBiZSB0YWtlbiBvbmNlCj4gcHRyYWNlX2ZyZWV6ZV90cmFjZWQgaGFzIGNvbXBsZXRlZCBzdWNj
ZXNzZnVsbHkuICBXaGljaCBmdW5kYW1lbnRhbGx5Cj4gbWVhbnMgdGhlIGxvY2sgZGFuY2Ugb2Yg
ZHJvcHBpbmcgc2lnbG9jayBhbmQgZ3JhYmJpbmcgdGFza2xpc3RfbG9jayBkb2VzCj4gbm90IHdv
cmsgb24gUFJFRU1QVF9SVC4gIFNvIEkgaGF2ZSB3b3JrZWQgdGhyb3VnaCB3aGF0IGlzIG5lY2Vz
c2FyeSBzbwo+IHRoYXQgdGFza2xpc3RfbG9jayBkb2VzIG5vdCBuZWVkIHRvIGJlIGdyYWJiZWQg
aW4gcHRyYWNlX3N0b3AgYWZ0ZXIKPiBzaWdsb2NrIGlzIGRyb3BwZWQuCuKApgpJdCB0b29rIG1l
IGEgd2hpbGUgdG8gcmVhbGlzZSB0aGF0IHRoaXMgaXMgYSBmb2xsb3ctdXAgSSBzb21laG93IGFz
c3VtZWQKdGhhdCB5b3UgYWRkZWQgYSBmZXcgcGF0Y2hlcyBvbiB0b3AuIE1pZ2h0IGhhdmUgYmVl
biB0aGUgeWVzdGVyZGF5J3MKaGVhdC4gYjQgYWxzbyByZWZ1c2VkIHRvIGRvd25sb2FkIHRoaXMg
c2VyaWVzIGJlY2F1c2UgdGhlIHY0IGluIHRoaXMKdGhyZWFkIGxvb2tlZCBuZXdlcuKApiBBbnl3
YXkuIEJvdGggc2VyaWVzIGFwcGxpZWQ6Cgp8ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
CnwgV0FSTklORzogc3VzcGljaW91cyBSQ1UgdXNhZ2UKfCA1LjE4LjAtcmM3KyAjMTYgTm90IHRh
aW50ZWQKfCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQp8IGluY2x1ZGUvbGludXgvcHRy
YWNlLmg6MTIwIHN1c3BpY2lvdXMgcmN1X2RlcmVmZXJlbmNlX2NoZWNrKCkgdXNhZ2UhCnwKfCBv
dGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOgp8CnwgcmN1X3NjaGVkdWxl
cl9hY3RpdmUgPSAyLCBkZWJ1Z19sb2NrcyA9IDEKfCAyIGxvY2tzIGhlbGQgYnkgc3NkZC8xNzM0
Ogp8ICAjMDogZmZmZjg4ODAwZWFhNjkxOCAoJnNpZ2hhbmQtPnNpZ2xvY2spey4uLi59LXsyOjJ9
LCBhdDogbG9ja19wYXJlbnRzX3NpZ2xvY2tzKzB4ZjAvMHgzYjAKfCAgIzE6IGZmZmY4ODgwMGVh
YTcxZDggKCZzaWdoYW5kLT5zaWdsb2NrLzIpey4uLi59LXsyOjJ9LCBhdDogbG9ja19wYXJlbnRz
X3NpZ2xvY2tzKzB4MTE1LzB4M2IwCnwKfCBzdGFjayBiYWNrdHJhY2U6CnwgQ1BVOiAyIFBJRDog
MTczNCBDb21tOiBzc2RkIE5vdCB0YWludGVkIDUuMTguMC1yYzcrICMxNgp8IEhhcmR3YXJlIG5h
bWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMC1kZWJp
YW4tMS4xNi4wLTQgMDQvMDEvMjAxNAp8IENhbGwgVHJhY2U6CnwgIDxUQVNLPgp8ICBkdW1wX3N0
YWNrX2x2bCsweDQ1LzB4NWEKfCAgdW5sb2NrX3BhcmVudHNfc2lnbG9ja3MrMHhiNi8weGMwCnwg
IHB0cmFjZV9zdG9wKzB4YjkvMHgzOTAKfCAgZ2V0X3NpZ25hbCsweDUxYy8weDhkMAp8ICBhcmNo
X2RvX3NpZ25hbF9vcl9yZXN0YXJ0KzB4MzEvMHg3NTAKfCAgZXhpdF90b191c2VyX21vZGVfcHJl
cGFyZSsweDE1Ny8weDIyMAp8ICBpcnFlbnRyeV9leGl0X3RvX3VzZXJfbW9kZSsweDUvMHg1MAp8
ICBhc21fc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0KzB4MTIvMHgyMAoKVGhhdCBpcyBwdHJh
Y2VfcGFyZW50KCkgaW4gdW5sb2NrX3BhcmVudHNfc2lnbG9ja3MoKS4KClNlYmFzdGlhbgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFp
bGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

