Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuraF-001jDr-42
	for linux-um@lists.infradead.org; Sat, 28 May 2022 08:14:04 +0000
Received: by mail-pj1-x1031.google.com with SMTP id m14-20020a17090a414e00b001df77d29587so9006344pjg.2
        for <linux-um@lists.infradead.org>; Sat, 28 May 2022 01:13:56 -0700 (PDT)
From: Yu-Jen Chang <arthurchang09@gmail.com>
Subject: [PATCH 0/2] x86: Optimize memchr() for x86-64 
Date: Sat, 28 May 2022 16:12:34 +0800
Message-Id: <20220528081236.3020-1-arthurchang09@gmail.com>
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
To: ak@linux.intel.com, jdike@linux.intel.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, keescook@chromium.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org, jserv@ccns.ncku.edu.tw, Yu-Jen Chang <arthurchang09@gmail.com>

KioqIEJMVVJCIEhFUkUgKioqClRoZXNlIHBhdGNoIHNlcmllcyBhZGQgYW4gb3B0aW1pemVkICJt
ZW1jaHIoKSIgZm9yIHg4Ni02NCBhbmQgClVTRVItTU9ERSBMSU5VWCAoVU1MKS4KIApUaGVyZSBl
eGlzdHMgYW4gYXNzZW1lYmx5IGltcGxlbWVudGF0aW9uIGZvciB4ODYtMzIuIEhvd2V2ZXIsIApm
b3IgeDg2LTY0LCB0aGVyZSBpc24ndCBhbnkgb3B0aW1pemVkIHZlcnNpb24uIFdlIGltcGxlbWVu
dCB3b3JkLXdpc2UgCmNvbXBhcmlzb24gc28gdGhhdCA4IGNoYXJhY3RlcnMgY2FuIGJlIGNvbXBh
cmVkIGF0IHRoZSBzYW1lIHRpbWUgb24gCng4Ni02NCBDUFUuIFRoZSBvcHRpbWl6ZWQg4oCcbWVt
Y2hyKCnigJ0gaXMgbmVhcmx5IDR4IGZhc3RlciB0aGFuIHRoZSAKb3JnaW5hbCBpbXBsZW1lbnRh
dGlvbiBmb3IgbG9uZyBzdHJpbmdzLgoKV2UgdGVzdCB0aGUgb3B0aW1pemVkIOKAnG1lbWNocigp
4oCdIGluIFVNTCBhbmQgYWxzbyByZWNvbXBpbGUgdGhlIDUuMTggCktlcm5lbCB3aXRoIHRoZSBv
cHRpbWl6ZWQg4oCcbWVtY2hyKCnigJ0uIFRoZXkgcnVuIGNvcnJlY3RseS4KCkluIHRoaXMgcGF0
Y2ggd2UgYWRkIGEgbmV3IGZpbGUgInN0cmluZ182NC5jIiwgd2hpY2ggb25seSBjb250YWlucyAK
Im1lbWNocigpIi4gV2UgY2FuIGFkZCBtb3JlIG9wdGltaXplZCBzdHJpbmcgZnVuY3Rpb25zIGlu
IGl0IGluIHRoZSAKZnV0dXJlLgoKWXUtSmVuIENoYW5nICgyKToKICB4ODYvbGliOiBPcHRpbWl6
ZSBtZW1jaHIoKQogIHg4Ni91bTogVXNlIHg4Nl82NC1vcHRpbWl6ZWQgbWVtY2hyCgogYXJjaC94
ODYvaW5jbHVkZS9hc20vc3RyaW5nXzY0LmggfCAgMyArKwogYXJjaC94ODYvbGliL01ha2VmaWxl
ICAgICAgICAgICAgfCAgMSArCiBhcmNoL3g4Ni9saWIvc3RyaW5nXzY0LmMgICAgICAgICB8IDc4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBhcmNoL3g4Ni91bS9NYWtlZmlsZSAg
ICAgICAgICAgICB8ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDgzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3g4Ni9saWIvc3RyaW5nXzY0LmMK
Ci0tIAoyLjI1LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

