Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: vincent-perrier <vincent-perrier@club-internet.fr>
In-Reply-To: <20080721154658.GA6860@c2.user-mode-linux.org>
References: <20080721154658.GA6860@c2.user-mode-linux.org>
Date: Mon, 21 Jul 2008 22:24:39 +0200
Message-Id: <1216671879.15095.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [uml-devel] [uml-user] [PATCH] Fix for 2.6.26 ptrace crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: "david.r" <david.r@seznam.cz>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, David Shane Holden <dpejesh@yahoo.com>

SGVsbG8sCkkgYWxzbyBoYWQgdGhlIGNyYXNoIHdpdGggYSBsb3Qgb2YgemVyb3MgaW4gYSB2ZXJ0
aWNhbCBsaW5lIHdpdGgga2VybmVsCjIuNi4yNiwgSSB3YXMgc2FkIHRoZW4uCkJ1dCBJIGFtIG5v
dyBoYXBweSwgSSBhcHBsaWVkIHRoZSBwYXRjaDoKCmJhc2gtMy4xIyBjZCBsaW51eC0yLjYuMjYK
YmFzaC0zLjEjIHBhdGNoIC1wMSA8IC4uL2plZmYucGF0Y2gKcGF0Y2hpbmcgZmlsZSBhcmNoL3Vt
L2luY2x1ZGUvaW5pdC5oCkh1bmsgIzEgc3VjY2VlZGVkIGF0IDQ1IHdpdGggZnV6eiAyLgpIdW5r
ICMyIHN1Y2NlZWRlZCBhdCA1NCB3aXRoIGZ1enogMS4KCkFuZCBteSAyLjYuMjYgdW1sIG1hY2hp
bmUgd29ya2VkISEKCkFsbCB0aGlzIHRvIHNheTogSSBjb25maXJtIHRoZSBwYXRjaCB3b3JrZWQg
Zm9yIG1lIHRvby4KClJlZ2FyZHMKCgpPbiBNb24sIDIwMDgtMDctMjEgYXQgMTE6NDYgLTA0MDAs
IEplZmYgRGlrZSB3cm90ZToKPiBJIGJlbGlldmUgSSBmaWd1cmVkIG91dCB0aGUgcHRyYWNlIGNy
YXNoIHRoYXQgc2hvd2VkIHVwIHdpdGggMi42LjI2LAo+IHRoYW5rcyB0byBUb3JhbGYgRsO2cnN0
ZXIuCj4gCj4gVGhlIHBhdGNoIGlzIGJlbG93Lgo+IAo+IEkgaGF2ZSBvbmUgY29uZmlybWF0aW9u
IHRoYXQgdGhpcyBmaXhlcyB0aGUgcHJvYmxlbSAtIEknZCBsaWtlIGEgZmV3Cj4gbW9yZSBqdXN0
IHRvIGJlIHN1cmUuCj4gCj4gCQkJSmVmZgo+IAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5O
ZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSBNb2JsaW4gWW91ciBNb3ZlIERldmVsb3Blcidz
IGNoYWxsZW5nZQpCdWlsZCB0aGUgY29vbGVzdCBMaW51eCBiYXNlZCBhcHBsaWNhdGlvbnMgd2l0
aCBNb2JsaW4gU0RLICYgd2luIGdyZWF0IHByaXplcwpHcmFuZCBwcml6ZSBpcyBhIHRyaXAgZm9y
IHR3byB0byBhbiBPcGVuIFNvdXJjZSBldmVudCBhbnl3aGVyZSBpbiB0aGUgd29ybGQKaHR0cDov
L21vYmxpbi1jb250ZXN0Lm9yZy9yZWRpcmVjdC5waHA/YmFubmVyX2lkPTEwMCZ1cmw9LwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGlu
dXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNl
ci1tb2RlLWxpbnV4LWRldmVsCg==
