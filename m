Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcbDB-0000h3-Db
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 21:29:58 +0000
Date: Tue, 10 Nov 2020 22:29:53 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1253718433.290759.1605043793706.JavaMail.zimbra@nod.at>
In-Reply-To: <ee2da9e0-2858-ef9c-b8b9-bdf569ec9bb4@cambridgegreys.com>
References: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
 <1098264641.290574.1605039225057.JavaMail.zimbra@nod.at>
 <ee2da9e0-2858-ef9c-b8b9-bdf569ec9bb4@cambridgegreys.com>
Subject: Re: [PATCH] um: allow using glibc string functions instead of generics
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
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+IAo+PiBPbiB3aGF0IHdvcmtsb2FkIGRpZCB5
b3Ugc2VlIHN1Y2ggYSBodWdlIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50Pwo+IAo+IEZpbGUgSU8g
fiAxJSBvciB0aGVyZWFib3V0cywgaXBlcmYgLSAyLTQlLgo+IAo+PiBUaGUgaW4ta2VybmVsIHZh
cmlhbnRzIG9mIG1lbWNweSBhbmQgc3VjaCBhcmUgYWxyZWFkeSB3ZWxsIG9wdGltaXplZC4KPiAK
PiBVTUwgaGFzIG5vIHN0cmluZy5oIGluIGFzbSB3aGljaCBtZWFucyBpdCBmYWxscyBiYWNrIHRv
Cj4gYXNtLWdlbmVyaWMvc3RyaW5nLmggd2hpY2ggaW4gdHVybiBwdWxscyBpbiB0aGUgb25lcyBm
cm9tIGxpYi9zdHJpbmcuYwo+Cj4gVGhlc2UgYXJlIG5vdCBvcHRpbWl6ZWQuCgpIbW1tLCBJIHRo
aW5rIGl0IHNob3VsZCB1c2UgdGhlIGhpZ2hseSBvcHRpbWl6ZWQgdmFyaWFudHMgZnJvbSBhcmNo
L3g4Ni4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==

