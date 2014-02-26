Return-Path: <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
Message-ID: <1393417896.17341.2.camel@concordia>
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 26 Feb 2014 23:31:36 +1100
In-Reply-To: <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
References: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
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
Subject: Re: [PATCH v2 1/1] audit: Add CONFIG_HAVE_ARCH_AUDITSYSCALL
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: linux-s390@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, rgb@redhat.com, catalin.marinas@arm.com, x86@kernel.org, will.deacon@arm.com, arndb@arndb.de, eparis@redhat.com, linux-kernel@vger.kernel.org, dsaxena@linaro.org, viro@zeniv.linux.org.uk, user-mode-linux-user@lists.sourceforge.net, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-audit@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

T24gVHVlLCAyMDE0LTAyLTI1IGF0IDE4OjE2ICswOTAwLCBBS0FTSEkgVGFrYWhpcm8gd3JvdGU6
Cj4gQ3VycmVudGx5IEFVRElUU1lTQ0FMTCBoYXMgYSBsb25nIGxpc3Qgb2YgYXJjaGl0ZWN0dXJl
IGRlcGVuY2VuY3k6Cj4gICAgICAgIGRlcGVuZHMgb24gQVVESVQgJiYgKFg4NiB8fCBQQVJJU0Mg
fHwgUFBDIHx8IFMzOTAgfHwgSUE2NCB8fCBVTUwgfHwKPiAJCVNQQVJDNjQgfHwgU1VQRVJIIHx8
IChBUk0gJiYgQUVBQkkgJiYgIU9BQklfQ09NUEFUKSB8fCBBTFBIQSkKPiBUaGUgcHVycG9zZSBv
ZiB0aGlzIHBhdGNoIGlzIHRvIHJlcGxhY2UgaXQgd2l0aCBIQVZFX0FSQ0hfQVVESVRTWVNDQUxM
Cj4gZm9yIHNpbXBsaWNpdHkuCj4gCj4gU2lnbmVkLW9mZi1ieTogQUtBU0hJIFRha2FoaXJvIDx0
YWthaGlyby5ha2FzaGlAbGluYXJvLm9yZz4KPgo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMv
S2NvbmZpZyBiL2FyY2gvcG93ZXJwYy9LY29uZmlnCj4gaW5kZXggOTU3YmYzNC4uN2IzYjhmZSAx
MDA2NDQKPiAtLS0gYS9hcmNoL3Bvd2VycGMvS2NvbmZpZwo+ICsrKyBiL2FyY2gvcG93ZXJwYy9L
Y29uZmlnCj4gQEAgLTE0MSw2ICsxNDEsNyBAQCBjb25maWcgUFBDCj4gIAlzZWxlY3QgSEFWRV9E
RUJVR19TVEFDS09WRVJGTE9XCj4gIAlzZWxlY3QgSEFWRV9JUlFfRVhJVF9PTl9JUlFfU1RBQ0sK
PiAgCXNlbGVjdCBBUkNIX1VTRV9DTVBYQ0hHX0xPQ0tSRUYgaWYgUFBDNjQKPiArCXNlbGVjdCBI
QVZFX0FSQ0hfQVVESVRTWVNDQUxMCj4gIAo+ICBjb25maWcgR0VORVJJQ19DU1VNCj4gIAlkZWZf
Ym9vbCBDUFVfTElUVExFX0VORElBTgoKTG9va3MgZ29vZCBmb3IgcG93ZXJwYy4KCkFja2VkLWJ5
OiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+CgpjaGVlcnMKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFp
bGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3ps
YWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=

