Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjwPM-0001bb-Uh for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 05:29:26 -0700
Received: from qb-out-0506.google.com ([72.14.204.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IjwPK-0000Ih-5D
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 05:29:23 -0700
Received: by qb-out-0506.google.com with SMTP id c8so1144359qbc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Oct 2007 05:29:21 -0700 (PDT)
Date: Mon, 22 Oct 2007 20:25:04 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071022122504.GL2998@hacking>
References: <20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
	<20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
	<20071022061245.GG2998@hacking> <87d4v7fy5i.fsf@hades.wkstn.nix>
	<20071022065202.GI2998@hacking>
	<20071022065943.GC10864@uranus.ravnborg.org>
	<20071022074823.GJ2998@hacking>
	<20071022113600.GA8181@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071022113600.GA8181@ftp.linux.org.uk>
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
To: Al Viro <viro@ftp.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, WANG Cong <xiyou.wangcong@gmail.com>, Ingo Molar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>

T24gTW9uLCBPY3QgMjIsIDIwMDcgYXQgMTI6MzY6MDBQTSArMDEwMCwgQWwgVmlybyB3cm90ZToK
Pk9uIE1vbiwgT2N0IDIyLCAyMDA3IGF0IDAzOjQ4OjIzUE0gKzA4MDAsIFdBTkcgQ29uZyB3cm90
ZToKPj4gSSBqdXN0IGZvbGxvd2VkIHdoYXQgU2FtIHRvbGQgbWUsIGVycm9ycyBhcmUgbXVjaCBm
ZXdlciB0aGlzIHRpbWUsCj4+IGJ1dCBzdGlsbCBleGlzdC4gRXJyb3IgbWVzc2FnZXMgYXJlOgo+
PiAKPj4gICBDQyAgICAgIGFyY2gvdW0va2VybmVsL3N5c2NhbGwubwo+PiAgIENDICAgICAgYXJj
aC91bS9rZXJuZWwvc3lzcnEubwo+PiBhcmNoL3VtL2tlcm5lbC9zeXNycS5jOiBJbiBmdW5jdGlv
biA/Pz9zaG93X3N0YWNrPz8/Ogo+PiBhcmNoL3VtL2tlcm5lbC9zeXNycS5jOjYzOiBlcnJvcjog
Pz8/VUVTUD8/PyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKPj4gYXJj
aC91bS9rZXJuZWwvc3lzcnEuYzo2MzogZXJyb3I6IChFYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmll
ciBpcyByZXBvcnRlZCBvbmx5IG9uY2UKPj4gYXJjaC91bS9rZXJuZWwvc3lzcnEuYzo2MzogZXJy
b3I6IGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4uKQo+PiBtYWtlWzFdOiAqKiogW2Fy
Y2gvdW0va2VybmVsL3N5c3JxLm9dIEVycm9yIDEKPj4gbWFrZTogKioqIFthcmNoL3VtL2tlcm5l
bF0gRXJyb3IgMgo+PiAKPj4gT3IgSSBtaXNzZWQgc29tZXRoaW5nIGFnYWluPwo+PiAKPj4gQW5k
IEkgdXNlIGBtYWtlIGRlZmNvbmZpZyBBUkNIPXVtJyB0byBnZW5lcmF0ZSAuY29uZmlnLCBteSB0
cmVlCj4+IGlzIDIuNi4yMy1naXQxNiAoQWwsIGlzIHRoaXMgT0s/KS4KPgo+Tm93IGFwcGx5IHRo
ZSBwYXRjaCB1cHRocmVhZCwgaXQgc2hvdWxkJ3ZlIGZpeGVkIHRoYXQgb25lIChhbmQgeWVzLCB5
b3UKPmFyZSBkb3duIHRvIHRoZSBzdHVmZiB0aGlzIHBhdGNoIGlzIHN1cHBvc2VkIHRvIGZpeCAt
IGFuZCBkb2VzIHNvIGhlcmUpLgoKWWVzLCB0aGlzIG9uZSBpcyBmaXhlZC4gVGhhbmtzIGZvciB5
b3VyIHBhdGNoLgoKQnV0IGFub3RoZXIgb25lIGNvbWVzIG91dC4gOygKCiAgQ0MgICAgICBrZXJu
ZWwvc2NoZWQubwprZXJuZWwvc2NoZWQuYzozOTAyOiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMg
Zm9yIOKAmHdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZeKAmQppbmNsdWRlL2xpbnV4
L2NvbXBsZXRpb24uaDo0NjogZXJyb3I6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mIOKAmHdhaXRf
Zm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZeKAmSB3YXMgaGVyZQprZXJuZWwvc2NoZWQuYzoz
OTA4OiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMgZm9yIOKAmHdhaXRfZm9yX2NvbXBsZXRpb25f
aW50ZXJydXB0aWJsZeKAmQppbmNsdWRlL2xpbnV4L2NvbXBsZXRpb24uaDo0NjogZXJyb3I6IHBy
ZXZpb3VzIGRlY2xhcmF0aW9uIG9mIOKAmHdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJs
ZeKAmSB3YXMgaGVyZQptYWtlWzFdOiAqKiogW2tlcm5lbC9zY2hlZC5vXSBFcnJvciAxCm1ha2U6
ICoqKiBba2VybmVsXSBFcnJvciAyCgpDQzogSW5nbyBNb2xhciA8bWluZ29AZWx0ZS5odT4KCi0t
IApNYXkgdGhlIFNvdXJjZSBCZSBXaXRoIFlvdS4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5u
ZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5OiBTcGx1bmsgSW5jLgpTdGlsbCBncmVwcGluZyB0aHJv
dWdoIGxvZyBmaWxlcyB0byBmaW5kIHByb2JsZW1zPyAgU3RvcC4KTm93IFNlYXJjaCBsb2cgZXZl
bnRzIGFuZCBjb25maWd1cmF0aW9uIGZpbGVzIHVzaW5nIEFKQVggYW5kIGEgYnJvd3Nlci4KRG93
bmxvYWQgeW91ciBGUkVFIGNvcHkgb2YgU3BsdW5rIG5vdyA+PiBodHRwOi8vZ2V0LnNwbHVuay5j
b20vCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXIt
bW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK
