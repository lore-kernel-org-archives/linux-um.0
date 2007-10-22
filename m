Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ijwcr-0002wU-G1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 05:43:21 -0700
Received: from ag-out-0708.google.com ([72.14.246.249])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ijwcr-00059c-3f
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 05:43:21 -0700
Received: by ag-out-0708.google.com with SMTP id 23so2268093agd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Oct 2007 05:43:18 -0700 (PDT)
Date: Mon, 22 Oct 2007 20:39:01 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071022123901.GM2998@hacking>
References: <20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
	<20071022061245.GG2998@hacking> <87d4v7fy5i.fsf@hades.wkstn.nix>
	<20071022065202.GI2998@hacking>
	<20071022065943.GC10864@uranus.ravnborg.org>
	<20071022074823.GJ2998@hacking>
	<20071022113600.GA8181@ftp.linux.org.uk>
	<20071022122504.GL2998@hacking> <20071022123041.GA4990@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071022123041.GA4990@elte.hu>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in	2.6.23-final.
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>

T24gTW9uLCBPY3QgMjIsIDIwMDcgYXQgMDI6MzA6NDFQTSArMDIwMCwgSW5nbyBNb2xuYXIgd3Jv
dGU6Cj4KPiogV0FORyBDb25nIDx4aXlvdS53YW5nY29uZ0BnbWFpbC5jb20+IHdyb3RlOgo+Cj4+
IE9uIE1vbiwgT2N0IDIyLCAyMDA3IGF0IDEyOjM2OjAwUE0gKzAxMDAsIEFsIFZpcm8gd3JvdGU6
Cj4+ID5PbiBNb24sIE9jdCAyMiwgMjAwNyBhdCAwMzo0ODoyM1BNICswODAwLCBXQU5HIENvbmcg
d3JvdGU6Cj4+ID4+IEkganVzdCBmb2xsb3dlZCB3aGF0IFNhbSB0b2xkIG1lLCBlcnJvcnMgYXJl
IG11Y2ggZmV3ZXIgdGhpcyB0aW1lLAo+PiA+PiBidXQgc3RpbGwgZXhpc3QuIEVycm9yIG1lc3Nh
Z2VzIGFyZToKPj4gPj4gCj4+ID4+ICAgQ0MgICAgICBhcmNoL3VtL2tlcm5lbC9zeXNjYWxsLm8K
Pj4gPj4gICBDQyAgICAgIGFyY2gvdW0va2VybmVsL3N5c3JxLm8KPj4gPj4gYXJjaC91bS9rZXJu
ZWwvc3lzcnEuYzogSW4gZnVuY3Rpb24gPz8/c2hvd19zdGFjaz8/PzoKPj4gPj4gYXJjaC91bS9r
ZXJuZWwvc3lzcnEuYzo2MzogZXJyb3I6ID8/P1VFU1A/Pz8gdW5kZWNsYXJlZCAoZmlyc3QgdXNl
IGluIHRoaXMgZnVuY3Rpb24pCj4+ID4+IGFyY2gvdW0va2VybmVsL3N5c3JxLmM6NjM6IGVycm9y
OiAoRWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlCj4+ID4+
IGFyY2gvdW0va2VybmVsL3N5c3JxLmM6NjM6IGVycm9yOiBmb3IgZWFjaCBmdW5jdGlvbiBpdCBh
cHBlYXJzIGluLikKPj4gPj4gbWFrZVsxXTogKioqIFthcmNoL3VtL2tlcm5lbC9zeXNycS5vXSBF
cnJvciAxCj4+ID4+IG1ha2U6ICoqKiBbYXJjaC91bS9rZXJuZWxdIEVycm9yIDIKPj4gPj4gCj4+
ID4+IE9yIEkgbWlzc2VkIHNvbWV0aGluZyBhZ2Fpbj8KPj4gPj4gCj4+ID4+IEFuZCBJIHVzZSBg
bWFrZSBkZWZjb25maWcgQVJDSD11bScgdG8gZ2VuZXJhdGUgLmNvbmZpZywgbXkgdHJlZQo+PiA+
PiBpcyAyLjYuMjMtZ2l0MTYgKEFsLCBpcyB0aGlzIE9LPykuCj4+ID4KPj4gPk5vdyBhcHBseSB0
aGUgcGF0Y2ggdXB0aHJlYWQsIGl0IHNob3VsZCd2ZSBmaXhlZCB0aGF0IG9uZSAoYW5kIHllcywg
eW91Cj4+ID5hcmUgZG93biB0byB0aGUgc3R1ZmYgdGhpcyBwYXRjaCBpcyBzdXBwb3NlZCB0byBm
aXggLSBhbmQgZG9lcyBzbyBoZXJlKS4KPj4gCj4+IFllcywgdGhpcyBvbmUgaXMgZml4ZWQuIFRo
YW5rcyBmb3IgeW91ciBwYXRjaC4KPj4gCj4+IEJ1dCBhbm90aGVyIG9uZSBjb21lcyBvdXQuIDso
Cj4+IAo+PiAgIENDICAgICAga2VybmVsL3NjaGVkLm8KPj4ga2VybmVsL3NjaGVkLmM6MzkwMjog
ZXJyb3I6IGNvbmZsaWN0aW5nIHR5cGVzIGZvciDigJh3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVy
cnVwdGlibGXigJkKPj4gaW5jbHVkZS9saW51eC9jb21wbGV0aW9uLmg6NDY6IGVycm9yOiBwcmV2
aW91cyBkZWNsYXJhdGlvbiBvZiDigJh3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGXi
gJkgd2FzIGhlcmUKPj4ga2VybmVsL3NjaGVkLmM6MzkwODogZXJyb3I6IGNvbmZsaWN0aW5nIHR5
cGVzIGZvciDigJh3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGXigJkKPj4gaW5jbHVk
ZS9saW51eC9jb21wbGV0aW9uLmg6NDY6IGVycm9yOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDi
gJh3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGXigJkgd2FzIGhlcmUKPj4gbWFrZVsx
XTogKioqIFtrZXJuZWwvc2NoZWQub10gRXJyb3IgMQo+PiBtYWtlOiAqKiogW2tlcm5lbF0gRXJy
b3IgMgo+Cj5kb2VzIHRoZSBwYXRjaCBiZWxvdyBvbnRvcCBvZiBsYXRlc3QgLWdpdCBoZWxwPwo+
CgpUaGFua3MsIEluZ28hCgpJIGFtIHVzaW5nIDIuNi4yMy1naXQxNiBwbHVzIEFsJ3MgcHJldmlv
dXMgcGF0Y2guCkFmdGVyIGFwcGx5aW5nIHlvdXIgcGF0Y2gsIGl0IGJ1aWxkcyBmaW5lLgoKUmVn
YXJkcy4KCgpXQU5HIENvbmcKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0YubmV0IGVtYWlsIGlz
IHNwb25zb3JlZCBieTogU3BsdW5rIEluYy4KU3RpbGwgZ3JlcHBpbmcgdGhyb3VnaCBsb2cgZmls
ZXMgdG8gZmluZCBwcm9ibGVtcz8gIFN0b3AuCk5vdyBTZWFyY2ggbG9nIGV2ZW50cyBhbmQgY29u
ZmlndXJhdGlvbiBmaWxlcyB1c2luZyBBSkFYIGFuZCBhIGJyb3dzZXIuCkRvd25sb2FkIHlvdXIg
RlJFRSBjb3B5IG9mIFNwbHVuayBub3cgPj4gaHR0cDovL2dldC5zcGx1bmsuY29tLwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgt
ZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1t
b2RlLWxpbnV4LWRldmVsCg==
