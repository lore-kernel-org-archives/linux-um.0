Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZIqC-0062uT-D6
 for linux-um@lists.infradead.org; Sat, 09 Oct 2021 20:21:10 +0000
Date: Sat, 9 Oct 2021 22:20:59 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <356575565.55001.1633810859041.JavaMail.zimbra@nod.at>
In-Reply-To: <5B27741E-71A5-41CF-912C-D299248691F7@sipsolutions.net>
References: <20211008215133.9371-1-rdunlap@infradead.org>
 <CABVgOS=QVysVtN5seB5hp7hHAw5P0yuOaA3rgkRtEyiJu-1H6Q@mail.gmail.com>
 <05939461-793d-2266-8752-1b593bab8eec@infradead.org>
 <f0ead035-f05b-73fb-1fd4-48c1eff8bc92@cambridgegreys.com>
 <5B27741E-71A5-41CF-912C-D299248691F7@sipsolutions.net>
Subject: Re: [PATCH] um: Add missing "FORCE" target when using if_changed
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, Randy Dunlap <rdunlap@infradead.org>, davidgow <davidgow@google.com>, masahiroy <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-kbuild <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, x86 <x86@kernel.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkpvaGFubmVzIEJlcmciIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IEFuOiAiYW50b24gaXZhbm92IiA8YW50b24uaXZh
bm92QGNhbWJyaWRnZWdyZXlzLmNvbT4sICJSYW5keSBEdW5sYXAiIDxyZHVubGFwQGluZnJhZGVh
ZC5vcmc+LCAiZGF2aWRnb3ciCj4gPGRhdmlkZ293QGdvb2dsZS5jb20+Cj4gQ0M6ICJtYXNhaGly
b3kiIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4sICJNaWNoYWwgTWFyZWsiIDxtaWNoYWwubGttbEBt
YXJrb3ZpLm5ldD4sICJOaWNrIERlc2F1bG5pZXJzIgo+IDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNv
bT4sICJsaW51eC1rYnVpbGQiIDxsaW51eC1rYnVpbGRAdmdlci5rZXJuZWwub3JnPiwgIkplZmYg
RGlrZSIgPGpkaWtlQGFkZHRvaXQuY29tPiwgInJpY2hhcmQiCj4gPHJpY2hhcmRAbm9kLmF0Piwg
ImxpbnV4LXVtIiA8bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZz4sICJ4ODYiIDx4ODZAa2Vy
bmVsLm9yZz4KPiBHZXNlbmRldDogU2Ftc3RhZywgOS4gT2t0b2JlciAyMDIxIDE1OjA2OjAxCj4g
QmV0cmVmZjogUmU6IFtQQVRDSF0gdW06IEFkZCBtaXNzaW5nICJGT1JDRSIgdGFyZ2V0IHdoZW4g
dXNpbmcgaWZfY2hhbmdlZAoKPiBPbiA5IE9jdG9iZXIgMjAyMSAwNzozNjozNiBDRVNULCBBbnRv
biBJdmFub3YgPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gd3JvdGU6Cj4gCj4+
VGhlIHBhdGNoIGJ5IEpvaGFubmVzIGlzIG5vdCBpbiB0aGUgcGVuZGluZyBsaXN0IGluIHBhdGNo
d29yaywgc28gaXQKPj5sb29rcyBsaWtlIFJpY2hhcmQgaGFzIHByb2Nlc3NlZCBpdCBhbmQgaXQg
d2lsbCBiZSBpbiB0aGUgbmV4dCBwdWxsIHJlcXVlc3QuCj4gCj4gSSB0aGluayBpdCdzIHN0aWxs
IG9wZW46Cj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXVtL3Bh
dGNoLzIwMjEwOTI4MTE1MTQ2LjI3N2JlYzIzMjhiYi5JZjcwOTI2NTA1ZDE2ZDZjNmEyMjkwMDJl
YjZkM2Y2ODM4YjU0NjE3NUBjaGFuZ2VpZC8KClRoaXMgcGF0Y2ggaXMgbm93IGluIGxpbnV4LW5l
eHQuCgpUaGFua3MsCi8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=

