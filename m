Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlQqj-0006JI-E1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 08:44:05 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JlQqg-0004iD-JI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 08:44:05 -0700
Date: Mon, 14 Apr 2008 11:43:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080414154342.GA9434@c2.user-mode-linux.org>
References: <20080412.233914.54446044.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080412.233914.54446044.xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [Patch] UML: Fix another build error
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

T24gU2F0LCBBcHIgMTIsIDIwMDggYXQgMTE6Mzk6MTRQTSArMDgwMCwgV0FORyBDb25nIHdyb3Rl
Ogo+IAo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvci4KPiAKPiAg
IENDICAgICAgYXJjaC91bS9kcml2ZXJzL21jb25zb2xlX2tlcm4ubwo+IC9ob21lL3dhbmdjb25n
L3Byb2plY3RzL2xpbnV4LTIuNi9hcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5jOjMzNzog
ZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhtY29uc29sZV9yZWdpc3Rlcl9kZXbigJkKPiAvaG9t
ZS93YW5nY29uZy9wcm9qZWN0cy9saW51eC0yLjYvYXJjaC91bS9pbmNsdWRlL21jb25zb2xlX2tl
cm4uaDo0NzogZXJyb3I6IHByZXZpb3VzIGRlZmluaXRpb24gb2Yg4oCYbWNvbnNvbGVfcmVnaXN0
ZXJfZGV24oCZIHdhcyBoZXJlCj4gbWFrZVsyXTogKioqIFthcmNoL3VtL2RyaXZlcnMvbWNvbnNv
bGVfa2Vybi5vXSBFcnJvciAxCj4gbWFrZVsxXTogKioqIFthcmNoL3VtL2RyaXZlcnMvbWNvbnNv
bGVfa2Vybi5rb10gRXJyb3IgMgo+IG1ha2U6ICoqKiBbc3ViLW1ha2VdIEVycm9yIDIKClRoaXMg
b25lIGlzIGZpc2h5LiAgRm9yIG9uZSB0aGluZywgaXQgbG9va3MgbGlrZSB5b3UgcmVwcm9kdWNl
IHRoaXMKd2l0aCAhQ09ORklHX01DT05TT0xFLCBidXQgSSBqdXN0IHN1Y2Nlc3NmdWxseSBidWls
dCBhCiFDT05GSUdfTUNPTlNPTEUgVU1MLgoKU2Vjb25kLCB0aGUgYXJjaC91bS9kcml2ZXJzL01h
a2VmaWxlIGxvb2tzIHRvIG1lIChhbmQgdGhlIGJ1aWxkIGxvZwpjb25maXJtcykgdGhhdCBtY29u
c29sZV9rZXJuLmMgaXNuJ3QgY29tcGlsZWQgd2l0aCAhQ09ORklHX01DT05TT0xFLgoKVGhpcmQs
IHlvdSBzaG91bGQgYXNrIHlvdXJzZWxmIGlmIHRoZXJlIG1pZ2h0IGJlIGEgZGVlcGVyIHByb2Js
ZW0gdGhhdApuZWVkcyBmaXhpbmcgaWYgeW91IGZpbmQgeW91cnNlbGYgcHV0dGluZyAjaWZkZWYg
Q09ORklHX0ZPTyBpbiBmaWxlcwp3aGljaCBpbXBsZW1lbnQgRk9PLgoKCQkJCUplZmYKCi0tIApX
b3JrIGVtYWlsIC0gamRpa2UgYXQgbGludXggZG90IGludGVsIGRvdCBjb20KCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSAyMDA4IEphdmFPbmUo
U00pIENvbmZlcmVuY2UgCkRvbid0IG1pc3MgdGhpcyB5ZWFyJ3MgZXhjaXRpbmcgZXZlbnQuIFRo
ZXJlJ3Mgc3RpbGwgdGltZSB0byBzYXZlICQxMDAuIApVc2UgcHJpb3JpdHkgY29kZSBKOFRMMkQy
LiAKaHR0cDovL2FkLmRvdWJsZWNsaWNrLm5ldC9jbGs7MTk4NzU3NjczOzEzNTAzMDM4O3A/aHR0
cDovL2phdmEuc3VuLmNvbS9qYXZhb25lCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1t
b2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK
