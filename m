Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaNou-00FQ8K-9F
	for linux-um@lists.infradead.org; Mon, 19 Sep 2022 20:56:50 +0000
Date: Mon, 19 Sep 2022 22:56:44 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <437983532.241061.1663621004742.JavaMail.zimbra@nod.at>
In-Reply-To: <39e063ad-208d-f5f0-9807-eedcf0db1692@infradead.org>
References: <20220823010830.2675419-1-davidgow@google.com> <39e063ad-208d-f5f0-9807-eedcf0db1692@infradead.org>
Subject: Re: [PATCH] arch: um: Mark the stack non-executable to fix a
 binutils warning
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
To: Randy Dunlap <rdunlap@infradead.org>, davidgow <davidgow@google.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Nick Desaulniers <ndesaulniers@google.com>, tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>, dave hansen <dave.hansen@linux.intel.com>, torvalds <torvalds@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com, x86 <x86@kernel.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIlJhbmR5IER1bmxhcCIgPHJk
dW5sYXBAaW5mcmFkZWFkLm9yZz4KPj4gTGluazoKPj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ZmZj
ZjljNTcwMGU0OWMwYWVlNDJkY2JhOWExMmJhMjEzMzhlODEzNgo+PiBMaW5rOgo+PiBodHRwczov
L3NvdXJjZXdhcmUub3JnL2dpdC8/cD1iaW51dGlscy1nZGIuZ2l0O2E9Y29tbWl0O2g9YmE5NTFh
ZmI5OTkxMmRhMDFhNmU4NDM0MTI2YjhmYWM3YWE3NTEwNwo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZp
ZCBHb3cgPGRhdmlkZ293QGdvb2dsZS5jb20+Cj4gCj4gQWNrZWQtYnk6IFJhbmR5IER1bmxhcCA8
cmR1bmxhcEBpbmZyYWRlYWQub3JnPiAjIGJ1aWxkLXRlc3RlZAoKVGhpcyBwYXRjaCBjYXVzZXMg
YSBidWlsZCBlcnJvciBvbiBvbmUgb2YgbXkgc3lzdGVtczoKCi91c3IvbGliNjQvZ2NjL3g4Nl82
NC1zdXNlLWxpbnV4LzcvLi4vLi4vLi4vLi4veDg2XzY0LXN1c2UtbGludXgvYmluL2xkOiB1bnJl
Y29nbml6ZWQgb3B0aW9uICctLW5vLXdhcm4tcnd4LXNlZ21lbnRzJwovdXNyL2xpYjY0L2djYy94
ODZfNjQtc3VzZS1saW51eC83Ly4uLy4uLy4uLy4uL3g4Nl82NC1zdXNlLWxpbnV4L2Jpbi9sZDog
dXNlIHRoZSAtLWhlbHAgb3B0aW9uIGZvciB1c2FnZSBpbmZvcm1hdGlvbgpjb2xsZWN0MjogZXJy
b3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKCkp1c3QgbGlrZSBpbiBjb21taXQgZmZjZjlj
NTcwMGU0ICgieDg2OiBsaW5rIHZkc28gYW5kIGJvb3Qgd2l0aCAteiBub2V4ZWNzdGFjayAtLW5v
LXdhcm4tcnd4LXNlZ21lbnRzIikgeW91IG5lZWQgdG8KdGVzdCBmb3IgaXQuCgpUaGFua3MsCi8v
cmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

