Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZEeHg-0003rc-Rb
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 14:00:40 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEeHb-0005sV-Vu
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 14:00:40 +0000
Message-ID: <55A3C47B.8040206@nod.at>
Date: Mon, 13 Jul 2015 16:00:27 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1436794918.3306.5.camel@m3y3r.de>	
	<CAFLxGvwo2hjvrkF_ChR1Ooc6o7OqEGEOKnP=4NAmt8vP07Kd-Q@mail.gmail.com>
	<1436795884.3306.7.camel@m3y3r.de>
In-Reply-To: <1436795884.3306.7.camel@m3y3r.de>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] uml_net zombie processes
To: Thomas Meyer <thomas@m3y3r.de>, Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

QW0gMTMuMDcuMjAxNSB1bSAxNTo1OCBzY2hyaWViIFRob21hcyBNZXllcjoKPiBBbSBNb250YWcs
IGRlbiAxMy4wNy4yMDE1LCAxNTo1MiArMDIwMCBzY2hyaWViIFJpY2hhcmQgV2VpbmJlcmdlcjoK
Pj4gT24gTW9uLCBKdWwgMTMsIDIwMTUgYXQgMzo0MSBQTSwgVGhvbWFzIE1leWVyIDx0aG9tYXNA
bTN5M3IuZGU+IAo+PiB3cm90ZToKPj4+IEhpLAo+Pj4KPj4+IFRoZSB1bWxfbmV0IG5ldHdvcmsg
c2V0dXAgImZhaWxzIiBvbiBteSBjb21wdXRlciB3aXRoOgo+Pj4KPj4+IFsgICAxNS45MzAwMDBd
IGhlbHBlcl93YWl0IDogd2FpdHBpZCBwcm9jZXNzIDExNjczIGZhaWxlZCwgZXJybm8gPSAKPj4+
IDEwCj4+PiBbICAgMTUuOTMwMDAwXSAqIG1vZHByb2JlIHR1bgo+Pj4gICAgICAgICAgICAgICAg
KiBpZmNvbmZpZyB0YXAwIDE5Mi4xNjguMTAuMSBuZXRtYXNrIDI1NS4yNTUuMjU1LjI1NSAKPj4+
IHVwCj4+PiAgICAgICAgICAgICAgICAqIGJhc2ggLWMgZWNobyAxID4gL3Byb2Mvc3lzL25ldC9p
cHY0L2lwX2ZvcndhcmQKPj4+IFsgICAyMC40ODAwMDBdIGhlbHBlcl93YWl0IDogd2FpdHBpZCBw
cm9jZXNzIDExNzgwIGZhaWxlZCwgZXJybm8gPSAKPj4+IDEwCj4+PiBbICAgMjAuNDgwMDAwXSAq
IHJvdXRlIGFkZCAtaG9zdCAxOTIuMTY4LjEwLjIgZGV2IHRhcDAKPj4+ICAgICAgICAgICAgICAg
ICogYmFzaCAtYyBlY2hvIDEgPgo+Pj4gL3Byb2Mvc3lzL25ldC9pcHY0L2NvbmYvdGFwMC9wcm94
eV9hcnAKPj4+Cj4+PiBiZWNhdXNlIEkgcnVuIHVtbCBsaW51eCBhcyBhIG5vcm1hbCB1c2VyIGFu
ZCBJIGd1ZXNzIHRoZXNlIGNvbW1hbmRzCj4+PiBmYWlsLCBiZWNhdXNlIG9mIGluc3VmZmljaWVu
dCByaWdodHM6Cj4+PiBiYXNoIC1jIGVjaG8gMSA+IC9wcm9jL3N5cy9uZXQvaXB2NC9pcF9mb3J3
YXJkCj4+PiBiYXNoIC1jIGVjaG8gMSA+IC9wcm9jL3N5cy9uZXQvaXB2NC9jb25mL3RhcDAvcHJv
eHlfYXJwCj4+Pgo+Pj4gQnV0IHRoaXMgZmFpbHVyZSBpcyBva2F5IGZvciBtZSwgYXMgZmlyZXdh
bGxkLCBzZXRzIGFib3ZlIG9wdGlvbnMKPj4+IGNvcnJlY3RseSBvbiBteSBob3N0IGNvbXB1dGVy
Lgo+Pj4KPj4+IFRoZSBwcm9ibGVtIEkgc2VlIGlzIHRoYXQgVU1MIGxpc3QgdHdvIHpvbWJpZSBw
cm9jZXNzZXM6Cj4+PiAgIDExNzgwIHJvb3QgICAgICAgMjAgICAwICAgICAwICAgICAwICAgICAw
IFogIDAuMCAgMC4wICAwOjAwLjAwIAo+Pj4gMTU6MzQg4pSCICDilIIgICAgIOKUnOKUgCB1bWxf
bmV0Cj4+PiAgIDExNjczIHJvb3QgICAgICAgMjAgICAwICAgICAwICAgICAwICAgICAwIFogIDAu
MCAgMC4wICAwOjAwLjAwIAo+Pj4gMTU6MzQg4pSCICDilIIgICAgIOKUnOKUgCB1bWxfbmV0Cj4+
Pgo+Pj4gVU1MIHNlZW1zIHRvIG5ldmVyIHJlYXAgdGhvc2UgdHdvIHByb2Nlc3NlcywgbGlrZWx5
IGJlY2F1c2Ugb2YgCj4+PiBlcnJubz0xMCBleGl0IGNvZGUuCj4+Pgo+Pj4gYW55IGlkZWEgaG93
IHRvIGZpeCB0aGlzPwo+Pgo+PiBIbW0sIGl0IHRyaWVzIHRvIHJlYXAgdGhlbSB1c2luZyB3YWl0
cGlkKCkuCj4+IEJ1dCBpdCBzZWVtcyB0byBmYWlsIHdpdGggRUNISUxELgo+Pgo+PiBDYW4geW91
IGFkZCBhIGZldyBwcmludHMgdG8gY29tcGFyZSB0aGUgUElEcz8KPiAKPiBTdXJlLCB3aGVyZSBz
aG91bGQgSSBhZGQgdGhvc2U/Cj4gb3MtTGludXgvaGVscGVyLmMgLSBoZWxwZXJfd2FpdChpbnQg
cGlkKSA/CgpZZWFoLiBBbmQgcGxlYXNlIGFkZCBhIGR1bXBfc3RhY2soKSB0byBmaWd1cmUgb3V0
IHdoZXJlIGl0IHdhcyBjYWxsZWQuCgpUaGFua3MsCi8vcmljaGFyZAoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkRvbid0IExpbWl0IFlvdXIgQnVzaW5lc3MuIFJlYWNoIGZvciB0aGUgQ2xvdWQuCkdp
Z2VORVQncyBDbG91ZCBTb2x1dGlvbnMgcHJvdmlkZSB5b3Ugd2l0aCB0aGUgdG9vbHMgYW5kIHN1
cHBvcnQgdGhhdAp5b3UgbmVlZCB0byBvZmZsb2FkIHlvdXIgSVQgbmVlZHMgYW5kIGZvY3VzIG9u
IGdyb3dpbmcgeW91ciBidXNpbmVzcy4KQ29uZmlndXJlZCBGb3IgQWxsIEJ1c2luZXNzZXMuIFN0
YXJ0IFlvdXIgQ2xvdWQgVG9kYXkuCmh0dHBzOi8vd3d3LmdpZ2VuZXRjbG91ZC5jb20vCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51
eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2Vy
LW1vZGUtbGludXgtZGV2ZWwK

