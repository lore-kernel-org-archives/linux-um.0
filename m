Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 3 Mar 2021 14:18:29 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: lkml delivery: was: Re: [PATCH next v4 00/15] printk: remove
 logbuf_lock
Message-ID: <YD+MpccJp4gX6bOP@alley>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: John Ogness <john.ogness@linutronix.de>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, Kees Cook <keescook@chromium.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jordan Niethe <jniethe5@gmail.com>, Alistair Popple <alistair@popple.id.au>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Wei Li <liwei391@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Michael Kelley <mikelley@microsoft.com>, linux-hyperv@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
List-ID: <linux-um.lists.infradead.org>

SGkgSm9obiwKCk9uIFdlZCAyMDIxLTAzLTAzIDExOjE1OjEzLCBKb2huIE9nbmVzcyB3cm90ZToK
PiBIZWxsbywKPiAKPiBIZXJlIGlzIHY0IG9mIGEgc2VyaWVzIHRvIHJlbW92ZSBAbG9nYnVmX2xv
Y2ssIGV4cG9zaW5nIHRoZQo+IHJpbmdidWZmZXIgbG9ja2xlc3NseSB0byBib3RoIHJlYWRlcnMg
YW5kIHdyaXRlcnMuIHYzIGlzCj4gaGVyZSBbMF0uCgpIYXZlIHlvdSBnb3Qgc29tZSByZXBseSBm
cm9tIGxrbWwgdGhhdCBpdCBoYXMgbm90IGRlbGl2ZXJlZCB0aGVyZSwKcGxlYXNlPwoKSSBhbSBu
b3QgYWJsZSB0byBnZXQgdGhlIHBhdGNoc2V0IHVzaW5nIGI0IHRvb2w6CgokPiBiNCBhbSAtbyB0
ZXN0IDIwMjEwMzAzMTAxNTI4LjI5OTAxLTEtam9obi5vZ25lc3NAbGludXRyb25peC5kZQpMb29r
aW5nIHVwIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTAzMDMxMDE1MjguMjk5MDEtMS1q
b2huLm9nbmVzcyU0MGxpbnV0cm9uaXguZGUKR3JhYmJpbmcgdGhyZWFkIGZyb20gbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWh5cGVydgpBbmFseXppbmcgMiBtZXNzYWdlcyBpbiB0aGUgdGhyZWFkCi0t
LQpUaHJlYWQgaW5jb21wbGV0ZSwgYXR0ZW1wdGluZyB0byBiYWNrZmlsbApHcmFiYmluZyB0aHJl
YWQgZnJvbSBsb3JlLmtlcm5lbC5vcmcvbGttbApTZXJ2ZXIgcmV0dXJuZWQgYW4gZXJyb3I6IDQw
NApHcmFiYmluZyB0aHJlYWQgZnJvbSBsb3JlLmtlcm5lbC5vcmcvbGludXgtbXRkClNlcnZlciBy
ZXR1cm5lZCBhbiBlcnJvcjogNDA0CkdyYWJiaW5nIHRocmVhZCBmcm9tIGxvcmUua2VybmVsLm9y
Zy9saW51eHBwYy1kZXYKTG9hZGVkIDIgbWVzc2FnZXMgZnJvbSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eHBwYy1kZXYvCi0tLQpXcml0aW5nIHRlc3QvdjRfMjAyMTAzMDNfam9obl9vZ25l
c3NfcHJpbnRrX3JlbW92ZV9sb2didWZfbG9jay5tYngKICBFUlJPUjogbWlzc2luZyBbMS8xNV0h
CiAgRVJST1I6IG1pc3NpbmcgWzIvMTVdIQogIEVSUk9SOiBtaXNzaW5nIFszLzE1XSEKICBFUlJP
UjogbWlzc2luZyBbNC8xNV0hCiAgRVJST1I6IG1pc3NpbmcgWzUvMTVdIQogIEVSUk9SOiBtaXNz
aW5nIFs2LzE1XSEKICBFUlJPUjogbWlzc2luZyBbNy8xNV0hCiAgRVJST1I6IG1pc3NpbmcgWzgv
MTVdIQogIEVSUk9SOiBtaXNzaW5nIFs5LzE1XSEKICBFUlJPUjogbWlzc2luZyBbMTAvMTVdIQog
IFtQQVRDSCBuZXh0IHY0IDExLzE1XSBwcmludGs6IGttc2dfZHVtcGVyOiByZW1vdmUgQGFjdGl2
ZSBmaWVsZAogIOKckyBbUEFUQ0ggbmV4dCB2NCAxMi8xNV0gcHJpbnRrOiBpbnRyb2R1Y2UgYSBr
bXNnX2R1bXAgaXRlcmF0b3IKICBFUlJPUjogbWlzc2luZyBbMTMvMTVdIQogIFtQQVRDSCBuZXh0
IHY0IDE0LzE1XSBwcmludGs6IGttc2dfZHVtcDogcmVtb3ZlIF9ub2xvY2soKSB2YXJpYW50cwog
IEVSUk9SOiBtaXNzaW5nIFsxNS8xNV0hCi0tLQpUb3RhbCBwYXRjaGVzOiAzCi0tLQpXQVJOSU5H
OiBUaHJlYWQgaW5jb21wbGV0ZSEKQ292ZXI6IHRlc3QvdjRfMjAyMTAzMDNfam9obl9vZ25lc3Nf
cHJpbnRrX3JlbW92ZV9sb2didWZfbG9jay5jb3ZlcgogTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDIxMDMwMzEwMTUyOC4yOTkwMS0xLWpvaG4ub2duZXNzQGxpbnV0cm9uaXguZGUK
IEJhc2U6IG5vdCBmb3VuZAogICAgICAgZ2l0IGFtIHRlc3QvdjRfMjAyMTAzMDNfam9obl9vZ25l
c3NfcHJpbnRrX3JlbW92ZV9sb2didWZfbG9jay5tYngKCgphbmQgSSBkbyBub3Qgc2VlIGl0IGF0
IGxvcmUuIEl0IGhhcyBvbmx5IGZvdW5kIGNvcGllcyBpbiBsaW51eC1oeXBlcnYKYW5kIGxpbnV4
LXBwY2RldiBtYWlsaW5nIGxpc3RzLApzZWUgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDIxMDMwMzEwMTUyOC4yOTkwMS0yLWpvaG4ub2duZXNzQGxpbnV0cm9uaXguZGUvCgpCZXN0IFJl
Z2FyZHMsClBldHIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvCg==

