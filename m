Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC5NN-001Uow-Eg
	for linux-um@lists.infradead.org; Thu, 14 Jul 2022 20:23:58 +0000
Date: Thu, 14 Jul 2022 13:23:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH] um: Replace to_phys() and to_virt() with less generic
 function names
Message-ID: <62d07b5120291_16fb97294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220714184600.3981953-1-linux@roeck-us.net>
Content-Disposition: inline
In-Reply-To: <20220714184600.3981953-1-linux@roeck-us.net>
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
To: Guenter Roeck <linux@roeck-us.net>, Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Dan Williams <dan.j.williams@intel.com>, Christoph

WyBhZGQgSmFuZSBdCgpHdWVudGVyIFJvZWNrIHdyb3RlOgo+IHRvX3ZpcnQoKSBhbmQgdG9fcGh5
cygpIGFyZSB2ZXJ5IGdlbmVyaWMgYW5kIG1heSBiZSBkZWZpbmVkIGJ5IGRyaXZlcnMuCj4gQXMg
aXQgdHVybnMgb3V0LCBjb21taXQgOTQwOWM5YjY3MDllICgicG1lbTogcmVmYWN0b3IgcG1lbV9j
bGVhcl9wb2lzb24oKSIpCj4gZGlkIGV4YWN0bHkgdGhhdC4gVGhpcyByZXN1bHRzIGluIGJ1aWxk
IGVycm9ycyBzdWNoIGFzIHRoZSBmb2xsb3dpbmcKPiB3aGVuIHRyeWluZyB0byBidWlsZCB1bTph
bGxtb2Rjb25maWcuCj4gCj4gZHJpdmVycy9udmRpbW0vcG1lbS5jOiBJbiBmdW5jdGlvbiDigJhw
bWVtX2RheF96ZXJvX3BhZ2VfcmFuZ2XigJk6Cj4gLi9hcmNoL3VtL2luY2x1ZGUvYXNtL3BhZ2Uu
aDoxMDU6MjA6IGVycm9yOgo+IAkJCXRvbyBmZXcgYXJndW1lbnRzIHRvIGZ1bmN0aW9uIOKAmHRv
X3BoeXPigJkKPiAgIDEwNSB8ICNkZWZpbmUgX19wYSh2aXJ0KSB0b19waHlzKCh2b2lkICopICh1
bnNpZ25lZCBsb25nKSAodmlydCkpCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgXn5+fn5+
fgo+IAo+IFVzZSBsZXNzIGdlbmVyaWMgZnVuY3Rpb24gbmFtZXMgZm9yIHRoZSB1bSBzcGVjaWZp
YyB0b19waHlzKCkgYW5kIHRvX3ZpcnQoKQo+IGZ1bmN0aW9ucyB0byBmaXggdGhlIHByb2JsZW0g
YW5kIHRvIGF2b2lkIHNpbWlsYXIgcHJvYmxlbXMgaW4gdGhlIGZ1dHVyZS4KPiAKPiBGaXhlczog
OTQwOWM5YjY3MDllICgicG1lbTogcmVmYWN0b3IgcG1lbV9jbGVhcl9wb2lzb24oKSIpCj4gQ2M6
IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+IENjOiBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGxzdC5kZT4KCkFja2VkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4KCkphbmUgaGFkIHNlbnQgYSBwbWVtIGxvY2FsIGZpeHVwLCB0aGF0IEkg
d2FzIGFib3V0IHRvIHB1c2ggdG8gbGludXgtbmV4dDoKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L252ZGltbS8yMDIyMDYzMDE4MjgwMi4zMjUwNDQ5LTEtamFuZS5jaHVAb3JhY2xlLmNvbS8KCi4u
LmJ1dCBJIGxpa2UgdGhpcyBvbmUgdG9vLCBsZXRzIGRvIGJvdGguCgo+IFNpZ25lZC1vZmYtYnk6
IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4KPiAtLS0KPiAgYXJjaC91bS9pbmNs
dWRlL2FzbS9wYWdlLmggICAgICB8IDQgKystLQo+ICBhcmNoL3VtL2luY2x1ZGUvc2hhcmVkL21l
bS5oICAgIHwgNCArKy0tCj4gIGFyY2gvdW0vb3MtTGludXgvc2thcy9wcm9jZXNzLmMgfCA2ICsr
Ky0tLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVt
IG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

